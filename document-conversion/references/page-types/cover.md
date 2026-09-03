# Page Type: Cover

Optional first page. Rendered only when the script is invoked with `--cover`. Implemented in `cover_page_cb` and `build_cover` in `scripts/generate_ibm_pdf.py`.

## What the script actually draws

1. **Full-bleed background fill** -- solid `#071c68` covering the entire letter-size page.
2. **Cyan accent line** -- a single 1pt horizontal line in `cyan_11` (`#82cfff`), spanning the content width, drawn 122pt below the top of the page.
3. **Title block** -- pushed down 1.7 inches from the top:
   - Title (required, 45pt Light, white).
   - Subtitle (optional, 24pt Light, cyan_11) -- only if `--subtitle` is passed.
   - Description (optional, 14pt Light, cyan_09) -- only if `--description` is passed.
4. **Metadata block** -- only rendered if at least one of `--date` / `--team` is provided. Pushed 2.5 inches below the title block. Each item is a label/value pair:
   - Label: 12pt Light, cyan_11 (e.g. "Research date", "Team").
   - Value: 14pt Light, white.
5. **Logo** -- the IBM Rebus totem SVG (`assets/ibm-rebus-totem.svg`), placed at the bottom-right corner with 57pt margins from the right and bottom edges, scaled to fit a 45x100pt box. Skipped silently if `svglib` is not installed or the asset is missing.

After the cover, the script appends a `PageBreak` so subsequent pages use the standard content frame.

## CLI flags that drive the cover

| Flag | Required | Effect |
|------|----------|--------|
| `--cover` | Yes (to render this page at all) | Enables cover-page rendering. |
| `--title` | No (defaults to title-cased filename) | Used for cover title and footer template. |
| `--subtitle` | No | Renders the subtitle line. |
| `--description` | No | Renders the description line. |
| `--date` | No | Renders "Research date" metadata pair. |
| `--team` | No | Renders "Team" metadata pair only when explicitly provided. The row is suppressed otherwise — no default placeholder. |

## Markdown interactions

If the source markdown has a top-of-document H1 whose text matches the cover title (case-insensitive), the script drops that H1 and a single trailing `---` rule so the title doesn't appear twice. A `## Cover` block in the markdown (heading + body + trailing rule) is also stripped before parsing.

## Style references

- `style-schema.json` > `cover_page.*` -- background, accent line, logo placement.
- `style-schema.json` > `text_styles.cover_*` -- title, subtitle, description, metadata label/value styles.
