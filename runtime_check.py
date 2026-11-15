"""Read-only application/export self-test for the private Windows runtime.

Works with ANY saved job: a brand-new installation ships an empty job (no demonstration
building), so when the saved job has no managed frame yet the test builds a small frame in
memory only. Nothing is written to data/editor.
"""

import sys
import tempfile
from pathlib import Path


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

import ezdxf  # noqa: E402
import openpyxl  # noqa: E402
import pymupdf  # noqa: E402

from mbdp.detail.drawing import render_dxf, render_pdf, render_svg  # noqa: E402
from mbdp.detail.drawing.building_sheet import building_sheet  # noqa: E402
from mbdp.detail.drawing.frame_sheet import frame_sheet  # noqa: E402
from mbdp.detail.drawing.frameline_sheets import frameline_sheet, roof_plan_sheet  # noqa: E402
from mbdp.detail.model import D, Job  # noqa: E402

saved = APP / 'data/editor/job.json'
job = Job.loads(saved.read_text(encoding='utf-8')) if saved.exists() else None
state = 'saved building readable'
if job is None or not job.settings.get('frames'):
    # Empty / first-launch job: exercise the real generator on an in-memory frame instead.
    from mbdp.detail.frame import FrameParams, generate_frame
    from mbdp.detail.templates import standard_parts

    job = Job('RUNTIME-CHECK', '', parts=standard_parts())
    generate_frame(job, FrameParams(endwalls=dict(enabled=True), length=D("40'")))
    state = 'saved building empty or absent (new installation); in-memory test frame generated'
fid = next(iter(job.settings['frames']))
with tempfile.TemporaryDirectory(prefix='mbdp-runtime-check-') as folder:
    t = Path(folder)
    sheet = (
        building_sheet(job, fid)
        if job.settings['frame_layouts'][fid].get('building_geometry')
        else frame_sheet(job, fid)
    )
    render_pdf([sheet, frameline_sheet(job, fid, 1), roof_plan_sheet(job, fid)], str(t / 'check.pdf'))
    render_dxf(sheet, str(t / 'check.dxf'))
    (t / 'check.svg').write_text(render_svg(sheet), encoding='utf-8')
    assert len(pymupdf.open(t / 'check.pdf')) == 3
    assert len(ezdxf.readfile(t / 'check.dxf').modelspace()) > 0
    wb = openpyxl.Workbook()
    wb.active.append(['Runtime', 'OK'])
    wb.save(t / 'check.xlsx')
    assert openpyxl.load_workbook(t / 'check.xlsx').active['B1'].value == 'OK'
print('Runtime OK: ' + state + '; PDF, SVG, DXF and XLSX exports passed. No job changes.')
