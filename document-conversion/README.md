# Document Conversion

*Source:* [github.ibm.com/Neil-Everette/Bob](https://github.ibm.com/Neil-Everette/Bob) → `skills/document-conversion/`
*Built by* [Neil Everette](https://github.ibm.com/Neil-Everette)

<!-- Card metadata — the marketplace renders these fields on the card preview, not on the details page. Keep in sync with the `card` block in manifest.json. -->

```yaml
category: Documentation
short_description: Markdown in, IBM-branded PDF out — IBM Plex Sans, IBM Design Language colors, optional cover page, auto-detected TOC.
version: 1.0.0
updated: 2026-04-27
author: Neil Everette
```

---

## Summary

Hand it a Markdown file and walk away with an IBM-branded PDF using IBM Plex Sans and IBM Design Language colors. Cover page and table of contents are optional and auto-detected from the source. Most runs land in less than a minute. Works in IBM Bob, Claude Code, and most other LLMs.

---

## What this skill does

Reads one Markdown file and writes the same-named PDF next to it (`report.md` → `report.pdf`) by calling `scripts/generate_ibm_pdf.py`. The renderer is Python + ReportLab, the typography is IBM Plex Sans (with a graceful fallback to ReportLab built-ins when fonts are missing), and the palette comes from IBM Design Language.

The script recognizes a small set of conventions from the Markdown source:

- `## Contents` (or `## Table of Contents`) followed by a numbered list becomes the styled TOC page; the original block is stripped from the body.
- `## Cover` is stripped from the body — pass cover content as CLI args if you want one rendered.
- `<!-- pagebreak -->` on its own line forces a page break.
- `---` renders as a thin horizontal rule, not a page break.
- Headings use H1 32pt Light, H2 16pt Medium, H3 12pt Medium. No automatic page-per-section.

The same conventions live in `references/page-types/` for cover, content, and TOC layouts. Style values are mirrored in `references/style-schema.json` so an editor can review the values without reading Python.

---

## What it enables you to do

- Convert any Markdown report into a presentation-ready IBM-branded PDF without leaving the chat.
- Toggle a cover page on or off through one CLI flag, with an auto-detected TOC when the source includes a `## Contents` block.
- Get IBM Plex Sans typography and IBM Design Language colors out of the box — no template wiring required.
- Force a page break with a single HTML comment when a section needs to start on its own page.
- Render the same source file again after edits — the script overwrites the PDF in place.

---

## Example output

Sample style schema: [style-schema.json](https://github.ibm.com/Neil-Everette/Bob/blob/main/skills/document-conversion/references/style-schema.json)

---

## How to use

1. Save your Markdown file anywhere on disk. Add a `## Contents` heading and numbered list if you want a TOC page.
2. Tell Bob: *"convert this markdown to an IBM PDF,"* *"export this report as a branded PDF,"* or *"make a PDF from `<file>.md`."*
3. Pass cover metadata (title, subtitle, date, team) when the skill asks — or skip the cover entirely.
4. Wait. The skill installs `reportlab` and `svglib` if missing, runs the script, and verifies the PDF renders.
5. Open the PDF next to the source file.

---

## Requirements

**Required**

- **A Markdown source file (`.md`).** Word docs, Google Docs, and PDFs as input are out of scope.
- **Python 3.** The script and its dependencies (`reportlab`, `svglib`) install on first run.

**Optional**

- **IBM Plex Sans installed at `~/Documents/IBM_Plex_Sans/static`.** Without it, the script falls back to ReportLab built-ins — branding will be off but the PDF still renders.
- **A `## Contents` heading and numbered list in the source.** Triggers the styled TOC page automatically.

If a required item is missing, the skill stops and tells you what's wrong. Optional items are skipped without complaint.

---

## One-click install

Copy this prompt into IBM Bob or your LLM of choice — the agent will install the skill for you.

```
# Install IBM Bob skill: document-conversion

Copy the folder `skills/document-conversion/` from https://github.ibm.com/Neil-Everette/Bob into `~/.bob/skills/document-conversion/`.

If the destination already exists, ask me before overwriting. Confirm when done.
```

> Keep this code block in sync with `install-prompt.md` (verbatim).

---

## Installation

Three steps. No terminal. No file paths to type.

1. **Find your agent below** — Bob, Claude Code, or any other LLM.
2. **Copy the whole code block.** Click the copy icon in the top-right of the block.
3. **Paste it into a fresh chat with your agent and hit enter.** The agent fetches the skill from this repo and installs it. Restart the agent when it tells you to.

No cloning. The agent fetches a small list of markdown files directly from raw URLs and writes them to the right local folder. That's it.

#### → IBM Bob

```
Install the "document-conversion" skill into IBM Bob. Do NOT clone the repo. Fetch each of the URLs below directly (one HTTP GET per file) and write the response body to the matching local path. All URLs are raw markdown — no auth required as long as I'm on the IBM network.

If ~/.bob/skills/document-conversion/ already exists, rename it to ~/.bob/skills/document-conversion.backup-<timestamp>/ first. Then create the folders ~/.bob/skills/document-conversion/, ~/.bob/skills/document-conversion/references/, ~/.bob/skills/document-conversion/references/page-types/, ~/.bob/skills/document-conversion/assets/, and ~/.bob/skills/document-conversion/scripts/.

Files to fetch and write:
- https://raw.github.ibm.com/Neil-Everette/Bob/main/skills/document-conversion/SKILL.md → ~/.bob/skills/document-conversion/SKILL.md
- https://raw.github.ibm.com/Neil-Everette/Bob/main/skills/document-conversion/README.md → ~/.bob/skills/document-conversion/README.md
- https://raw.github.ibm.com/Neil-Everette/Bob/main/skills/document-conversion/manifest.json → ~/.bob/skills/document-conversion/manifest.json
- https://raw.github.ibm.com/Neil-Everette/Bob/main/skills/document-conversion/install-prompt.md → ~/.bob/skills/document-conversion/install-prompt.md
- https://raw.github.ibm.com/Neil-Everette/Bob/main/skills/document-conversion/references/ibm-brand.md → ~/.bob/skills/document-conversion/references/ibm-brand.md
- https://raw.github.ibm.com/Neil-Everette/Bob/main/skills/document-conversion/references/style-schema.json → ~/.bob/skills/document-conversion/references/style-schema.json
- https://raw.github.ibm.com/Neil-Everette/Bob/main/skills/document-conversion/references/page-types/content.md → ~/.bob/skills/document-conversion/references/page-types/content.md
- https://raw.github.ibm.com/Neil-Everette/Bob/main/skills/document-conversion/references/page-types/cover.md → ~/.bob/skills/document-conversion/references/page-types/cover.md
- https://raw.github.ibm.com/Neil-Everette/Bob/main/skills/document-conversion/references/page-types/toc.md → ~/.bob/skills/document-conversion/references/page-types/toc.md
- https://raw.github.ibm.com/Neil-Everette/Bob/main/skills/document-conversion/assets/ibm-rebus-totem.svg → ~/.bob/skills/document-conversion/assets/ibm-rebus-totem.svg
- https://raw.github.ibm.com/Neil-Everette/Bob/main/skills/document-conversion/scripts/generate_ibm_pdf.py → ~/.bob/skills/document-conversion/scripts/generate_ibm_pdf.py

After all 11 files are written, confirm the count, then tell me to restart Bob.
```

#### → Claude Code

```
Install the "document-conversion" skill into Claude Code. Do NOT clone the repo. Fetch each of the URLs below directly (one HTTP GET per file) and write the response body to the matching local path. All URLs are raw markdown — no auth required as long as I'm on the IBM network.

If ~/.claude/skills/document-conversion/ already exists, rename it to ~/.claude/skills/document-conversion.backup-<timestamp>/ first. Then create the folders ~/.claude/skills/document-conversion/, ~/.claude/skills/document-conversion/references/, ~/.claude/skills/document-conversion/references/page-types/, ~/.claude/skills/document-conversion/assets/, and ~/.claude/skills/document-conversion/scripts/.

Files to fetch and write:
- https://raw.github.ibm.com/Neil-Everette/Bob/main/skills/document-conversion/SKILL.md → ~/.claude/skills/document-conversion/SKILL.md
- https://raw.github.ibm.com/Neil-Everette/Bob/main/skills/document-conversion/README.md → ~/.claude/skills/document-conversion/README.md
- https://raw.github.ibm.com/Neil-Everette/Bob/main/skills/document-conversion/manifest.json → ~/.claude/skills/document-conversion/manifest.json
- https://raw.github.ibm.com/Neil-Everette/Bob/main/skills/document-conversion/install-prompt.md → ~/.claude/skills/document-conversion/install-prompt.md
- https://raw.github.ibm.com/Neil-Everette/Bob/main/skills/document-conversion/references/ibm-brand.md → ~/.claude/skills/document-conversion/references/ibm-brand.md
- https://raw.github.ibm.com/Neil-Everette/Bob/main/skills/document-conversion/references/style-schema.json → ~/.claude/skills/document-conversion/references/style-schema.json
- https://raw.github.ibm.com/Neil-Everette/Bob/main/skills/document-conversion/references/page-types/content.md → ~/.claude/skills/document-conversion/references/page-types/content.md
- https://raw.github.ibm.com/Neil-Everette/Bob/main/skills/document-conversion/references/page-types/cover.md → ~/.claude/skills/document-conversion/references/page-types/cover.md
- https://raw.github.ibm.com/Neil-Everette/Bob/main/skills/document-conversion/references/page-types/toc.md → ~/.claude/skills/document-conversion/references/page-types/toc.md
- https://raw.github.ibm.com/Neil-Everette/Bob/main/skills/document-conversion/assets/ibm-rebus-totem.svg → ~/.claude/skills/document-conversion/assets/ibm-rebus-totem.svg
- https://raw.github.ibm.com/Neil-Everette/Bob/main/skills/document-conversion/scripts/generate_ibm_pdf.py → ~/.claude/skills/document-conversion/scripts/generate_ibm_pdf.py

After all 11 files are written, confirm the count, then tell me to start a fresh Claude Code session.
```

#### → Any other LLM (ChatGPT, Gemini, Claude web, etc.)

For agents that can't write to your filesystem, the skill runs in-conversation — the LLM fetches the same files but holds them in context instead of writing them to disk.

```
Set up the "document-conversion" skill for this conversation. Do NOT clone any repo. Fetch each URL below (one HTTP GET per file) and load the response body as part of your working context.

Operating instructions (treat this file as your primary instructions for the rest of the conversation):
- https://raw.github.ibm.com/Neil-Everette/Bob/main/skills/document-conversion/SKILL.md

Reference library (read each one when SKILL.md tells you to):
- https://raw.github.ibm.com/Neil-Everette/Bob/main/skills/document-conversion/references/ibm-brand.md
- https://raw.github.ibm.com/Neil-Everette/Bob/main/skills/document-conversion/references/style-schema.json
- https://raw.github.ibm.com/Neil-Everette/Bob/main/skills/document-conversion/references/page-types/content.md
- https://raw.github.ibm.com/Neil-Everette/Bob/main/skills/document-conversion/references/page-types/cover.md
- https://raw.github.ibm.com/Neil-Everette/Bob/main/skills/document-conversion/references/page-types/toc.md

Confirm you have all 6 files loaded. Then wait for me to paste a Markdown file to convert. Note: the LLM-context flow describes the rendering rules; producing an actual PDF requires the Bob or Claude Code install with Python.
```

If your LLM can't fetch URLs, click the raw view of each file in the repo, copy the contents, and paste them into the chat as separate messages.

### Did it work?

After your agent restarts, open any project folder with a Markdown file. Tell your agent any of these:

- "convert this markdown to an IBM PDF"
- "export this report as a branded PDF"
- "render `<file>.md` as a PDF"
- "make a PDF from this markdown"

The skill picks up the input, does its thing, and reports when it's done.

### To uninstall

Tell your agent: *"Delete the document-conversion skill folder from my agent's skills directory."*

---

## How the skill runs (summary)

A summary of the steps inside [`SKILL.md`](./SKILL.md). You don't need to read this to use the skill — it's here for the curious. The full untruncated SKILL.md (including the script's CLI contract and dependency install commands) lives in [`SKILL.md`](./SKILL.md) in this folder.

````markdown
---
name: document-conversion
description: Convert a Markdown file into an IBM-branded PDF. Trigger when the user asks to convert, render, generate, or export a Markdown document into a branded PDF, mentions an IBM PDF or IBM-branded report, or shares an .md file and wants it formatted for distribution.
---

# Document Conversion

Render a Markdown file into an IBM-branded PDF using Python + ReportLab. Output uses IBM Plex Sans and IBM Design Language colors. Cover page and table of contents are optional.

## Progress checklist

```
- [ ] Step 1: Identify the source .md file
- [ ] Step 2: Gather optional cover metadata
- [ ] Step 3: Install reportlab and svglib if missing
- [ ] Step 4: Run scripts/generate_ibm_pdf.py with flags
- [ ] Step 5: Verify the PDF and report the output path
```

## Steps in plain language

1. **Identify the source.** Confirm the `.md` path or ask for it. Output PDF is the same base name next to the source.
2. **Cover metadata.** Optional. Ask only if the user wants a cover page.
3. **Dependencies.** Install `reportlab` and `svglib` quietly on first run.
4. **Render.** Call `scripts/generate_ibm_pdf.py` with the source path, optional `--cover-title`, `--cover-subtitle`, `--cover-date`, `--cover-team`, and `--font-dir` flags.
5. **Verify and report.** Confirm the PDF wrote, then print the output path back to the user.
````

---

## Contact

Run into an issue, or have an idea to improve this skill? Contact [neil.everette@ibm.com](mailto:neil.everette@ibm.com).
