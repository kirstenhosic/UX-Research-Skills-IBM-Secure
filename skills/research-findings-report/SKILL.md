---
name: research-findings-report
description: >-
  Write a findings-and-recommendations report from synthesized findings
  records, the output of a completed analysis (Scenario A): a 3-5 page .docx
  body in IBM Secure's design system, a .md appendix carrying the detail a
  skeptic will check, and an additional-materials section linking the files a
  re-user will need. Use this whenever someone wants to write up, document, or
  share research findings as a document rather than slides. Trigger on
  "findings report," "research report," "write up my study," "findings doc,"
  "research summary," "recommendations report," or "turn my analysis into a
  report," even when the word "skill" isn't used, and including requests that
  arrive with only raw notes, transcripts, or a prose summary. Take those too,
  but recommend running the analysis first and say what the shortcut costs.
  The report leads with each finding, follows with counted evidence, states
  the strength of every claim, and is written for a mixed stakeholder
  audience (PM + Eng + UXD + customer-facing roles).
---

# Research Findings Report

Build the written readout: the document that takes a stakeholder from "what
question did we ask" to "here is what we learned, how sure we are, and what we
should do about it" without a meeting. The audience is mixed. PMs read for the
decision and its cost, engineers read for the mechanism and the counts,
designers read for the flow and the mental-model gap, and customer-facing
colleagues read for the symptom a customer will describe. Write once, for all
of them, by leading with the finding and keeping the evidence one layer down.

This skill owns the report's *content, structure, and language*. It hands the
`.docx` rendering (typography, palette, callouts, tables) to the
**research-document-template** skill, which holds IBM Secure's design system.

> **Prerequisite: the research-document-template skill**
> (`skills/research-document-template.py` and `skills/CONFIG-SCHEMA.md`). This
> skill composes the report and a `sections` config; the template renders the
> `.docx`. If the template isn't available in your environment you can still
> produce the full report as Markdown, styled per `DESIGN-SYSTEM.md` when it
> lands somewhere that can honor it. Flag that the `.docx` build needs the
> template.

## The report in one view

Three tiers, three different readers, one deliverable:

| Tier | Lives in | Carries | Sized for |
|---|---|---|---|
| **Body** | the `.docx`, 3-5 pages | What changes a decision: headline answer, findings with evidence and strength, recommendations with owners | The stakeholder who reads it once |
| **Appendix** | a companion `.md` file, summarized in the `.docx` | What a skeptic checks: full findings records, method detail, coverage matrix, disconfirming evidence | The colleague who wants to argue with it |
| **Additional materials** | a linked list in both files | What a re-user needs: transcripts index, discussion guide, theme review packet, analysis outputs, prior reports | The researcher who picks this up in a year |

The sorting rule: **if removing it would change what the reader decides, it
goes in the body. If removing it would change whether they believe you, it
goes in the appendix. If removing it would change whether someone can build on
this study, it goes in additional materials.** When in doubt, push down a
tier. A 3-5 page body that sends a skeptic to the appendix beats a 9-page body
that loses the PM on page 2.

## When you're invoked

There are two ways this goes, and they produce different reports.

**The good path:** you're handed **findings records** that have already been
through synthesis and its gates. Each carries its own evidence, exact counts,
confidence, and limits. Your job is selection, arrangement, and prose. You are
not deciding what the study found.

**The degraded path:** you're handed raw notes, transcripts, or a prose
summary and asked to write the report. You can, and sometimes it's the only
option. But say once, plainly, what it costs. Synthesizing *while* writing is
exactly where reports go wrong: a quote gets smoothed into paraphrase, a
"4 of 8" softens into "half," a limit gets dropped because the paragraph read
better without it. Recommend running Scenario A first. If the user wants to
proceed anyway, proceed, then flag every inference you made, by name, at the
end, and say how far the report can travel (below).

## Step 1 — Start from findings records

### The record shape

A findings record is the unit this report renders from. If you have the UX
Research Skills repo, `FINDINGS-CONTRACT.md` is the full spec and governs. The
minimum this skill needs:

```
FINDING F1
  statement:      one finding, at insight level where the evidence reaches it
  rq:             the research question it answers, or UNMAPPED
  prevalence:     exact counts. "5 of 8", never "most"
  scope:          product · persona · the conditions they were under
  evidence:       >=1 verbatim quote or observed behavior, each with a
                  participant ID and a locatable source
  disconfirming:  what contradicts this, or "none found" / "not sought"
  confidence:     high / medium / low, and why
  limits:         what this finding does not apply to
  recommendation: optional as a whole. If it reaches the report it carries
                  action, owner, depends_on (the finding IDs it rests on),
                  horizon (this-quarter / direction-of-travel), confidence,
                  alternatives_considered, and reverses_if
  telling_detail: the concrete specific that could only have come from being
                  in the room (optional; use it when it's there)
  artifact_ref:   the screen, flow, or state this happened on (optional)
```

### The rendering rule

**Render only what a record contains.** If a paragraph needs a quote, the
quote has to already be in a record. If it isn't, the report can't produce it,
and the gap becomes visible instead of getting filled. Concretely:

- Every claim in the body carries its finding ID, inline in brackets like
  `[F1]` or in the appendix cross-reference
- A quote matches its record's quote exactly, character for character
- A number matches `prevalence`. "5 of 8" never becomes "most", "the
  majority", or "~60%"
- `confidence` and `limits` appear in the body for every finding you feature,
  in your own prose, not only in an appendix table
- Anything in the report with no matching record is a defect, not a style
  choice

### Validate before you write

1. **Do records exist?** If not, you're on the degraded path. Say so, then
   follow it.
2. **Does each record you plan to use carry the minimum fields?** `statement`,
   at least one sourced verbatim `evidence` entry, exact `prevalence`, `scope`
   (product + persona), `rq`, and `participant_type` on every evidence entry.
   A record missing any of those is a recollection, not a finding. Don't
   feature it. `participant_type` matters in a report specifically: a quote
   from an internal colleague describing customers reads as a customer quote
   once it sits in a pull-quote callout, and the record is the only place that
   distinction survives.
3. **Is `destination` declared** (`internal-team` / `internal-org` /
   `external`)? Put it on the title page, in the footer note, and in the
   filename. Forwarding is how this material actually travels, and a report
   that doesn't say where it was meant to go can't warn the person who
   forwards it. Ask; don't guess.
4. **Are there more findings than the body can hold?** Usually yes, and that's
   normal. Feature the 3-6 that carry the story; the rest go to the appendix
   as full records, named in the body in one line so nobody thinks they were
   dropped.

5. **Do any records carry a participant name?** They shouldn't (the suite
   de-identifies before analysis), but check anyway. If one slipped through,
   the identity rule below governs before anything else is written.

If a record fails check 2, report the gap to the user by finding ID and ask.
Never fill it in yourself.

### Participant identity: numerical IDs only, everywhere

The report refers to participants **only by purely numerical participant ID** (`P1`, `P2`, `P3`, ...),
everywhere: body, appendix, additional-materials descriptions, filenames, and
document metadata. Do NOT use prefixed, alphanumeric, or organizational IDs like `C-BofA-Eng`, `P-IBM-SE1`, or `C-NWM-TL`. Consistency across all documents is mandatory. If a name or alphanumeric ID appears anywhere in the input, replace it before writing:

- **In prose and attributions:** use the ID. If the study has no ID scheme
  yet, assign one (P1, P2, in session order) and use it consistently across
  the report, the appendix, and the records.
- **Inside a verbatim quote:** substitute the bracketed ID for the name, for
  example "I'll just ask [P4]" for "I'll just ask Dave." The brackets mark
  the substitution as an editorial alteration. This is the **one permitted
  deviation** from the byte-match rule, and it applies to participant names
  only; nothing else in a quote may be altered.
- **Report the mapping to the user in the conversation** (name to ID, one
  line each) so they can verify who is who. The mapping never lands in the
  report, the appendix, or any linked material.
- **Role and company stay.** "P3, platform engineer at a mid-size fintech" is
  what makes a finding actionable, and it is permitted. The
  `research-safety-checker` still applies its destination bar: for an
  `external` destination, a company name may itself need to generalize
  ("a large EU bank"), and stricter consent terms always win. Keep role and
  company by default; let the safety gate say when the destination can't
  carry them.

Names, email addresses, and phone numbers never survive to the page at any
destination. A name inside a linked material is the same defect one step
removed: don't link a file you know carries names (see the
additional-materials rules).

### Then gather the report-specific context

The records tell you what the study found. They don't tell you these. Collect
them separately, and ask once rather than inventing anything.

**About the study** (for the title page and method note): product and a
one-line description of what was studied; study type(s); sample (n, segments,
experience levels, recruiting source, limitations); contributors with roles;
dates; the decision or question that prompted the research.

**About the framing:** which finding the user considers the headline, if they
have a view; who the primary reader is; any deadline the report serves.

**About the materials:** what exists to link in the additional-materials
section. Ask for actual paths or URLs (repo files, shared-drive links, ticket
links). Never invent a link, and never link raw transcripts or any file
carrying participant-identifying data unless the destination and consent
permit it; when a source can't travel, list it by name with "available on
request from [role]" instead of a link.

### The degraded path — no records, just notes

1. **Say once what's missing and why it matters.** Three fields can't be
   recovered at writing time because each requires having swept the whole
   corpus: `disconfirming`, `limits`, and `confidence`. A report built from
   notes will simply not have them, and their absence is invisible on the
   page, which is precisely what makes it dangerous.
2. **If they'd rather proceed, proceed.** A useful report today beats a
   rigorous one that never gets written.
3. **Reconstruct records as you go.** For each finding you feature, write the
   record (even partial) and show the user. Mark what you inferred versus what
   the notes actually say.
4. **State your assumptions at the end, inline and by name.** ("I treated X as
   the headline; the notes gave no count for the onboarding issue, so that
   paragraph says 'several participants' and must be corrected before this
   ships.")
5. **Say how far this report can travel.** Reconstructed records marked
   inferred, with `disconfirming: not sought`, are honest, and that honesty
   draws flags: workable for `internal-team`, the wrong foundation for
   anything headed `internal-org` or `external`, where the report gate starts
   blocking. If it's going beyond the team, this is the moment to stop and
   run the analysis.

## Step 2 — Impose the structure

Use this order. It's findings-first: the reader gets the answer before the
evidence, then the evidence backs it up, then the actions, then the depth.
Skip sections that don't apply; don't pad. Section-by-section recipes, target
lengths, worked examples, and the `sections` config skeleton live in
[references/report-structure.md](references/report-structure.md). Read it
before writing.

1. **Title page** — product, "UX Research Findings & Recommendations",
   contributors with roles, date, declared destination. Apply standard heading styles (`#` / `##` / `###` in Markdown; `Heading 1` / `Heading 2` in Word/python-docx) to every section heading to enable automatic Table of Contents generation.
2. **Participant Reference Table (Mandatory)** — table with explicit header `Participant ID` listing purely numerical IDs (`P1`, `P2`...), roles, orgs, and evidence calibration.
3. **Executive summary** (≤ half a page) — the headline finding in the first
   sentence, the decision it informs, then the featured findings as
   one-liners, each with its count and confidence. This section concludes; it
   never restates. A reader who stops here should leave with the answer.
4. **Method note** (≤ a third of a page) — who, how many, what method, when,
   and the one or two limits that most constrain the findings. Full detail
   goes to the appendix. This sits high because a skeptic looks for it before
   granting the findings anything.
5. **Findings** — the featured 3-6, ordered by importance, never by
   chronology or research question number. Each finding: the claim as a
   heading, evidence with exact counts and one verbatim quote, your
   interpretation marked as yours, then confidence and limits in your own
   voice. The strongest finding gets the most room. Equal-sized sections for
   unequal evidence is a lie told through layout.
6. **Recommendations** — numbered, each an action with an owner, its
   `depends_on` finding IDs, its horizon label, and its confidence. Rendered
   as a design-system table so the room can scan it.
7. **Potential Next Steps** — prioritized study roadmap for follow-up research (e.g., developer interviews, EU accounts, surveys).
8. **What this means for you** (optional, ≤ a third of a page) — one or two
   lines per audience (PM, Eng, Design, customer-facing) for a report
   traveling beyond the immediate team. Skip for a small, close team.
9. **Reviewer Notes** — the flags that rode along from the gates: unmapped
   findings retained, research questions left unaddressed, open judgment
   calls. This section is where a study stays honest in public.
10. **Appendix** (summarized in the `.docx`, full content in the companion
   `.md`) — full findings records including the non-featured ones, the
   research-question coverage matrix, method detail, participant profile,
   disconfirming evidence detail, alternatives considered for each
   recommendation.
11. **Additional materials** — the linked list: each entry a name, a one-line
   description of what it is and when to open it, a link or location, and an
   access note where access is restricted.

## Step 3 — Write it like a researcher

`VOICE-AND-STYLE.md` is the standard and its rubric is what the readability
gate scores. The rules that do the most work in a findings report:

- **Lead with the finding, follow with the evidence.** The claim is the
  heading and the first sentence. The count, the quote, and the condition it
  happens under come after. Never open with method or background.
- **Count exactly.** "6 of 8," not "most." "2 of 8, both operators," not
  "some users." Exact counts at small n are honest twice over: they give the
  real number and they show the reader how small the sample is.
- **State the strength of every finding, and say why.** "High confidence:
  consistent across five sessions and two data types, one explained
  counter-case." "Early signal: two participants, same session block. I
  wouldn't generalize past that." A finding presented without its strength
  reads as stronger than the record says it is.
- **One hedge per claim, and a specific one.** The uncertainty goes in the
  numbers and the scope, not in a fog of "may potentially suggest."
- **No sentence is interrupted by an em dash or en dash.** Finish the
  thought. Then start the next sentence, or put the aside in brackets.
  "Configuration broke down at the auth screen (six of eight participants)
  before anyone reached policies." Hyphens in compound words are fine.
- **Let quotes do work prose can't.** One verbatim quote per featured
  finding, attributed by participant ID, byte-matched to the record.
- **Keep the telling detail.** The sticky note on the monitor, the fourteen
  open tabs. If the record carries one, it survives the trip to the page.
  Specific is the point.
- **Plain language for a mixed room.** Expand every acronym on first use.
  Research-process jargon (thematic saturation, affinity mapping) stays in
  the method note or the appendix. Product jargon stays in: this is a
  technical audience and "namespace" and "auth method" are the actual words.
- **Mark the altitude.** Don't jump from a mental-model claim to a 4px button
  in adjacent paragraphs without signaling. Group findings by level or label
  them (`[systemic]` / `[workflow]` / `[interface]`).
- **Recommendations are actions with owners.** "Reorder the auth setup flow
  so permissions come first. Design, this sprint." Not "consideration should
  be given to reordering."
- **The summary concludes.** It would be wrong if the findings were
  different. "The auth method flow is the problem; fix the ordering there and
  three of these five findings go away" is a summary. A list of topics is
  not.

## Step 4 — Render (delegate to research-document-template)

Compose a `sections` config (the custom layout in `skills/CONFIG-SCHEMA.md`)
and render through `skills/research-document-template.py`. That template owns
the design system: IBM Plex Sans, IBM Carbon color tokens (Blue 60 #0F62FE
headings, Gray 100 #161616 body), callout boxes with accent bars,
design-system tables, page furniture. Don't
restyle by hand. Specifics that matter for this report:

- The **headline finding** renders as a callout box in the executive summary
- **Recommendations** render as a table: # / Action / Owner / Depends on /
  Horizon / Confidence
- **Table of Contents:** Include `"include_toc": true` in the report config so `research-document-template.py` inserts a native Word Table of Contents field block right after the metadata block
- The **destination** goes in the `footer_note` config (for example
  "Confidential — Internal Use Only · internal-team") so every page carries it
- File naming per `DESIGN-SYSTEM.md`:
  `[Product]_[ResearchType]_FindingsReport_[Date].docx`, with the companion
  appendix as `[Product]_[ResearchType]_FindingsReport_[Date]_Appendix.md`
- The template reports any section it omitted. Read that list against your
  draft before sharing; a report that silently lost its Reviewer Notes is
  exactly the failure the gates exist to catch.

The appendix `.md` and any additional materials stay alongside the `.docx`,
in the same folder or repo location, so the links in the document resolve for
every reader at the declared destination.

## Step 5 — QA the content, not just the formatting

**First, a record-fidelity pass: no net-new data.** Go section by section and
verify that every piece of information traces to a findings record (or, on
the degraded path, to the source material the user provided). The report may
only *select, arrange, and interpret* what it was given.

- Every claim maps to a finding ID. A claim with no record behind it is
  blocking. Cut it or flag the gap; never source it from your own reasoning.
- Every quote byte-matches its record. Read them side by side. Smoothing a
  quote to fit a paragraph is the single most common way a report becomes
  untrue, and it never feels like fabrication while you're doing it.
- Every number matches `prevalence` exactly.
- Confidence and limits are visible in the body for every featured finding.
- Every recommendation carries its owner, `depends_on` IDs, horizon, and
  confidence from its record. An empty `depends_on` is blocking: the action
  did not come from the research, and a findings report is the worst place to
  imply it did. `alternatives_considered` and `reverses_if` live in the
  appendix, but they ship: they are what the room will ask for.

Then confirm the structure:

- Body is 3-5 pages. Over budget? Push detail down a tier before cutting a
  finding.
- Findings are ordered by importance and sized by evidence strength.
- The executive summary could stand alone and would be wrong if the findings
  were different.
- Sample size and limitations are stated honestly, in the body.
- Every additional-materials link resolves, carries its one-line description,
  and is appropriate for the declared destination. No linked file carries
  participant-identifying data the destination doesn't permit.
- No participant name appears anywhere: body, appendix, materials list,
  filenames, or document metadata. Participants are P-IDs; substitutions
  inside quotes are bracketed ([P4]); the name-to-ID mapping was reported to
  the user in chat and written to no file. Role and company references are
  present where useful and consistent with the declared destination.
- No sentence anywhere in the report is interrupted by an em dash or en dash.
- Reviewer Notes are present, including unmapped findings and unaddressed
  research questions. A study that quietly drops a question its stakeholders
  still expect an answer to will get asked about it anyway.

## Step 6 — Automated Gate Checks & Proactive Researcher Guidance

You must not wait for the researcher to ask for quality, safety, or formatting checks. Automate them during execution and prompt the user proactively at key decision points:

1. **Automated Name Scrubbing (Pre-Flight Safeguard):**  
   Before writing any text to a Markdown report, JSON config, or `.docx` file, automatically scrub every participant name and replace it with `P1`, `P2`, ... IDs. State the name-to-ID mapping to the researcher in chat ONCE and ensure it never lands in any output file.

2. **Automated Evaluation Loop (Quality & Redaction Gate):**  
   After composing the report draft, automatically run the pre-flight checks:
   - `research-safety-checker` (verifies zero names or PII leak into files, config, or footer metadata)
   - `research-synthesis-checker` (verifies exact quote byte-matching and exact prevalence counts)
   - `research-readability-checker` (verifies body conciseness: 3–5 pages max, layered structure)

3. **Proactive Researcher Prompts:**  
   Prompt the researcher at natural decision seams:
   - *"I have created the draft report with all participant names pseudonymized (P1, P2...). Would you like me to run the pre-flight safety & groundedness audit on the file now?"*
   - *"Report draft complete. Would you like me to compile the styled `.docx` deliverable using `research-document-template`?"*
   - *"Are there any specific stakeholders or owners to assign to Recommendations R1–R12 before exporting for broader distribution?"*
   - *"Important: Please thoroughly review and verify this draft report yourself—checking quote nuances, evidence grounding, and stakeholder alignment—before sharing it out with project stakeholders, product managers, or leadership."*
   - *"Participant Reciprocity (Closing the Loop): Consider preparing a sanitized, high-level participant summary ('What We Learned & Product Direction') to share back with participating customer accounts (e.g., P1–P4). This demonstrates impact, builds long-term trust, and keeps customer accounts engaged for follow-up studies."*

## Step 7 — You are not the last check

Your QA pass is the producer checking their own work, which is worth doing
and is not independent. Inside the UX Research Skills suite, the report goes
through its gates before it's shared: `research-safety-checker` first
(including the appendix and every linked material), then
`research-synthesis-checker` in report mode (re-verifying every claim against
the findings records), then `research-readability-checker`.
`EVALUATION-LOOP.md` §4.8 is the Definition of Done, and §8 has the sequence.

Hand off cleanly:

- **The record set you rendered from**, so the report gate checks prose
  against records rather than re-reading transcripts.
- **The declared destination**, so the safety scan applies the right bar.
- **The additional-materials list**, so the safety scan can check what the
  links expose, not just what the document says.

Whatever the gates say, the report is a draft until the researcher signs
off: they read the whole body, the appendix, and the materials list, make
their own edits, and the sign-off is recorded (§11 of `EVALUATION-LOOP.md`
has the block). The report ships under their name, not a gate's. An edit of
theirs that moves a quote, a count, or an attribution re-runs the synthesis
gate first.

Outside the suite, the same principle holds in a lighter form: before this
report gets shared, someone who didn't write it reads it against the source.

## A note on honesty

A report's value is that the team can trust it without being in the room.
Don't round a "somewhat" into a "strongly," don't promote one comment to
"users say," and don't present an interpretation as a measured result. When
the data is thin or mixed, say so on the page. An honest "early signal, worth
validating" is more useful to a product team than false confidence, and it is
the sentence that keeps them coming back for the next study.

## After the report: closing the loop with participants

The report you just wrote is for your organization. It is not the artifact
that goes back to the people who gave you their time, and it should never be
retrofitted into one by deleting a few sections.

When the report is settled, offer the participant-facing summary and hand off
to the `research-participant-summary` skill. It produces a one-page "At a
Glance" card by default, plus a short email body, a "You said / We heard"
one-pager, or a slide summary. It exists separately because a participant
summary carries a stricter data bar than this report (no participant IDs, no
exact counts, no verbatim quotes, no company names) and a risk this report
doesn't have: a requirement stated flat under your company's logo reads to a
customer as a roadmap promise.

The recruiting argument for doing it at all: a participant who sees their own
requirement in print says yes to the next study. One who hears nothing assumes
the session went into a drawer.

---

*Part of the Dr. Morgan UX research suite. Author: **Kirsten Hosic**, UX
Research Strategy Lead, Security Product Design.*
