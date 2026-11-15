# Windows 10/11 x64. Private, hash-locked runtime; no Python install. Microsoft runtime prerequisite may request consent.
[CmdletBinding()]
param([switch]$SetupOnly, [switch]$Repair)
$ErrorActionPreference = 'Stop'
$ProgressPreference = 'SilentlyContinue'
$root = $PSScriptRoot
Set-Location -LiteralPath $root
$lockStream = $null
$stage = $null
try {
    if (-not [Environment]::Is64BitOperatingSystem -or $env:PROCESSOR_ARCHITECTURE -eq 'ARM64') {
        throw 'This package requires Windows x64 (Intel/AMD), not ARM or 32-bit Windows.'
    }
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    Add-Type -AssemblyName System.IO.Compression.FileSystem
    $manifestPath = Join-Path $root 'runtime-lock.json'
    $manifestHash = (Get-FileHash -LiteralPath $manifestPath -Algorithm SHA256).Hash.ToLowerInvariant()
    $manifest = Get-Content -LiteralPath $manifestPath -Raw | ConvertFrom-Json
    if ($manifest.schema -ne 1 -or $manifest.platform -ne 'Windows x64') { throw 'Invalid runtime manifest.' }
    try {
        $lockStream = [IO.File]::Open((Join-Path $root '.runtime-setup.lock'), 'OpenOrCreate', 'ReadWrite', 'None')
    } catch { throw 'Setup is already running, or this folder is not writable. Extract into your own Documents folder.' }
    $runtime = Join-Path $root 'runtime'
    $stamp = Join-Path $runtime 'runtime-ready.txt'
    $ready = (-not $Repair) -and (Test-Path -LiteralPath (Join-Path $runtime 'python.exe')) -and (Test-Path -LiteralPath $stamp) -and ((Get-Content -LiteralPath $stamp -Raw).Trim() -eq $manifestHash)
    if (-not $ready) {
        Write-Host 'First launch: setting up your private editor runtime. Internet needed this time (about 50 MB).'
        $downloads = Join-Path $root '.runtime-downloads'
        New-Item -ItemType Directory -Path $downloads -Force | Out-Null
        function Get-VerifiedArchive($record) {
            $uri = [Uri]$record.url
            if ($uri.Scheme -ne 'https' -or $uri.Host -notin @('www.python.org','files.pythonhosted.org','download.visualstudio.microsoft.com')) { throw 'Runtime URL is not an approved HTTPS source.' }
            if ([IO.Path]::GetFileName($record.filename) -ne $record.filename -or $record.filename -match '[\\/:]') { throw 'Invalid download filename.' }
            if ($record.sha256 -notmatch '^[a-f0-9]{64}$') { throw 'Invalid expected archive hash.' }
            $path = Join-Path $downloads $record.filename
            $valid = (Test-Path -LiteralPath $path) -and ((Get-FileHash -LiteralPath $path -Algorithm SHA256).Hash.ToLowerInvariant() -eq $record.sha256)
            if (-not $valid) {
                Write-Host ('Downloading ' + $record.filename)
                $temporary = $path + '.partial'
                Invoke-WebRequest -UseBasicParsing -Uri $record.url -OutFile $temporary
                if ((Get-Item -LiteralPath $temporary).Length -ne $record.size -or (Get-FileHash -LiteralPath $temporary -Algorithm SHA256).Hash.ToLowerInvariant() -ne $record.sha256) {
                    Remove-Item -LiteralPath $temporary -Force
                    throw ('Integrity check failed: ' + $record.filename + '. Nothing installed; try again.')
                }
                Move-Item -LiteralPath $temporary -Destination $path -Force
            }
            return $path
        }
        function Expand-SafeArchive($archive, $destination) {
            $prefix = [IO.Path]::GetFullPath($destination).TrimEnd([IO.Path]::DirectorySeparatorChar) + [IO.Path]::DirectorySeparatorChar
            $zip = [IO.Compression.ZipFile]::OpenRead($archive)
            try {
                foreach ($entry in $zip.Entries) {
                    # Legacy Windows PowerShell/.NET still enforces MAX_PATH.
                    # Check before GetFullPath/ExtractToDirectory can emit an opaque error.
                    if (($prefix.Length + $entry.FullName.Length) -ge 240) {
                        throw 'Runtime path is too long for Windows PowerShell. Move the ENTIRE extracted editor folder to C:\MBE13 (not inside another long-named folder), then retry. Do not overwrite an existing folder. Your saved job is unchanged.'
                    }
                    $candidate = [IO.Path]::GetFullPath((Join-Path $destination $entry.FullName))
                    if (-not $candidate.StartsWith($prefix, [StringComparison]::OrdinalIgnoreCase)) { throw 'Unsafe archive path.' }
                }
            } finally { $zip.Dispose() }
            [IO.Compression.ZipFile]::ExtractToDirectory($archive, $destination)
        }
        # Windows includes UCRT, but not necessarily the MSVC C++ DLL used by MuPDF.
        $msvc = Join-Path $env:SystemRoot 'System32\msvcp140.dll'
        $installedVersion = [Version]'0.0.0.0'
        if (Test-Path -LiteralPath $msvc) {
            $v = (Get-Item -LiteralPath $msvc).VersionInfo
            $installedVersion = [Version](('{0}.{1}.{2}.{3}' -f $v.FileMajorPart,$v.FileMinorPart,$v.FileBuildPart,$v.FilePrivatePart))
        }
        if ($installedVersion -lt [Version]$manifest.vc_runtime.minimum_version) {
            Write-Host 'Microsoft Visual C++ runtime is needed. Windows may ask permission for its official installer (about 25 MB).'
            $redist = Get-VerifiedArchive $manifest.vc_runtime
            $signature = Get-AuthenticodeSignature -LiteralPath $redist
            if ($signature.Status -ne 'Valid' -or $signature.SignerCertificate.Subject -notmatch 'Microsoft Corporation') { throw 'Microsoft runtime signature verification failed.' }
            $process = Start-Process -FilePath $redist -ArgumentList '/install','/passive','/norestart' -Verb RunAs -Wait -PassThru
            if ($process.ExitCode -notin @(0,1638,3010)) { throw ('Microsoft runtime installer returned ' + $process.ExitCode) }
            if ($process.ExitCode -eq 3010) { Write-Host 'Microsoft runtime requests a restart; restart Windows if the self-test below fails.' }
        }
        $stage = Join-Path $root ('.rt-' + [Guid]::NewGuid().ToString('N').Substring(0,12))
        New-Item -ItemType Directory -Path $stage | Out-Null
        Expand-SafeArchive (Get-VerifiedArchive $manifest.python) $stage
        $site = Join-Path $stage 'Lib\site-packages'
        New-Item -ItemType Directory -Path $site -Force | Out-Null
        foreach ($wheel in $manifest.wheels) {
            Expand-SafeArchive (Get-VerifiedArchive $wheel) $site
        }
        # This lock contains no purelib/platlib relocation sections. Fonttools'
        # optional man-page .data remains intact; CLI entry points are not needed.
        [IO.File]::WriteAllText((Join-Path $stage 'python312._pth'), "python312.zip`n.`n..`nLib/site-packages`nimport site`n", [Text.Encoding]::ASCII)
        $python = Join-Path $stage 'python.exe'
        & $python -X utf8 (Join-Path $root 'runtime_check.py')
        if ($LASTEXITCODE -ne 0) { throw 'Runtime self-test failed. Your saved building has not been modified.' }
        if (Test-Path -LiteralPath $runtime) {
            # Preserve rather than overwrite any earlier runtime during repair.
            Move-Item -LiteralPath $runtime -Destination ($runtime + '-previous-' + [Guid]::NewGuid().ToString('N'))
        }
        Move-Item -LiteralPath $stage -Destination $runtime
        $stage = $null
        [IO.File]::WriteAllText($stamp, $manifestHash, [Text.Encoding]::ASCII)
        Write-Host 'Setup complete. Later starts do not require Internet.'
    }
    $lockStream.Dispose(); $lockStream = $null
    if (-not $SetupOnly) {
        & (Join-Path $runtime 'python.exe') -X utf8 (Join-Path $root 'launcher.py')
        if ($LASTEXITCODE -ne 0) { throw 'Editor stopped with an error. See the message above; close any old editor using the same port.' }
    }
} catch {
    Write-Host ('ERROR: ' + $_.Exception.Message) -ForegroundColor Red
    Write-Host 'Your saved building is not replaced by setup. Extract to a writable folder; check Internet and retry.'
    exit 1
} finally {
    if ($lockStream) { $lockStream.Dispose() }
    if ($stage -and (Test-Path -LiteralPath $stage)) { Remove-Item -LiteralPath $stage -Recurse -Force }
}
