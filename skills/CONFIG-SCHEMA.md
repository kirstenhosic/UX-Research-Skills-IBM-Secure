# Research Plan Configuration Schema

Complete reference for all available configuration options in the JSON schema.

## Structure Overview

```json
{
  "plan_type": "string",
  "product_name": "string",
  "plan_title": "string",
  "metadata": ["array of strings"],
  
  "purpose": "string (short lead paragraph)",
  "purpose_points": ["array — bullets after the purpose lead"],
  "purpose_extra": "string, or { \"text\": \"lead\", \"items\": [\"bullets\"] }",
  "central_question": "string",
  "primary_outputs": ["array"],
  
  "scope_intro": "string",
  "scope_headers": ["In Scope label", "Out of Scope label"],
  "in_scope": ["array"],
  "out_of_scope": ["array"],
  "scope_note": "string",
  
  "research_questions_intro": "string",
  "research_questions": [{ "group_name": "string", "questions": ["array"] }],
  
  "hypotheses_intro": "string",
  "hypotheses": [{ "id": "H1", "statement": "string", "note": "string (optional)" }],
  
  "risks_intro": "string",
  "risks": [{ "label": "string", "detail": "string" }],
  
  "open_items": ["array"],
  
  "participant_profile": "string (short lead)",
  "participant_criteria": ["array — bulleted profile criteria"],
  "disqualifiers": ["array"],
  "recruitment_channels": ["strings, or { \"name\": \"channel\", \"points\": [\"detail bullets\"] }"],
  
  "discussion_guide_intro": "string (moderator note rendered as a callout above the guide)",
  "discussion_guide": [{ 
    "section_name": "string",
    "time_info": "string", 
    "questions": ["array"] 
  }],
  
  "analysis_plan": { "intro": "string", "items": ["array"] },
  
  "timeline": [{ 
    "timeframe": "string", 
    "milestone": "string" 
  }],
  
  "deliverables": [{
    "title": "string",
    "items": ["array"]
  }],
  
  "include_*": true/false
}
```

## Detailed Field Reference

### Document Metadata

#### `plan_type` (string, optional)
The type of research being planned.

**Examples:**
- `"migration"` — Migration study (like Consul)
- `"feature-evaluation"` — Testing a new feature
- `"adoption"` — Understanding adoption barriers
- `"competitive"` — Comparing against alternatives
- `"custom"` — Any other type

---

#### `product_name` (string, required)
The product or initiative name shown on the title page.

**Examples:**
```json
"product_name": "Consul Adoption"
"product_name": "Boundary Enterprise Access Management"
"product_name": "Consul Service Mesh"
```

---

#### `plan_title` (string, required)
Subtitle shown under the product name.

**Examples:**
```json
"plan_title": "Research Plan"
"plan_title": "Migration & Trust Study"
"plan_title": "Feature Evaluation Plan"
```

---

#### `metadata` (array of strings, optional)
Additional context shown on the title page (organization, status, dates, etc.).

**Example:**
```json
"metadata": [
  "IBM HashiCorp Secure  |  UX Research",
  "Status: Draft for Review  |  Author: Jane Smith  |  Created: June 2026",
  "Research Window: Weeks 5–8  |  Findings Due: [DATE]"
]
```

---

#### `page_header` (array of 1–2 strings, optional)
Running header shown on every page: a bold title line and an optional gray context line, separated from the body by a thin accent rule. Omit for no header.

**Example:**
```json
"page_header": [
  "Consul Adoption — Study 1 Plan",
  "IBM HashiCorp Secure  |  UX Research  |  July 2026"
]
```

---

#### `footer_note` (string, optional)
Note shown at the left of every page footer (page number moves to the right). Without it, the page number is centered.

**Example:**
```json
"footer_note": "Confidential — Internal Use Only"
```

---

### Strategic Framing

#### `purpose` (string, required)
1–2 paragraphs explaining why this research matters and what problem it solves.

**Example:**
```json
"purpose": "This research addresses slow initial adoption. We need to understand what platform teams evaluate before committing to a production deployment, and what product investment, documentation, and support would need to be in place for them to get there."
```

---

#### `purpose_points` (array of strings, optional)
Bullets rendered directly after the purpose lead paragraph. Note: the team's
established preference is prose (no bullets) for the Purpose and Strategic
Framing narrative — use this field sparingly; genuine lists like
`primary_outputs` stay bulleted.

---

#### `purpose_extra` (string or object, optional)
Supporting framing that doesn't belong in the main purpose paragraph, e.g.
distinguishing customer segments. A plain string renders as a paragraph; an
object `{ "text": "lead", "items": ["..."] }` renders a short lead followed
by bullets.

---

#### `central_question` (string, optional)
The single overarching research question in quotation marks.

**Example:**
```json
"central_question": "\"What has to be true for a platform team to move from evaluating this to running it in production?\""
```

---

#### `primary_outputs` (array of strings, optional)
Bulleted list of what this research is expected to produce, rendered under a
bold "Primary Outputs:" lead-in at the end of the Purpose section.

---

### Scope Boundaries

#### `scope_intro` (string, optional)
Why scope is bounded the way it is. Omit it and no intro paragraph renders —
there is no default, because a sentence explaining your reasoning has to come
from you. Say what you actually cut and why.

**Example:**
```json
"scope_intro": "Narrowed to setup only, because the rotation flow ships in Q4."
```

---

#### `scope_headers` (array of two strings, optional)
Overrides the scope table's column headers (default `["In Scope", "Out of Scope"]`).
Use when you need ownership context in the header itself, e.g.:
```json
"scope_headers": ["In Scope — UX Research Owned", "Out of Scope — Other Teams / Future Studies"]
```

---

#### `scope_note` (string, optional)
Italic clarifying note rendered directly under the scope table — e.g. to flag
that an out-of-scope item is deferred rather than permanently excluded.

---

#### `in_scope` (array of strings, optional)
List of topics/questions that ARE included in the research. Renders as the left column of a two-column In Scope / Out of Scope table, with each item as a bullet in regular (non-bold) weight. **Keep items concise — one short line each (roughly 4–7 words)** so the columns stay scannable side by side; aim for ~5–7 items.

**Example:**
```json
"in_scope": [
  "When and why customers decide to migrate",
  "Trust signals and risk tolerance",
  "Critical feature requirements for engagement",
  "Role-based migration labor and bottlenecks"
]
```

---

#### `out_of_scope` (array of strings, optional)
List of topics that are explicitly NOT included. Renders as the right column of the scope table — same rules: concise bullets, regular weight.

**Example:**
```json
"out_of_scope": [
  "Competitive migration analysis",
  "Pricing and packaging",
  "Consul UI/UX evaluation",
  "Feature parity prioritization"
]
```

---

### Research Questions

#### `research_questions_intro` (string, optional)
Introductory text before research questions. Omit it and no intro paragraph
renders — there is no default. Don't use it to assert that the questions are
well-formed; that is `plan-reviewer`'s call, and a document that claims it of
itself has only moved the claim somewhere nothing checks. Use it to say what
the questions are for.

**Example:**
```json
"research_questions_intro": "Three questions, all tied to the September go/no-go."
```

---

#### `research_questions` (array of objects, optional)
Array of research question groups, each with a title and list of questions.

**Structure:**
```json
"research_questions": [
  {
    "group_name": "3.1 Decision Model — Priority 1",
    "questions": [
      "RQ1: How do customers decide to migrate critical infrastructure?",
      "RQ2: What triggering events create willingness to move?",
      "RQ3: What organizational constraints affect the decision?"
    ]
  },
  {
    "group_name": "3.2 Trust and Risk Thresholds — Priority 1",
    "questions": [
      "RQ4: What would have to be true for a customer to initiate migration?",
      "RQ5: What risks are unacceptable vs. tolerable?"
    ]
  }
]
```

---

### Assumptions, Hypotheses, Risks, and Open Items

These sections are common to research rationales (and useful in plans too). Each
renders only when its array has content, so omitting a field leaves no empty
heading — the same rule every other section in this schema follows. This is
also the trio that a prior version of the generic `sections` layout silently
dropped when converting a hand-written rationale into config form, so treat
their presence as required whenever a rationale has stated hypotheses or risks.

#### `hypotheses_intro` (string, optional)
Introductory text before the hypotheses list — e.g. framing them as
falsifiable claims to be checked against disconfirming evidence at synthesis.

#### `hypotheses` (array of objects, optional)
Each item renders as `{id}: {statement} {note}`.

**Structure:**
```json
"hypotheses": [
  { "id": "H1", "statement": "Primary barriers are fear of unrecoverable errors AND absence of feature parity.", "note": "These barriers are weighted differently across segments." },
  { "id": "H2", "statement": "TBD — pending PM and Engineering input on critical feature hypotheses." }
]
```

#### `risks_intro` (string, optional)
Introductory text before the risks list.

#### `risks` (array of objects, optional)
Each item renders as `{label}: {detail}`. Plain strings are also accepted if
you don't need a label/detail split.

**Structure:**
```json
"risks": [
  { "label": "Recruitment access", "detail": "No formalized process exists and CSM relationships are new." },
  { "label": "Sample scope", "detail": "7 interviews cannot represent full diversity of the customer base. Findings are directional." }
]
```

#### `open_items` (array of strings, optional)
Unresolved items to confirm before the plan is finalized (e.g. pending legal
sign-off, unconfirmed timelines, dependencies on other teams).

**Structure:**
```json
"open_items": [
  "Legal/consent — confirm participant and recording consent process",
  "Findings handoff date — confirm with PM"
]
```

---

### Participants & Recruitment

#### `participant_profile` (string, optional)
Short lead sentence describing who you're targeting. Put the specific
criteria in `participant_criteria` bullets rather than packing them all into
this paragraph.

**Example:**
```json
"participant_profile": "Primary operators of Vault Current in a production environment, with direct input into infrastructure migration decisions."
```

---

#### `participant_criteria` (array of strings, optional)
Bulleted screening criteria rendered under the Target Profile lead.

**Example:**
```json
"participant_criteria": [
  "Role: platform engineer, security engineer, or DevOps lead",
  "Primary operator of Vault Current in production",
  "Company size: 200+ employees",
  "Direct input into infrastructure migration decisions"
]
```

---

#### `disqualifiers` (array of strings, optional)
Conditions that automatically exclude potential participants.

**Example:**
```json
"disqualifiers": [
  "Primary contact is through a managed service (no migration authority)",
  "Not operating in production environment",
  "Fewer than 200 employees"
]
```

---

#### `recruitment_channels` (array, optional)
How you'll find and recruit participants, in priority order. Plain strings
render as flat bullets; `{ "name", "points" }` objects render a bold channel
name with indented detail bullets — prefer objects when a channel needs more
than one sentence of explanation.

**Example:**
```json
"recruitment_channels": [
  {
    "name": "1. CSM-mediated via product manager — primary channel",
    "points": [
      "Templated outreach email provided to CSMs; researcher owns logistics after introduction",
      "Explicitly request 1–2 skeptical or at-risk accounts to counter sampling bias"
    ]
  },
  {
    "name": "2. External research panel — last resort",
    "points": ["Treat as supplementary; weight customer sessions more heavily in synthesis"]
  }
]
```

---

### Discussion Guide

#### `discussion_guide_intro` (string, optional)
Moderator note rendered as a callout box above the guide sections — use for
session-wide guidance such as language framing (e.g. "favor 'adoption' over
'migration' in participant-facing wording") or consent reminders.

#### `discussion_guide` (array of objects, optional)
Ordered sections of the discussion guide, each with questions that will be auto-numbered.

**Structure:**
```json
"discussion_guide": [
  {
    "section_name": "Section 1 — Warm-Up",
    "time_info": "5 minutes",
    "questions": [
      "(1.1) Tell me about your role and how you came to manage this system.",
      "(1.2) Walk me through your current deployment."
    ]
  },
  {
    "section_name": "Section 2 — Current Practice",
    "time_info": "10 minutes  →  RQ2 setup",
    "questions": [
      "(2.1) What are the two or three workflows your team depends on most?",
      "(2.2) Tell me about the last time something caused operational stress."
    ]
  }
]
```

**Notes:**
- Do NOT include numbering in question text — the generator numbers questions sequentially across the whole guide (1, 2, 3 …) so any question is unambiguous mid-session. A question given as an array of strings renders as letter sub-parts under one number (5a, 5b, 5c). Never use decimal pairs like (1.1).
- Questions render as indented numbered items with a bold number — no bullet glyphs (the number is the marker)
- A question string starting with `[` (e.g. `"[Framing — read to participant]: …"`) renders as an italic, unnumbered moderator line
- Include time allocations for each section
- Optionally reference which research questions each section addresses with `→ RQ#` notation
- Questions are rendered as bullet points in the document
- Section time allocations should sum to the session length stated in `metadata` — check this whenever you add or remove questions

---

### Analysis Plan

#### `analysis_plan` (object or string, optional)
How sessions become findings. Renders after the discussion guide, before the
timeline. As an object: `intro` paragraph plus bulleted `items`; a plain string
renders as a single paragraph. Cover: unit of analysis, coding approach
(deductive frame / inductive pass), coder count and disagreement handling,
the disconfirming-evidence check against stated hypotheses, and what will NOT
be analyzed. Don't leave analysis activities living only as timeline
milestones — that's how this section gets silently lost.

**Structure:**
```json
"analysis_plan": {
  "intro": "Analysis converts session data into findings mapped to the product decisions. The unit of analysis is the coded excerpt within each session.",
  "items": [
    "Coding: deductive frame seeded by the research question groups, with an inductive pass for emergent themes",
    "Process: independent coding, then a norming session to resolve disagreements before affinity mapping",
    "Bias check: disconfirming-evidence pass against each retained hypothesis",
    "Out of analysis scope: feature-level prioritization ranking (deferred to quantitative follow-up)"
  ]
}
```

---

### Timeline

#### `timeline` (array of objects, optional)
Milestones and activities week-by-week. **Columns adapt to the keys you provide** — recognized keys, in column order: `phase`, `timeframe`, `milestone`, `outputs`, `activities`. A column appears only if at least one item uses its key.

Any cell value may be an **array of strings**, which renders as bullets inside
the cell — strongly preferred over sentence-run prose for dense milestone
cells:

```json
{ "timeframe": "Wk 1–2", "milestone": [
  "Stakeholder alignment confirmed",
  "Screener and outreach email finalized",
  "Consent process confirmed with legal"
] }
```

**Simple structure:**
```json
"timeline": [
  {
    "timeframe": "Wk 1–2",
    "milestone": "Stakeholder alignment confirmed. PM and Eng input gathered."
  },
  {
    "timeframe": "Wk 3–4",
    "milestone": "Recruitment live. Discussion guide finalized. Pilot completed."
  }
]
```

**Rich execution-plan structure** (renders a 4-column Phase / Timeframe / Outputs / Activities table):
```json
"timeline": [
  {
    "phase": "Phase 1 — Alignment",
    "timeframe": "Wk 1–2",
    "outputs": "Finalized screener and outreach email",
    "activities": "Stakeholder alignment, CSM meeting, consent process confirmed"
  }
]
```

---

#### `success_criteria` (object, optional)
Renders a "Success Criteria" section as paired callout boxes — "Research is successful if:" and "Failure looks like:". Toggle with `include_success_criteria`.

**Example:**
```json
"success_criteria": {
  "success": "The PM can defend the adoption roadmap with evidence-backed confidence, and feature prioritization decisions cite specific findings.",
  "failure": "\"It depends\" findings with no decision guidance, or recommendations no one owns."
}
```

---

### Deliverables

#### `deliverables` (array of objects, optional)
What the research will produce, organized by type.

**Structure:**
```json
"deliverables": [
  {
    "title": "7.1 Research Findings",
    "items": [
      "One findings document mapped to three product decisions",
      "Each finding: evidence (quote + participant ID) → interpretation → insight",
      "Scope statement and confidence note included"
    ]
  },
  {
    "title": "7.2 Migration Narrative Input",
    "items": [
      "Draft language PM can use to build the the launch event narrative",
      "Grounded in actual participant language — not paraphrased"
    ]
  }
]
```

---

### Section Inclusion Flags

Boolean flags to include/exclude entire sections. **A section renders only when its flag allows it AND it has content** — a config with no `discussion_guide` data never produces an empty "Discussion Guide" heading, even if the flag is left at its default.

**Section numbering is dynamic:** H1 numbers ("1.", "2.", …) are assigned at generation time, so omitting a section never leaves a gap. Sub-numbers inside your data (group names like "3.1", deliverable titles like "7.1", question numbers like "(1.1)") are yours to keep consistent with the sections you include.

#### `include_central_question` (boolean, default: `true`)
Include the central research question in a callout box.

#### `include_scope_table` (boolean, default: `true`)
Include the two-column In Scope / Out of Scope table (bulleted, non-bold items).

#### `include_research_questions` (boolean, default: `true`)
Include the "Core Research Questions" section.

#### `include_hypotheses` (boolean, default: `true`)
Include the "Assumptions and Hypotheses" section.

#### `include_risks` (boolean, default: `true`)
Include the "Risks and Limitations" section.

#### `include_open_items` (boolean, default: `true`)
Include the "Open Items Before Plan Finalization" section.

#### `include_analysis_plan` (boolean, default: `true`)
Include the "Analysis Plan" section.

#### `include_participants` (boolean, default: `true`)
Include the "Participants and Recruitment" section.

#### `include_discussion_guide` (boolean, default: `true`)
Include the "Discussion Guide" section.

#### `include_timeline` (boolean, default: `true`)
Include the "Timeline and Milestones" section.

#### `include_deliverables` (boolean, default: `true`)
Include the "Deliverables" section.

---

### Custom Document Layout (`sections`)

For documents that don't fit the research-plan structure — rationales, briefs, one-pagers — provide a top-level `sections` array. When present, it **replaces** the plan layout entirely (title and metadata still render first).

Each section has a `heading` (auto-numbered unless `"numbered": false`) and an ordered list of `blocks`:

| Block `type` | Fields | Renders as |
|---|---|---|
| `paragraph` | `text`, optional `bold`, `italic` | Body paragraph |
| `bullets` | `items`, optional `lead` (bold intro line) | Bulleted list |
| `callout` | `title`, `text` | Shaded callout box with accent bar |
| `table` | `headers`, `rows` (array of arrays) | Design-system table |
| `subheading` | `text` | Heading 2 |

**Example — a research rationale:**
```json
{
  "product_name": "Consul Adoption",
  "plan_title": "Research Rationale",
  "metadata": ["IBM HashiCorp Secure  |  UX Research"],
  "sections": [
    {
      "heading": "Why This Research Matters",
      "blocks": [
        { "type": "paragraph", "text": "Adoption stalls between evaluation and production..." },
        { "type": "callout", "title": "Central Question", "text": "\"What needs to be true for customers to feel confident beginning?\"" }
      ]
    },
    {
      "heading": "Assumptions and Risks",
      "blocks": [
        { "type": "subheading", "text": "Assumptions" },
        { "type": "bullets", "items": ["Customers will delay migration by default", "Trust is the binding constraint"] },
        { "type": "table", "headers": ["Risk", "Mitigation"], "rows": [["Low recruitment", "CSM channel + internal fallback"]] }
      ]
    }
  ]
}
```

---

## Complete Minimal Example

The smallest valid research plan configuration:

```json
{
  "product_name": "My Product",
  "plan_title": "Research Plan",
  "purpose": "We need to understand how customers use this feature.",
  "participant_profile": "Product users with 6+ months of experience."
}
```

This will generate a document with:
- Title and metadata section
- Purpose statement
- Minimal discussion guide
- Basic timeline

---

## Complete Extended Example

A fully-featured configuration with all options:

```json
{
  "plan_type": "migration",
  "product_name": "Consul Adoption",
  "plan_title": "Research Plan",
  
  "metadata": [
    "IBM HashiCorp Secure  |  UX Research",
    "Status: Draft for Review  |  Author: Jane Smith  |  Created: June 2026",
    "Research Window: Weeks 5–8  |  Findings Due: [DATE]"
  ],
  
  "purpose": "This research addresses slow initial adoption. We need to understand what conditions would make customers feel safe enough to begin migration.",
  
  "central_question": "\"What migration experience and capabilities are needed for customers to feel confident beginning?\"",
  
  "scope_intro": "Narrowed to the decision to begin, not the migration itself \u2014 the execution work is a separate study in Q4.",
  
  "in_scope": [
    "Migration decision-making: when and why customers begin",
    "Trust and risk thresholds",
    "Minimum feature requirements"
  ],
  
  "out_of_scope": [
    "Competitive analysis",
    "Pricing and packaging",
    "UI/UX usability evaluation"
  ],
  
  "research_questions_intro": "Four questions, all tied to the Q3 go/no-go on migration tooling investment.",
  
  "research_questions": [
    {
      "group_name": "3.1 Decision Model",
      "questions": [
        "RQ1: How do customers decide to migrate?",
        "RQ2: What triggers the decision?"
      ]
    }
  ],
  
  "participant_profile": "Platform engineers at companies with 200+ employees, with direct input into infrastructure decisions.",
  
  "disqualifiers": [
    "Primary contact through managed service",
    "Not operating in production"
  ],
  
  "recruitment_channels": [
    "CSM-mediated — primary channel",
    "Internal IBM staff — fallback"
  ],
  
  "discussion_guide": [
    {
      "section_name": "Section 1 — Warm-Up",
      "time_info": "5 minutes",
      "questions": [
        "(1.1) Tell me about your role.",
        "(1.2) Walk me through your current setup."
      ]
    }
  ],
  
  "timeline": [
    {
      "timeframe": "Wk 1–2",
      "milestone": "Stakeholder alignment confirmed."
    }
  ],
  
  "deliverables": [
    {
      "title": "7.1 Research Findings",
      "items": [
        "Findings document with evidence and recommendations"
      ]
    }
  ],
  
  "include_central_question": true,
  "include_scope_table": true,
  "include_research_questions": true,
  "include_participants": true,
  "include_discussion_guide": true,
  "include_timeline": true,
  "include_deliverables": true
}
```

---

## Field Validation

### Required Fields
- `product_name` — Must be non-empty string
- `plan_title` — Must be non-empty string

### Optional But Recommended
- `purpose` — Establishes research rationale
- `research_questions` — Drives entire research plan
- `participant_profile` — Ensures targeted research
- `discussion_guide` — Essential for conducting sessions

### No Validation Applied — but omissions are reported
The template accepts any valid JSON. If a field is missing, that section won't
appear in the document. This is intentional, to allow maximum flexibility.

What it will **not** do is drop a section silently. Every section that doesn't
render is listed after the file is written, with the reason — either no content
under its key, or an `include_*` flag set to `false`:

```
! 2 section(s) omitted from Vault_Adoption_Study.docx:
    Discussion Guide — no content under "discussion_guide"
    Timeline and Milestones — suppressed by "include_timeline": false
  Check these against the plan this document was generated from.
```

The report goes to stderr, so it survives redirection and can't be lost in a
pipeline. Read it against the plan the config came from: a document that quietly
contains less than the plan that passed the gates is the same failure the deck
gate exists to catch — the render step changing what a reader sees relative to
what was checked.

When calling the template as a library rather than a script, the same list is
available from `generator.omission_report()`.

---

## Tips for Configuration

### Keep It Maintainable
- Store configs in version control
- Use descriptive field names
- Add comments (JSON doesn't support them, so use descriptive values)

### Plan for Reuse
- Create a base config for your product (e.g., `vault-base-config.json`)
- Copy and customize for specific studies
- Share templates with your team

### Iterate Thoughtfully
- Start with minimal config, add sections as needed
- Test document generation before finalizing
- Review with stakeholders before locking in wording

---

## Examples by Research Type

### Migration Study
See: the full-plan example above, and `skills/README.md`

### Feature Evaluation
```json
{
  "plan_type": "feature-evaluation",
  "product_name": "[Product]",
  "plan_title": "Feature Evaluation Study",
  "research_questions": [
    {
      "group_name": "Comprehension",
      "questions": ["RQ1: Do users understand?", "RQ2: Do they see the value?"]
    },
    {
      "group_name": "Usability",
      "questions": ["RQ3: Can they accomplish the task?", "RQ4: Where does it break down?"]
    }
  ]
}
```

### Adoption Study
```json
{
  "plan_type": "adoption",
  "product_name": "[Product]",
  "plan_title": "Adoption and Barriers Study",
  "research_questions": [
    {
      "group_name": "Adoption Triggers",
      "questions": ["RQ1: What events trigger adoption?"]
    },
    {
      "group_name": "Barriers",
      "questions": ["RQ2: What prevents adoption?"]
    }
  ]
}
```

---

**Version:** 1.0  
**Last Updated:** July 2026  
**Maintainer:** UX Research Team
