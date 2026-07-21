# Quick Start: Research Plan Skill by Role

Fast-track guide for different team members at IBM HashiCorp Secure.

---

## For UX Researchers

**Goal:** Create a research plan you'll execute in the field.

### 5-Minute Setup

1. **Open Claude Code** and invoke the skill:
   ```
   /hashicorp-secure-research-plan
   ```

2. **Tell Claude about your research:**
   ```
   I'm planning a migration study for Vault Next.
   
   Key research questions:
   - What barriers prevent migration?
   - What trust signals matter most?
   - Do customers prefer phased or full migration?
   
   Participants: 7 platform engineers at 200+ person orgs
   Timeline: 6 weeks (start Week 5)
   Deliverable: Findings document with migration recommendations
   ```

3. **Claude generates** a full research plan document

4. **Customize the discussion guide:**
   - All questions are numbered (1.1, 2.1, 2.2, etc.)
   - Edit directly in the Word document for your specific probes
   - This is your script for sessions — make it yours

### Key Points for You

✅ **Use the discussion guide as your field guide** — It's numbered for easy reference during sessions  
✅ **Validate scope with stakeholders** — Use the In/Out of Scope section  
✅ **Share early and often** — The document is presentation-ready  
✅ **Keep it nearby** — Print the discussion guide, reference it during interviews  

### Pro Tips

- **Research questions first** — Define these before writing the discussion guide
- **Map to decisions** — Make explicit what each question informs (product decision, communication strategy, etc.)
- **Number everything** — Makes note-taking and analysis easier
- **Include contingencies** — What if recruiting is slow? Plan for it.

---

## For Product Managers

**Goal:** Get stakeholder alignment and ensure research answers your key questions.

### 10-Minute Setup

1. **Gather these inputs** before creating the plan:
   - What decision does this research inform? (feature prioritization, migration model, adoption strategy)
   - What would change your mind about this product/feature?
   - What's the biggest uncertainty right now?
   - Who are your target users? (by role, industry, company size)

2. **Invoke the skill and tell Claude:**
   ```
   I need a research plan to inform our Vault Next migration strategy.
   
   This research will answer:
   - What barriers prevent migration?
   - What confidence signals do customers need?
   - Should we support hybrid deployment during migration?
   
   These decisions depend on it:
   - Feature prioritization for V1
   - Migration model (phased vs. full cutover)
   - Professional services packaging
   
   We need findings by Sept 12 for HashiConf narrative.
   ```

3. **Review the generated plan:**
   - Scope boundaries (in/out) — Does this align with your constraints?
   - Research questions — Do they map to your key decisions?
   - Timeline — Is it realistic?

4. **Share with Engineering and UX** for feedback before finalizing

### Key Sections for You

📊 **Scope Boundaries** — Use this to manage stakeholder expectations  
🎯 **Research Questions** — Ensure these map to decisions you'll make  
📅 **Deliverables** — Define success criteria with your team  
⏱️ **Timeline** — Plan when you'll have findings and what happens next  

### Pro Tips

- **Define success criteria** — What would make this research "successful"? (key insights, decision clarity, stakeholder alignment)
- **Plan the narrative early** — What will you tell HashiConf based on findings?
- **Budget for iteration** — Research often surfaces unexpected insights; plan for a follow-on if needed
- **Involve Engineering from start** — They need to understand what the research will inform

---

## For Engineering Leads

**Goal:** Understand what customers will tell us and what to do with it.

### 15-Minute Setup

1. **Identify the unknowns:**
   - What technical decisions depend on customer feedback?
   - What do you assume customers care about? (reliability, ease of migration, feature parity, etc.)
   - What would change your architecture or roadmap?

2. **Tell Claude:**
   ```
   We're planning a migration study for Vault Next. 
   
   From an engineering perspective, we need to validate:
   - Will customers accept a phased migration model?
   - How critical is feature parity for initial migration?
   - Can we deprecate plugin support or do we need backwards compatibility?
   - Will hybrid deployment (running both versions) be required?
   
   Participants: 7 platform engineers and DevOps leads
   We need findings by September 12.
   ```

3. **Review the generated plan** for:
   - Research questions that map to your technical decisions
   - Participant profiles (are we researching the right people?)
   - Timeline (can you support a debrief discussion with UX after each session?)

### Key Sections for You

🔧 **Research Questions** — Which ones will inform product architecture?  
👥 **Participant Profile** — Are these the actual people who make technical decisions at their org?  
📋 **Discussion Guide** — What will we actually ask participants about your technical approach?  
🎯 **Scope Boundaries** — What's NOT being researched (competitive analysis, pricing, etc.)?  

### Pro Tips

- **Surface your assumptions early** — The research plan should test what you believe is true
- **Attend sessions if possible** — Hearing customer problems firsthand changes perspective
- **Prepare for surprises** — Customers often care about different things than you expect
- **Plan for pivot** — If research shows your approach won't work, what's the backup?

---

## For Security & Compliance Teams

**Goal:** Ensure research meets governance and ethical standards.

### What You'll Review

- **Consent & Participation** — Are we getting informed consent? 📋
- **Data Handling** — How will we de-identify participant data? 🔒
- **Confidentiality** — Are we protecting unreleased roadmap details? 🤐
- **Recording & Analysis** — Who has access to session recordings? 👥

### Key Questions to Ask

- ✅ Is participant consent documented in writing?
- ✅ Are sessions recorded with permission?
- ✅ Will recordings be deleted after analysis, or retained? How long?
- ✅ Will findings be de-identified before sharing?
- ✅ What's our retention policy for research data?

### What to Check in the Plan

The research plan should include or link to:
- Participant consent form
- Recording consent process
- De-identification approach
- Data retention timeline
- Confidentiality guidelines for unreleased products

---

## For CrossFunctional Teams Running Parallel Studies

**Goal:** Create consistent, professional research plans across teams.

### Template Approach

1. **Create a base configuration** for your product:
   ```
   cp ~/.claude/skills/example-migration-research.json vault-base-config.json
   ```

2. **Customize for your specific study:**
   ```
   cp vault-base-config.json vault-feature-adoption-study.json
   # Edit: research questions, participant profile, timeline, deliverables
   ```

3. **Generate the document:**
   ```
   python3 ~/.claude/skills/research-plan-generator.py vault-feature-adoption-study.json Vault_Feature_Adoption_Study.docx
   ```

4. **Share the config** with your team so others can run similar studies

### Benefits of This Approach

✅ Consistent formatting across all research  
✅ Easy to compare findings (same structure, different research)  
✅ New team members can quickly understand your research approach  
✅ Stakeholders know what to expect from all research deliverables  

---

## Common Questions by Role

### "I've never done research before — where do I start?"

**For PMs:** Define the ONE decision this research will inform. Everything flows from that.  
**For Eng Leads:** List the assumptions you're least confident about. Those become research questions.  
**For Researchers:** Start with Scope — what's the smallest, most focused study that would give you confidence?

---

### "How do I know if my research plan is good?"

✅ **Scope** is clear (in/out of scope table is tight)  
✅ **Research questions** map to specific decisions  
✅ **Participants** are real decision-makers at your target companies  
✅ **Timeline** is realistic for recruiting and analysis  
✅ **Deliverables** answer the research questions  
✅ **Stakeholders agree** it's worth doing  

---

### "What if we discover something unexpected?"

**Great!** That's the point of research. Build in time for analysis before you have to present findings.

The plan should include:
- Time for data analysis (usually 1–2 weeks after sessions end)
- A follow-on study recommendation (if you discover a gap)
- A synthesis phase (before writing recommendations)

---

### "Can we do this remotely?"

**Yes.** Update the discussion guide and timeline:
- Use Zoom or Teams for sessions
- Plan for technical issues (backup plan if someone disconnects)
- Screen share the migration model instead of showing in-person
- Test recording/consent process in advance

Update in your config:
```json
"discussion_guide": [
  {
    "section_name": "Section 1 — Welcome & Tech Check",
    "time_info": "3 minutes",
    "questions": [
      "(1.1) Can you hear and see me clearly?",
      "(1.2) Do you have any questions before we start?",
      "[Note: This session will be recorded. Is that okay?]"
    ]
  }
]
```

---

### "How do we handle disagreement about scope?"

**Use the In/Out of Scope table to make disagreement visible.** Then decide:
- Is this truly out of scope, or a missing research question?
- If out of scope, why? (timeline? cost? not critical to decision?)
- If missing, add it to research questions or plan a follow-on study

Document the decision so you can explain it later to skeptics.

---

## Checklist: Before You Start

### Pre-Research (Week 1)

- [ ] Draft research plan (use this skill)
- [ ] Share plan with stakeholders (PM, Eng, UX, Security)
- [ ] Get alignment on scope, timeline, deliverables
- [ ] Confirm participant targets and recruiting strategy
- [ ] Secure consent forms and legal review (if needed)
- [ ] Assign research roles and responsibilities

### During Research (Weeks 2–5)

- [ ] Conduct sessions using numbered discussion guide
- [ ] Take notes on research questions and surprise findings
- [ ] Follow up on contingencies (recruiting challenges, technical issues)
- [ ] Debrief with team after each session

### Post-Research (Weeks 6–7)

- [ ] Analyze transcripts and notes against research questions
- [ ] Synthesize findings into insights and recommendations
- [ ] Map findings to original decisions
- [ ] Share findings with stakeholders
- [ ] Plan follow-on research (if needed)

---

## Next Steps

1. **Choose your role above** and follow the setup guide
2. **Gather the information** needed for your research context
3. **Invoke the skill** `/hashicorp-secure-research-plan`
4. **Generate your first document** and share with your team
5. **Iterate** before finalizing with stakeholders

Happy researching! 🚀
