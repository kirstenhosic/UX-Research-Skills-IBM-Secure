# Research Plan Generator — Integration Checklist

Use this checklist to integrate the Research Plan Generator skill into your UX Research Skills repo.

## Pre-Integration (Prep)

- [ ] Review the skill files at `~/.claude/skills/`
- [ ] Review `DESIGN-SYSTEM.md` to understand styling standards
- [ ] Review `RESEARCH-PLAN-INTEGRATION.md` to understand architecture
- [ ] Confirm you have write access to the repo
- [ ] Create a new branch: `git checkout -b feature/research-plan-generator`

---

## Step 1: Add Skill Files to Repo

### Create skills directory

```bash
cd your-repo/
mkdir -p skills
```

### Copy skill files

```bash
# Copy the generator script
cp ~/.claude/skills/research-document-generator.py skills/

# Copy the example configuration
cp ~/.claude/skills/your-config.json skills/

# Copy the documentation (rename to repo-specific README)
cp ~/.claude/skills/research-document-template.md skills/README.md

# Optional: Copy all supporting docs
cp ~/.claude/skills/CONFIG-SCHEMA.md skills/
cp ~/.claude/skills/QUICK-START-BY-ROLE.md skills/
cp ~/.claude/skills/RESEARCH-PLAN-SKILL-README.md skills/
```

### Verify files

```bash
ls -la skills/
# Should show:
# - research-document-generator.py
# - your-config.json
# - README.md
# - (optional: CONFIG-SCHEMA.md, QUICK-START-BY-ROLE.md, etc.)
```

- [ ] All skill files copied successfully
- [ ] File permissions are correct (readable by team)
- [ ] Generator script is executable: `chmod +x skills/research-document-generator.py`

---

## Step 2: Add Design System Documentation

### Copy design system files

```bash
cp /path/to/DESIGN-SYSTEM.md .
cp /path/to/RESEARCH-PLAN-INTEGRATION.md .
```

### Verify placement

```bash
ls -la | grep DESIGN-SYSTEM
ls -la | grep RESEARCH-PLAN-INTEGRATION
```

- [ ] DESIGN-SYSTEM.md in repo root
- [ ] RESEARCH-PLAN-INTEGRATION.md in repo root
- [ ] Files are readable by team

---

## Step 3: Update README.md

### Add Research Plan Generator section

In the main `README.md`, add this section after the "What's in this repo" table:

```markdown
### New: Research Plan Generator Skill (Scenario G)

**Fast path to publication-ready research plans** — Use the Research Plan Generator 
to create professional research plans in ~30 minutes instead of 4+ hours.

| File | Role | Use it when |
|---|---|---|
| `skills/research-document-generator.py` + `example-*.json` | **Research Plan Generator** | You need a professional, styled research plan document. Invoke via `/research-document-template` or run the script directly. Adapts to migration, feature evaluation, adoption, and comparative studies. |

**Why use it:**
- ✅ Professional design (IBM Secure colors, spacing, typography)
- ✅ Fully customizable (JSON configuration)
- ✅ Team reusable (same styling across all research)
- ✅ Research-ready (discussion guides numbered for field use)

**Integration:** Works seamlessly with Dr. Morgan's Scenario C (UX Plan From Scratch) — use the generator for fast output, or ask Dr. Morgan to coach you through planning for deeper learning.

**See also:**
- `DESIGN-SYSTEM.md` — Styling standards for all research documents
- `RESEARCH-PLAN-INTEGRATION.md` — Architecture and integration guide
- `skills/README.md` — Complete skill documentation
```

### Update the "How to use" section

After the existing "How to use" instructions, add:

```markdown
## Using the Research Plan Generator

**In Claude Code:**
```bash
/research-document-template

I'm planning a [study type] for [product].
Research questions: [list]
Participants: [describe]
Timeline: [weeks]
```

→ Generates a complete, styled Word document

**Or run directly:**
```bash
python3 skills/research-document-generator.py skills/your-config.json my-plan.docx
```

**Design Standards:** All generated documents follow IBM Secure's design system (see `DESIGN-SYSTEM.md`).
```

- [ ] README.md updated with Research Plan Generator section
- [ ] "How to use" section includes the skill
- [ ] Links to DESIGN-SYSTEM.md and RESEARCH-PLAN-INTEGRATION.md
- [ ] Links to skills/README.md for full documentation

---

## Step 4: Update Dr. Morgan Agent

### Add guidance in Scenario C

In `agents/dr-morgan.agent.md`, find the section for **Scenario C (UX Plan From Scratch)** and add this guidance:

```markdown
### Quick Option: Research Plan Generator Skill

To generate a professional research plan document immediately without coaching:

**Invoke the Research Plan Generator:**
```
/research-document-template

[Describe your research study]
```

This generates a complete, styled Word document (30 min → publication-ready plan).

**When to use:**
- You've already done your thinking and need a polished document
- You want to move fast
- You need professional styling right away

**When to stay here with me:**
- You're new to research and want to learn the process
- You want to think through tradeoffs and decisions
- You need a sounding board and rigor partner
```

### Add product context if needed

If Dr. Morgan doesn't already reference all IBM Secure products, add them to the PRODUCT CONTEXT section:

- Vault (existing)
- Boundary (existing)
- Consul (existing)
- Terraform (existing)
- Vault Radar (existing)
- Any new products your team researches

- [ ] Scenario C updated with Research Plan Generator guidance
- [ ] PRODUCT CONTEXT section is current
- [ ] Agent file is syntactically valid (test by invoking it)

---

## Step 5: Create Product-Specific Templates

### Create example configs for each product

```bash
# Vault (already exists)
# Add others as needed:

# Boundary feature evaluation
cp skills/your-config.json skills/example-boundary-feature-eval.json

# Consul adoption study
cp skills/your-config.json skills/example-consul-adoption.json

# Terraform policy study
cp skills/your-config.json skills/example-terraform-policies.json
```

### Customize each template

```bash
# Edit each file with:
# - Product name and description
# - Typical research questions for that product
# - Common participant profiles
# - Standard timeline

# Example edit: example-boundary-feature-eval.json
{
  "product_name": "Boundary Enterprise",
  "plan_title": "Feature Evaluation Study",
  "research_questions": [
    {
      "group_name": "Feature Comprehension",
      "questions": [
        "RQ1: Do participants understand what this feature does?"
      ]
    }
  ]
}
```

- [ ] Created example configs for each product (or at least 2–3 main products)
- [ ] Each example is customized with product context
- [ ] Each config is valid JSON (test with: `python3 -m json.tool skills/example-*.json`)

---

## Step 6: Test the Integration

### Test the generator

```bash
# Generate a test document
python3 skills/research-document-generator.py \
  skills/your-config.json \
  test-output.docx

# Verify output
file test-output.docx  # Should show: Microsoft Word 2007+
ls -lh test-output.docx  # Should be ~40-50 KB

# Clean up
rm test-output.docx
```

### Test in Claude Code

```bash
# In Claude Code, invoke:
/research-document-template

I'm planning a test research study.
Research questions: test question
Participants: test participants
Timeline: 6 weeks
```

- [ ] Generator script runs without errors
- [ ] Output document is valid (opens in Word/Google Docs)
- [ ] Document styling matches DESIGN-SYSTEM.md
- [ ] Dr. Morgan agent still works after updates
- [ ] `/research-document-template` invocation works

---

## Step 7: Commit and Document

### Stage files

```bash
git add skills/
git add DESIGN-SYSTEM.md
git add RESEARCH-PLAN-INTEGRATION.md
git add README.md  # (if updated)
git add agents/dr-morgan.agent.md  # (if updated)
```

### Commit

```bash
git commit -m "Add Research Plan Generator skill with design system integration

- Adds research-document-generator.py for creating styled research plans
- Adds example configurations for migration, feature eval, adoption studies
- Establishes DESIGN-SYSTEM.md as standard for all research documents
- Updates Dr. Morgan agent to reference the skill
- Documents integration approach in RESEARCH-PLAN-INTEGRATION.md
- Skills now generate professional, consistent documents across all products"
```

### Push

```bash
git push origin feature/research-plan-generator
```

### Create pull request

Create a PR on GitHub with:
- **Title:** Add Research Plan Generator skill
- **Description:**
  ```
  ## Summary
  Adds a reusable, configurable skill for generating professional research plan documents
  that follow IBM Secure's design system standards.
  
  ## What's included
  - research-document-generator.py — Core Python generator
  - example-*.json configurations — Templates for different research types
  - DESIGN-SYSTEM.md — Styling standards for all research documents
  - RESEARCH-PLAN-INTEGRATION.md — Architecture and integration guide
  - Updated Dr. Morgan agent — References the skill in Scenario C
  
  ## Benefits
  - Reduces research plan creation from 4+ hours to ~30 minutes
  - Ensures consistent professional styling across all research
  - Enables faster research planning and stakeholder alignment
  - Shareable templates across products and teams
  
  ## Testing
  - Verified generator creates valid Word documents
  - Tested with example configuration
  - Validated styling against DESIGN-SYSTEM.md
  - Confirmed Dr. Morgan agent still functions
  ```

- [ ] All files committed
- [ ] Commit message is descriptive
- [ ] PR created with clear description
- [ ] PR passes any automated checks

---

## Step 8: Communicate to Team

### Create announcement

```markdown
## Research Plan Generator Now Available! 🎉

We've added a new skill to speed up research plan creation.

**Use it:**
```
/research-document-template
```

**Features:**
- Creates professional research plans in ~30 minutes
- Consistent styling across all products (Vault, Boundary, Consul, etc.)
- Fully customizable (migration, feature eval, adoption studies)
- Discussion guides numbered for field use

**Learn more:**
- Quick start: See skills/README.md
- Full docs: RESEARCH-PLAN-INTEGRATION.md
- Design standards: DESIGN-SYSTEM.md

**Questions?** See QUICK-START-BY-ROLE.md for your role.
```

### Share with team

- [ ] Slack/Teams announcement posted
- [ ] Email to team with link to PR
- [ ] Added to team's shared documentation
- [ ] Scheduled 15-minute walkthrough demo (optional but recommended)

---

## Post-Integration

### Monitor usage

Over the next month, track:
- How many times teams use the skill
- What research types are most common
- Feedback on styling or structure
- Requests for new features or examples

### Gather feedback

Send a quick survey to users:
- Did the skill save you time?
- Does the styling match your expectations?
- What would make it more useful?
- Any bugs or issues?

### Update documentation

Based on feedback:
- Add new example configurations
- Clarify confusing sections
- Document common customizations
- Fix any bugs in the generator

---

## Troubleshooting During Integration

### "I'm getting a syntax error in the generator script"

**Fix:** Ensure you have python-docx installed:
```bash
pip install python-docx
```

### "The output document looks wrong"

**Check:**
1. Are colors matching DESIGN-SYSTEM.md?
2. Is spacing consistent?
3. Did you customize the colors in the script?

**Fix:** Regenerate with the unmodified generator script

### "I want to customize it for our specific products"

**Good!** Create product-specific example configs:
```bash
cp skills/your-config.json skills/example-[product].json
# Edit with product-specific research questions, participants, etc.
```

### "The PR has conflicts"

**Resolve:**
1. Pull latest from main: `git fetch origin && git rebase origin/main`
2. Resolve conflicts in files
3. Force push: `git push -f origin feature/research-plan-generator`

---

## Completion Checklist

- [ ] Step 1: Skill files added to repo
- [ ] Step 2: Design system docs added
- [ ] Step 3: README.md updated
- [ ] Step 4: Dr. Morgan agent updated
- [ ] Step 5: Product-specific templates created
- [ ] Step 6: Integration tested
- [ ] Step 7: Committed and PR created
- [ ] Step 8: Team notified

**All steps complete?** 🎉 The Research Plan Generator is now integrated!

---

## Quick Reference

**To use the skill:**
```
/research-document-template
[Describe your research]
```

**To run the script directly:**
```bash
python3 skills/research-document-generator.py \
  skills/your-config.json \
  my-plan.docx
```

**To customize the config:**
```bash
cp skills/your-config.json my-study.json
# Edit my-study.json
python3 skills/research-document-generator.py my-study.json my-plan.docx
```

**To understand styling:**
→ See `DESIGN-SYSTEM.md`

**To understand architecture:**
→ See `RESEARCH-PLAN-INTEGRATION.md`

**To learn how to use:**
→ See `skills/README.md`

---

**Questions?** See RESEARCH-PLAN-INTEGRATION.md or create an issue in the repo.

**Version:** 1.0  
**Last Updated:** July 2026  
**Maintainer:** Kirsten Hosic (@kirstenhosic)
