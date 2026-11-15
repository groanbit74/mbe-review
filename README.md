# Building Editor (MBDP) — v0.8.66

Local-first metal-building detailing editor. It models a main roof/frame set, independent endwalls, lean-tos, openings, panels and trim, then produces drawings (PDF/SVG/DXF), cut lists, a pooled-stock **master material order** and connected **supplier → stock bar → cut piece → building location** references. It runs on Windows 10/11 x64 through a hash-locked private Python runtime, or from source.

> **Status: detailing software, not an engineering service.** It does not design or check connections, bracing or foundations; it details what the job inputs say. The release check (*Outputs → Release check*) lists only concrete, input-resolvable gaps (missing lengths, unresolved opening clashes, lot / grid mismatches); when it reads COMPLETE the three packages are complete for the inputs given, and the **Drawing status** select decides whether sheets carry the REVIEW watermark or are issued FOR CONSTRUCTION. The Windows launcher has not been tested natively on Windows.

> **Keep this repository private.** Your customer name and job numbers appear in code, tests and docs because the first templates were taken from those shop drawings. It also contains supplier catalog excerpts (see *Third-party material*).

## Current version

Start with [`CHANGELOG.md`](CHANGELOG.md), the [v0.8.66 release notes](docs/V0.8.66_RELEASE.md), and [`docs/RUN-LOCALLY.md`](docs/RUN-LOCALLY.md) (how to run it). The per-version notes and delivery-verification records of earlier releases are archived under [`docs/history/`](docs/history/). The standing product requirements are in [`docs/specification/`](docs/specification/) (consolidated 5 October 2026; later changes are recorded in the changelog).

## Run from source

Python 3.10 or newer is declared in `pyproject.toml`; the Windows package pins Python 3.12.10, and the clean-clone check below was run with Python 3.13.

```bash
python -m venv .venv
.venv\Scripts\activate            # Windows   (Linux/macOS: source .venv/bin/activate)
pip install -e .                  # installs pymupdf, ezdxf, openpyxl
python -m mbdp.cli editor --workspace data/editor --port 8010
```

A ready-to-run Windows package (no Python install) is produced by `python tools/build_local_package.py --output Metal-Building-Editor-<version>.zip`; see `docs/RUN-LOCALLY.md` for both ways of running it.

Open <http://localhost:8010/>. The editor listens on all network interfaces (intended for a trusted LAN). On first start it creates `data/editor/` with an **empty job** and opens Building settings; that folder is git-ignored, so **back up your own job files separately**. Saving is automatic: the open job is `data/editor/job.json` and every job is also filed under its number in `data/editor/jobs/<job number>.json` — **Job ▾ → Open job…** lists them all and switches between them (duplicate, delete, download and import per job; see `docs/RUN-LOCALLY.md`, *Working on several jobs*). The re-modelled sample job (Clark Jordan 1277345) is available from **Job ▾ → Load sample job**; it has no building layout, so its erection set is the cover sheet only and the customer elevations answer with an error instead of a document. That is existing behaviour, not a problem with your own job.

## Tests and formatting

```bash
pip install -e .[dev]                 # pytest, ruff, playwright
python -m pytest -q
python -m ruff format --check . && python -m ruff check .     # style gate (config in pyproject.toml)
pre-commit install                    # optional: run the gate on every commit (or: git config core.hooksPath tools/git-hooks)
```

The whole tree was formatted with `ruff format` in 0.8.23 (one statement per line, 120 columns); that commit is listed in `.git-blame-ignore-revs` — run `git config blame.ignoreRevsFile .git-blame-ignore-revs` once so `git blame` looks through it.

Some regression tests need files that are deliberately **not** stored in git: saved building jobs, historical fixtures and the customer's shop-drawing PDFs. In a clean clone those tests are reported as **skipped** (with the missing file names), not passed. v0.8.66 clean-clone suite: **814 passed, 252 skipped, 0 failed**; skips require private inputs that are not present in this clone. The marker file `tests/.skip_missing_private_fixtures` turns that on; delete it in a private working folder that has the files, and a missing file fails again. `tests/ui_connections_check.py` and the `review/verify_*.py` scripts are Playwright browser checks that need a running editor; they are not collected by pytest (the version-named `ui_v0*_check.py` scripts are archived under `history/tests/ui/`).

## What is in this repository

| Path | Contents |
|---|---|
| `mbdp/` | Application source: `mbdp/detail/` is the editor, geometry, drawings, ordering and traceability; `mbdp/dims.py` the shared dimension grammar; `mbdp/cli.py` the `editor` / `draw` / `sample-job` commands. (The extraction/review pipeline the editor grew from was removed in 0.8.24; it is in git history.) |
| `tests/` | pytest regression tests, conftest, browser and PowerShell check scripts. |
| `tools/` | Current scripts only: `build_local_package.py` (downloadable package), `export_github_source.py` (clean copy of the repository), `lock_windows_runtime.py`, the two catalog importers. |
| `history/` | Version-named review / QA / release-build scripts (`history/tools/`), the old Playwright checks (`history/tests/ui/`) and the one-off Windows upgrade helpers. Kept for reference; most need private files or a specific old release and do not run against the current editor. |
| `windows/` | Windows launcher, hash-locked runtime manifest (`runtime-lock.json`), start/repair scripts and the *READ ME FIRST* text. |
| `docs/` | `RUN-LOCALLY.md`, rules and connection notes, the specification, reference excerpts; `docs/history/` holds the per-version package / verification notes of every earlier release and the pre-v0.8.21 README. |
| `data/` | Only two small demo inputs. Saved jobs are not tracked. |

## Deliberately not in this repository

* Saved building jobs and backups (`data/editor/`, `data/owner_*`, received copies) and the job inside each release package.
* Original uploads: customer shop-drawing PDFs and job files.
* Release ZIPs and generated reports. Attach release ZIPs to a GitHub Release.
* Archived historical fixtures (`docs/reference/*.zip`) and the customer-drawing excerpt PDF under `docs/reference/framing/`.

`.gitignore` enforces this.

## Third-party material

`mbdp/detail/data/sss-supplier-reference.pdf` (served by the editor's supplier-reference link) and `docs/reference/mbci/Q06-MBCI-Punching-CI19.pdf` are excerpts of supplier catalogs, and the JSON data under `mbdp/detail/data/` is derived from them. They belong to their publishers. Remove them before making this repository public.

## License

No license file is included, so all rights are reserved by default. Add one only if you decide to share the code.

## History

The README that covered releases up to v0.8.13 is preserved at [`docs/history/README-through-v0.8.13.md`](docs/history/README-through-v0.8.13.md).
