# Changelog

## 0.8.66 - 2026-10-14

### Purlin dimension ladder placement and eave-row/post fit corrections

- Frame-line purlin spacing chains now sit above the rafter and above the roof-sheet dimension label. Lean-to spacing chains begin at the main-building eave and run out to the low-eave endpoint; main-roof chains begin at the main-building eave. The cut sheet identifies purlin marks/locations, the low-eave datum, and the rafter top line.
- The lean low-eave purlin row is set to the post outside face and marked direct-welded to the post/column, even when some adjacent rafter supports are open-face channels. Its longitudinal pieces use the zero-clearance column-support rule. Main eave-purlin symbols place their flange inboard, with the outside face at the column face.
- Frame-line schedule metadata now matches the bottom-aligned schedule layout. Corrected the false opening appearance on the framing elevation remains covered by regression checks.
- Verification: Ruff check and format checks passed; focused purlin/drawing regressions **7 passed**; full clean-clone suite **814 passed, 252 skipped** for 16 absent private fixtures. The regenerated 97-sheet owner drawing set was visually reviewed; customer drawings are delivered separately and are not included in the application archive.

## 0.8.64 - 2026-10-14

### LT1 special open-C ends now display and export as flush channel fits

- Regenerates prior-version cached frame geometry from saved frame inputs on job load and CLI drawing export. This repairs stale layouts that still held W6x9/bypass endpoint geometry even though the saved LT1 inputs already specified `special_open_c`; the user did not need to change the LT1 bypass setting.
- Lean cut sheets now draw a representative physical endpoint line, identify the actual frame line and section, and list purlin fit by physical frame line. Additions/purlin sheets no longer summarize mixed support fits as a global bypass; frame-line coordination views use that line’s profile and cut geometry.
- LT1 acceptance: physical lines 1 and 4 use the matched open-face channel and flush/in-channel fit; lines 2 and 3 retain W6x9 bypass. Cut lengths, head data, purlin schedule, and per-line records remain station-specific.
- Regression suite: 812 passed, 252 skipped for private fixtures. Ruff checks and visual inspection of regenerated endpoint/interior sheets passed.

## 0.8.63 - 2026-10-14

### Special open-C lean endpoints and clearer frame-line sheets

- `special_open_c` lean ends now resolve independently of the selected/default W rafter and interior per-line overrides. End supports use a single open-face channel matched to the lean purlin depth and supplier; interior W6x9 bypass lines retain their section, fit, and purlin-depth deduction. Member generation, rafter/column cuts, purlin end setbacks, and connection/head metadata use the same per-station resolution.
- Frame-line elevations no longer repeat lean/main-roof purlin-spacing chains. Purlins remain visible; station locations, run/piece lengths, and lean spacing stay on the dedicated roof/purlin schedules.
- Reworked frame-line member schedules to include lean rafter and column marks, profiles, and cut/blank lengths while staying clear of the title block. Girt-top dimension chains are staggered beside the frame line; long fit and height notes are split into readable lines.
- Regression/visual review includes special open-C endpoints with W bypass interiors, supplier selection, low-head/cut records, and schedule/layout checks. Clean-clone suite: 811 passed, 252 skipped because private fixtures are deliberately absent; Ruff check passed.

## 0.8.62 - 2026-10-14

### Per-location column-to-rafter connection controls

- Added compact, inherited per-location connection schedules for welded primary rigid frames, endwall supports, and lean-to supports. Primary-frame controls are independent for the left and right physical columns on every repeated frame line; bolted primary frames retain their existing geometry and do not expose unsupported welded-seat options.
- Primary overrides now split welded column/rafter takeoffs where geometry differs, update cut lengths, head attachments and purlin stations, and carry physical marks and selected modes into frame-line drawings, cut labels and member schedules. Gable cut-and-fold, two-piece gable and mono-slope frame paths are covered.
- Endwall and lean-to overrides preserve inherited defaults and only offer supported connection modes at each location; support-specific geometry and drawing schedules reflect the selected modes.
- Added regression coverage for mixed-mode primary frames, endwalls and lean-tos. Full clean-clone suite: 808 passed, 252 skipped because private fixtures are deliberately absent. Ruff, JavaScript syntax and diff checks pass.

## 0.8.61 - 2026-10-31

### Pitch-cut added endwall posts and separately sized endwall girts

- Added intermediate endwall uprights and roof-bearing opening jambs are now pitch-cut to the rafter underside and directly welded, regardless of the corner-column seat/face choice. Corner/main columns retain their existing inside-face, on-seat, and direct-weld options; the existing corner clearance remains a corner-only setting. Direct added-post heads remain fabrication-fit review items, not an engineering approval.
- Consolidated endwall editing into **Building settings → Endwalls & openings**. Removed the second left-pane editor; endwall/frame-line elevation sheets remain review outputs and state where their inputs are edited. Their corner-connection depiction follows the selected corner option.
- Added an **ENDWALL GIRT** product selector to **Secondaries**. Blank follows the sidewall girt; an explicit supplier Cee/Zee can set endwall-girt size independently. The chosen profile flows through endwall horizontal members, bearing-jamb/header defaults, endwall product schedules and drawings. Existing endwall elevations and fit mode remain shared; no sidewall lap rules or capacities are inferred.
- Added regressions for added-post head geometry and corner-choice preservation, bearing-jamb heads, separate endwall girt selection, and the consolidated editor. Full suite passes.


## 0.8.60 - 2026-10-31

### HSS opening uprights no longer report unknown section or unresolved endwall cuts

- HSS opening jambs/uprights now enter frame purchasing as tube demands, using the selected HSS size, nominal wall, calculated weight, HSS grade/finish and normal stock planning. They no longer go through the cold-formed secondary catalog lookup that raised `UNKNOWN PROFILE`.
- For bearing HSS jambs on endwalls, interrupted girts and base-angle runs now resolve to the selected HSS outside-face envelope with square cuts and no cope. The flush-girt rule retains its face deductions and 1/8-in total fit; bypass/base-angle blanks subtract the tube half-width at the affected end. Only HSS-supported rows are resolved this way; unsupported non-HSS receiving geometries keep their existing review status.
- Added regressions for sidewall HSS jamb ordering and endwall bearing-HSS girt/base-angle setout. Full test suite passes.


## 0.8.59 - 2026-10-31

### Excel keeps the pricing dropdowns when opening the workbook

- Fixed the remaining Excel repair reported for `pricing.xlsx`: the size-validation list used inline text containing inch marks and other punctuation, which Excel removed from `sheet1.xml` while opening. Pricing material, unit, and size dropdowns now use workbook-defined named ranges stored on the hidden reference sheet. The Size dropdown resolves from the selected Material, and dimension strings with quotes/commas no longer corrupt validation XML.
- Regression checks validate the workbook XML, formulas and cached values, plus all three named-range dropdowns. The full test suite passes.


## 0.8.58 - 2026-10-31

### Pricing Excel compatibility, all-category order, customer end datum, custom posts, HSS opening jambs, common-first section lists

- Pricing workbook: replace regex-based cached-value XML edits with node-safe OOXML updates. Formulas remain live against the editable Price book; cached unit prices, line totals and totals still show immediately at open. All workbook XML parts are validated by regression tests.
- Supplier workbook: add an **All items** worksheet consolidating Frame, Secondaries, and Sheets / Trim under simple category headings, set to print on one landscape A3 page. The individual category sheets remain.
- Customer elevations: on both long-side views, clip displayed frame steel to the 0 / building-length end datums. This is a view-only crop; it does not change steel geometry, cut lengths, or roof-sheet/eave overhangs.
- Custom endwall post entry: in Endwalls & openings, set Post layout to **Editable interior stations** and enter centerline coordinates from the outside-view left end in increasing order. For a 30-ft wall with posts 9 ft 10 in in from each end, enter `9'-10", 20'-2"` (not the same 9 ft 10 in value twice). Station mode derives the bay count/widths from those coordinates, so stale bay widths no longer produce a width-total error. The other endpoint is 20 ft 2 in from the left datum.
- Framed openings: add HSS tubing as an **upright/jamb section** option (not a header option); tube section, nominal wall, and computed weight carry through the member model.
- Common sizes now come first in section selections and workbook size dropdowns: W6x9, W8x10, W10x12, W10x15, W12x14, W12x16, W12x19, W12x22; HSS 4x4 and 4x6 in 14 ga, 11 ga, then 3/16; purlin Cee 4 / 6 / 8 first; open-face channels in ascending 4 / 6 / 8 in order. Remaining sizes follow by increasing size.


## 0.8.57 - 2026-10-26

### Pricing filled in at the start, conversions, quick order, ridge rule

- Pricing sheet: every field is filled when the file opens - stored unit
  prices and line totals are written into the file alongside the live
  Price-book lookups, so the total is visible immediately and editing
  the Price book still updates the sheet in Excel.
- Footer gains Markup % and Labor: ORDER AMT + markup + labor = FINAL
  BUILDING PRICE.
- Units rechecked against the quotes: W beams and ALL secondaries
  (purlins, eave struts, open-face channel, tubing, base angle) by CWT;
  clips per each; sheets by CSF; trim per foot.
- Special (fabricated) clips are no longer individual pieces on the
  supplier order or the pricing sheet: they are figured as ONE full
  hot rolled strip (3/16 x 4 x 20 ft) in both.
- New CONVERSIONS page: a price-per-foot calculator for all CWT and CSF
  items (type a CWT/CSF price, get $/lb, $/sq ft, $/lin ft, plus the
  per-size $/ft table for everything on the job).
- New QUICK ORDER page: a blank standard order sheet with pricing -
  Type and Size dropdowns (beam / purlin / open face / tubing / base
  angle / rake angle / sheets / trim), preset blank rows: 3 beam, 5
  purlin, 4 open face, 2 tubing, 2 base angle, 2 rake angle, 5 sheets
  and 2 each of rake, head, jamb, ridge, corner, eave, base and sill
  trim; quantity and length (inches) typed in, prices from the book.
- Ridge trim is figured in EQUAL lengths up to 20'-6" with a 6 in
  overlap (all other trim keeps the job lap rule).


## 0.8.56 - 2026-10-26

### Pricing workbook in the supplier's quotation units

- New PRICING XLSX download (beside Supplier XLSX on the Master order
  page), built from the material list and modelled on the owner's SSS
  quotations: beams / purlins / open-face channel / tubing / strip priced
  by weight (LBS @ $/CWT), sheets by area (SFT @ $/CSF on the 38.25 in
  gross width), trim by the foot ($/FT), accessories and doors per each.
- Editable: Material and Unit are dropdowns, Size is a dropdown of the
  sizes on the job for that material, Quantity / Basis / Unit price can
  be typed over. Weights are computed from the sections (W lb/ft, cold
  formed developed width at 14 ga, plate volume).
- An editable PRICE BOOK sheet is seeded from the owner's Oct 2026 SSS
  quotes (WF 140/CWT, Zee purlin 85/CWT, channel 75/CWT, strip and plate
  113/CWT, Galvalume 106/CSF, color panels 128/CSF, ridge 2.53/ft, rake
  2.26/ft, sculptured corner 2.67/ft, door jamb 1.16/ft, head 1.17/ft,
  purlin clips 0.75 / 2.95 EA); the Pricing sheet pulls prices from it by
  Material + Size, falling back to the material-only price.
- Footer follows the quote: Material subtotal + Freight / processing +
  Tax (8.25 % seeded, editable) = ORDER AMT. Unpriced lines stay blank
  and never block a job.
- Supplier order sheets gain a Length (in) column beside the ft-in
  length (supplier order only, as requested).


## 0.8.55 - 2026-10-26

### One drawing style, dimensions on the drawing, a short supplier order

- Consistency: the separate door opening sheets are deleted - openings are
  folded into the wall / frame-line framing sheets where they are drawn
  and dimensioned in the same style. The lean-to sheets (lean section,
  lean purlin lay, walk-door fit) are redrawn in the set's black,
  thin-line style - no blue/red thick-lined abstract pages.
- Erection and frame-line drawings carry dimensions and member marks
  only. All other notation (ground/slab datum, peak meaning, eave purlin
  position, bay states, girt/lean descriptions, opening clear sizes)
  moved to NOTE lines and captions in the sheet margin.
- Supplier order workbook rewritten short: Part number (from the drawing
  sheets), Quantity, Length, Supplier part number (no SSS-/MBCI-
  prefix, blank when unspecified), Specification kept short (e.g.
  PBR 26ga), a brief Description (e.g. TRCRS - Corner) and a short
  Location (roof sheets, corner trim, end wall, side wall, door trim,
  rake trim, main column, endwall girt, ...).
- Eave and base trim are an OPTION (Sheets & trim, off by default) -
  never added automatically.
- Master geometry sheet: the bottom note block is deleted and the
  building plan is drawn bigger.
- Editor: the Parts library is removed from the left pane.


## 0.8.54 - 2026-10-18

### Owner follow-up on the erection notes round

- The roof sheet is DIMENSIONED on the frame lines (a slope dimension line
  with ticks, one overall length per slope; the eave overhang dimensioned
  apart), not just lettered. A main-plane lean sheet dimensions ridge to
  lean eave in one piece.
- Purlin station chains now run on EVERY frame sheet (end walls included),
  on BOTH slopes, starting at the OUTSIDE EAVE PURLIN and going up the
  slope; lean purlin stations chain from the LOW LEAN EAVE.
- Eave purlins draw OUTSIDE the columns with the outside face flush with
  the outside edge of the frame (main eave and lean low eave alike).
- Roof framing plan: the top and bottom information blocks are removed -
  only the sheet label and the title block remain - and the plan itself
  is drawn bigger.
- Roof framing spacing is never locked: the first-purlin / spacing /
  datum fields stay enabled; typing in them turns "Automatic equal roof
  spacing" off (the checkbox is named in the field label).
- Trim on sheeting pages is drawn at its actual size: corner trim is a
  4 in wide band at each wall end; rake trim runs out to the edge of the
  roof (extended past the wall by the eave overhang).
- Lean rafter shop sheet renders the doubled open-face I-rafter SECTION:
  (a) channels welded back to back, or (b) a 1/8 in plate the width of the
  open face sandwiched full length - chosen per lean-to in the dialog.
- New lean END rafter option "Special open-C": a C purlin cut to pitch,
  flush-welded to the low lean column and extending into the main
  building's open-face end rafter against its flat face, plus an open-face
  Cee cut to pitch at the column, welded to column and C purlin, stopping
  1/2 in from the sheet with its flat welded to the open part of the C
  purlin. Both pieces are cut, listed and drawn (dashed) on the lean
  rafter sheet.


## 0.8.53 - 2026-10-18

### Erection drawing notes round (owner's 18-page marked set, 20x50 roof-only extension)

- Frame-line sheets draw in the whole-frame language: members WHITE, lean-tos
  and the roof line BLACK (all blue wording gone), vertical dimensions dragged
  out to the edge of the drawing, and the member list is a full-width table
  across the bottom of the sheet, one row per member type.
- Wall girts are dimensioned on a dimension line beside the eave dimension,
  always to the TOP of the girt; the duplicate girt labels are gone. The
  "rafter top at the ridge" note and the "inside face to inside face" door
  dimension are gone; the roof sheet is measured along the slope with the
  eave overhang included, and purlin stations start at the OUTSIDE EDGE of
  the column (lean purlins likewise, out from the main wall).
- Walk doors draw with their 2.5 in flange all around on the framing
  drawings (not on customer/sheeting views) and the base angle stops 1/2 in
  clear of the door face. Opening jamb posts are measured to the FACE of
  the opening in the post chain, and the setout is not drawn twice.
- Side walls: lean-tos are off these drawings entirely; corner columns -
  including the junction column of an enclosed/roof-only building - sit
  with their outside face on the frame line, so the bay dimensions read
  out-to-out (20 + 15 + 15: the enclosed building is 30 ft out-to-out).
- Lean-to section sheets are deleted (the frame lines section every lean);
  open lean walls carry no girt lines or labels.
- Sheeting pages: every sheet carries its mark AND its length; corner trim,
  rake/eave trim and ridge trim are drawn on the elevation with their runs.
- Roof-only extension bay at an inside wall: the bay measures 20'-1 1/2"
  outside edge of frame line 1 to inside edge of the inside wall FOR THE
  SHEETS; the lean purlins in that bay stay 20'-0" and land on a clip
  protruding from the inside wall (shown on the roof plan and in the piece
  status). The roof-only outer end line draws ground, not slab.


## 0.8.52 - 2026-10-17

### End walls have their own dialogue

- The "End walls & end rafters..." button opens the dedicated End walls
  dialogue (it previously opened the wizard tab; the dialogue itself had
  no caller). One section per end wall, including the outer end of a
  roof-only extension: end rafter, purlin fit, corner-column seat.
- The corner seat is a visible a/b/c choice and always changeable:
  (a) inside face - corner column to the roof line; (b) on the column
  seat; (c) direct weld, pitch-cut. The standard only pre-selects.
- FLUSH is no longer silently forced over a BYPASS pick: choosing bypass
  with a channel end rafter swaps the rafter to the W preset and says so
  in the dialogue; choosing a channel sets flush and says why. The wizard
  endwall cards keep the seat in the main grid with the same wording.


## 0.8.51 - 2026-10-17

### Owner round: end columns, lean girts, roof sheets, plan size

- Flush channel end walls run their corner columns to the roof line by
  default (end rafter welded to the inside face); the corner-column seat
  chooser is now only an override. Bypass W end rafters still sit on the
  post. The owner was doing nothing wrong - the seat default was the old
  reference geometry.
- Lean-to girts draw at the lean post on frame-line sections (bottom girt
  first) at the lean's own girt lines; the lean dialog takes lean girt
  elevations of its own (blank = shop rule from the lean low eave).
- Where a lean roof continues the main plane, the frame-line roof sheet
  line runs ridge to lean eave as one sheet, matching the takeoff.
- End-wall opening setout dimensions from the outside face of the nearest
  corner column, never the column centre.
- Sheeted lean walls on the customer elevations draw sheet ribs and eave
  trim instead of a generic block.
- Roof framing plan: line-schedule chart deleted; the plan fills the sheet.


## 0.8.50 - 2026-10-17

### Lean-tos on end walls work

- A lean-to attached to an end wall (the editor's right end wall) no longer
  dies with "Lean roof purlin adapter currently supports side-attached
  leans": the purlin layout, rafter cut planes, lean wall framing and sheet
  surfaces all run in the lean's face-local coordinates on any of the four
  walls, hanging on the end-wall posts (corner centres inset half their
  width count as coincident with the out-to-out lean ends).
- The blanket "ENDWALL attachment face/orientation must be confirmed" hold
  is gone; the welded connection builder resolves face/seat per end-wall
  post exactly as it does on a main column.
- Customer elevations draw end-attached leans (posts, rafters, purlins,
  roof plane, sheeted outer and end walls) on all four views.


One entry per release, newest first. The detailed per-version notes that used to sit in `docs/` are archived
under [`docs/history/`](docs/history/); the standing requirements are in [`docs/specification/`](docs/specification/).
Versions before 0.8.21 were delivered as Windows review packages; their delivery-verification records are listed with them.

## 0.8.49 — customer view trim; the outer end of a roof-only extension can be sheeted

* **Rake trim shows on the gable ends (owner):** it now sits just outside the end-wall
  sheet plane and is drawn on the end views. Jamb and head trim are **1 1/2 in** faces and
  the head runs **to the outside of each jamb** (squared look). A wall's sheets, trim and
  openings are drawn only on the view that faces that wall - no more trim strip floating
  a skin-depth off the building in the neighbouring view.
* **Sheeted outer end (owner):** the end wall past a roof-only extension (bay enclosure)
  can now be set **Sheeted now** (Building settings step 1, *Outer extension end*; the
  step-3 enclosure select drives the same state). It takes posts, girts, base angle,
  sheets, panels and corner/base trim, reaches COMPLETE, and the customer view's left
  endwall shows that sheeted end instead of looking through an open end at the frame.

## 0.8.48 — customer view: sheets outside the frame; customer elevations promoted

* **Customer elevations promoted:** the customer view (four exterior elevations with sheets
  and trim in the job colors) is a visible **Customer elevations PDF** button in Outputs,
  not a folded "extras" link.
* **Frame no longer sticks out of the walls (owner):** the customer view drew wall sheets
  ON the wall line while frame members are centred on / flush with it, so half the column
  and post depth painted over the sheeting. The wall skin now sits 9 in outside the wall
  line (8 in girt + sheet), where it really is; lean sheeting likewise sits outside the
  lean posts. Members genuinely in front of a wall (lean posts under an open lean) still
  show. Exterior members also stop at the ground - post-hole embedment is not drawn.

## 0.8.47 — round 17: corner columns out-to-out, eave purlin at the building edge, no base angle without a slab; slab stops at the main building, lean-to drawn only on the frame lines it spans

* **Dimension rule corrected (owner):** only INTERMEDIATE columns are measured to centre;
  corner/end columns are out-to-out. The frame-line centre set-out chain is gone (width reads
  "OUT-TO-OUT OF CORNER COLUMNS") and end-wall post chains run OUT -> intermediate centres -> OUT.
* **Eave purlin at the edge of building:** on frame-line sections the eave strut is drawn at the
  wall line, tied back to the inset rafter, instead of starting at the rafter.
* **Shop format:** frame-line views carry a plain member list under the drawing (mark | section
  | qty | cut), like the whole-frame shop sheet.
* **Round 17 follow-up (owner preview):** lean-tos now default to **post holes even on a slab
  building** (only an explicit slab choice puts lean posts on the slab - this job's lean-to has
  no slab). Frame-line 4 doors are un-mirrored to their true outside-view position with the
  door dimensions at the **bottom** of the drawing; the blue roof-line wording sits horizontally
  at the eave instead of floating along the slope; end-wall girts are drawn from the **inside
  face of the corner columns**; the **eave purlin is drawn at both wall lines** on interior
  frame-line sections.
* **Foundation on the drawings (owner):** slab buildings draw the slab as a 6 in band with
  "FLOOR = TOP OF SLAB"; post-footing buildings draw a **ground line at floor height** with
  the post holes below it - on frame lines, side walls, lean-to walls and the whole-frame
  shop sheet. The 6 in thickness is the stated assumption (`standards.SLAB_THICKNESS_IN`).
* **Slab stops at the main building (owner preview):** the 6 in slab band now ends at the main
  wall lines; beyond them the floor datum is flown out to the lean-to posts as a **dotted
  ground line** ("NO SLAB UNDER LEAN-TO"), on frame lines and on the whole-frame shop sheet.
* **A lean-to is drawn only where it attaches (owner preview):** frame-line views (erection and
  archive end-wall sheets) limit the lean-to to the frame lines its run actually spans - a
  partial-length lean no longer appears on lines it never touches, and a full-length lean now
  shows on the end lines too, connected to the corner column. Mirrored (rear end) views
  reflect about the view centre so a one-sided lean-to stays on the sheet.
* **CAB1 bug:** post-hole (post footing) buildings no longer buy base angle - `sheet_supports`
  added it regardless of foundation. The angle that remains on such jobs is the rake angle and
  the material list now says so (Base Angle only when a slab/run actually has one).

## 0.8.46 — round 16: purlin stock lengths land on the rafter centres; SSS Zee lap, MBCI standard, price book; erection drawing pass

Owner, 17 Oct: *"typically purlin stock lengths land on center of rafter - 20' bay, 25' bay. Occasionally
a 15' bay and one stock 30' spans two bays with no cut, or 10' and 20' bay. Under no circumstances do we
splice purlin between bays (C purlin). Zees overlap, but do not splice mid bay either. ... the most
efficient option is a 30' purlin spanning over the center bay running end to end. On a flush mount run I
should still use 30' purlin and cut to length."*  The 0.8.45 stock-length lay (joints wherever the stock
ran out, i.e. between the rafters) was a misreading and is retired.

* **Purlin lay (new `mbdp/detail/purlin_lay.py`).** A purlin run is laid in STOCK LENGTHS that always land
  on rafter centres: one stick spans every whole bay it can (15 + 15 -> one 30'-0 stick, 10 + 20 -> one
  30'-0 stick, 20 + 15 + 15 -> a 20 and a 30), the split buys the least stock then the fewest pieces, and a
  purlin is **never spliced between rafters**. Applies to the main roof purlins, the eave members that
  follow the purlin rule, and every lean-to roof purlin row (a lean joint in a channel or beside a flush
  rafter is a break). The stock lengths are the ones the order is bought in (`ordering.stock_lengths_in`:
  an SSS Cee 20/25/30 ft, an SSS Zee 21/26/30 ft, otherwise the Order settings). Flush runs sit beside each
  rafter, so they stay one piece per bay and are cut to length from stock (two 15 ft bays out of one 30 ft
  stick). A designed MBCI lap pattern is left as the structural designer set it. *Purlin lay* =
  `span` (standard) | `per_bay` on the bay layout.
* **Zee lap over a rafter.** `purlin_lap_in` = the TOTAL lap, centred on the rafter centreline (each piece
  overhangs half of it); blank = butt at the centreline. Laps are only ever at rafters.
* **Order result (the owner's 20' + 15' + 15' job).** 30'-0 sticks land exactly (no kerf, no remnant)
  instead of 15'-0 pieces cut from 20' sticks: the purlin and eave sticks of the saved job go from 30
  (690 ft bought, 82.7 ft of remnants) to 20 (550 ft, 1.5 ft of remnants).
* **Channel end rafters now trim the end piece on jobs saved with the old zero-gap flag too** (19'-11 3/4,
  or 29'-11 3/4 for a spanning end piece, cut from the 30' stick); a flush run is never overridden by that
  flag.
* **Wizard defaults (round-14 leftovers removed).** A new frame in *Building settings* opened with the
  purlin fit on FLUSH, and choosing a welded construction forced FLUSH again; both are gone - BYPASS is the
  standard fit on every new frame and the construction switch no longer touches it.
* **Owner answers implemented (round 16, second half).** SSS Zee purlins default to a **12 in lap centred
  on each rafter** when the lap box is blank (SSS Zee stock is bay + 1 ft: a 20 ft bay buys a 21 ft stick,
  interior pieces are bay + 12 in, end pieces carry half the lap; an explicit `0` is a chosen butt). Eave
  struts span like purlins **except at a column that itself reaches eave height**, where the strut is
  welded to the side of the column and that frame line is a break. The **MBCI standard** is now a served
  default set (`standards.MBCI_STANDARD`): 8 in Zee, **16 ga at 20 ft bays / 14 ga at 25 ft bays**
  (suggested on supplier conversion by the job's longest bay), 8x5x3.375 14 ga low-single eave strut,
  2x4 14 ga base angle, PBR 26 ga panels in every colour. **Price book & material list**
  (`mbdp/detail/pricing.py`): the internal workbook gains a *Material List* sheet in the owner's shape
  (Quantity / Length / Size / Shape / Description / Color / Label / price / sq.ft. price / line total)
  filled by the program from the supplier plan, plus the job estimate lines (material, labor, walk,
  rollup, insulation, wall light, slab, roof vent, gutter); prices come from the editor's *Price book /
  material list* dialog (material match, per piece / per ft / per sq ft) or manual lines, and **UNPRICED
  lines never block a job**. Still held for the owner's drawing notes: the drawing-quality / sheet-pruning
  pass.
* **Drawing notes pass (owner, erection drawings).** The erection stack now opens with the **frame
  lines in order 1..N** (interior sections and framed end walls interleaved by line number), then the
  side-wall framing and the roof framing plan in the framing group, then sheeting. Frame-line captions
  name the **main-frame type `MF-n`** instead of the confusing `COL-1` (shop marks stay on shop sheets).
  Purlins are drawn as **single lines** on frame-line and end-wall views. Frame-line views add an
  **overall out-to-out dimension (incl. lean-tos)** under the outside-wall-lines dimension, and the
  members table now also lists the purlin / eave / girt profiles for the line. The cover carries a
  one-paragraph **drawing legend / dimension convention** (roof line, single-line secondaries, out-to-
  centre columns, openings out to inside face). The **material list keeps each supplier's own labels**:
  same columns for SSS and MBCI, plus Supplier and Supplier item columns (SSS `PN8ZEE - ...`, MBCI
  `MBCI-Z-...`), and price-book matches are supplier-specific.
* **Shop-style erection frame lines + two editor fixes (owner round 16).** Frame-line captions drop
  the duplicated member-summary line (title, one fit rule, heights; the schedule table carries the
  members), and the roof sheet + **ridge cap** is drawn raised at the peak. The **end-rafter dialogue
  now has the corner-column seat chooser it was missing** (on the column seat / welded to the inside
  face / pitch-cut direct weld — the `post_head` setting, previously only reachable in Full frame
  settings under a name that never said "seat"). **Opening a sample asks for the size first**:
  width, length, eave height, pitch and bay lengths in the opening dialogue, applied and regenerated
  server-side (`JobStore.customize_geometry`), with "Open as-is" still available. The 4 in in the SSS
  Zee example is the rafter flange width: the centred 12 in lap covers it (2 in each side of the
  centreline) with 4 in to spare.
* **Dimensions on the pieces (owner round 16).** The member table has left the frame-line
  drawings: each view now carries member marks with their cut lengths (rafters lettered
  `mark - cut` along the member, column mark + low-point cut under each column), a **purlin
  station dimension chain along the slope (eave to ridge)** taken from the model's clip
  stations, and opening set-out dimensions **from out to the inside face** plus the clear
  width on end walls. One consolidated **FRAME LINE MEMBER SCHEDULE** sheet (R series, right
  after the frame lines) holds the quantities/cuts for every line. Dimensions are generated
  from the same geometry that cuts the steel, never typed separately.
* **Out-to-centre set-out, roof sheet lift, ghost doors (owner round 16).** Frame-line
  sections gain a **column set-out chain (OUT to centre of each column)** and end-wall post
  chains now run OUT -> centre -> centre -> OUT instead of centre-to-centre only. The roof
  sheet is drawn **raised off the purlin/rafter line** with the ridge cap at true scale
  (7 in of cover each side of the peak, was a 24 in cartoon). The side-wall framing sheet's
  opening table no longer lists end-wall openings - they read as **ghost doors** in the
  side walls; end-wall doors stay on the end-wall views with their out-to-inside-face dims.
* **Supplier rule by construction.** `standards.SUPPLIER_BY_CONSTRUCTION` (welded -> SSS, bolted -> MBCI,
  the owner's general rule) is served in `catalog.layout_rules`, and the Main frames step shows a one-line
  note naming the supplier the rule points at and the one the job is on. Design for the supplier book,
  pricing and editable order lines: `docs/design/SUPPLIERS-PRICING.md` (proposal, not built).
* **Retired:** the 0.8.45 `purlin_stock_in` / `purlin_lap_in` stock-lay inputs (dropped on open with a
  visible note), the run-sheet stock-lay note; `DETAIL_VERSION` 28 regenerates saved jobs once.

## 0.8.45 — round 15: roofline and eave height corrected, the purlin fit is the owner's rule again (2026-10-16)

Owner round 15. Round 14's "roofline is the top of the rafter and purlins are ALWAYS flush" was the FLUSH
case only, over-applied; the corrections below are now the rules, in the model and on the drawings.

* **Roofline = TOP OF THE ROOF PURLIN; eave height = TOP OF THE EAVE PURLIN.** The main building reports
  **eave height AND peak height**, where the peak is the ACTUAL highest point of the roofline (the peak
  purlin top) - `peak_height_in` on the frame layout, dimensioned on the frame, frame-line and shop bays,
  and in the customer elevations. Every **lean-to reports its own eave height**, even when it continues the
  main roof plane; a frame line where a lean-to joins carries three numbers (eave at the lean-to, eave at
  the main building, peak of the main building). The round-14 forcing of `purlin_mode = flush` on welded
  frames is withdrawn: a job saved at 0.8.44 or earlier regenerates once with **BYPASS** and keeps the
  rafter-at-the-column choice (`sync_frames` migration, `DETAIL_VERSION` 27).
* **Column height follows the seat x fit pair - all four cases exist.** (a) rafter welded to the column
  flange + BYPASS (the SHOP STANDARD) = **eave - purlin**, eave purlin bearing on the column seat - the
  owner's 20x50 job is back to `COL-1 11'-6 5/16"` (12'-0" eave - 6" purlin + 5/16" base plate);
  (b) rafter flush to the column + FLUSH = **eave**, eave purlin welded to the outside of the column
  flange (typical on tube columns); (c) rafter on the column seat + BYPASS = **eave - purlin - rafter**;
  (d) rafter on the seat + FLUSH = **eave - rafter**. The purlin-fit select is live again on welded frames
  and its copy states the rule.
* **Bypass pieces.** A bypass purlin **bears ON the rafter top flange**: the terminal piece runs to the
  END RAFTER FLANGE OUTER EDGE (the rake angle is welded over the purlin ends) at both end walls, and the
  interior pieces butt at the rafter **CENTERLINE** with no gap - a terminal bay at an open-face channel
  end rafter is `19'-11 3/4"` (1/4 in from the channel web), and every full bypass bay is the full
  `20'-0"`. The MBCI lap/terminal source pages no longer apply to a bypass fit.
* **Stock-length purlin lay (new, bay layout).** Enter a purlin **stock length** (and a lap at a joint when
  the purlin is lapped) and the run is laid in full sticks from the end rafter flange outer edge: a stock
  length runs over an interior rafter with **NO break**, a lapped piece **overhangs the intermediate
  rafter**, the joint positions are **evenly spaced** (stock less the lap on centers) and the two END pieces
  come out equal and shorter, cut to fit. Blank = one piece per bay (the shop standard). The stock lay is a
  bypass rule; a flush fit or an end-wall roof override on a stock lay is refused by name.
* **Flush mount wording.** Wide-flange rafter: a CLIP welded to the rafter web, the purlin SQUARE CUT
  (no cope) 1/8 in total per bay clear of the rafter flange edge, inside-to-inside of the flange - C and Z
  alike; open-face channel rafter unchanged (purlin inside the flanges 1/4 in from the web, welded top and
  bottom). Flush wall girt = coped around the column flange, welded to the web, no clip. The settings step 2
  and step 3 hints, the purlin-fit tooltip and the run-field defaults were corrected to this vocabulary.

## 0.8.44 — round 14: the shop-standard connection in one place, sheets ordered longer (2026-10-16)

Owner round 14, straight from the shop. Four corrections, applied across the model, the editor and the drawings.

* **Roof line = top of the rafter; purlins ALWAYS flush.** On a welded frame the roof line *is* the top of
  the rafter and the purlin tops are flush with it at every rafter and purlin depth - a rafter deeper than
  the purlin no longer pushes the roofline up, and no purlin depth is deducted anywhere. `purlin_mode` is
  normalized to `flush` whenever a welded frame is generated or saved, and a job saved with the bypass fit
  on a welded frame is regenerated once with the flush fit stored (rule migration). The bypass fit stays
  live for bolted frames, end-wall rake details and lean-to W rafter lines.
* **Column heights / seat.** A welded column runs to the rafter top line and is cut to **eave height**
  (inside flange = the rafter welded between the column flanges is the SHOP STANDARD; the rafter on top of
  the pitch-cut column seat is the OPTION). Column, knee, weld, frame and shop captions read "column to
  rafter top line". `welded_knee` defaults to `inside_flange` on new jobs and samples.
* **Every connection option in ONE dialog.** Building settings step 2 (*Main frames*) now carries the four
  `Connections — ...` groups with nothing collapsed: rafter seat, connection construction, gable ridge
  (standard = one-piece cut-and-fold rafter, option = shared 1/2 in ridge plate), purlin fit and depth,
  foundation, base connection, plates, brackets, clips, gaps and weld size. The end-wall hint was corrected
  to the shop rule (W end rafters BYPASS with the rake angle on the purlins and a 4 in leg down; only a
  sheeted open-face CHANNEL end rafter is flush; a welded interior frame carries its purlins flush, so the
  roof line is the top of the rafter = the eave height).
* **Sheets ordered LONGER.** A bay whose two columns stand at different grades follows the LOWER slab by
  standard - the wall sheets and the base angle are ordered long and the transition area is cut to fit on
  site; clearing the raised slab is the option (`mixed_bay = "higher"`). Panel / base-angle statuses name
  the rule that applied. Applies to main walls, end walls and lean outer walls.
* **Drawings.** Side-wall rule caption "Eave height = floor to the ROOF LINE = TOP OF RAFTER; purlin tops
  flush with it"; one canonical roof-line wording in the frame-line banner, the line schedule and the
  elevations; the lean rafter sheet says "HIGH END on the main column seat per station ... welded to the
  column face elsewhere"; the print dialog titles the ridge sheet "cut-and-fold ridge (one-piece rafter,
  standard)".
* Verified: sample 359 - welded inside flange, the column now runs to 144 (eave height, 11'-11 1/2" +
  plate) with the rafter top at the roof line; the outside-seat option - column pitch-cut under the rafter
  (10'-11 9/16"); owner's 20x50 job and both demo files open, regenerate and stay COMPLETE (that job's
  columns go from 11'-6 5/16" to 12'-0 5/16" because its 6 in purlins no longer sit on top of the roof
  line). `DETAIL_VERSION` **26** (every welded frame regenerates once on load). Tests: updates in
  `tests/test_v075.py`, `test_v076.py`, `test_v0829_samples.py`, `test_v0831_rules.py`,
  `test_v0834_rules.py`, `test_v0837_rules.py`, `test_v0838_rules.py`, `test_v0839_rules.py`,
  `test_v0843_grades.py`.

## 0.8.43 — column grades: every column cut to the grade at its base (2026-10-16)

Owner round 13. The standard stays "every column at the same grade" (the set level, 0 = top of the main
slab), but the owner's job has the roof-extension bay poured 1 1/2" lower (longer posts on those two lines)
and lean-to posts in augered holes at the natural ground - each needs its own grade while the eave stays level.

* **Column grades - a separate box** (sidebar *Column grades*, route `POST /api/grades`). The dialog lists
  every column of the frame set - main frame columns per frame line and side, end-wall / cross-wall posts
  and door jambs, lean-to posts - with its standard cut; type the grade at that column relative to the set
  level (`-1 1/2`, `+1/4`, `-1'-6"`; blank = standard; 3 ft limit). A slab column takes the top of slab
  there; a post in a hole takes the **ground level** there (post length = top - ground + hole depth). The
  column grows by the amount it sits lower; eave, roof line and every girt line are unchanged (girt stations
  on the column move with the base). Saved as `frames[fid].grades {datum, mixed_bay, columns{key: inches}}`;
  keys `main|<line>|<left|right>`, `post|<mark>`, `lean|<lean id>|<lean line>`.
* **Marks by length.** Main columns of different lengths become their own assemblies and cut marks
  (`COL-1A`, `COL-1B` ... / `RF-100A` ...): the group at the set level keeps the plain mark (else the largest
  group), quantities add up to the frame count, the variants carry only the column-level derivation (the
  frame takeoff stays on the owner assembly) and are rebuilt on every generation. End-wall and lean posts
  already carry one mark per post - their cut simply changes. Shipping list, cut sheets, cut list and the
  stock plan follow.
* **Sheets and base angle follow the slab of the bay.** Each bay takes the grade shared by its two columns;
  a *mixed* bay (the step is at a column line) clears the HIGHER slab by standard - a sheet cut to the lower
  grade would hit the raised slab - or reaches the LOWER slab when that option is chosen in the dialog
  (`mixed_bay`). Wall panel strips, the sidewall base angle pieces (one per bay already), the end-wall base
  angle rows and the lean outer-wall supports drop by the bay offset (`base_steps` per wall surface, outside
  view). Lean-to end posts stand on their own line's grade.
* **Lean-to foundation of its own** (Lean-tos dialog *Lean post foundation*: as the main building / slab /
  post holes with depth and diameter, standard 3 ft x 18 in). Post-hole lean posts get no base plate and no
  base angle; their girt lines follow the post-footing rule; the lean section and the lean rafter sheet draw
  / list the holes and the grade per line.
* **Drawings.** New *COLUMN GRADE SCHEDULE* sheet (erection set after the rigid frame sections, shop set
  after the shipping list; only when a grade is entered): every column with grade, bottom, standard and
  actual cut, foundation; the marks by length; the wall base offsets by bay. Rigid frame sections and side
  wall elevations draw each column from its own base with `BASE -1 1/2" (GRADE)` and the shop mark of that
  line (lines with different grades get their own section sheets); end wall framing shows the post bases and
  the stepped base angle; post holes are drawn from the ground at the post. The lean "FIT HOLD" captions are
  gone.
* Verified on the owner's 20x50 job: the six posts on frame lines 1-2 at -1 1/2" come out 1 1/2" longer
  (11'-7 5/16" / 12'-5 3/16"), the junction wall sheets and base angle sit 1 1/2" lower, LT1 in 3 ft holes with
  ground at -2 / -3 1/2 / -5 / -6 1/2 gives posts 13'-2" / 13'-3 1/2" / 13'-5" / 13'-6 1/2"; COMPLETE.
  `DETAIL_VERSION` 25 (saved jobs regenerate once on load). Tests: `tests/test_v0843_grades.py`.

## 0.8.42 — lean-to over some bays on either side; rafter section per lean frame line (2026-10-16)

Owner round 12. A second lean-to on the other side over the 20' bay only raised two errors
(*"Lean clip completion needs an explicit low-row support"* and *"Shared main-eave takeoff currently requires a
full-length side lean"*); and the owner wants to pick, line by line, a single open-face channel, a doubled
open-face channel welded into an I, or a W rafter — with flush or bypass purlins on the W lines — and have
the lean column heights follow.

* **Lean-to over SOME bays, either side, either roof continuity.** A channel-rafter lean has its purlins
  welded inside the channel: there are no purlin clips, so the clip schedule is empty instead of a stop. A
  lean that *continues the main roof plane* over some bays steps the roof sheets: ridge-to-lean-eave panels
  over the lean's bays, the main length outside them, the main eave trim runs beside the lean, the lean eave
  inside it, and a rake down each open lean end (`step_rakes`, `eave_runs` on the roof surface; the panel strip
  straddling a step takes the long length). The bay-numbered extent, the purlin pieces, the roof plan, the
  frame-line table / elevations and the customer views all place a **back-wall** lean correctly (lean
  coordinates are the outside view of that wall; plan-datum consumers mirror them — a lean over bay 1 is at
  the left end in plan on either side).
* **Rafter section per lean frame line** — Lean-tos dialog, *Rafter at each lean frame line*: a select per
  line (station, 1 = start end) with *Standard rule* (single open-face channel at the two ends, doubled
  back-to-back I on the interior lines), any single open-face / lipped Cee, its `x2` doubled I, or a W.
  Saved as `rafter_lines {"<line>": "<section id>"}` on the lean. Every lean model keeps it per station:
  `rafter_profile`, `rafter_pair`, `purlin_fit` (`channel` / `flush` / `bypass`), the members table (RF row
  per line with quantity 1 or 2, COL row per line with its own cut), `rafter_cut_detail.lines` (blank, plumb
  depth, top at the column) and `low_connection_detail.lines` (post cut per line).
* **Roof secondary fit for W rafter lines** (the lean's *purlin_mode*, relabelled): **flush** = purlins between
  the flanges welded to the web (piece set back half the web + 1/8 in like the flush girt rule), rafter top AT
  the roofline, post to the roofline; **bypass** = purlins over the rafter, rafter top a purlin depth below the
  roofline, post a purlin depth shorter. An open-face channel is always in-channel (1/4 in setback) and the
  setting does not apply to it. *Check leans saved by older versions with a W rafter and FLUSH: they were
  modelled like BYPASS before (the lean rafter sheet now lists the post cut per line).*
* Lean end-wall posts run to the END line's section (a W bypass end rafter sits a purlin lower than a channel).
* **Lean rafter sheet** (shop set): values in ft-in and the table *RAFTER AND POST BY FRAME LINE* (line,
  station, rafter, qty, long blank, plumb depth, top at column, purlins, post cut). **Roof plan**: the lean
  caption names the section per line; lean purlin rows drawn.
* **Customer elevations PDF** works again with the SSS Z purlins on a lean (it rejected them since the SSS
  standard) and now draws leans over some bays, separate-plane lean roofs and the back-wall lean in place.
* **Fix:** the outer end of a roof-only bay (E1 of a bay-zoned job) no longer draws the RIGHT end wall's
  openings.
* Tests: `tests/test_v0842_lean_lines.py` (+10); `test_v0837` adjusted (the fit setting is for W lines).

## 0.8.41 — older jobs open again; Convert to shop standard (SSS) (2026-10-16)

The owner's 20' × 50' job (20 × 30 enclosed + 20 × 20 roof only, 18' × 50' lean-to, built under 0.8.2x) would
not open in the current release. Three causes, all fixed, plus a conversion path for every older job:

* **"Saved MBCI lap rules differ; review and reselect patterns before regeneration" is gone.** The bay layout
  carried a hash of the lap-rule text; any wording change in the rules locked every saved job out, and the
  editor offered no way to "reselect patterns". A layout saved under an older stamp is now re-applied with the
  current rules and re-stamped (an unknown pattern or direction is still rejected by name).
* **Crash in the completion scope** (`string indices must be integers`) when the end-wall record carried
  non-dict entries (the inside cross wall of a bay-zoned job) — fixed.
* **Two disclaimer strings were blocking the release** ("Check rolled fillets … connection design before
  cutting/welding", "WALK FRAME SECTION FIT: verify purchased frame depth/lips …"): neither names anything the
  user can enter; both are classified as notes now (release policy).
* **`legacy_upgrade`** (new): *Job ▾ → Convert to shop standard (SSS)…* converts the open job and lists every
  change — another supplier's purlins / girts / eave struts / base angles / panels / colors / trims become the
  SSS product of the same family and depth (the unique match the *Supplier products* preview would suggest,
  else the shop standard for that role), the job-wide policy becomes SSS primary, a lean-to on the pre-0.8.34
  clip (`legacy` / `gap_overlap` fit) goes to the standard rafter-welded-direct connection (the 2 in clip stays
  the option), stale rule stamps are dropped, every frame is regenerated. The list is kept in the job file
  (`settings.upgrade_log`) and shown once. A job that cannot be opened as saved (job list, *Open job file…*)
  is converted automatically and the same list is shown; one that opens as saved is left exactly as saved.
* Tests: `tests/test_v0841_legacy_upgrade.py` (+5), `test_v077` stale-stamp case inverted. 653 passed / 252 skipped.

## 0.8.40 — side walls readable; sheeted-wall flow verified in the editor; catalog boilerplate gone (2026-10-16)

Follow-up to round 10 after the owner repeated items 4 and 5.

* **Item 4 verified through the editor itself** (jsdom harness driving the real page against a live server):
  Samples ▾ → 357 roof only → Building settings → Walls → *Back sidewall = Sheeted* fills the girt lines in the
  form (1'-0, 4'-8, 8'-4), ticks *Wall sheets*, and *Save building & regenerate* produces 9 back-wall girts,
  the "GIRT LINES: shop standard lines …" note and RELEASE CHECK: COMPLETE; *Left endwall = Sheeted* then
  switches the end-wall framing on (3 frames + the bearing end wall, "END WALL FRAMING: …"). Removing the girt
  product from a sheeted job is rejected with "Choose an SSS girt product". The save status line now repeats the
  release check ("RELEASE CHECK: n open item(s), see the banner") and counts the remaining notes as
  "shop-rule note(s)" instead of "fit/catalog warning(s)".
* **Side wall elevations readable** (`erection_views.sidewall`, S sheets and the archive SIDEWALL sheets):
  column / corner-post marks stand horizontally above each column in bold instead of rotated inside the thin
  column; every girt and eave strut carries its **cut mark** (`SR-<frame>-nnn`, the mark on the shipping list
  and cut sheet) along the piece; a **MEMBERS ON THIS WALL** table (mark, member, cut / length, per bay, bays,
  total) at the top right lists the corner posts and columns with their sections and cuts, the eave struts,
  the girts grouped by cut length and the base-angle sticks — the same table style as the frame-line sheets;
  the elevation sits below the table at full sheet width.
* **Catalog boilerplate removed.** "PURLIN/GIRT/EAVE: Supplier nominal profile selected; steel thickness,
  bends/lips, punching and installed fit remain unverified." and "EAVE: MBCI says height depends on roof slope
  …" were written on every job (an SSS job included) and never blocked anything — pure noise next to the real
  notes. Only a hand-entered reference profile (USER6in) is still named.
* Tests: `tests/test_v0840_rules.py` (+3), `test_v0839` side-wall assertions tightened. 648 passed / 252 skipped.

## 0.8.39 — fully welded start; sheets never without girts; one erection drawing language (2026-10-16)

Owner round 10: **every new job starts fully welded** with the **cut-and-fold** ridge (bolted brackets and the
shared ridge plate are the options), **20' bays** and **SSS primary** confirmed on every job; **bracing BY
OTHERS**; the roof-only → sheeted-wall gap is closed (**"can't have sheets without wall girts"**); and the
erection drawings are drawn in **one language**.

* **New jobs start FULLY WELDED.** The frame wizard, the four samples (356–359) and every job started from them
  now use `connection_style = fully_welded`, flush girts welded to the column web (`girt_mode = flush`,
  `girt_attachment = web_weld`) and `ridge_fabrication = standard`. `standard` resolves per frame
  (`frame.ridge_fabrication_resolved`): the **one-piece cut-and-fold rafter on every fully welded gable frame
  with W rafters**, the shared ridge plate wherever that cannot apply (bolted, welded box, mono-slope, channel
  rafters). `plate` stays selectable as the option; `cut_and_fold` as the explicit choice. Jobs saved without
  the key read as `standard`. The samples: RF1-1 is one piece per frame (357: qty 4 on 4 frames), columns
  10'-4 9/16" (359, slab) / 13'-5 1/16" (358, 3' embed), all COMPLETE. Fix found on the way: the flush-girt web
  datum (`girt_web_y`) was computed from the column section *before* the width preset resolved it, so a saved
  job regenerated to a different value after a width change — it is now computed after the end-wall/preset
  step and regeneration is byte-identical (test).
* **Bracing BY OTHERS.** General note on the cover sheet: "Bracing BY OTHERS - no wall or roof bracing is
  detailed, listed or ordered in this package." No bracing settings, members or quantities; the scope/lean
  status strings say "bracing BY OTHERS" instead of "bracing … pending / unquantified".
* **Sheets never without wall girts** (`wall_girts.apply` runs right after the enclosure step, `wall_girts.check`
  after the cladding). A roof-only job (357) whose wall is switched to *sheeted* — in the Walls step or through
  the *Wall sheets* checkbox — gets the shop-standard girt lines (post footing 1'-0 / 4'-8 / 8'-4; slab base
  angle + even lines at 5' maximum; walk door 7'-3), the slab base-angle run, and on a sheeted END the standard
  bearing end wall (posts by width, girts, base angle): the end frame leaves the primary lot (357 + left end
  sheeted → 3 frames + `front_end` with 3 posts / 6 girts). The applied rules are reported as state ("GIRT LINES:
  shop standard lines …", "BASE ANGLE: …", "END WALL FRAMING: … standard bearing end walls …") so a saved job
  regenerates to the same text. A sheeted wall surface that still has no girt behind it (a bay-zone or
  legacy-input case) is a **release blocker**: "SHEETED WALL WITHOUT GIRTS: Back sidewall is sheeted but its
  girts are missing - … or set the wall OPEN." — phrased in the release gate's actionable vocabulary (test: every
  variant blocks). Explicit *sheeted* in the wall map now wins over an old `cladding.walls = false` flag; the
  end-wall model skips an end whose bay-layout type is still `rigid_frame`; *Include end-wall girts* is forced
  on for a sheeted end that has a girt product.
* **Release check always in view.** The editor state carries `release` (`status`, `complete`, `count`, first
  items) and a banner under the geometry bar shows **RELEASE CHECK: COMPLETE** (green) or **RELEASE CHECK: OPEN
  ITEMS** (red) with the first blockers, *Show all* and a jump to the model checks; the save status line repeats it.
* **Erection drawings in ONE language** (`drawing/erection_views.py`). The rigid frame cross sections (R), the
  end wall framing (E, outside view, the right end mirrored) and the side wall elevations (S) are drawn by the
  same code straight onto the 22x17 sheet — no more shrunken 11x17 sheets. Primary members grey-filled; girts,
  purlins, eave struts and base angles at true size (section in the cross sections, visible flange in the
  elevations); the dotted blue roof line with the bypass/flush rule; floor datum; outside-wall / bay / post
  dimensions below the floor, eave (and ridge / high eave) at the sides; frame-line bubbles under the side walls;
  open and future bays red dashed with their label; post footings drawn; marks 8.5 pt, captions 11 pt, nothing
  below 7 pt (test). Every frame line carries a **MEMBERS ON THIS FRAME LINE** table (mark, section, per line,
  lines, total, cut / blank) and a caption with the connection construction, purlin / girt products and the
  foundation. The 11x17 archive sheets `FL<n>-…` and `SIDEWALL-F/B-…` draw the same views (editor preview =
  printed set). The REVIEW watermark is now painted under the geometry instead of over it. The side-wall S sheet
  stacks both elevations at full width with the openings table below.
* UI: the connection select reads *Shop standard — FULLY WELDED (seat, web-welded girts, cut-and-fold ridge)* /
  *Option — bolted brackets* / *Option — welded apex box*; the ridge select *Shop standard — CUT AND FOLD* /
  *Cut and fold (explicit)* / *Option — shared 1/2 in ridge plate*. The Walls step never disables a wall select
  again; choosing *sheeted* switches the wall sheets on and fills the girt lines in the form.
* Tests: `tests/test_v0839_rules.py`; older expectations updated for the new standards (`test_v075`
  shared-plate geometry now asks for `ridge_fabrication = plate`; sample cut lengths and rafter quantities;
  end-type notes). 645 passed / 252 skipped.

## 0.8.38 — open end walls without posts; girts welded to the web; cut-and-fold one-piece rafter; SSS primary (2026-10-15)

Owner round 9: bracing skipped (not standard); **SSS is the primary supplier on every job**; **open
end walls have no interior posts**; **welded girts are welded to the web - clips optional**; and the
shop's **cut-and-fold** one-piece rafter ridge as an option.

* **Open end walls: no interior posts.** An end wall that is OPEN (Building settings → Walls) has no
  interior posts: the end rafter spans corner column to corner column and the end frame is a rigid
  frame of the **main sections** (W12X14 on the 40' sample instead of the W8X10 bearing preset). Per
  end *Interior end posts* = `auto` (standard: posts only when the end is sheeted) | `always` (posts
  kept on an open end) | `never` (a sheeted end without posts - then its girts must clear the stock
  length, which is the only blocker). 20' wide ends are unchanged (one bay either way). Warnings:
  "OPEN END WALL: no interior posts - end rafter … spans corner column to corner column …"; sheet
  titles "OPEN END - RIGID END FRAME, NO POSTS" / "NO INTERIOR POSTS". Regeneration is stable.
* **Welded buildings: flush girts welded directly to the column web, no clip.** The direct weld is a
  `mark` part (`GIRT-WELD`, no dimensions, no weight) assigned as the girt clip of welded flush
  `web_weld` frames: the BOM, the clip order (only the purlin clips remain), the connection schedule
  (`DIRECT-WELD`, quantity 0, mount "COLUMN WEB (girt coped at the flanges)" / "CORNER COLUMN INSIDE
  FLANGE" / "TUBE FACE") and the drawings follow - the column sheet dimensions the girt stations with
  one "GIRT welded to web (coped), no clip" callout, the coordination views draw the girt end at the
  web, the opening sections say so. `web_clip` (stock clip welded to the web) and bolted bypass clips
  are unchanged. Switching a job to fully welded in the editor sets girts flush / web weld.
* **Cut-and-fold one-piece W rafter** (`ridge_fabrication = plate | cut_and_fold`, fully welded gable
  frames with W rafters only; the shared ridge plate stays the default). The rafter is ONE shop piece
  per frame: blank = 2 × (top-line span / cos pitch + depth × tan pitch) long point to long point,
  both knee cuts plumb with the long point at the bottom flange; a wedge 2 × depth × tan(pitch) wide
  at the bottom flange (2" on W12X14 at 1:12), apex at the underside of the top flange, is cut from the
  bottom flange and the web, the rafter is folded on the top flange and the seam welded. No ridge
  plate, no `AP-` connection. The 40' sample: blank 40'-3 5/8", each leg 20'-0 13/16" bottom of knee
  cut to bottom of wedge, wedge 2" × 11 11/16". The RF sheet shows the one-piece blank with the purlin
  clips of both legs (right leg = mirror image, stationed from the left long point, 1/16 grid) and the
  wedge; a new `RIDGE-<frame>` sheet gives the folded ridge, the wedge on the flat blank, the whole
  blank and the shop numbers; the frame sheet says "ONE-PIECE RAFTER: CUT & FOLD, NO PLATE"; cut list,
  shipping list and purchasing (stock longer than 40') follow. UI: *Connection construction → Welded
  gable ridge (W rafters)*, shown only when it applies; the stepper refuses it elsewhere.
* **Base angles over 20 ft are laid in 20 ft stock sticks** plus the remainder, butted on the slab
  (`…-B002-S1 / -S2`; end wall `…-BA1-1-S1 / -S2`). The 25' optional bay and a sheeted end wall
  without posts no longer hold for "stock segmentation" - the 45' (20/25) slab building reaches
  COMPLETE.
* **Triple-S Steel is the primary supplier of every job.** Every fallback that still assumed MBCI
  (sourcing config, product categories, editor defaults, base angle default, headings and messages)
  now assumes SSS; MBCI remains the option.
* Drawing polish: clip station labels on assembly sheets print on the 1/16 grid (the starting clip
  no longer prints as "1 85417/1000000"); the welded eave cover plate BOM line is "PL .188 x 3.970 x
  14.940 IN" instead of a 15625ths fraction.
* Tests: `tests/test_v0838_rules.py` (15); `test_v078` and `test_v0830` updated to the new rules.

## 0.8.37 — continued-plane lean corrected to the shop rule; stock overhead doors; insulation note (2026-10-15)

Owner answer, round 8: "purlin always stays in channel. Rafter raises to roofline. Roofline always
follows top of purlin: purlin inset in rafter -> top of rafter = roofline; bypass -> roofline = top
of purlin. Eave height = roofline. Outside seat -> rafter sits on column, column shortened to keep
top of purlin at eave height; inside flange -> column raised to top of rafter. Top of rafter =
bottom of purlin unless inset / flush." The rafter end above the column top is no issue.

* **Corrects 0.8.36.** A lean roof that continues the main roof plane no longer forces bypass
  purlins and no longer rejects a lean purlin depth that differs from the main one: an open-face
  channel lean rafter keeps its purlins **in the channel** and its top **is the roofline** (144" on
  the 12' sample); a W lean rafter tops out at the bottom of the purlin (136"). The lean's own
  purlin depth stays allowed.
* **Direct weld at the main column line, per station** (`high_connection_detail.stations[].fit`,
  `.behind`, `.summary`): the plumb end sits **on the column seat** beside the main rafter end when
  the lean rafter bottom lands on that seat (1/2" leeway, W12X14 lean on W12X14 outside-seat
  frames); otherwise it is welded to the **column face**, the **main rafter end** (outside seat)
  and the **eave strut** over the end - whatever stands on the column line. The 0.8.36 holds
  "rafter end extends outside the main column height" / "lean rafter plumb depth differs from the
  main rafter" are gone; the station note states how much of the rafter end stands above the column
  top. A lean roof that meets ABOVE the main roofline is now a concrete blocker (it was silently
  COMPLETE): "lean high eave X exceeds the main roofline Y at the wall; lower the lean eave or
  continue the main roof plane".
* Sheets follow: lean section "High: …", rafter cut sheet "HIGH END …" and the shop note "ROOF
  PURLINS sit IN the rafter channel …; the rafter top is the roofline (continued main roof plane)".
  Editor: continuity choice and lean hint reworded to the rule.
* **Stock overhead doors** 8x8, 10x10, 12x12, 14x14, 16x14 as one-click buttons on the openings
  card (`OVERHEAD_STOCK`); any other size is still typed.
* **Insulation by others**: cover-sheet general note "Insulation BY OTHERS - not part of this
  package; no insulation quantities are listed"; the roofline general note now states the bypass /
  channel rule as the shop applies it (W end rafters bypass with rake angle; channel ends flush).
* Tests: `tests/test_v0836_rules.py` replaced by `tests/test_v0837_rules.py` (8 tests).
* Not started (needs the shop's details first): **bracing** - not standard; when selected, portal
  frames on open walls and cable X-bracing on sheeted walls and the roof.

## 0.8.36 — lean roof that continues the main roof plane (2026-10-15)

Owner answer, round 7: "if inside flange is selected, then it doesn't bypass. If bypass is selected
then it sits on the column seat and is welded directly to that - the same as the outside-seat option.
For welded buildings there are only two options: outside seat and inside flange."

* **Continued main roof plane** (`roof_continuity = main_plane`) is the main roof build-up carried on:
  the lean rafter line continues the main rafter line, the **main purlin lines run over the lean
  rafter** (bypass, main purlin depth - a different lean purlin depth is rejected with the reason;
  the in-channel purlin detail stays with the separate / lowered lean roof).
* **Connection follows the main seat, per station** (`high_connection_detail.stations[].fit`):
  where the member runs to the rafter top line (inside-flange column, flush channel end rafter) the
  lean rafter end is inside the member height and is **welded to the outside face**; where the main
  rafter sits ON the member (outside-seat column, bypass end rafter on the posts) the lean rafter
  **sits on the column seat beside the main rafter end and is welded to the seat** - its plumb depth
  must match that rafter (1/2 in leeway, the difference is noted); a deeper or shallower lean rafter
  is a concrete blocker naming the depth and, at an end-wall post, the end-rafter override. Both
  cases reach COMPLETE (359 welded, inside flange: W8X10 lean rafter - face at the interior columns,
  seat on the W8X10 end-rafter posts, blank 11'-9 1/8; outside seat: W12X14 lean rafter on W12X14
  seats). The generic "attachment centre outside the column" note no longer fires for this case. The
  lowered lean roof is unchanged; its "rafter above the column top" message now names the two ways
  out (lower the roof or continue the main plane).
* Lean section, LEAN RAFTER CUTS and the frame coordination view read the face / seat result; the
  coordination view no longer fails on a shared main eave strut row (no flange width in the catalog
  page). Dialog: the roof-plane option and the lean hint explain the rule.
* Welded frames keep exactly two seat options (`welded_knee = outside_seat | inside_flange`).

## 0.8.35 — every wall an explicit choice; the lean-to finished (2026-10-15)

Owner answers, round 6: "it is imperative that I choose which walls to sheet or remain open,
including lean-to" and "lean-to is important to finish completely".

* **Main building walls** - *Building settings → step 1 → Walls*: front sidewall, back sidewall, left
  end wall, right end wall each **Sheeted / OPEN** (`cladding.wall_states`, default all sheeted; an older
  job derives the end walls from its *End wall enclosure* records). An open sidewall gets no girts, no
  base angle, no panels and no trim; an open end wall keeps its posts and end rafter (frame line sheet)
  and nothing else. The choice writes the step-3 *End wall enclosure* and - with bay enclosure on -
  every bay's side state, and reads back from them. Openings on an open wall are rejected with the
  wall named. Sample 357 (roof only) reports all four walls open.
* **Lean-to walls** - *Lean-to settings → Lean-to walls*: outer wall, start end, finish end and the
  main wall under the lean each **OPEN / SHEETED** (`walls`). **A new lean-to is roof only** (three lean
  walls open, main wall sheeted). The old three check boxes (`sheeted_ends`, `sheeted_outer_wall`,
  `open_main_below`) map onto the four switches when an older job is opened and are no longer saved.
* **Lean-to framing complete.** Lean posts stand on the main framing lines; the lean runs the whole
  length or a **range of main bays** (`bays = {from, to}`, e.g. 2-3 of 3; the dialog field reads
  "2-3"). **Lean end posts** (`end_posts` = auto / always / never): standard only when that end is
  sheeted and the projection exceeds 20 ft - centred by the end-wall table (25 ft → one post at 12'-6,
  40 ft → 20 ft bay); their own section or the lean column section. **Lean girts** (`girt_mode`,
  `girt_attachment`): lines by the main-wall rule (slab: base angle then 5 ft maximum; post footing:
  12 in then 5 ft maximum) under the flush shop rules - tube face / tube face 19'-7 7/8 (4x4, 20 ft
  bay), W web weld with the flange cope 19'-11 11/16 (W8X10), open-face channel post 19'-11 3/4
  (inside the open face 1/4 in, flat side 1/8 in), stock web clips 3x5 / 5x7 / 7x9 as the option,
  bypass on request; end girts from the main column's outside flange to the lean post's inside face
  (12 ft projection → 11'-7 7/8). **All column options** for lean posts (W, tube, open-face channel)
  and all rafter options. Girt pieces `COL-1-L1-OG1-n / SG1-n / FG1-n`, end posts `…-SEP1 / FEP1`.
* **Lean-to sheets and trim.** Sheeted lean walls get their panel layouts (sloped tops on the ends),
  base angle / rake angle supports, corner trim; the lean roof gets rakes; **no flashing when the lean
  roof continues the main roofline**, a **custom-formed wall-to-roof transition** (26 ga, job pitch,
  20'-6 maximum pieces) when the roof is lowered on the sidewall. All of it is on the master order;
  the old "lean secondaries / wall takeoff pending" holds are gone. New R sheet **LEAN-TO WALLS n**
  (outer wall and both ends with posts, girt lines and the wall states; girt piece table) in the
  archive (`<frame>~lean_walls~<i>~1`) and the composed erection set. Lean jobs - roof only, all
  sheeted, bay ranges, W / tube / channel posts, 25 ft sheeted ends with end posts - reach COMPLETE;
  `end_posts = never` on a sheeted end wider than 20 ft is the one (input-resolvable) blocker.
* **No empty pages**: an OPEN wall no longer produces a "0 panel pieces" PBR layout sheet or a
  "SHEETING AND TRIM" page in the erection set (its framing stays on the frame-line sheet). With bay
  enclosure on and the enclosed block starting at line 0, the front wall is labelled *Left endwall*
  again (not "Inside wall (enclosed junction) at 0"").

## 0.8.34 — mono-slope carport, lean-tos under the shop rules (2026-10-15)

Owner answers, round 5: (1) the standard carport is mono-slope, (2) lean-tos follow the shop rules
with the connection to the main building as a choice, (3) the 1/8 in rule stands for mixed W-web /
tube-face ends (no change).

* **Standard carport sample 356 / carport starting option = MONO-SLOPE** ("most carports are
  monosloped"): 20' × 40' × 8' low eave, 1:12, 4x4x11 ga tube posts, low columns 11'-0 5/16, high
  columns 12'-8, doubled-channel rafter 19'-5 5/16 welded inside both columns, low and high eave
  members 19'-7 3/4, purlins 19'-11 1/2, no ridge. The gable carport stays a frame-type choice (ridge =
  butt + face splice plates). A job list that already holds a gable 356 keeps it; *New job → start
  from the carport* builds the mono-slope one. High-side girts of a mono-slope frame on tube columns
  now resolve (`secondary_runs`).
* **Lean-tos under the shop rules.** *Connection to the main building* is a per-lean choice:
  **welded directly to the main column** - rafter cut plumb, butted to the outside face of the column,
  no gap, no clip part (**standard**, `high_connection = welded_direct`); **welded clip** - rafter end
  2 in clear of the column, 1/2 in clip welded to the column face and the rafter web (option,
  `high_clip_fit = owner_gap`); bolted end plate (legacy). *Rafter seat at the lean post*: inside face
  (standard) - the post runs to the rafter top line (pitch-cut top, long side inside), the rafter is
  welded to its inside face, **no cap on an open-face channel rafter** (cap plate kept on W rafters);
  on top of the post; or follow the main frame. **Open-face channel lean rafters carry the purlins IN
  the channel** (always flush, no purlin deduction, no clips): bay pieces = bay − 1/4 in each end
  (20 ft bays → 19'-11 1/2), rows evenly spaced at 5 ft maximum from the top row at the main column to
  the eave row at the post line. Rafter blank = top line between the plumb cuts + depth × pitch
  (12'-0 projection, 1:12, SS8214, 4x4 post: 11'-9 3/16; post 7'-11 1/2 short / 7'-11 13/16 long).
  Channel depth must equal the lean purlin depth (6 / 8 / 10 in channels accepted). A separate-plane
  lean roof never shares the main eave member; the lean purlin schedule also works on a bolted main
  frame when the lean itself is welded. A lean-to with the standard detail reaches COMPLETE; the old
  "clip on a bypass wall" / "web thickness pending" / "seat fit pending" holds are gone for the shop
  details. Lean section, LEAN LOW and LEAN RAFTER CUTS sheets show the resolved detail.
* Lean-to dialog: the choices above, standard defaults on *Add lean-to* (welded direct, inside face,
  flush purlins in the channel, lean purlins on, 5 ft maximum).

## 0.8.33 — standard bays, carport rafters inside the columns, open-face leeway (2026-10-15)

Owner answers, round 4 - and the "Unknown endwall support type" failure on the sample building.

* **Frame bays along the length: 20 ft standard, never an equal subdivision.** New bay layout
  `standard` (default for new frames and the samples): 20 ft bays, the odd remainder as its own
  **middle** bay when it is 10 ft or more (50 ft → 20 / 10 / 20, 70 ft → 20 / 20 / 10 / 20), otherwise
  added to the middle bay (45 ft → 20 / 25); 25 ft is an option, any size is possible. The bay layout
  card lists every bay - typing a size in one switches to **entered bays** (`explicit`, must total the
  length; +/− bay, *Reset to standard*). The **primary frame lot follows the grid** in these layouts
  (the "Interior fabrication lot" field is filled in and locked); legacy equal-bay layouts keep the
  entered lot and the QUANTITY MISMATCH warning. Bay enclosure defaults to the same 20 ft bays and
  gets a *Standard 20 ft bays from the length* button (`standards.standard_bays`, `building.apply`,
  `dim.js standardBays`).
* **Bay enclosure on a roof-only start** (rigid frames at both ends) converts both ends to
  post-supported bearing end walls with an `END TYPE CHANGED` note instead of failing with
  "Unknown endwall support type" (`bay_zones.apply`).
* **Open-face leeway**: a girt / eave member with an end inside an open face carries no 1/8 in
  clearance - the 1/4 in setback is the leeway. Channel upright on an end wall: open side
  10' − column − 1/4, flat side 10' − column − 1/8 (gauge not figured). Carport eave member
  19'-7 3/4 (full tube + 1/4 in the interior channel).
* **Rafter seat is a global welded-frame option** (*Rafter seat*: on top of the column / inside
  flange-face). Inside: column to the rafter top line, pitch-cut top, rafter welded to the inside
  face with plumb ends; the pitched cap plate stays on W rafters, **open-face channel rafters get no
  cap**. Gable ridge for channel rafters = **butt + 3/16 x 5 x 7 face splice plates, one each side**
  (`ridge_joint = face_splice`); mono-slope has no ridge (the end-wall face clip is ignored on a
  mono-slope). The carport sample / starting option uses it on every rafter: HSS 4x4 columns
  11'-0 5/16 (interior and corner alike), doubled-channel rafter 9'-8 15/16 from the column inside
  face to the ridge - the same blank as the single channel end rafter. New EAVE sheet variant for the
  side-welded detail; the ridge sheet shows the splice plates.
* Correction to 0.8.32: a side-welded end rafter with two plumb cuts is a parallelogram - its blank
  is the top line **plus depth x pitch** (9'-8 15/16, not 9'-8 7/16); end-wall members round to the
  nearest 1/16 like the main frame.
* Lean-to rafters may be open-face channels (single id; the module pairs interior rafters back to
  back, the two end rafters stay single).
* Tests: `tests/test_v0833_rules.py` (20).

## 0.8.32 — shop rules round 3: corner members on the wall line, tubes, carport end detail (2026-10-15)

Owner answers to the 0.8.31 questions.

* **Sidewall flush girts / eave members at a bearing end wall**: the end members stand with their
  **outside face on the end wall line** — a W corner column like a frame column (web at half the flange
  width), a tube at half its width — so the end bay loses that offset as well
  (`secondary_runs`: per-support `offsets`, per-piece `end_fits`). **Tubes follow the web rule with no
  cope** (the whole side is flat): 4x4 columns, 20 ft bays → **19'-7 7/8** interior, **19'-5 7/8** first
  and last bay (owner's numbers); W8X10 corner / W12X14 interior → 19'-9 11/16 end bays, 19'-11 5/8
  interior; clip option 19'-5 13/16 / 19'-7 3/4. The clip option is ignored at tubes. Rigid end frames
  stay centred on the line. Cope depth = flange thickness + 1/16 from the inside of the flange (confirmed);
  every W size has its own web / flange dimensions (`sections.py`, W6X9 … W14X26 and up).
* **Carport end detail** (`post_head = "side_welded"`, sample 356 and `CARPORT_STANDARD`): the corner
  tubes run **to the roof line** (pitch-cut top, no cap), the single channel end rafters are **welded to
  their inside face** — rafter from the tube inside face to the ridge, plumb both ends (20 ft: 9'-8 7/16),
  **3/16 x 5 x 7 splice plate welded to the channel faces at the ridge** (`ridge_joint = "face_clip"`) —
  and the **eave member butts the corner tube inside face** (full width + 1/8) while sitting inside the
  interior I-rafter channel 1/4 in from the web (19'-7 5/8). Interior posts under a side-welded end keep
  the pitch-cut direct head. Wizard: *End post head* gains the option.
* **End-wall flush girts at cold-formed uprights** (owner convention): an open-face channel / Cee post has
  its **web inner face on the station** with the body toward the far end — the girt on the flat side
  butts the web (station less the gauge thickness), the girt on the open side of a channel sits **inside
  the open face 1/4 in from the web**; a lipped Cee cannot take the girt inside, so that girt butts the
  lips at the full depth. 20 ft end wall, 4x4 corner tubes, SS6214 upright at the centre → 9'-7 3/4 flat
  side, 9'-7 5/8 open side (1/8 in clearance applied where a butt end exists).
* Tests: `tests/test_v0831_rules.py` extended (15).

## 0.8.31 — shop rules round 2: channel rafters, A_butt, carport starting option, flush girts (2026-10-15)

Owner corrections and additions of 2026-10-15 (`mbdp/detail/standards.py`). Saved jobs keep their framing
until regenerated; the SSS defaults, the wizard and the samples use the new rules.

* **Open-face channel end rafters match the purlin depth** — 6 in channel for 6 in purlins, 8 in for 8 in,
  10 in for 10 in (`standards.channel_end_rafter(purlin_depth)`; the 0.8.30 span rule was a mistake).
  The purlin **sits inside the open face 1/4 in from the channel web and is welded to the flanges top and
  bottom** — no purlin clips at a channel rafter (`welded_frame.py` records the station only, the frame
  sheet draws the purlin end inside the channel). Purlin / eave-member lengths follow: 20 ft bay with a
  bypass W rafter at one end and a channel at the other = **19'-11 3/4** (the owner's "20'-1/4" — 1/4 in
  from the W centre line, 1/4 in inside the channel); channels at both ends = **19'-11 1/2**.
* **`A_butt` bay pattern** (shop standard, new default of the SSS standard, the wizard and the samples):
  simple-span purlins and girts **butt at the interior support centre line** (a 20 ft bay between bypass W
  rafters cuts 20'-0; the terminal bays keep the 1/4 in project end clearance). The MBCI `A_simple`
  pattern keeps its 1/4 in cutback at every interior support (19'-11 1/2) for jobs that want it.
* **Carport starting option** (`standards.CARPORT_STANDARD`, sample **356**): 20 x 40 x 8 ft eave, two
  20 ft bays, 1:12, roof only, **4x4x11 ga tube posts**, interior rafter **two SS6214 open-face channels
  welded back to back into an I** (`SSS-SS6214x2`; every open-face channel now has an `x2` doubled
  section — `sections.channel_names()`), **single SS6214 end rafters**, 6 in Z purlins inside the
  channels (19'-11 1/2), post footings. Purchasing lists the doubled rafter as two single channels per
  member ("TWO CHANNELS WELDED BACK TO BACK (I SHAPE) PER MEMBER").
* **Flush sidewall girts** (`girt_mode = flush`): **welded directly to the column web** — length = bay less
  half the web each end less 1/8 in, the outer flange **coped around the column flange** (cope = half the
  flange width less half the web + 1/8 in long, flange thickness + 1/16 in deep; listed per piece as
  `copes`) so the girt face matches the outside flange (W8X10 / W12X14 20 ft bay → 19'-11 11/16). New
  option **`girt_attachment = web_clip`** (wizard: *Flush girt attachment*): a **stock purlin clip welded
  to the web** — 6 in girt 3x5, 8 in 5x7, 10 in 7x9, long side welded, short side sticking out — and the
  girt runs inside to inside of the flanges less 1/4 in (19'-7 3/4; clips listed per piece as `web_clips`).
* **Flush end-wall girts**: the **corner column stands like the frame columns** (web across the building,
  outside flange in the sidewall plane; its depth runs along the end wall); the end-wall girt is **welded
  to the corner column's inside flange** flush with the outer edge of the building (the 8 in girt sticks
  out past the 4 in flange) and to the **post webs** — length = post centre line less half the post web,
  less the corner column half depth, less 1/8 in total (40 ft end wall, centre post → 19'-3 7/8). Cee
  posts take their web thickness from the gauge table instead of a "fit pending" hold.
* **Samples renumbered / New job starting options**: **356 carport, 357 roof only, 358 three-sided
  (implement shed), 359 fully enclosed**; the first real job proposed is **360**. Samples are recognised
  by the `sample` key they carry (older copies by customer SAMPLE + building name), so a workspace filed
  under 0.8.29/0.8.30 keeps its numbers and only gains the carport under the next free number.
  *New job…* now asks for the **starting option** — blank (wizard) or a copy of any sample under the new
  number (`POST /api/job/new {start_from: carport|roof_only|three_sided|enclosed}`); the Samples ▾ menu
  lists the four buildings and the Clark Jordan reference.
* Tests: `tests/test_v0831_rules.py` (12); 0.8.29 / 0.8.30 tests updated to the renumbering, the
  channel-by-depth rule and `A_butt`.

## 0.8.30 — shop layout rules: girts, even purlins, end walls, doors; Samples menu (2026-10-15)

Owner decisions of 2026-10-15 turned into defaults (`mbdp/detail/standards.py`, mirrored for the wizard in
`static/shop_rules.js`). Everything stays editable per job; saved jobs keep their framing until regenerated.

* **Wall girts** (`standards.girt_lines`): **slab** = base angle CAB1 at the floor, girts evenly spaced at
  **5 ft maximum** up to the eave strut (12 ft eave → 4'-0 / 8'-0; 14 ft → 4'-8 / 9'-4; 20 ft → 5 / 10 / 15);
  **post footing** = no base angle, first girt **12 in above the floor**, then even at 5 ft maximum
  (12 ft → 1'-0 / 4'-8 / 8'-4); a **walk door** fixes the **7'-3 header girt** (lines above it stay even).
  The wizard fills a new frame's *Girt elevations* from the rule, follows eave / foundation / door changes
  until the field is edited, and has a **Standard** button to re-apply it. The foundation choice also sets
  slab / base angle (slab) or no base angle (post footing) for new frames.
* **Gable end walls**: when the peak is more than 7 ft above the top sidewall girt the end wall gets extra
  girt lines continuing the spacing (`standards.gable_extra_girt_lines`, listed in the end-wall warnings).
* **Purlins**: new frames use **automatic equal spacing** (`auto_roof_spacing`), eave strut to ridge purlin,
  5 ft maximum (40 ft 1:12: 3 regular rows + the ridge purlin per slope, 4'-9 3/8 spaces).
* **End walls** (`endwalls.py`): the W preset end rafter (W8X10 to 40 ft, W10X12 above) is now **BYPASS**
  like the interior frames — the rake angle sits on top of the purlins with its 4 in leg down over the purlin
  ends; *flush* stays an explicit override. **Open-face channel end rafters** (`rafter_override = "channel"`)
  are sized by the longest span between supports — **6 in to 20 ft, 8 in to 30 ft** (SSS-SS6214 / SSS-SS8214,
  MBCI 6p125 / 8p125 under the MBCI policy) — and are **top-flush** with the purlins (a deeper purlin projects
  below the channel; no inside-depth hold, cut datum = channel web at the gauge thickness). No rake angle on
  flush or open ends. **Standard posts centred by width** (`post_layout = "standard"`, the default):
  30 ft → 15 / 15, 40 ft → 20 / 20, 50 ft → 20 / 10 / 20, other widths equal bays at 20 ft maximum — a later
  width change re-applies the table. **Open end wall** (`enclosure = "open"`): posts and end rafter only —
  no girts, base angle, wall sheets, corner / base trim or rake angle; an opening on it is rejected.
* **Doors** (new openings; saved ones keep their framing): **walk door** 3'-0 × 7'-0 with the **wall girt above
  the head as the header** (7'-3 girt; jambs stop at it, no separate header member); **overhead door** (new
  kind, 10'-0 × 10'-0 default) with **full-height jambs** to the eave strut / end rafter and the header at the
  door height — girts above the door are cut at the jambs. *Add walk door / Add overhead door / Add window*
  buttons; *Header* and *Jamb height* selectors per opening. Under the SSS policy the jamb / header default is
  the SSS Cee at the girt depth (**SSS-PN8**) instead of a hold.
* **Upgrades, not standard**: eave trim is no longer pre-selected (listed NOT ORDERED until chosen); gutters
  and base trim were already off. Base angle stays standard on slabs.
* **Samples ▾** header menu: one click opens sample 356 / 357 / 358 or the Clark Jordan reference
  (*Job ▾ → Load sample job…* still works). Samples regenerated on the rules: 357 girts 1'-0 / 4'-8 / 8'-4
  without base angle, 358 base angle + 4'-0 / 8'-0, both with W8X10 bypass end rafters and the centre post.
* Fixes: an opening on a job with SSS secondaries (no published weight) crashed the girt-interruption
  regroup (`erection_templates`); frame-line sheet notes now state each end's actual roof mode.
* Tests: `tests/test_v0830_rules.py` (20; the JS rule mirror is checked against Python with node when
  available); `test_frame_lines`, `test_v079`, `test_v0829_samples` updated to the bypass standard.

## 0.8.29 — SSS shop standard, job numbers from 356, three sample jobs (2026-10-15)

* **Shop standard** (`mbdp/detail/standards.py`, owner decision): every new job (*New job…*, the blank
  first-launch job) carries the SSS product policy and the SSS products pre-selected in the frame wizard —
  purlins and girts **SSS-PN8ZEE-F2** (8 in Z, 14 ga, 2 in flange), eave strut **SSS-PN8SSES**, base angle
  **SSS-CAB1**, **SSS-PBR 26 ga** sheets in Galvalume Plus (roof) / Light Stone (walls), Burnished Slate trim,
  SSS trims TRCRS / TRRKTSTD / TRETSTD / TRETHS / TRRCF / TRDJMBT / TRDHT, simple-span runs. Every value stays
  editable per job. Served as `catalog.supplier_defaults.sss` (`GET /api/catalog`).
* **SSS base / sill trim**: SSS has no base or sill trim product. A trim role left blank under the supplier
  product policy is listed as **NOT ORDERED** (zero stock) instead of *PROFILE PENDING* — it no longer holds
  the order or the release.
* **Job numbers** start at **356**; samples take 356–358, so the first real job proposed is **359**
  (`GET /api/jobs/next-number`; the Clark Jordan reference 1277345 and the numbers the 0.8.28 editor
  proposed on its own, 1000001–1000099, never advance the counter).
* **Three sample jobs** (`mbdp/detail/samples.py`), filed in every job list once per workspace, customer
  SAMPLE, all 40 ft × 60 ft × 12 ft eave, 1:12, 3 bays @ 20 ft, W12X14 frames, release check COMPLETE:
  **356 roof only** (rigid frames at both ends, no walls or girts, post footings 18 in × 3 ft),
  **357 three-sided** (both end walls and the back sidewall sheeted, front sidewall open, post footings),
  **358 enclosed** (all four walls sheeted, slab). **Job ▾ → Load sample job…** offers them (and the Clark
  Jordan reference); it reopens the listed — possibly edited — copy. `POST /api/job/sample {which}`.
* **Main rigid frame at an end line** (`bay_layout.front_end / rear_end.type = "rigid_frame"`): the end
  line is one more frame of the primary lot (sections = main sections, roof fit follows the interior), so
  roof-only and open buildings count four frames for three bays. Frame-line drawings label it END RIGID
  FRAME; the lot check expects bays + 1.
* Release gate: a roof-only building (wall sheets off) no longer reports *zero girt runs* as a gap; the
  slab base angle note no longer blocks when the bay runs already count the base angle; a chosen *open bay*
  is drawn as a plain label, not as a red hold line.
* Tests: `tests/test_v0829_samples.py` (12). Suite: 526 passed / 252 skipped.

## 0.8.28 — save / open jobs visible again; stale-page guard; previous-installation import (2026-10-15)

* **Why**: a user's browser kept the page of an earlier, differently built editor for `http://localhost:8010/`
  (that build served its page without cache headers) and showed it against the 0.8.27 server — the page
  failed with `load failed: Cannot read properties of undefined (reading 'map')` and the job list seemed gone.
* **Stale-page guard**: the page carries its version (`<meta name="editor-version">`, `mbdp.__version__`) and
  sends it with every call (`X-Editor-Version`). API calls from a browser page of another version are refused
  with a plain message — *press Ctrl+F5 to reload* — instead of failing inside the old page's JavaScript.
  Navigations, `<img>`/`<embed>` loads, scripts, curl and the tests are not affected (the check only applies
  to `fetch()` calls, recognised by `Sec-Fetch-Mode`). The launcher opens a version-stamped address so a
  cached page is never reused for the first start.
* **Open / Save in the header**: **Open job…** (the job list) and **Save job file…** (download
  `Job-<number>.json`, `GET /api/job/download`) sit next to the Job ▾ menu. Saving on this computer remains
  automatic; the file is for copies, e-mail and other computers.
* **Import from a previous installation…** (`POST /api/jobs/import-folder {path}`): scans a folder — e.g.
  `C:\mbe8.22` — for saved jobs (`job.json`, `jobs/*.json`, recovery copies, start-up backups, downloaded
  `Job-*.json` / `job_json.txt`), adds the newest copy of each job number to the job list, reports older
  copies skipped and identical jobs already listed. Nothing is opened or changed in the scanned folder.
  **Add job files to the list…** (`POST /api/jobs/add`) does the same for files picked in the browser,
  several at once.
* **Job numbers**: *New job…* and *Duplicate job as…* propose the next free number after the highest all-digit
  number in the job list (`GET /api/jobs/next-number`; 1000001 on an empty list) — the user can type another;
  a number that is already listed is confirmed first. `POST /api/job/new` without a number assigns it.
* Load failures show a dialog with the message and a **Reload page** button; an answer that is not JSON
  (another program on the port) is reported as such.
* Tests: `tests/test_v0828_jobs.py`, `tests/test_version_consistency.py`.

## 0.8.27 — foundation option: slab or post footing (2026-10-15)

* **Foundation** group in the frame / building settings (`FrameParams.foundation`, `footing_depth`,
  `footing_diameter`; `mbdp/detail/foundation.py`): **A — Slab** (default, unchanged: columns on base plates
  at the top of slab) or **B — Post footing** with the hole depth and diameter as inputs (standard
  18 in diameter × 3 ft deep).
* With post footings the posts are embedded the full hole depth: **no base plate is detailed**, the column
  cut / order length is the floor-to-top length **plus the hole depth** (main columns, bolted and welded;
  end-wall posts; lean-to columns), girt-clip stations are measured from the bottom of the post, and the
  column assembly sheet carries a **FLOOR LINE** mark at the embedment. Elevations above the floor datum
  are unchanged, so the eave / roof dimensions and every other member are the same as on a slab.
* Drawings: the rigid-frame cross sections and the end-wall framing sheets draw the holes (diameter × depth)
  below the floor datum with the footing callout; the erection cover carries a foundation general note
  (post footings or slab); `frame_layouts[fid].foundation` and the column derivation record the option.
* **Launcher runs from the source ZIP too**: `windows/launcher.py` and `windows/runtime_check.py` locate
  the `mbdp` folder next to or above themselves (the ready-to-run package has them side by side; a source
  checkout has the launcher in `windows/`). Starting `windows\Start Editor.bat` from an extracted
  `building-editor-source-*.zip` used to fail the runtime self-test with `No module named 'mbdp'`.
* Tests: `tests/test_v0827_foundation.py` (defaults and validation, column length / base plate / stations
  for bolted and welded frames, user hole size, end-wall posts, release check + order lengths, sheets).

## 0.8.26 — release check: concrete gaps only (2026-10-15)

* **Jobs can reach COMPLETE.** The permanent "review hold / not approved / unverified / NOT RELEASED"
  wording was a policy, not information: it blocked every job for ever and said nothing a detailer could
  act on. It is gone from the model errors, the release report, the sheets and the exports.
  `mbdp/detail/holds.py` classifies note text: *actionable* items (MODEL ERRORS, FAIL, CLASH, NO VALID,
  missing lengths, lot / grid mismatch …) still block and still print in red; disclaimer wording is
  not drawn and never blocks. `release_checks.report()` lists only input-resolvable blockers, each with a
  `resolve` instruction, and returns `complete` when there are none.
* **Eave strut cut lengths are computed** (simple span between frame lines, `length_basis` recorded) instead
  of staying PENDING by policy; eave pieces carry positive weights on the cut and shipping lists.
* **HSS tube columns / posts have weights**: nominal wall (gauge decimal or fraction) with the AISC
  2t / t corner radii convention (`tube_sections.weight_lb_ft`; HSS4x4x1/4 = 12.21 lb/ft); an entered
  actual wall on an end-wall post is used when present. The shipping list no longer shows UNKNOWN.
* **Sheets**: top-of-sheet "REVIEW HOLD / NOT FOR FABRICATION" banners removed from the connection,
  fabrication, frame, frame-line, ridge, weldment, template, order and additions sheets; informational
  lines (roof rule, column cut correction, cladding scope, end-wall length statement, first-purlin
  formula, weld leg, FUTURE bay) are plain text, so `packages.hold_line` surfaces only real red notes.
  The erection cover prints `STATUS … RELEASE CHECK: COMPLETE | OPEN ITEMS (n) … MODEL <rev>`.
  Footers and the purchasing / shipping lists use factual wording.
* **Exports**: `plate_rules.json` status is `RULE-DERIVED`, generated plate rows report `RULE-DERIVED`,
  `*.geometry.json` status follows the job's drawing status, `review_hold` texts state the rule basis.
* **Editor**: Outputs dialog shows the release badge, confirms before issuing FOR CONSTRUCTION with open
  items; connection-template option relabelled *Project default (girts cut at jambs, clip-connected)*.
* **Model revision is stable across save / reload** (`Attachment.to_json` writes `tilt` as a float): the cover
  line, the release report and the save lock now quote the same `M-…` for the same job.
* Tests: `tests/test_v0826_release_gate.py` (80 ft × 4-bay fully-welded job → COMPLETE with eave lengths;
  36×84 door → CLEAR with jamb / header / girt cuts; 5 frames on 3 lines → lot / grid blocker; tube weights;
  revision round trip; shipping list without UNKNOWN weights).

## 0.8.25 — print packages and save conflict check (2026-10-14)

* **Erection set (22×17)** composed from the drawing views instead of copying archive sheets
  (`mbdp/detail/drawing/packages.py`): cover + sheet index + general notes (C1), one rigid-frame
  cross section per *distinct* frame line with the caption listing every line it applies to (R),
  lean-to section with its member list (R), end-wall framing from the frame-line views (E), end-wall
  sheeting elevation with the panel groups and trim runs of that wall tabulated beside it (E), both
  side-wall framing elevations on one sheet with the opening setout table (S), side-wall sheeting +
  trim (S), roof framing plan with the purlin / eave piece list (B), roof sheeting + trim (B). One
  title block (description, size, customer, job no, sheet no, issue, revisions, building colours),
  the grey REVIEW watermark and one red hold line per sheet replace the red note paragraphs. PDFs in
  `<workspace>/details/` are appended as the D series and indexed on the cover.
* **Shop set (11×17)**: shipping list (assemblies, then clips / plates beyond the assembly BOMs; total
  weight; END OF ORDER), *every* assembly sheet (managed frame members were excluded before), cut
  sheets, end-member cut lists, weldments / ridge / eave details, lean-to shop details and the
  job-specific plates two per sheet. Catalog clips, stock tables, panel / trim tables, opening and
  rake sheets and the review register left the shop set (purchasing workbook / archive).
* **Outputs dialog** regrouped as Erection / Shop / Purchasing with the archive, CAM and raw exports
  collapsed under *Archive & references*; **Drawing status** select (`job.settings.drawing_status`:
  `REVIEW` default or `FOR CONSTRUCTION`) controls watermark and issue column. `print_manifest.json`
  now carries the sheet index and the archive → package routing of every sheet.
* **Optimistic save lock**: the editor sends `base_revision` with every save; `PUT /api/job` answers
  409 `{conflict, revision}` when the stored job moved on, and the window offers to reload. Saves
  without `base_revision` (scripts) behave as before.
* Furniture helpers in `sheet.py` record their item ranges (`sheet.meta['furniture']`), which is what
  lets the composer lift the drawing content of any sheet; identical-plate alias lines are plain text
  so they survive composition. Private-data test `test_compact_packets_preserve_unique_details_and_aliases`
  was updated to the new composition but could only be run against the public fixtures here.

## 0.8.24 — materials page and tab strip (2026-10-14)

* **Master order table** is a page in the drawing pane (`4 · Materials → Master order table`, also first
  entry of *Sheets → Materials & order*): supplier lines per department with the expandable stock → piece →
  location trace and *View drawing* jump, review entries, filter, purchasing exports and *Stock & order
  rules…* (docked beside the page; saving rebuilds the order and re-opens the panel). Replaces the
  "Master order list" pop-up and the "Material optimizer" modal.
* **Tab strip = views of the current object**: member (whole frame · assembly · cut · pieces), frame
  (building dimensions · whole frame · frame lines · sidewalls · roof plan · eave / ridge), endwalls,
  secondaries, cladding, lean-tos, materials and connection families, each with a label; the 25-tab
  stack of every building sheet on every member is gone.

## 0.8.23 — job list (2026-10-14)

* Every job is filed under its job number in `data/editor/jobs/<number>.json` and can be reopened by name
  (**Job ▾ → Open job…**); duplicate, delete, download and import per job; start-up offers the list.
* Retired import/check pipeline removed (`mbdp/web`, `extract`, `rules`, `pipeline`, `interpret`, `release`,
  `report`, `store`, top-level `model`, `exports`, `catalog`) together with the `pilot` / `serve` CLI commands;
  the editor, `draw` and `sample-job` remain. Version-named review tools, browser checks and release notes
  moved to `history/` and `docs/history/`. Code formatted with `ruff` (see `pyproject.toml`).

## 0.8.22 — consolidated editor and frame-line drawings (2026-10)

* Review branch `review/consolidation`: one dimension grammar, catalog served once (16× smaller autosave),
  Job ▾ / Outputs… header, 5-step sidebar, grouped sheet list, resizable workbench with the Building settings
  stepper docked beside the drawing, outputs opened in the page, no demonstration job by default.
* **Frame-line drawings**: one elevation per frame line, sidewall framing elevations and the roof framing plan;
  roof datum rule — interior frames bypass, end-wall rafters flush (roof line = top of purlin).
* Downloadable local package (`tools/build_local_package.py`), Windows self-test fixed for a blank first job,
  **Job ▾ → Open job file…**.

## 0.8.21 — error navigation and connected material references

* [V0821_DELIVERY_VERIFICATION.md](docs/history/V0821_DELIVERY_VERIFICATION.md) — v0.8.21 final delivery verification
* [V0821_PACKAGE.md](docs/history/V0821_PACKAGE.md) — v0.8.21 — error navigation and connected material references

## 0.8.20 — reconstructed building and unified settings

* [V0820_DELIVERY_VERIFICATION.md](docs/history/V0820_DELIVERY_VERIFICATION.md) — v0.8.20 delivery verification
* [V0820_PACKAGE.md](docs/history/V0820_PACKAGE.md) — Building Editor v0.8.20 — reconstructed building and unified settings

## 0.8.19 — independent SSS sections and tube columns

* [V0819_DELIVERY_VERIFICATION.md](docs/history/V0819_DELIVERY_VERIFICATION.md) — v0.8.19 delivery verification
* [V0819_FRESH_VERIFICATION.md](docs/history/V0819_FRESH_VERIFICATION.md) — v0.8.19 complete fresh installation
* [V0819_PACKAGE.md](docs/history/V0819_PACKAGE.md) — Building Editor v0.8.19 — independent SSS sections and tube columns

## 0.8.18 — actual supplier products, not purchasing aliases

* [V0818_DELIVERY_VERIFICATION.md](docs/history/V0818_DELIVERY_VERIFICATION.md) — v0.8.18 verification
* [V0818_PACKAGE.md](docs/history/V0818_PACKAGE.md) — v0.8.18 — actual supplier products, not purchasing aliases

## 0.8.17 — supplier selection, mixed sourcing and owner-supplied SSS references

* [V0817_DELIVERY_VERIFICATION.md](docs/history/V0817_DELIVERY_VERIFICATION.md) — v0.8.17 delivered artifact verification
* [V0817_PACKAGE.md](docs/history/V0817_PACKAGE.md) — v0.8.17 — supplier selection, mixed sourcing and owner-supplied SSS references

## 0.8.16 — actionable model findings

* [V0816_PACKAGE.md](docs/history/V0816_PACKAGE.md) — v0.8.16 — actionable model findings

## 0.8.15 — Customer elevations and main-roof purlins

* [V0815_DELIVERY_VERIFICATION.md](docs/history/V0815_DELIVERY_VERIFICATION.md) — v0.8.15 delivery verification
* [V0815_PACKAGE.md](docs/history/V0815_PACKAGE.md) — v0.8.15 — Customer elevations and main-roof purlins

## 0.8.14 — Material optimizer

* [V0814_DELIVERY_VERIFICATION.md](docs/history/V0814_DELIVERY_VERIFICATION.md) — v0.8.14 delivery verification
* [V0814_PACKAGE.md](docs/history/V0814_PACKAGE.md) — v0.8.14 — Material optimizer

## 0.8.13 — independent end rafters and three print packages

* [V0813_DELIVERY_VERIFICATION.md](docs/history/V0813_DELIVERY_VERIFICATION.md) — v0.8.13 delivery record
* [V0813_PACKAGE.md](docs/history/V0813_PACKAGE.md) — v0.8.13 — independent end rafters and three print packages

## 0.8.12 — your building (first owner package)

* [V0812_DELIVERY_VERIFICATION.md](docs/history/V0812_DELIVERY_VERIFICATION.md) — v0.8.12 delivery record
* [V0812_PACKAGE.md](docs/history/V0812_PACKAGE.md) — Your building — v0.8.12

## 0.8.11 — final software package for current owner increment

* [V0811_FINAL_PACKAGE.md](docs/history/V0811_FINAL_PACKAGE.md) — v0.8.11 — final software package for current owner increment

## 0.8.10 — owner welded-fit / lean-purlin review update

* [V0810_WELDED_FIT_REVIEW.md](docs/history/V0810_WELDED_FIT_REVIEW.md) — v0.8.10 — owner welded-fit / lean-purlin review update

## 0.8.9 — Owner endwall/opening coordination update

* [V089_ENDWALL_REVIEW.md](docs/history/V089_ENDWALL_REVIEW.md) — v0.8.9 — Owner endwall/opening coordination update

## 0.8.8 — channel-rafter hotfix

* [V088_CHANNEL_HOTFIX.md](docs/history/V088_CHANNEL_HOTFIX.md) — v0.8.8 channel-rafter hotfix
* [V088_WELDED_REVIEW.md](docs/history/V088_WELDED_REVIEW.md) — v0.8.8 — welded input and geometry review build
* [V088_WORK_IN_PROGRESS.md](docs/history/V088_WORK_IN_PROGRESS.md) — Historical implementation checkpoint — superseded

## 0.8.7 — Q01–Q10 implementation review

* [V087_IMPLEMENTATION_REVIEW.md](docs/history/V087_IMPLEMENTATION_REVIEW.md) — v0.8.7 — Q01–Q10 implementation review

## 0.8.6 — confirmed corrections / review build

* [V086_CORRECTION_REVIEW.md](docs/history/V086_CORRECTION_REVIEW.md) — v0.8.6 — confirmed corrections / review build

## 0.8.5 — source-linked framed openings and lean transitions

* [V085_SOURCE_TEMPLATES.md](docs/history/V085_SOURCE_TEMPLATES.md) — v0.8.5 — source-linked framed openings and lean transitions

## 0.8.4 — lean-to high-connection geometry review

* [V084_LEAN_CONNECTION_DETAILS.md](docs/history/V084_LEAN_CONNECTION_DETAILS.md) — v0.8.4 — lean-to high-connection geometry review

## 0.8.3 — Lean-to and opening COORDINATION PREVIEW

* [V083_FRAMING_COORDINATION.md](docs/history/V083_FRAMING_COORDINATION.md) — v0.8.3 — Lean-to and opening COORDINATION PREVIEW

## 0.8.2 — Job master material order

* [V082_MASTER_ORDER.md](docs/history/V082_MASTER_ORDER.md) — v0.8.2 — Job master material order

## 0.8.1 — Master building dimensions and orientation

* [V081_MASTER_BUILDING.md](docs/history/V081_MASTER_BUILDING.md) — v0.8.1 — Master building dimensions and orientation

## 0.8 — PBR sheets, colors, openings and trim

* [V080_PBR_SHEETS_TRIM.md](docs/history/V080_PBR_SHEETS_TRIM.md) — v0.8.0 — PBR sheets, colors, openings and trim

## 0.7.9 — User section presets and separate endwall setout

* [V079_ENDWALL_PRESETS.md](docs/history/V079_ENDWALL_PRESETS.md) — v0.7.9 — User section presets and separate endwall setout

## 0.7.8 — Column datum, slab base and automatic spacing

* [V078_COLUMN_SLAB_SPACING.md](docs/history/V078_COLUMN_SLAB_SPACING.md) — v0.7.8 — Column datum, slab base and automatic spacing

## 0.7.7 — Equal-bay secondary run takeoff

* [V077_EQUAL_BAY_RUNS.md](docs/history/V077_EQUAL_BAY_RUNS.md) — v0.7.7 — Equal-bay secondary run takeoff

## 0.7.6 — MBCI secondary library, first pass

* [V076_MBCI_LIBRARY.md](docs/history/V076_MBCI_LIBRARY.md) — v0.7.6 — MBCI secondary library, first pass

## 0.7.5 — welded frame options

* [V075_WELDED_OPTIONS.md](docs/history/V075_WELDED_OPTIONS.md) — v0.7.5 — welded frame options

## 0.7.4 — warning-only clearance and additional bracket starting clips

* [V074_CLIP_CLEARANCE.md](docs/history/V074_CLIP_CLEARANCE.md) — v0.7.4 — warning-only clearance and additional bracket starting clips

## 0.7.3 — remove the arbitrary apex minimum

* [V073_APEX_MINIMUM.md](docs/history/V073_APEX_MINIMUM.md) — v0.7.3 — remove the arbitrary apex minimum

## 0.7.2 — finished apex size, peak clips and outside-face datums

* [V072_DETAIL_CORRECTIONS.md](docs/history/V072_DETAIL_CORRECTIONS.md) — v0.7.2 — finished apex size, peak clips and outside-face datums

## 0.7.1 — new job first, apex link and visible whole frame

* [V071_STARTUP_AND_LINK.md](docs/history/V071_STARTUP_AND_LINK.md) — v0.7.1 — new job first, apex link and visible whole frame

## 0.7 — whole gable and mono-slope frames; raised apex bottom

* [V07_WHOLE_FRAMES.md](docs/history/V07_WHOLE_FRAMES.md) — v0.7 — whole gable and mono-slope frames; raised apex bottom

## 0.6 — inset mating plates, column-top seat, user hole centers

* [V06_INSET_AND_HOLES.md](docs/history/V06_INSET_AND_HOLES.md) — v0.6 — inset mating plates, column-top seat, user hole centers

## 0.5 — seated K plates, common top line, column-face clip datum

* [V05_EAVE_ALIGNMENT.md](docs/history/V05_EAVE_ALIGNMENT.md) — v0.5 — seated K plates, common top line, column-face clip datum

## 0.4 — member-driven plate families and 1/4-inch weld default

* [V04_PLATE_FAMILIES.md](docs/history/V04_PLATE_FAMILIES.md) — v0.4 — member-driven plate families and 1/4-inch weld default

## 0.3 — coordinate-controlled parts and linked gable frames

* [V03_FABRICATION.md](docs/history/V03_FABRICATION.md) — v0.3 — coordinate-controlled parts and linked gable frames

## Earlier

* [docs/history/README-through-v0.8.13.md](docs/history/README-through-v0.8.13.md) — the README that covered releases up to v0.8.13.
* [docs/history/MBDP-HANDOFF-v085-ARCHIVE.md](docs/history/MBDP-HANDOFF-v085-ARCHIVE.md) — v0.8.5 hand-off record.
