---
name: research-document-template
description: Generate professionally formatted UX research documents (plans, rationales, briefs) for IBM HashiCorp Secure products with the corporate design system
meta:
  version: 2.0
  author: UX Research Team
  tags: [research, documentation, word, enterprise, template]
  design-system: ../DESIGN-SYSTEM.md
---

# IBM HashiCorp Secure — Research Document Template

Create professional, reusable research documents following IBM HashiCorp Secure's design system and formatting standards. **This is the single template every generated research document goes through** — use it whenever a skill, agent, or teammate produces a research document, so all outputs share the same structure and styling.

## What This Skill Does

Generates polished Word documents (.docx) for UX research artifacts with:
- **Consistent Design System**: IBM Plex Sans typography, IBM Carbon color tokens (Blue 60 #0F62FE, Gray 100 #161616), Gray 10 callouts with Blue 60 accent bars
- **Two Layouts**:
  - **Research plan** (default) — purpose → scope → research questions → participants → discussion guide → timeline → deliverables
  - **Custom `sections`** — for rationales, briefs, one-pagers, or any document that doesn't fit the plan structure
- **Readability Built In**: 1.15 line spacing, dynamic section numbering (omitted sections never leave gaps), no orphaned headings (keep-with-next), page-number footers, table headers that repeat across page breaks
- **Team Reusability**: Use for Vault, Boundary, Consul, Radar, or Terraform research

## How to Use

**As a skill (in Bob / Claude Code):**
```
/research-document-template

I'm planning a [study type] for [product]. [Describe your research...]
```

**As a script:**
```bash
python3 skills/research-document-template.py my-config.json My_Research_Plan.docx
```

You provide:

1. **Document Type**:
   - Research plan (migration study, feature evaluation, adoption, comparative)
   - Rationale / brief / custom document (uses the `sections` layout)

2. **Core Details**:
   - Product name and document title
   - Purpose and central research question
   - Scope (in/out), research questions, participants, timeline — as applicable

3. **Optional Customizations**:
   - Include/exclude specific sections (empty sections are automatically skipped — no orphaned headings)
   - Custom section layouts via the `sections` config (see `CONFIG-SCHEMA.md`)

## Output

A Word document (.docx) ready to share with stakeholders, print, or refine:

- Professional cover: title, subtitle, thin accent rule, gray metadata block
- Running page header (document title + org/date) and a confidentiality footer note, when configured
- Auto-numbered sections with no gaps
- Callout boxes for key questions, decisions, and success/failure criteria
- Design-system tables with repeating headers — timelines adapt from simple Timeframe/Milestone up to 4-column Phase/Timeframe/Outputs/Activities execution plans
- Numbered discussion guide questions (1.1, 2.1…) for field reference
- Page numbers on every page

Plus a list of anything that didn't make it in:

```
! 2 section(s) omitted from Vault_Adoption_Study.docx:
    Discussion Guide — no content under "discussion_guide"
    Timeline and Milestones — suppressed by "include_timeline": false
  Check these against the plan this document was generated from.
```

Empty sections are skipped so you never get an orphaned heading — but skipping
them quietly would mean the `.docx` can contain less than the plan that passed
the gates, with nothing to say so. That's the same failure the deck gate exists
to catch: the render step changing what a reader sees relative to what was
checked. So every omission is named, with its reason. Read the list against the
plan the config came from before you share the document.

## Design System

All documents use IBM HashiCorp Secure's brand-aligned styling (see `../DESIGN-SYSTEM.md` for the full standard):
- **Font:** IBM Plex Sans throughout (body, lists, tables, footers), 1.15 line spacing
- **Blue 60** (#0F62FE) for the title and H1 headings
- **Gray 70** (#525252) for the subtitle and H2 headings
- **Callouts:** Gray 10 (#F4F4F4) background with a #0F62FE left accent bar
- **Body text:** Gray 100 (#161616) for comfortable reading
- **Tables:** Gray 10 (#F4F4F4) headers with bold Gray 100 text

## Common Scenarios

### Scenario 1: Migration Research (like Consul)
Research how customers make migration decisions, what barriers exist, and what support they need. `CONFIG-SCHEMA.md` documents every field with examples.

### Scenario 2: Feature Evaluation
Test a new feature or product concept with target users, mapped to feature-specific questions and success metrics.

### Scenario 3: Adoption Study
Research why teams do or don't adopt your product, what triggers adoption, and what removes friction.

### Scenario 4: Research Rationale / Brief
Document *why* a study matters — purpose, central question, and scope — without the full plan machinery. Only the sections you provide are rendered (a rationale config with no discussion guide produces no empty "Discussion Guide" heading), or use the `sections` layout for full control.

## Tips for Best Results

- **Be Specific**: The more detail you provide about your research context, the better tailored the document
- **Keep scope items concise**: One short line each (~4–7 words, ~5–7 items per column) — they render as non-bold bullets in a side-by-side In Scope / Out of Scope table
- **Know Your Research Questions**: Even rough draft RQs help generate targeted guidance
- **Timeline Reality**: Provide realistic timelines; the skill will suggest phase breakdowns
- **Scope Boundaries**: Explicitly note what's OUT of scope so stakeholders understand constraints
- **Sub-numbering lives in your config**: Section numbers ("1.", "2.") are automatic, but group names like "3.1" and question numbers like "(1.1)" come from your config — keep them consistent with the sections you include

## For IBM HashiCorp Secure Teams

This skill is designed for:
- **UX Research** — planning generative, evaluative, and comparative studies; writing rationales and briefs
- **Product Management** — getting stakeholder alignment on research scope
- **Engineering** — understanding customer decision-making and friction
- **Security/Compliance** — documenting research methodology and consent

Use consistently across teams so every research document meets the same professional standard. The repo copy (`skills/research-document-template.py`) is the source of truth — sync any local `~/.claude/skills/` copy from here.

---

*Part of the Dr. Morgan UX research suite. Author: **Kirsten Hosic**, UX Research
Strategy Lead, Security Product Design.*
