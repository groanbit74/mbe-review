# Run the Building Editor on your own computer

Two ways. Both keep your jobs as plain JSON files in `data/editor/` next to the program; nothing
is sent anywhere, and the editor only listens on your computer / trusted LAN.

## A. Windows 10/11 x64 – no Python install needed (recommended)

1. Download the package ZIP (`Metal-Building-Editor-<version>.zip`) and **Extract All** into a
   NEW folder you own, e.g. `C:\MBE\` (keep the path short; do not extract inside an old
   installation).
2. Double-click **`Start Editor.bat`** inside the extracted `Metal-Building-Editor` folder.
   (If you extracted the *source* ZIP instead, the same launcher is in its `windows\` sub-folder and
   works from there since v0.8.27: the runtime is created inside `windows\`, the job data in
   `data\editor` at the source root. Keep the folder path short, e.g. `C:\MBE`.)
   * The first start downloads a private, hash-locked Python runtime (about 50 MB, from
     python.org / pypi.org only) and the three locked wheels listed in `runtime-lock.json`.
     Internet is needed only for this first start.
   * If Windows SmartScreen asks, choose *More info → Run anyway*; if Windows Firewall asks,
     allow **private** networks only.
3. The console prints `This computer: http://localhost:8010/` and opens your browser.
   Keep the console window open while you work; press **Ctrl+C** to stop.
4. Saving is automatic. The job you are working on is `Metal-Building-Editor\data\editor\job.json`,
   and **every job is also filed under its job number** in
   `Metal-Building-Editor\data\editor\jobs\<job number>.json` (a timestamped copy of the open
   job is placed in `backups\` at every start).

## Saving and opening

* **Saving is automatic.** Every edit is written to `data\editor\job.json` and filed under the job
  number in `data\editor\jobs\`. There is no Save button to forget.
* **Save job file…** (header) downloads the open job as `Job-<number>.json` — a copy for e-mail,
  another computer or a backup. **Open job…** (header) is the job list.
* **If the page shows an older version number than the one you started** (top-left, "detailing
  editor vX.Y.Z"), the browser is showing a page it kept from an earlier installation: the editor
  refuses to work with it and asks you to press **Ctrl+F5**. Nothing is lost.

## Working on several jobs

* **Job ▾ → Open job… (job list)** shows every job with its number, customer, building size and
  the time it was last saved. **Open** switches to that job; the job you leave stays in the list
  exactly as you left it – nothing has to be saved first. The same list is offered at start-up
  (*Open a different job…*) when more than one job is present.
* **Job ▾ → New job…** starts another job on the shop standard (SSS products pre-selected in the
  frame wizard; every value stays editable). The number proposed is the next free one after the
  highest number in the job list — job numbers start at 356; the four sample jobs take 356–359
  (356 carport, 357 roof only, 358 three-sided, 359 enclosed), so the first real job is 360 — and can
  be changed; a number that is already listed is confirmed first. *New job…* then asks for the starting
  option: blank (the frame wizard) or a copy of one of the four sample buildings under the new number.
  **Job ▾ → Duplicate job as…** copies the open job under a new number (e.g. a revised quote) and
  continues in the copy.
* **Samples ▾** (header, next to *Job ▾*) opens one of the four sample buildings that every job list
  starts with (customer SAMPLE, SSS shop standard) with one click: **356** mono-slope carport (20' × 40' × 8'
  low eave, 2 bays @ 20', 1:12, 4x4x11 ga tube posts, doubled open-face channel I-rafter inside, single channel
  end rafters, 6" purlins inside the channels, post footings), then the 40' × 60' × 12' buildings
  (3 bays @ 20', 1:12): **357** roof only (rigid frames at both ends, post footings), **358** three-sided
  (end walls and back sidewall sheeted, front open, post footings, girts 1'-0 / 4'-8 / 8'-4), **359**
  fully enclosed (slab, base angle + girts 4'-0 / 8'-0) — or the Clark Jordan reference. *Job ▾ → Load
  sample job…* offers the same list. Edit them freely; opening a sample again shows your edited copy
  (a job list filed under 0.8.29/0.8.30 keeps its old numbers and only gains the carport).
* **Every new job starts FULLY WELDED (v0.8.39)**: rafter on the column seat, flush girts welded to the column
  web (coped, no clip), one-piece **cut-and-fold** ridge on gable W frames — the samples too. *Connection
  option* offers the bolted brackets and the welded apex box, *Welded gable ridge* the shared 1/2" plate, as
  options. **Bracing is BY OTHERS** (general note only). **Sheets never without wall girts:** switch a wall of
  a roof-only job to *sheeted* (Walls step or the *Wall sheets* box) and the shop girt lines (and, on an end,
  the standard bearing end wall with posts and girts) are filled in; a sheeted wall that still has no girt is
  a red **RELEASE CHECK** item in the banner under the geometry bar. The erection set (R / E / S sheets) is
  drawn in one style at full 22x17 size with a member table on every frame line and on every side wall
  (marks above the columns, the cut mark on every girt and eave strut).
* **Shop rules on every new frame** (Building settings): girts from the eave height and foundation
  (slab: base angle + girts at 5 ft maximum; post footing: first girt 1'-0 above the floor, then 5 ft
  maximum; a walk door fixes the 7'-3 header girt) — the *Standard* button next to *Girt elevations*
  re-applies the rule after edits; purlins evenly spaced at 5 ft maximum from the eave strut to the
  ridge purlin; end walls with the W preset rafter bypass (rake angle on top of the purlins), posts
  centred by width (30' = 15/15, 40' = 20/20, 50' = 20/10/20), *End wall enclosure* = sheeted or OPEN,
  *End rafter override* = *channel* for an open-face channel matching the purlin depth (6" / 8" / 10";
  flush — the purlins sit inside the channel 1/4" from the web, welded to the flanges, no clips);
  walk doors take the girt above as their header, overhead doors get full-height jambs.
* **Flush girts** (*Girts* = flush): sidewall girts are welded directly to the column web (bay less half
  the web each end less 1/8", outer flange coped around the column flange; tubes: flat face, no cope —
  4x4 columns give 19'-7 7/8" interior bays and 19'-5 7/8" end bays) or — *Flush girt attachment* =
  stock clip — on a stock purlin clip welded to the web (6" girt 3x5, 8" 5x7, 10" 7x9; girt inside to
  inside of the flanges less 1/4"). End members stand with their outside face on the end wall line.
  End-wall flush girts weld to the corner column's inside flange / tube face and to the post webs; at an
  open-face channel upright the girt butts the flat side on one bay and sits inside the open face 1/4"
  from the web on the other (an end inside an open face carries no 1/8" - the 1/4" setback is the
  leeway). Purlin / girt bays butt at the interior support centre line (*A_butt*, the shop standard);
  the MBCI *A_simple* pattern keeps its 1/4" cutback at every interior support. **Rafter seat** (welded
  frames): on top of the pitch-cut column, or inside flange / face - column to the rafter top line,
  rafter welded to the inside face, cap plate on W rafters only; open-face channel rafters butt at the
  ridge with 3/16 x 5 x 7 face splice plates. The carport uses it on every rafter (end walls: *End
  post head* = side welded). **Bays along the length**: 20 ft standard, odd bay in the middle, every
  bay editable on the bay layout card; the frame lot follows the grid.
* **Lean-tos** (*Lean-to settings*) follow the shop rules: *Connection to the main building* = welded
  directly to the main column (rafter cut plumb, butted to the outside face, no gap - the standard),
  welded clip with the rafter 2" clear of the column (option) or a bolted end plate (legacy); *Rafter
  seat at the lean post* = inside face (post to the rafter top line, rafter side-welded, no cap on an
  open-face channel rafter - the standard), on top of the post, or follow the main frame. Open-face
  channel lean rafters (depth = lean purlin depth, 6" / 8" / 10") carry the purlins in the channel:
  bay − 1/4" each end, rows at 5 ft maximum from the main column to the post line. *Add lean-to*
  starts with these defaults; a lean-to on the standard detail reaches COMPLETE.
* **Which walls are sheeted is always your choice.** *Building settings → step 1 → Walls* has one
  Sheeted / OPEN select per wall of the main building (front sidewall, back sidewall, left end wall,
  right end wall; all sheeted on a new job). An open sidewall has no girts, base angle, panels or trim;
  an **open end wall has no interior posts** - the end rafter spans corner column to corner column
  as a rigid end frame of the main sections (*Interior end posts* on each end-wall card: standard =
  only when the end is sheeted; *always* keeps them on an open end; *never* removes them from a
  sheeted end, which then has to clear the girt stock length). The *Lean-to settings* dialog has the same choice
  for every lean-to wall (outer wall, start end, finish end, and the main wall under the lean) - **a
  new lean-to is roof only**. A lean-to can cover the whole length or a range of main bays ("2-3");
  lean posts stand on the main framing lines; sheeted lean walls get girts under the flush shop rules
  (tube face, W web weld with cope, or stock web clips), end posts when a sheeted end is wider than
  20 ft, panels, base / rake angle, corner and rake trim and - for a lowered lean roof - the
  custom-formed wall-to-roof transition; a lean roof that continues the main roofline gets no
  flashing. The erection set gains a *LEAN-TO WALLS* sheet; open walls print no empty panel pages.
  A lean roof that **continues the main roof plane** follows the shop rule *roofline = top of
  purlin = eave height*: a channel lean rafter keeps its purlins in the channel and rises to the
  roofline, a W lean rafter tops out at the bottom of the purlin. Its plumb high end is welded
  directly at the main column line - to the column face, on the column seat beside the main rafter
  end when the depths match, otherwise to the main rafter end and the eave strut; the part of the
  rafter end above the column top (eave strut zone) is no hold.
* **Openings**: the stock overhead doors **8x8, 10x10, 12x12, 14x14 and 16x14** are one-click
  buttons (any other size: add one and type the width / height); walk doors stay 3'-0 x 7'-0.
* **Insulation is by others**: the cover sheet carries the general note; no insulation quantities.
* **Welded buildings - girts welded to the web, no clip.** Switching the connection option to fully
  welded sets the girts flush and welded directly to the column web (coped at the flanges); nothing is
  ordered or drawn for a girt clip (the column sheet dimensions the girt stations with the weld
  callout, the connection schedule says DIRECT-WELD). *Stock purlin clip welded to the web* remains
  the option.
* **Welded gable ridge: shared plate or CUT AND FOLD.** *Building settings → Connection construction
  → Welded gable ridge (W rafters)*: the shared 1/2" ridge plate (two rafter pieces per frame) or
  **cut and fold** - the W rafter stays ONE piece: a wedge 2 x depth x tan(pitch) wide at the bottom
  flange (2" on a 12" rafter at 1:12), apex at the underside of the top flange, is cut out of the
  bottom flange and the web, the rafter is folded on the top flange to the pitch and the seam is
  welded. No ridge plate, no ridge connection. The RIDGE sheet gives the shop numbers: blank long
  point to long point (the wedge is included), bottom of knee cut to bottom of wedge for each leg,
  the wedge width and depth; the rafter sheet shows the one-piece blank with the purlin clips of both
  legs stationed from the left long point. Purchasing orders the longer stock the one-piece rafter
  needs.
* **Base angles over 20 ft** (the 25 ft optional bay, an end wall without posts) are laid in 20 ft
  stock sticks plus the remainder automatically - the job is not held for "stock segmentation".
* **Triple-S Steel is the primary supplier of every job**; MBCI stays the option in *Supplier
  PRODUCTS* / purchasing. Headings and messages no longer name MBCI as the default.
* Changing the job number in the header moves the job's entry to the new number. If that number
  already belongs to another listed job, the file is kept as `<number>~2.json` and the list marks
  the duplicate number – nothing is overwritten.
* **Delete** (in the list) moves a job to `data\editor\jobs\deleted\`; it is never destroyed by the
  program. The open job cannot be deleted.
* Back up or carry jobs by copying the `data\editor\jobs` folder, or use **Download** next to a
  job in the list.

## Bringing a job from another computer / an older installation

* **Open job… → Import from a previous installation…** (v0.8.28): type the folder of the old
  installation (for example `C:\mbe8.22`). Every saved job found under it — `data\editor\job.json`,
  `data\editor\jobs\*.json`, recovery copies, the start-up backups in `backups\`, downloaded
  `Job-*.json` / `job_json.txt` files — is added to the job list; only the newest copy of each job
  number is taken and the older copies are counted as skipped. Nothing in the old folder is opened or
  changed, and the job you have open stays open. Repeating the import adds nothing twice.
* **Open job… → Add job files to the list…** picks one or more job files in the browser and files
  them the same way without opening them.
* **Job ▾ → Open job file…** (also available from the job list) and pick the file: a
  `job.json` or `jobs\<number>.json` from another installation, a file downloaded from the job
  list, or the `job_json.txt` produced by **Job ▾ → Download saved job (.txt)**. The job joins
  the job list under its number; if that number is already listed you are asked whether to
  replace the listed job (the replaced copy goes to `recovery\`) or keep both.
* **Round 14 - the shop-standard connection** (v0.8.44): *Building settings* step 2 **Main frames** holds
  every connection decision in one place (rafter seat, construction, gable ridge, purlin fit, foundation,
  base, plates, brackets, clips, weld size - nothing collapsed). The rafter top is the roof line and the
  purlins are always flush to it, so a welded column runs to the rafter top line at **eave height**;
  *Rafter seat* = **inside flange** (shop standard) or **on top of the column seat** (option). The gable
  ridge is the one-piece cut-and-fold rafter by standard, the shared 1/2 in ridge plate is the option.
  Where a bay's two columns stand at different grades (sidebar *Column grades*), the sheets and the base
  angle of that bay are **ordered longer** - to the lower slab - and the transition sheet is cut to fit on
  site; *Clear the higher slab* is the option in the grades dialog.
* **Round 15 - roofline, eave height, purlin fit** (v0.8.45): the roofline is the TOP OF THE ROOF PURLIN and the eave height is the TOP OF THE EAVE PURLIN; the main building reports eave AND peak (peak = the actual highest point of the roofline) and every lean-to reports its own eave height. BYPASS is the standard fit again - the purlin bears on the rafter top flange: the terminal piece runs to the end rafter flange OUTER edge (rake angle over the ends), the interior pieces split at the rafter CENTERLINE, a stock length may run over an interior rafter with no break, and a lapped (Z) piece overhangs the intermediate rafter at evenly spaced joints. FLUSH mount: on a W rafter a clip is welded to the rafter web and the purlin is square cut 1/8 in total clear of the flange edge; inside an open-face channel the purlin sits 1/4 in from the web. Column height = eave less the purlin when the rafter is welded to the column flange with bypass purlins (the standard), less the rafter too when the rafter sits on the column seat, and the plain eave height for the flush pair. *Building settings* step 4 runs now take a purlin STOCK LENGTH and a joint LAP for a stock-length lay.
* **Round 16 - purlin lay, suppliers, prices, erection drawings** (v0.8.46): purlin stock lengths land
  on rafter CENTRES and span whole bays (15+15 = one 30 ft stick; never spliced between rafters); SSS
  Zee purlins default to a 12 in lap centred on the rafter (stock = bay + 1 ft); eave struts break at a
  column that reaches eave height. MBCI standard set: 8 in Zee 16 ga (20 ft bays) / 14 ga (25 ft).
  *Price book / material list* on the Materials page prices the internal workbook's Material List
  sheet, which keeps each supplier's own labels (SSS PN8ZEE / MBCI MBCI-Z-...) in one format;
  unpriced lines never block a job. Erection drawings: frame lines 1..N first, member tables moved
  to one Frame Line Member Schedule, dimensions on the pieces (rafter/column cuts, purlin station
  chain along the slope, out-to-centre set-out), roof sheet raised with a true-scale ridge cap, and
  opening a sample asks for the building size in the opening dialogue. The End rafters dialogue has
  the corner-column seat chooser (seat / inside face / direct weld).
* **Customer view trim / sheeted outer end** (v0.8.52): rake trim shows on the gable ends; door
  jamb and head trim are 1 1/2 in faces with the head out-to-out of the jambs; the end wall past
  a roof-only extension can be **Sheeted now** (*Outer extension end* in step 1) - girts, sheets,
  panels and trim, and the customer left-endwall view shows it sheeted.
* **Customer view** (v0.8.48): *Outputs* has a visible **Customer elevations PDF** button - the four
  exterior elevations with sheets and trim in the job colors, to show your customer. The wall
  sheets sit outside the frame (on the girts), so columns and posts no longer stick through the
  sheeting; only steel that is really outside a wall (lean posts under an open lean) shows, and
  posts stop at the ground.
* **Round 17 - dimension and foundation rules** (v0.8.47): corner/end columns are dimensioned
  OUT-TO-OUT and only intermediate columns to centre; the eave purlin is drawn at the wall line
  (top = eave height); lean-tos stand in post holes even on a slab building unless *Slab* is
  chosen for the lean itself; the 6 in slab is drawn under the MAIN building only and the ground
  line is flown out dotted to the lean-to posts (no slab under a lean-to); a lean-to is drawn
  only on the frame lines its run spans (end lines included when it runs full length); a
  post-hole building buys no CAB1 base angle (the angle on it is the rake angle).
* **Lean-to over some bays / rafter per lean frame line** (v0.8.42): in *Lean-tos* give the bay range
  (bays are numbered from the LEFT end on either side), pick the rafter at each lean frame line (*Standard rule*
  = single open-face channel at the ends, doubled I inside; or a W) and, for W lines, *Roof secondary fit*
  FLUSH (rafter top at the roofline) or BYPASS (a purlin depth lower, shorter post). The lean rafter sheet
  lists blank, plumb depth, top at the column and the post cut per line.
* **Column grades** (v0.8.43): sidebar *Column grades* lists every column (main columns per frame line and
  side, end-wall posts and jambs, lean posts) - type the grade at that column relative to the set level
  (`-1 1/2` = 1 1/2 in lower = 1 1/2 in longer column; blank = standard). Slab column: top of slab there; post
  in a hole: the GROUND level there. Main columns of different lengths get their own marks (COL-1, COL-1A ...);
  the *COLUMN GRADE SCHEDULE* sheet lists everything. A lean-to can stand in post holes while the main
  building is on a slab: *Lean-tos* > *Lean post foundation*.
* **Jobs saved by an older version** (v0.8.41): a job the current rules cannot open as saved is converted
  to the shop standard automatically when it is opened (the change list is shown once and kept in the job
  file under `settings.upgrade_log`); a job that opens as saved is left exactly as saved. **Job ▾ → Convert
  to shop standard (SSS)…** does the same on request: another supplier's products become the SSS equivalents
  of the same family and depth, the job-wide policy becomes SSS primary, a lean-to on the old clip gets the
  standard welded-direct connection, and every change is listed.
* Or, with the editor stopped, copy the file to `Metal-Building-Editor\data\editor\job.json`
  and start again; choose *Resume saved job*. It is filed in the job list at that first save.
* Installations older than v0.8.23 had no job list: their `data\editor\job.json` is filed at the
  first start with the new program files, and any earlier jobs that survived as recovery copies
  (`data\editor\recovery\`) are imported once.

`Repair runtime.bat` re-creates the private runtime if it was damaged; your job is untouched.
Change the port in `settings.json` if 8010 is taken.

## B. From source on Windows, macOS or Linux (Python 3.10 or newer)

```bash
# 1. unpack the source ZIP (or clone the private repository) and enter the folder
cd building-editor

# 2. one-time setup in a private virtual environment
python -m venv .venv
# Windows:  .venv\Scripts\activate         macOS/Linux:  source .venv/bin/activate
pip install -e .

# 3. start the editor (creates data/editor/ with an empty job on first start)
python -m mbdp.cli editor --workspace data/editor --port 8010
```

Then open <http://localhost:8010/>. Stop with Ctrl+C. Optional: `pip install pytest && python -m pytest -q`
runs the regression suite (private-fixture tests are reported as *skipped*).

If you downloaded the Windows package instead of the source, `python launcher.py` does the
same thing on macOS/Linux (it creates `.venv` next to the launcher and installs the locked
requirements).

## What is in this build (v0.8.25 – consolidation review)

* **Foundation option** (v0.8.27): *Building settings → Foundation* — **Slab** (columns on base plates at the
  top of slab) or **Post footing** with hole depth and diameter inputs (standard 18 in × 3 ft). Post footing
  drops the base plates and adds the hole depth to the column, end-wall post and lean-to column lengths;
  the cross sections show the holes and the column shop sheet carries a FLOOR LINE mark.
* **Three print packages** (v0.8.25): *Outputs…* is organised as **Erection set** (22×17: cover +
  index, one cross section per distinct frame line, end walls, side walls, roof — each with its
  sheeting elevation and the panel / trim tables beside it), **Shop set** (11×17: shipping list,
  every assembly sheet, cut sheets, weldments, fabricated plates two per sheet) and **Purchasing**
  (supplier workbook / PDF, internal shop spreadsheet). The full archive of every generated sheet,
  the CAM exports and the raw data moved under *Archive & references* (opt-in). Standard-detail
  PDFs placed in `data/editor/details/` are appended to the erection PDF as the D series and listed
  on the cover. The **Drawing status** select (REVIEW watermark / FOR CONSTRUCTION) is saved with
  the job and printed in the title block of every sheet; a sheet carries one red line only when it
  has a concrete open item (the release check lists the same items).
* **Save conflict check** (v0.8.25): a save from a window that loaded an older revision than the
  one on disk (another window, the job list) is refused and the window offers to reload instead of
  overwriting the newer job.

* **Master order table page** (v0.8.24): *4 · Materials → Master order table* opens the order as a
  page in the drawing pane instead of a pop-up — supplier lines per department, the stock → piece →
  building-location trace under each line (*Trace ▾*, *View drawing* jumps to the sheet), the
  review entries, a filter box and the five purchasing exports as buttons at the top. *Stock & order
  rules…* opens beside the page; saving rebuilds the order and keeps the panel open.
* **Tab strip shows one family at a time** (v0.8.24): the tabs above the drawing are the views of
  what you are looking at — a member shows *Whole frame · Assembly sheet · Cut sheet · Pieces*; a
  frame sheet shows the frame family (building dimensions, whole frame, frame lines, sidewalls, roof
  plan, eave / ridge details); endwalls, secondaries, cladding, lean-tos and the order sheets each
  show their own family, with a label in front saying which. The sidebar and the Sheets list reach
  every family.
* **Job list** (v0.8.23): every job is kept under its job number and can be reopened by name
  (*Job ▾ → Open job…*); duplicate, delete, download and import per job. Earlier builds only
  kept the last job saved plus a recovery copy of the job before it.

* Numbered 5-step sidebar (Building → Framing → Sheets & trim → Materials → Sheets), Outputs
  dialog by audience, grouped sheet list, in-app viewer – see `docs/specification` and the
  review report that accompanied this build.
* **Frame-line drawings**: one elevation per frame line (`FL1-…`, `FL2-…`), front/back sidewall
  framing elevations and the roof framing plan, all under **Sheets → Frame lines**.
* **Roof datum rule**: interior rigid frames carry bypass purlins (roof line = rafter top +
  purlin depth); end-wall rafters are **flush** (roof line = top of the end rafter = top of the
  purlin). Lean-tos follow the same rule. An end can still be set to *Bypass* explicitly in
  its wall card.
