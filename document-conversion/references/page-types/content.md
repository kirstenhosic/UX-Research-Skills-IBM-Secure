# Page Type: Content

The default page frame for every body page (everything after cover and TOC). Implemented in `content_page_cb` and `parse_markdown` in `scripts/generate_ibm_pdf.py`.

## Page frame

The script draws **only a footer** on each content page. There is no top header rule, no document title in a header, no header page-number badge.

Each content page renders:

- **Footer rule** -- a 0.5pt gray_20 horizontal line, full content width, drawn 0.15 inch below the bottom margin.
- **Footer text (left)** -- `IBM Design Language  |  {title}  |  {date}`, in 6.5pt Regular gray_50, drawn 0.35 inch below the bottom margin. `{title}` is the value passed via `--title` (or a title-cased version of the markdown filename). `{date}` is `--date` or "Month YYYY" of the current date.
- **Footer text (right)** -- `IBM Confidential  ·  Page {N}`, same font/color, right-aligned at the same y-offset.

The content area itself is everything between the top margin (0.75 inch) and the bottom margin (0.85 inch), with 0.75 inch left/right margins -- a 7.0 inch content width.

## Supported markdown elements

The body parser renders:

- **Headings**: `#` (H1, rendered as a section header with blue bar + 32pt Light title + thin rule), `##` (H2, 16pt Medium), `###` (H3, 12pt Medium).
- **Body paragraphs**: 9.5pt Regular, gray_100.
- **Inline formatting**: `**bold**`, `*italic*`, `***bold italic***`, `[label](url)` (external `http(s)` links render in blue_60; internal anchors are bolded).
- **Bullet lists**: `- ` or `* ` (em-dash bullet), and indented sub-bullets (round bullet, deeper indent).
- **Blockquotes**: `> ` rendered as a callout box (blue_10 fill, blue_60 left bar, optional `-- attribution` line).
- **Tables**: standard pipe-delimited markdown tables with a separator row.
- **Horizontal rules**: `---` (and `***`, `___`) rendered as thin rules.
- **Page breaks**: an explicit `<!-- pagebreak -->` HTML comment forces a new page.
- **Bold-label paragraphs**: lines that start with `**Label:**` get the label bolded inline.

## What the script does NOT do

- It does not draw a top header rule, page number, or running title at the top of content pages.
- It does not auto-detect or generate executive-summary, conclusion, or section-divider page types -- those are just regular content rendered with the H1/H2/H3 styles.
- It does not insert page breaks between H1 sections automatically. Authors must add `<!-- pagebreak -->` where they want a forced break.

## Style references

- `style-schema.json` > `content_footer.*` -- footer rule + text layout.
- `style-schema.json` > `text_styles.*` -- all text element styles.
- `style-schema.json` > `table_style.*` -- table formatting.
- `style-schema.json` > `callout_box.*` -- blockquote/callout formatting.
- `style-schema.json` > `section_header.*` -- the blue bar + thin rule pattern used for H1.
