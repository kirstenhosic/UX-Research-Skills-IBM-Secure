# Research Plan Configuration Schema

Complete reference for all available configuration options in the JSON schema.

## Structure Overview

```json
{
  "plan_type": "string",
  "product_name": "string",
  "plan_title": "string",
  "metadata": ["array of strings"],
  
  "purpose": "string",
  "central_question": "string",
  
  "scope_intro": "string",
  "in_scope": ["array"],
  "out_of_scope": ["array"],
  
  "research_questions_intro": "string",
  "research_questions": [{ "group_name": "string", "questions": ["array"] }],
  
  "participant_profile": "string",
  "disqualifiers": ["array"],
  "recruitment_channels": ["array"],
  
  "discussion_guide": [{ 
    "section_name": "string",
    "time_info": "string", 
    "questions": ["array"] 
  }],
  
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
- `"migration"` — Migration study (like Vault Next)
- `"feature-evaluation"` — Testing a new feature
- `"adoption"` — Understanding adoption barriers
- `"competitive"` — Comparing against alternatives
- `"custom"` — Any other type

---

#### `product_name` (string, required)
The product or initiative name shown on the title page.

**Examples:**
```json
"product_name": "Vault Next Migration"
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
  "Research Window: Weeks 5–8  |  Findings Due: September 12, 2025"
]
```

---

#### `page_header` (array of 1–2 strings, optional)
Running header shown on every page: a bold title line and an optional gray context line, separated from the body by a thin accent rule. Omit for no header.

**Example:**
```json
"page_header": [
  "Vault Next Migration — Study 1 Plan",
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
"purpose": "This research addresses critical retention challenges. We need to understand what conditions would make customers feel safe enough to begin migration — and what product investments, commitments, and communication would need to be in place before that trust is possible."
```

---

#### `central_question` (string, optional)
The single overarching research question in quotation marks.

**Example:**
```json
"central_question": "\"What migration experience and capabilities need to be available for customers to feel confident beginning?\""
```

---

### Scope Boundaries

#### `scope_intro` (string, optional)
Introductory statement about why scope is bounded.

**Default:**
```json
"scope_intro": "Scope has been deliberately narrowed to maximize confidence within the available timeline."
```

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
  "Vault Next UI/UX evaluation",
  "Feature parity prioritization"
]
```

---

### Research Questions

#### `research_questions_intro` (string, optional)
Introductory text before research questions.

**Example:**
```json
"research_questions_intro": "All questions are anchored in behavior, decision-making, and trust under real constraints."
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

### Participants & Recruitment

#### `participant_profile` (string, optional)
Detailed description of who you're targeting.

**Example:**
```json
"participant_profile": "Platform engineers, security engineers, or DevOps leads who are the primary operators in a production environment, at companies with 200+ employees, with direct input into infrastructure decisions."
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

#### `recruitment_channels` (array of strings, optional)
How you'll find and recruit participants, in priority order.

**Example:**
```json
"recruitment_channels": [
  "CSM-mediated via GTM PM — primary channel. Templated outreach; researcher owns logistics.",
  "Internal IBM staff using product in production — valid fallback if CSM recruiting is slow.",
  "External panel (e.g., Respondent) — last resort. Treat as supplementary; weight customer sessions more."
]
```

---

### Discussion Guide

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
- Questions should include numbering like `(1.1)`, `(2.1)` for easy reference in sessions
- Include time allocations for each section
- Optionally reference which research questions each section addresses with `→ RQ#` notation
- Questions are rendered as bullet points in the document

---

### Timeline

#### `timeline` (array of objects, optional)
Milestones and activities week-by-week. **Columns adapt to the keys you provide** — recognized keys, in column order: `phase`, `timeframe`, `milestone`, `outputs`, `activities`. A column appears only if at least one item uses its key.

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
  "success": "The PM can defend the migration narrative at HashiConf with evidence-backed confidence, and feature prioritization decisions cite specific findings.",
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
      "Draft language PM can use to build the HashiConf narrative",
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
  "product_name": "Vault Next Migration",
  "plan_title": "Research Rationale",
  "metadata": ["IBM HashiCorp Secure  |  UX Research"],
  "sections": [
    {
      "heading": "Why This Research Matters",
      "blocks": [
        { "type": "paragraph", "text": "Vault Next will require existing customers to migrate..." },
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
  "product_name": "Vault Next Migration",
  "plan_title": "Research Plan",
  
  "metadata": [
    "IBM HashiCorp Secure  |  UX Research",
    "Status: Draft for Review  |  Author: Jane Smith  |  Created: June 2026",
    "Research Window: Weeks 5–8  |  Findings Due: September 12, 2025"
  ],
  
  "purpose": "This research addresses critical retention and trust challenges. We need to understand what conditions would make customers feel safe enough to begin migration.",
  
  "central_question": "\"What migration experience and capabilities are needed for customers to feel confident beginning?\"",
  
  "scope_intro": "Scope has been deliberately narrowed to maximize confidence within the available timeline.",
  
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
  
  "research_questions_intro": "All questions are anchored in behavior, decision-making, and trust under real constraints.",
  
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

### No Validation Applied
The generator accepts any valid JSON. If a field is missing, that section simply won't appear in the document. This is intentional to allow maximum flexibility.

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
See: `example-migration-research.json`

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
