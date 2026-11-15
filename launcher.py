"""Double-click bootstrap and trusted-LAN server. Private app runtime; Microsoft prerequisite may need installer consent."""

import hashlib
import json
import mimetypes
import os
import shutil
import socket
import subprocess
import sys
import threading
import time
import traceback
import webbrowser
from pathlib import Path

ROOT = Path(__file__).resolve().parent  # launcher files: settings.json, requirements.txt, VERSION.txt


def _app_root():
    """Folder that holds the ``mbdp`` package: this folder (the ready-to-run package) or a parent
    (the launcher started from ``windows/`` inside a source checkout / source ZIP)."""
    here = Path(__file__).resolve().parent
    for candidate in (here, *here.parents):
        if (candidate / 'mbdp' / '__init__.py').is_file():
            return candidate
    raise SystemExit(
        'The mbdp application folder was not found next to or above '
        + str(here)
        + '. Extract the COMPLETE Metal-Building-Editor ZIP (or the whole source ZIP) and start it again.'
    )


APP = _app_root()
if str(APP) not in sys.path:
    sys.path.insert(0, str(APP))


def main():
    os.chdir(ROOT)
    bundled = ROOT / 'runtime' / 'python.exe'
    if os.name == 'nt' and Path(sys.executable).resolve() == bundled.resolve():
        return serve()
    env = ROOT / '.venv'
    python = env / ('Scripts/python.exe' if os.name == 'nt' else 'bin/python')
    if Path(sys.prefix).resolve() != env.resolve():
        if not python.exists():
            print('First launch: creating a private Python environment...', flush=True)
            import venv

            venv.EnvBuilder(with_pip=True).create(env)
        return subprocess.call([str(python), str(ROOT / 'launcher.py')])

    requirements = ROOT / 'requirements.txt'
    fingerprint = hashlib.sha256(requirements.read_bytes()).hexdigest()
    marker = env / 'editor-dependencies.txt'
    if not marker.exists() or marker.read_text() != fingerprint:
        print('Installing dependencies. Internet is needed for this first setup...', flush=True)
        subprocess.check_call([sys.executable, '-m', 'pip', 'install', '-r', str(requirements)])
        marker.write_text(fingerprint)

    return serve()


def _version():
    stamp = ROOT / 'VERSION.txt'
    if stamp.exists():
        return stamp.read_text().strip()
    import re

    m = re.search(r'^version\s*=\s*"([^"]+)"', (APP / 'pyproject.toml').read_text(), re.M)
    return m.group(1) if m else 'source'


def serve():
    from http.server import ThreadingHTTPServer

    from mbdp.detail.editor.server import JobStore, make_handler

    config = json.loads((ROOT / 'settings.json').read_text())
    port = int(config.get('port', 8010))
    if not 1024 <= port <= 65535:
        raise ValueError('Use a port between 1024 and 65535 in settings.json.')
    workspace = APP / 'data' / 'editor'  # next to the mbdp package (same folder as ROOT in the package)
    mimetypes.add_type('image/svg+xml', '.svg')
    # Bind before loading mutable state or backing it up. A second launch must not
    # create another writer to the same job on this port.
    with ThreadingHTTPServer(('0.0.0.0', port), make_handler(None)) as server:
        backup = APP / 'backups' / time.strftime('%Y%m%d-%H%M%S')
        if (workspace / 'job.json').exists():
            backup.mkdir(parents=True, exist_ok=True)
            for name in ('job.json', 'audit.jsonl'):
                if (workspace / name).exists():
                    shutil.copy2(workspace / name, backup / name)
        server.RequestHandlerClass = make_handler(JobStore(str(workspace), seed='blank'))
        local = f'http://localhost:{port}/'
        print('\nMETAL BUILDING DETAILING EDITOR v' + _version() + '\n', flush=True)
        print(f'This computer: {local}')
        print(f'Network name:  http://{socket.gethostname()}:{port}/')
        try:
            ips = sorted({r[4][0] for r in socket.getaddrinfo(socket.gethostname(), None, socket.AF_INET)})
            for ip in ips:
                if not ip.startswith('127.'):
                    print(f'Network IP:    http://{ip}:{port}/')
        except OSError:
            pass
        print(f'Your saved job: {workspace / "job.json"}')
        print(f'Job list:       {workspace / "jobs"}  (one file per job number)')
        print('\nKeep this window open. Press Ctrl+C to stop.')
        print('Allow Windows Firewall access on PRIVATE networks only.')
        print('Trusted LAN only: no login or HTTPS; anyone who can connect can edit.')
        print('Use one active editor at a time to avoid overwriting edits.')
        print(
            'If the page shows an older version than v' + _version() + ' top-left, press Ctrl+F5 in the browser.\n',
            flush=True,
        )
        if config.get('open_browser', True):
            # A version-stamped address: a browser that still holds the page of an earlier
            # installation for http://localhost:8010/ must fetch this one afresh.
            timer = threading.Timer(1.0, webbrowser.open, args=(local + '?v=' + _version(),))
            timer.daemon = True
            timer.start()
        try:
            server.serve_forever()
        except KeyboardInterrupt:
            print('\nEditor stopped. Saved job remains in data/editor.')
    return 0


if __name__ == '__main__':
    try:
        sys.exit(main())
    except Exception:
        traceback.print_exc()
        print('\nStartup failed. Check the error above. If the port is in use, close the other editor window.')
        sys.exit(1)
