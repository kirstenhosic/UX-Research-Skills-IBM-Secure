# Research Plan Generator — Integration Guide

This guide explains how to integrate the **Research Plan Generator skill** into the UX Research Skills repo, and how all skills and agents reference it.

## What It Integrates

The **Research Plan Generator** is a reusable, configurable skill that produces professional research plan documents following the repo's design system standards (see `DESIGN-SYSTEM.md`).

It handles:
- ✅ Research plans (migration, feature evaluation, adoption, comparative studies)
- ✅ Professional styling (IBM Secure design language)
- ✅ Fully customizable configuration (JSON-based)
- ✅ Team reusability across all IBM Secure products

---

## Repository Integration

### File Structure

Add the skill to your repo under a new `skills/` directory:

```
UX-Research-Skills-IBM-Secure/
├── agents/
│   ├── dr-morgan.agent.md                        # Producer / reviser
│   ├── research-synthesis-checker.agent.md        # Gate — is it true?
│   ├── research-significance-checker.agent.md     # Gate — does it matter?
│   ├── research-plan-reviewer.agent.md            # Gate — plans & guides
│   └── research-readability-checker.agent.md      # Gate — voice, audience, PII
├── skills/
│   ├── research-document-generator.py
│   ├── example-migration-research.json
│   ├── CONFIG-SCHEMA.md
│   ├── QUICK-START-BY-ROLE.md
│   └── README.md
├── research-readout-deck/
├── DESIGN-SYSTEM.md                  # How documents look
├── VOICE-AND-STYLE.md                # How documents read
├── FINDINGS-CONTRACT.md              # The shape of a finding
├── EVALUATION-LOOP.md                # How documents get released
├── RESEARCH-PLAN-INTEGRATION.md      # This file
└── README.md
```

### Steps to Integrate

> **Already done, July 2026.** These steps are kept as a record of how the skill
> got into the repo — `skills/` is populated and working, so you don't need to
> run them. The step-by-step version with verification checkpoints lives in
> [`INTEGRATION-CHECKLIST.md`](INTEGRATION-CHECKLIST.md).
>
> Note that the paths below are the source filenames as they stood in July.
> They've since diverged: the generator was renamed from
> `research-plan-generator.py` to `research-document-generator.py`, and the skill
> definition that became `skills/README.md` is now
> `~/.claude/skills/hashicorp-secure-research-plan.md`. Treat the commands as
> history, not as instructions to re-run.

1. **Copy the skill files** from `~/.claude/skills/` to `skills/` in the repo:
   ```bash
   cp ~/.claude/skills/research-document-generator.py skills/
   cp ~/.claude/skills/example-migration-research.json skills/
   cp ~/.claude/skills/hashicorp-secure-research-plan.md skills/README.md
   ```

2. **Update the main README** (see "Updated README Section" below)

3. **Reference in agents** — Add guidance to Dr. Morgan to use the skill

4. **Commit to git:**
   ```bash
   git add skills/ DESIGN-SYSTEM.md RESEARCH-PLAN-INTEGRATION.md
   git commit -m "Add Research Plan Generator skill with design system integration"
   ```

---

## How Dr. Morgan References It

In `agents/dr-morgan.agent.md`, add this guidance under Scenario C (UX Plan From Scratch):

```markdown
### When to Use the Research Plan Generator Skill

**For immediate output:** If you need a professional research plan document quickly, 
invoke the **Research Plan Generator skill**:

    /research-document-template
    
Tell it about your research (questions, participants, timeline, deliverables), 
and it generates a complete Word document following IBM Secure's design standards 
(see `DESIGN-SYSTEM.md`).

**For coaching:** If you want me to guide you through the planning process step-by-step 
using Socratic questioning, continue here and I'll coach you through each phase.

**The difference:** The skill produces an artifact fast; I produce the thinking that 
goes into planning, with rigor and tradeoffs visible along the way. Pick your mode 
based on where you are:
- **Starting from scratch** → Use the skill, then iterate with me if needed
- **Have a draft and want critique** → Paste it here for coaching
- **Need to teach someone else** → Let me guide them through the process
```

---

## How Other Skills Use It

When creating new skills that produce research documents, reference the generator:

```markdown
## Output Standard

This skill produces documents following **IBM Secure's design system**. 
See `DESIGN-SYSTEM.md` for styling standards and `skills/research-document-generator.py` 
for the underlying document generator.

For research plans specifically, consider using the **Research Plan Generator skill** 
(`/research-document-template`) instead of building your own.
```

---

## How Teams Use It

### Scenario 1: UX Researcher Planning a Study

```
User: I'm starting a migration research study for Vault Next.

Options:
A) Use the Research Plan Generator directly:
   /research-document-template
   → Fast path (30 min to publication-ready plan)

B) Work with Dr. Morgan for coaching:
   Scenario C → Guides you through each phase
   → Slower path, more learning, more rigor
```

### Scenario 2: Cross-Functional Team Planning

```
Team: We need a research plan for a Boundary feature evaluation.

Steps:
1. Product Manager uses /research-document-template to draft initial plan
2. Team shares plan, gathers feedback
3. UX Researcher refines with Dr. Morgan's Scenario D (challenge & refine)
4. Finalize and publish using the generator
```

### Scenario 3: Dr. Morgan Coaching + Generator Output

```
User: I want to work through the planning process but need a final document.

Process:
1. Work with Dr. Morgan through Scenario C (coaching on each phase)
2. At each phase completion, extract your decisions
3. Feed them into /research-document-template
4. Get a polished document that reflects your thinking
```

---

## Configuration Examples

The skill uses JSON configurations. Store product-specific examples in `skills/`:

```
skills/
├── research-document-generator.py
├── example-migration-research.json         # Vault migration template — the only one that exists today
├── CONFIG-SCHEMA.md
├── QUICK-START-BY-ROLE.md
└── README.md
```

**Still to add.** A feature-evaluation and an adoption-study config
(`example-feature-eval.json`, `example-adoption-study.json`) would cover the two
most common study types after migration. Neither exists yet — build them from
the migration config using the steps under *Adding New Research Types* below,
and test each against the generator before committing.

Teams can **copy and customize** these configs for their research:

```bash
cp skills/example-migration-research.json vault-next-study.json
# Edit vault-next-study.json with your research questions
python3 skills/research-document-generator.py vault-next-study.json Vault_Next_Plan.docx
```

---

## Maintaining Consistency

### When the Design System Changes

1. **Update `DESIGN-SYSTEM.md`**
2. **Update `research-document-generator.py`:**
   ```python
   PRIMARY_BLUE = RGBColor(0x1F, 0x4E, 0x79)   # Edit colors here
   SECONDARY_BLUE = RGBColor(0x2E, 0x75, 0xB6)
   LIGHT_GRAY = "D9E1F2"
   ```
3. **Update guidance in Dr. Morgan** if output structure changes
4. **Commit with message:** "Update design system: [what changed and why]"

### When Adding New Research Types

1. **Create a new example config:**
   ```bash
   cp skills/example-migration-research.json skills/example-[type].json
   ```
2. **Document the template** in `skills/README.md`
3. **Test with the generator** to ensure it produces valid documents
4. **Commit:** `git add skills/example-[type].json`

### When Product Context Changes

Dr. Morgan's PRODUCT CONTEXT section (in `agents/dr-morgan.agent.md`) lists Vault, Boundary, Consul, Terraform, and Radar. 

When adding a new product or updating product details:

1. Update the PRODUCT CONTEXT in Dr. Morgan
2. Mirror the change into the six standalone scenario files — each carries its
   own copy so it stays pasteable on its own. Run the drift check in the main
   README afterward.
3. Create product-specific research plan examples (if needed)
4. Check the evaluators for product references. They are deliberately mostly
   product-agnostic — the checks are about evidence, coverage, and voice, not
   about your products — but `research-significance-checker` and
   `research-plan-reviewer` carry example personas and product names in their
   scope and conflation checks. Those examples should stay recognizable to your team.
5. Update this file with any new integration patterns

---

## Quality Assurance

Generated plans go through the same evaluation loop as everything else in the
suite. Full spec: [`EVALUATION-LOOP.md`](EVALUATION-LOOP.md).

**For a research plan or discussion guide, two gates apply, in order:**

1. **`agents/research-plan-reviewer.agent.md`** — the plan gate. Audits the
   upstream decisions (is a decision named and owned? are the research questions
   researchable? can the method actually answer them? are participants defined
   and recruitable? is there an analysis plan? are consent and data handling
   addressed?), then reviews the discussion guide question by question for
   leading, double-barreled, yes/no, and future-hypothetical questions, and maps
   coverage both ways between guide questions and research questions.

   This is the only gate that runs **before** fieldwork, which makes it the
   cheapest place in the whole system to catch a problem. A flawed plan produces
   data no amount of careful synthesis can rescue.

2. **`agents/research-readability-checker.agent.md`** — voice, mixed-audience
   fit, and the participant-data safety sweep. Scored against
   [`VOICE-AND-STYLE.md`](VOICE-AND-STYLE.md). Note that a plan is partly a form:
   voice matters in the framing, questions, and rationale, not in the logistics
   table.

**Then:**

3. **Visual design check** — use the checklist in
   [`DESIGN-SYSTEM.md`](DESIGN-SYSTEM.md); verify styling matches the standard.

4. **Peer review** — have a colleague read it for clarity, completeness, and a
   realistic timeline. Attach any gate flags as **Reviewer Notes** so they see
   them alongside the plan.

**On verdicts:** `REVISE` means fix only the blocking items and re-run that
gate. Two revision passes is the cap — if a plan still fails at iteration 3, the
problem is upstream of the wording and it escalates to you. `ESCALATE` fires
immediately, regardless of iteration, when no decision is named or the method
structurally can't answer the question; in those cases the plan needs rebuilding
from Phase 1, not refining.

> **Note:** `research-synthesis-checker` does **not** apply to plans — it
> verifies claims against research data, and a plan has no findings yet. Earlier
> versions of this guide pointed at it here; use `research-plan-reviewer`
> instead. The synthesis checker comes in later, once the study has produced
> findings.

---

## Troubleshooting

### "I generated a plan but it doesn't match the design system"

**Check:**
1. Are you using the latest version of `research-document-generator.py`?
2. Did you customize the colors in the Python script?
3. Do you have python-docx installed? (`pip install python-docx`)

**Fix:**
```bash
# Update the generator
cp ~/.claude/skills/research-document-generator.py skills/

# Regenerate your document
python3 skills/research-document-generator.py your-config.json your-plan.docx
```

### "I want to customize colors/fonts"

Edit `research-document-generator.py`:

```python
# Line 12-14: Change colors here
PRIMARY_BLUE = RGBColor(0x1F, 0x4E, 0x79)   # Edit RGB values
SECONDARY_BLUE = RGBColor(0x2E, 0x75, 0xB6)
LIGHT_GRAY = "D9E1F2"                       # Edit hex value
```

Then regenerate your documents.

### "I want to add a new section to the plan"

Edit your JSON config to add the section:

```json
"custom_section": {
  "title": "6.5 Risk Mitigation",
  "items": [
    "Risk 1: Recruiting is slow",
    "Mitigation: Activate internal staff fallback by Week 5"
  ]
}
```

Then modify `research-document-generator.py` to include it:

```python
if self.config.get('include_custom_section', False):
    self.add_heading_1(self.config.get('custom_section', {}).get('title', ''))
    self.add_bullet_list(self.config.get('custom_section', {}).get('items', []))
```

### "Can I use this with other IBM teams?"

**Yes!** The skill is product-agnostic. To use with other teams:

1. Change the blue color scheme if needed (edit `research-document-generator.py`)
2. Create new example configs with their product context
3. Share the `skills/` folder with the other team
4. Point them to `skills/README.md`

---

## References

**Standards**
- **Design System:** `DESIGN-SYSTEM.md` — how documents look: styling, colors, typography
- **Voice & Style:** `VOICE-AND-STYLE.md` — how documents read: human voice, mixed-audience digestibility, 21-item rubric
- **Findings Contract:** `FINDINGS-CONTRACT.md` — the shape of a finding, shared by every producer and consumer
- **Evaluation Loop:** `EVALUATION-LOOP.md` — gate matrix, verdict schema, revision cap, Definition of Done per artifact type

**The generator**
- **Skill README:** `skills/README.md` — Complete usage guide
- **Configuration Reference:** `skills/CONFIG-SCHEMA.md` — All customization options
- **Quick Start by Role:** `skills/QUICK-START-BY-ROLE.md` — role-specific entry points

**Agents**
- **Dr. Morgan:** `agents/dr-morgan.agent.md` — the producer and reviser; how coaching fits with the generator
- **Plan Reviewer:** `agents/research-plan-reviewer.agent.md` — **the gate for plans and discussion guides**
- **Synthesis Checker:** `agents/research-synthesis-checker.agent.md` — QA for findings, decks, and competitive claims (not plans)
- **Significance Checker:** `agents/research-significance-checker.agent.md` — research-question coverage, insight altitude, decision-fit
- **Readability Checker:** `agents/research-readability-checker.agent.md` — voice, audience fit, participant-data safety sweep

---

## Version Info

**Skill Integration:** v1.1 — plans now gated by `research-plan-reviewer`  
**Design System:** v1.0  
**Evaluation Loop:** v1.0  
**Last Updated:** August 2026  
**Maintainer:** Kirsten Hosic (@kirstenhosic)

---

## Next Steps

1. **Copy files** to your repo (see steps above)
2. **Update README.md** (see below)
3. **Test** — Generate a sample research plan
4. **Commit** and share with your team
5. **Train** — Run a quick walkthrough showing how to use the skill

---

## Updated README Section

Add this section to the main `README.md`:

```markdown
## New: Research Plan Generator Skill

**Fast path to publication-ready research plans**

Instead of writing research plans from scratch, use the **Research Plan Generator skill** to create professional, well-structured documents in minutes.

- ✅ **Fast:** 30 minutes from idea to publication-ready plan
- ✅ **Professional:** Follows IBM Secure design standards (colors, spacing, typography)
- ✅ **Flexible:** Adapts to migration, feature evaluation, adoption, and comparative studies
- ✅ **Reusable:** Share configurations across teams and products

### How to Use

In Claude Code:
```
/research-document-template

I'm planning a [study type] for [product].
Research questions: [list]
Participants: [describe]
Timeline: [weeks]
```

→ Generates a complete Word document

Or use directly:
```bash
python3 skills/research-document-generator.py skills/example-migration-research.json my-plan.docx
```

### Integration with Dr. Morgan

Dr. Morgan's **Scenario C** (UX Plan From Scratch) recommends the Research Plan Generator for fast output, or coaches you through planning for deeper learning.

### Design System

All documents follow IBM Secure's design standards. See `DESIGN-SYSTEM.md` for styling details.
```

---

**Ready to integrate?** Follow the steps above and commit to your repo!
