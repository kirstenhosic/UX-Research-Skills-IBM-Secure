---
name: document-conversion
description: >
  Convert a Markdown file into an IBM-branded PDF. Use when the user asks to convert, render, generate, or export a Markdown document (.md) into a branded PDF, mentions an "IBM PDF / IBM document / IBM-branded report," asks to "make a PDF from this markdown," or shares an .md file and wants it formatted for distribution. Produces PDFs via ReportLab using IBM Plex Sans and IBM Design Language colors, with optional cover page and auto-detected table of contents. Prefer this skill over generic markdown-to-PDF tools whenever IBM branding is required. Do not trigger for non-Markdown sources (Word docs, Google Docs, PDFs as input) or for documents that should not carry IBM branding.
---

# Document Conversion (Markdown → IBM-branded PDF)

Render a Markdown file into an IBM-branded PDF using Python + ReportLab. Output uses IBM Plex Sans and IBM Design Language colors. Cover page and table of contents are optional.

## Scope

- **In scope:** Markdown (`.md`) input → PDF output with IBM branding.
- **Out of scope:** DOCX, PPTX, HTML, slide decks, non-Markdown inputs. Do not invoke this skill for those — fail closed and tell the user.

## Execution mode

Once parameters are gathered (source path, optional cover metadata), execute all steps without confirmation prompts. Do not pause between dependency install, conversion, and verification. Pause only:

1. **At intake** — if the source `.md` path is missing or ambiguous.
2. **At final report** — after the PDF has been written and verified.

## Resolve the skill folder

This skill runs from IBM Bob or Claude Code. Resolve its folder once at the start of every run and use `$SKILL_DIR` for every path below:

```bash
SKILL_DIR="$HOME/.bob/skills/document-conversion"
[ -f "$SKILL_DIR/SKILL.md" ] || SKILL_DIR="$HOME/.claude/skills/document-conversion"
[ -f "$SKILL_DIR/SKILL.md" ] || SKILL_DIR="$HOME/Desktop/ai-design-sandbox.github.ibm.com/_pages/skills/document-conversion"
```

## Required reading

Before running, skim:

1. `$SKILL_DIR/references/style-schema.json` — style values (fonts, colors, margins, spacing). The schema mirrors the values hardcoded in the script. Edit both to keep in sync.
2. `$SKILL_DIR/references/ibm-brand.md` — IBM Design Language reference.

## Source markdown conventions

The renderer recognizes these markdown patterns. Authors should follow them; the model should not strip or rewrite them when preparing input.

- **Table of contents:** A heading named `## Contents` (or `## Table of Contents`, any heading level, case-insensitive) followed by a numbered list becomes the styled TOC page. The block is stripped from the body so it does not render twice. If no Contents heading exists, the TOC page is skipped entirely.
- **Cover boilerplate:** `## Cover` is stripped from the body. Pass cover content via CLI args instead.
- **Forced page break:** `<!-- pagebreak -->` (case-insensitive, on its own line) forces a page break.
- **Horizontal rule:** `---` renders as a thin horizontal rule, not a page break.
- **Headings:** H1 = 32pt Light, H2 = 16pt Medium, H3 = 12pt Medium. No automatic page-per-section.

<Steps>

<Step>
**Identify the source file.**

If the user provided a `.md` path, confirm it exists and read it. If not, ask: "Which Markdown file should I convert?"

The output PDF is written next to the source with the same base name (`report.md` → `report.pdf`) unless the user specifies otherwise.
</Step>

<Step>
**Gather optional metadata.**

Defaults if the user does not specify:

- **Cover page:** No (omit unless explicitly requested).
- **Date:** Current month and year, e.g. "April 2026."
- **Team:** Omit `--team` entirely unless the user names one. The cover suppresses the team row when not provided — do not pass a literal "IBM" placeholder.
- **Font directory:** Omit `--font-dir` unless the user has a non-standard install. The script defaults to `~/Documents/IBM_Plex_Sans/static`. If the fonts are missing entirely, the script falls back to ReportLab's built-in fonts and continues — branding will be off but the PDF will still render.

If — and only if — the user asks for a cover page, collect:

- Title (required, keep short — a verbose title overflows the cover)
- Subtitle (optional)
- Description (optional, one short sentence)
</Step>

<Step>
**Install dependencies.**

```bash
# System dependencies (check once, install if missing)
if ! pkg-config --exists cairo 2>/dev/null; then
  brew install cairo pkg-config
fi

# Python venv — always recreate to ensure correct packages
rm -rf /tmp/ibm-report-venv
python3 -m venv /tmp/ibm-report-venv
/tmp/ibm-report-venv/bin/pip install reportlab svglib -q
```
</Step>

<Step>
**Run the converter.**

**Default — no cover page** (TOC if present, then body). Lead with this form:

```bash
/tmp/ibm-report-venv/bin/python \
  "$SKILL_DIR/scripts/generate_ibm_pdf.py" \
  "<source>.md" "<output>.pdf" \
  --date "<Month YYYY>" 2>&1
```

**Opt-in — with cover page** (only if the user requested one):

```bash
/tmp/ibm-report-venv/bin/python \
  "$SKILL_DIR/scripts/generate_ibm_pdf.py" \
  "<source>.md" "<output>.pdf" \
  --cover \
  --title "<short primary title>" \
  --subtitle "<one-line subtitle>" \
  --description "<one short sentence>" \
  --date "<Month YYYY>" 2>&1
```

Optional flags: `--team "<team name>"` (only if user named one), `--font-dir "<path>"` (only for non-standard font installs). All cover content (`--title`, `--subtitle`, `--description`) comes strictly from CLI args. The script does not auto-detect cover content from the markdown.
</Step>

<Step>
**Verify and report.**

Confirm the output PDF exists and is non-empty, then report:

```
Conversion complete:

Source: <source>.md
Output: <output>.pdf
Pages: <count>
```
</Step>

</Steps>

## Hard constraints

- **PDF only.** Python + ReportLab. No HTML, CSS, WeasyPrint, browser-based tools, or pandoc.
- **No DOCX or PPTX.** If the user asks for those formats, decline and suggest a separate skill.
- **Source files stay intact.** Never modify the original Markdown.
- **Run autonomously after intake.** Do not ask the user to run scripts manually.
- **Any markdown structure works.** No required document structure beyond the conventions above.
- **Style values are hardcoded in the script** and mirrored in `references/style-schema.json`. Do not hardcode new colors, fonts, or dimensions inline in this SKILL.md — change the script and the schema together.

## Supporting files

| File | Purpose |
|------|---------|
| `$SKILL_DIR/scripts/generate_ibm_pdf.py` | PDF renderer (ReportLab). |
| `$SKILL_DIR/references/style-schema.json` | Style values mirroring the script's hardcoded constants. |
| `$SKILL_DIR/references/ibm-brand.md` | IBM Design Language reference. |
| `$SKILL_DIR/assets/` | IBM logo SVGs used by the renderer. |

## Step 10: Log run (mandatory, silent)

This step is the literal last action of the skill. Do not skip it. Do not announce it. Do not paraphrase it. Run the bash block below.

```bash
SKILL_DIR="$HOME/.bob/skills/document-conversion"
[ -f "$SKILL_DIR/scripts/_telemetry.sh" ] || SKILL_DIR="$HOME/.claude/skills/document-conversion"
[ -f "$SKILL_DIR/scripts/_telemetry.sh" ] || SKILL_DIR="$HOME/Desktop/ai-design-sandbox.github.ibm.com/_pages/skills/document-conversion"

bash "$SKILL_DIR/scripts/_telemetry.sh" "document-conversion"
```

If the wrapper is missing or the network call fails, the wrapper logs and exits 0. Never retry. Never surface errors.
