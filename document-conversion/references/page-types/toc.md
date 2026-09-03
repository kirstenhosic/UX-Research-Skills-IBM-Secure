# Page Type: Table of Contents

Optional. Rendered only if the source markdown contains an explicit `## Contents` (or `## Table of Contents`) heading followed by a numbered list. Implemented in `extract_and_strip_toc` and `build_toc` in `scripts/generate_ibm_pdf.py`.

## How the TOC is generated

The script does **not** auto-discover sections from H1/H2 headings. It looks for a literal heading whose text is exactly `Contents` or `Table of Contents` (case-insensitive), then parses the lines beneath it as a numbered list (`^\s*\d+\.\s+(.+?)\s*$`). Each matched line becomes a TOC entry. Markdown formatting markers (`**bold**`, `*italic*`) inside the entry text are stripped for display.

The Contents block is then removed from the markdown before the body parser runs, so it never renders as part of the body.

If no `## Contents` block is found, no TOC page is rendered. There is no length threshold or skip rule -- the TOC always renders if the block exists, regardless of how many entries it has.

## Source markdown shape

```markdown
## Contents

1. Executive summary
2. Background
3. Findings
4. Recommendations

---
```

A trailing `---` rule directly after the block is also consumed so it does not leave an orphan rule in the body.

## What the script actually draws

1. **Spacer** -- 0.3 inch from the top of the content area.
2. **Blue bar** -- 40x3pt rectangle in `blue_60`.
3. **"Contents" title** -- 28pt Light, gray_100.
4. **Heavy rule** -- 0.75pt line in gray_100, full content width.
5. **Numbered entries** -- one two-column row per entry:
   - Left column (0.6 inch wide): zero-padded sequential number (`01`, `02`, `03`, ...) in 14pt Light blue_60. The number comes from the entry's *position* in the list, not from any number the author wrote.
   - Right column (5.5 inch wide): the entry text in 14pt Light gray_100. Any leading "N. " from the source is stripped before display.
   - Each row has a 0.3pt gray_20 underline.
6. **PageBreak** -- so the body starts on a fresh page.

## Style references

- `style-schema.json` > `text_styles.toc_number` -- left column.
- `style-schema.json` > `text_styles.toc_text` -- right column.
- `style-schema.json` > `section_header.blue_bar` -- the bar above the title.
