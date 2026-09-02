*Dr. Morgan UX research suite — author: **Kirsten Hosic**, UX Research Strategy Lead, Security Product Design. MIT licensed.*

---

# Research plan

The same sixteen sections Dr. Morgan drafts in `ux_plan_from_scratch.md`.
Sections 1–8 are the thinking; a reviewer reads those hardest. The Definition
of Done is §4.1 of `EVALUATION-LOOP.md`, and `research-plan-reviewer` can
score a manually written plan at any time.

```
[Study name] — Research Plan

Summary:            1–3 sentences on what this study is and why it matters.
Authors:
Contributors:
Reviewers:
Intended audience:
Status:             Draft / In Review / Final
Created:            YYYY-MM-DD
Last updated:       YYYY-MM-DD
Jira ticket:        link
```

## 1. Background & context
What prompted this study, what is already known, and why this is not
repeating prior research.

## 2. The decision this informs
What will change based on the findings, who owns that decision, and the
timeframe. If nothing changes, reconsider the study (the
[intake template](01-study-intake.md) exists to catch this earlier).

## 3. Research goals
What the team will be able to do because of these findings.

## 4. Research questions
The specific, researchable, prioritized questions the study must answer.
Give each an ID (RQ1, RQ2). Findings map back to these IDs at synthesis, and
uncovered questions get flagged, so write questions you intend to answer.

## 5. Assumptions & hypotheses to test
What you expect to find, stated so it can be disconfirmed, not just
validated.

## 6. Out of scope
What this study explicitly will not address.

## 7. Methodology
The method, why it fits the research questions, **what it cannot tell you**,
and the tradeoffs accepted. The per-method files in `methods/` each carry a
"what it cannot tell you" section written to be usable here verbatim.

## 8. Participants
- Profile: persona(s), product, role (operator vs end-user)
- Sample size with rationale (a rule of thumb with stated assumptions)
- Screening criteria that qualify participants in or out
- Participant type per the suite's taxonomy: `customer-direct`,
  `internal-direct`, `internal-proxy`, `sme-external`. This label travels
  onto every piece of evidence and sets the bar for the impact message later,
  so decide it now.
- Known limitations (proxy participants, access constraints)

## 9. Recruitment plan & materials
Channel, screener (use the [screener template](04-participant-screener.md)),
incentive, and the recruiting email. Customer recruitment routes through PMs
and account teams; budget weeks, not days.

## 10. Materials
Note-taking form, consent form or NDA, prototype or stimuli, and the
**participant tracker**: create it now from
[06-participant-tracker.xlsx](06-participant-tracker.xlsx), before the first
recruit, not after the first session.

## 11. Discussion guide / interview script
The session script, mapped to research questions. Use the
[discussion guide template](05-discussion-guide.md); the guide has its own
gate (§4.6) and is checked the moment it is drafted, not at release.

## 12. Analysis plan
How data will be organized, coded, and synthesized into findings, and the
framework used. Findings land in the shape of
[the findings record](07-findings-record.md).

## 13. Timeline & milestones
Recruiting, sessions, analysis, and readout, with target dates.

## 14. Ethics, consent & data handling
Informed consent and recording consent, de-identification (P-IDs in
everything released; the tracker is the only identity map), storage location,
and retention period. Record per participant whether consent covers quoting
and recontact; the impact message depends on the recontact answer.

## 15. Output, audience & distribution
Deliverable format, who acts on it and by when, and how findings will be
shared. Name the destination tier (internal-team, internal-org, external);
the safety gate checks against it.

## 16. Risks & limitations
What could undermine the study's validity or usefulness, and mitigations.

---

*Part of the Dr. Morgan UX research suite. Manual alternative to
`ux_plan_from_scratch.md`; the checkers and release process apply either way.*
