---
name: research-readout-deck
description: >-
  Turn raw user-research findings (interview notes, survey results, usability
  observations, verbatim quotes) into a clean, easy-to-digest readout slide deck
  (.pptx) for a product team. Use this whenever someone wants to present, share,
  or "write up" research findings as slides, build a UXR readout or research
  share-out, turn study notes into a deck, or summarize what users said for PMs,
  engineers, and designers. Trigger on phrases like "research readout," "findings
  deck," "share out my study," "turn these notes into slides," "UXR presentation,"
  or "make a deck from this research," even when the word "skill" isn't used. The
  deck follows a findings-first narrative arc and is built for a mixed product-team
  audience (PM + Eng + UXD).
---

# Research Readout Deck

Build a research readout: a slide deck that takes a product team from "what
question did we ask" to "here's what we learned and what we should do about it,"
fast and without making them dig. The audience is a mixed product team, so the
deck has to land for three readers at once: PMs want the answer and the
recommendations, engineers want the specifics and the feasibility signals, and
designers want the interaction-level detail. Write for all three by leading with
the decision-relevant takeaway and keeping the evidence one layer down.

This skill owns the *content and narrative*. It hands the actual `.pptx`
mechanics (rendering, layout, QA) to the **pptx** skill.

> **Prerequisite — the `pptx` skill.** This skill does not render slides on its
> own; it produces the structure, narrative, and content rules, then delegates
> generation and visual QA to the separate **pptx** skill. Read this file first
> for the structure, then read the pptx skill before generating any slides. If
> the pptx skill isn't available in your environment, you can still use this file
> to plan the deck's content and narrative — just flag that the actual `.pptx`
> build needs it.

## When you're invoked

There are two ways this goes, and they produce different decks.

**The good path:** you're handed a set of **findings records** that have already
been through synthesis. Each one carries its own evidence, exact counts,
confidence, and limits. Your job is then selection and arrangement — pick the
findings that carry the story, impose the narrative, build the slides. You are
not deciding what the study found.

**The degraded path:** you're handed raw notes, transcripts, or a prose summary
and asked to make the deck. You can do this, and sometimes it's the only option.
But say once, plainly, what it costs — because synthesizing *while* building
slides is exactly where readouts go wrong. A quote gets tightened to fit a text
box. A "4 of 8" softens into "most." A hedge gets dropped because the line
scanned better without it. Offer to run synthesis first. If the user wants to
proceed anyway, proceed — then flag every inference you had to make, by name, at
the end.

## Step 1 — Start from findings records

### The record shape

A findings record is the unit this deck renders from. If you have the UX
Research Skills repo, `FINDINGS-CONTRACT.md` is the full spec and governs. The
minimum shape — all this skill needs to build from — is:

```
FINDING F1
  statement:      one finding, at insight level where the evidence reaches it
  rq:             the research question it answers, or UNMAPPED
  prevalence:     exact counts — "5 of 8", never "most"
  scope:          product · persona · the conditions they were under
  evidence:       >=1 verbatim quote or observed behavior, each with a
                  participant ID and a locatable source
  disconfirming:  what contradicts this — or "none found" / "not sought"
  confidence:     high / medium / low, and why
  limits:         what this finding does not apply to
  recommendation: the action and its owner (optional — but if it reaches a
                  slide, it needs an owner)
  telling_detail: the concrete specific that could only have come from being
                  in the room (optional; use it when it's there)
  artifact_ref:   the screen, flow, or state this happened on (optional)
```

### The rendering rule

**Render only what a record contains.** This is the point of the whole file.

If a slide needs a quote, the quote has to already be in a record. If it isn't,
the deck can't produce it — and the gap becomes visible instead of getting
filled. Concretely:

- Every claim on a slide carries its finding ID — on the slide face, or in the
  speaker notes if that would clutter it
- A quote on a slide matches its record's quote exactly, character for character
- A number on a slide matches `prevalence`. "5 of 8" never becomes "most"
- `confidence` and `limits` appear somewhere for every finding you show
- Anything on a slide with no matching record is a defect, not a style choice

### Validate before you build

Run this before writing a single slide. It takes a minute and it catches the
failure this skill exists to prevent.

1. **Do records exist?** If not, you're on the degraded path — say so, then
   follow it.
2. **Does each record you plan to use carry the minimum fields?** `statement`,
   at least one sourced verbatim `evidence` entry, exact `prevalence`, `scope`
   (product + persona), `rq`, and a `participant_type` on every evidence entry.
   A record missing any of those isn't a finding, it's a recollection. Don't
   build a slide on it. `participant_type` matters on a slide specifically:
   a quote from an internal colleague reporting on customers reads as a
   customer quote once it is set in 28pt beside a photo, and the record is the
   only place that distinction survives.
3. **Is `destination` declared** — `internal-team`, `internal-org`, or
   `external`? Put it on the title slide and in the filename. Forwarding is how
   this material actually travels, and a deck that doesn't say where it was
   meant to go can't warn the person who forwards it. Ask; don't guess.
4. **Are there more findings than slide budget?** Usually yes, and that's
   normal. Choose. Don't compress all of them onto crowded slides.

If a record fails check 2, report the gap to the user by finding ID and ask.
Never fill it in yourself.

### Then gather the deck-specific context

The records tell you what the study found. They don't tell you these — collect
them separately, and ask once rather than inventing anything.

**About the study (for the title + methodology):**
- Product / feature name and a one-line description of what was tested
- Study type(s): interviews, survey, usability test, diary study, etc.
- Sample: how many participants, what segments (e.g. enterprise vs. SMB),
  experience levels, recruiting source, and any limitations
- Contributors and roles (Secure UX, PM, UXD, Eng) and the date
- Optional: a link/location for the full research doc

**About the framing:**
- The decision or question that prompted the research — the deck leads with this
- Which findings the user considers the headline, if they have a view

**About delivery:**
- Theme: **always default to IBM Carbon theming** (the palette below). Only swap
  the single accent if the user explicitly requires a different brand
- Any hard constraints (must-include sections). The deck targets **~15 slides**
  by default — see the slide budget in Step 3
- Screenshots of the tested UI (screens, states, flows, the artifact under test) — ask for these if the study touched an interface and none came with the findings; most usability readouts should be screenshot-led

### The degraded path — no records, just notes

When the user says "here are my notes, make the deck," don't refuse and don't
pretend it's equivalent. Do this instead:

1. **Say once what's missing and why it matters.** Three fields cannot be
   recovered at deck-build time, because each one requires having swept the
   whole corpus: `disconfirming` (what contradicts this finding), `limits` (what
   it doesn't apply to), and `confidence` (how much weight it bears). A deck
   built from notes will simply not have them, and their absence is invisible on
   a slide — which is precisely what makes it dangerous. Offer to run synthesis
   first.
2. **If they'd rather proceed, proceed.** A useful deck today beats a rigorous
   one that never gets built.
3. **Then reconstruct records as you go.** For each finding you put on a slide,
   write the record — even a partial one — and show the user. Mark what you
   inferred versus what the notes actually say. This is slower than freehanding
   slides and it is the entire safeguard.
4. **State your assumptions inline at the end**, not buried in a slide ("I
   treated X as the headline finding; nothing in the notes gave me a
   participant count for the onboarding issue, so that slide says 'multiple
   participants' and should be corrected before you present it").

## Step 2 — Separate observation, interpretation, and recommendation

This is the discipline that makes a readout trustworthy. For every finding,
keep three things distinct:

- **Observation** — what users actually did or said (evidence: n, %, quote).
- **Interpretation** — what you think it means, marked as your read.
- **Recommendation** — what the team should do about it.

The example deck does this explicitly: data on the left, an *Interpretation*
block underneath, recommendations collected separately. Preserve that
separation. Don't smuggle an interpretation in as if it were an observation,
and don't state a recommendation without the finding it rests on.

Also calibrate strength of evidence. "13 of 16 described it as very useful" is
representative; one participant's offhand comment is anecdotal. Say which is
which. If a claim is thin, label it ("early signal," "worth validating").

## Step 3 — Impose the narrative arc

Use this order. It's findings-first: the team gets the answer before the
evidence, then the evidence backs it up, then the full backlog, then next
steps. Skip sections that don't apply; don't pad. Detailed slide-by-slide
recipes (layouts, what goes where) live in
[references/deck-structure.md](references/deck-structure.md) — read it before
building.

**Slide budget — keep it to ~15.** A readout should be skimmable, so target
**no more than 15 slides**. A large multi-method study may run a little over, but
stay tight — never pad to fill space. With that budget, the *spine* is: Title,
Summary, Recommendations shortlist, one Methodology, Findings summary, the 4-6
strongest evidence slides, one synthesis statement, What's next, and the Full
recommendations list. The first things to cut or merge when you're over budget:
a standalone Agenda, Context slides, redundant per-participant slides (keep the
2-3 that carry the story), standalone quote slides (fold the quote into the
evidence slide instead), and the Appendix. A tight spine beats completeness.

1. **Title** — feature name, "UX Research Findings & Recommendations," contributors + roles, date, optional link.
2. **Agenda** — the sections below, so readers can orient.
3. **(Optional) Context** — current vs. new state, or what was tested, with a screenshot or two.
4. **Summary** — three columns: *what went well* / *where it can evolve* / *how we move forward*. Lead with the single headline stat or takeaway.
5. **Recommendations (shortlist)** — the 3-6 that matter most, numbered, key phrase bolded.
6. **Section divider → Findings**, then for each method:
   - **Methodology** ("Who we spoke to" / "Who participated"): n, segments, cadence, limitations.
   - **Findings (summary)** for that method — the numbered takeaways.
   - **Evidence**, shaped to the method:
     - **Usability testing** (a primary method here): task-by-task results
       (completion, where people got stuck, severity-rated issues), the observed
       behavior behind each issue, and a verbatim quote that captures it. Lead
       with the issue and its severity, not the task number.
     - **Interviews** (the other primary method): per-participant deep-dives
       (User type / Primary use case / Unmet needs), themed 3-column
       finding+interpretation slides, and synthesis statements.
     - **Survey or other quant**: ratings tables and ranked lists.
7. **Quote slides** — interspersed throughout, not clustered. One verbatim quote, large, attributed by role/segment.
8. **Synthesis statements** — occasional full-bleed single-insight slides that name the throughline ("The root of their challenges lies with X").
9. **What's next** — roadmap, owners, timing; tie findings to upcoming work.
10. **Full list of recommendations & feature requests** — the complete backlog, numbered, can span slides.
11. **Thanks**, then **Appendix** — reference documents / links.

## Step 4 — Write slides for a mixed audience

- **Show, don't describe — use screenshots.** This is a usability-heavy team,
  and a readout about an interface should *show* that interface. Whenever a
  finding is about a specific screen, flow, state, or artifact, put the actual
  screenshot on the slide and annotate it (a callout, an arrow, a circle on the
  spot where people struggled) rather than describing the UI in prose. Screens
  anchor context slides, per-participant/per-task slides, issue slides, and
  before/after comparisons. Ask the user for screenshots up front if the
  findings reference the UI and none were provided — a tree test or notes-only
  study may legitimately have none, but most usability readouts should be
  screenshot-led. Crop tight to the relevant area and keep annotations in the
  accent color. A record's `artifact_ref` tells you which screen a finding
  happened on — use it to pick the right screenshot instead of guessing.
- **One idea per slide.** A slide title should be a *claim*, not a topic.
  "Users struggle to build complex queries" beats "Query building."
- **Lead with the takeaway, support with evidence.** Big stat or one-line
  insight up top; detail below.
- **Keep the detail that proves someone was there.** A record's
  `telling_detail` — the participant who kept a cheat sheet in a text file, the
  sticky note on the monitor — is the strongest signal in the deck that this
  came from real sessions and not a summary of a summary. It survives the trip
  to the slide. Don't sand it off for being specific; specific is the point.
- **Quotes earn their place.** Use them to make a finding human, not to fill
  space. Verbatim from the record, attributed, anonymized.
- **Make recommendations actionable and mapped.** Each rec traces back to a
  finding ID and carries the owner named in its record. Prioritize; don't dump.
- **Respect the three readers.** Where a finding has engineering or design
  implications, name them — feasibility notes for eng, interaction detail for
  design, impact/priority for PM.
- **Plain language.** Spell out jargon and internal acronyms the first time;
  a readout often travels beyond the room.

## Step 5 — Build the deck (delegate to pptx)

Read the **pptx** skill now and follow it to generate the `.pptx`. Key things
to carry over:

- **Findings-first, claim-titled slides**, per the structure above.
- **Screenshots of the tested UI**, annotated, on the context, per-task/
  participant, and issue slides — see Step 4. If you have screens, lead with them.
- **Section dividers** use a full-color background with a single short phrase —
  these set the rhythm of the deck and separate Interviews / Survey / What's next.
- **Quote slides** are deliberately sparse: one large centered quote, attribution
  small beneath it.
- **Data tables** (survey ratings) get a clean three-column treatment:
  statement / number (with SD if you have it) / plain-language reading.
- Honor the pptx skill's anti-patterns: no accent stripes or underlines under
  titles, no text-only filler slides, strong contrast, no overflow. Every slide
  needs a visual element (stat callout, icon, chart, screenshot, or quote mark).

### Theme — IBM by default (Carbon Design System / IBM Plex)

Default to **IBM theming**, drawn from the IBM Design Language and the Carbon
Design System: light and grid-disciplined — predominantly white (or Gray 10)
content slides with crisp near-black type, a single **Blue 60** accent, and
**Gray 100** dark anchors for title, dividers, and closing slides. Flat color
only (no gradients, shadows, glows, or rounded-corner gimmicks); lead with type
hierarchy and whitespace, left-aligned to a grid. Typography is **IBM Plex**
(Sans for headings/body, Mono for data, Serif for large pull-quotes), falling
back to a clean grotesque if Plex is unavailable — never a default serif like
Times for body.

If the deck is **not** for IBM, keep the same discipline — one dark anchor, one
accent, light content backgrounds, AA contrast — and swap Blue 60 for the other
brand's primary accent.

**The full Carbon color-token palette (hex values + per-role usage), the status
colors, and the every-slide aesthetic guardrails live in
[references/deck-structure.md](references/deck-structure.md) — read it before
building, and enforce the guardrails again in QA (Step 6).**

## Step 6 — QA the content, not just the pixels

Run the pptx skill's visual QA (subagents, overflow check). On top of that,
check the *content*:

**First, a record-fidelity pass — no net-new data.** Before anything else, go
slide by slide and verify that every piece of information traces back to a
findings record (or, on the degraded path, to the source material the user
provided). The deck may only *select, restructure, and interpret* what it was
given — it must never introduce data that isn't there.

Check each slide against its record:

- **Every claim maps to a finding ID.** A claim with no record behind it is
  blocking. Cut it or flag the gap; do not source it from your own reasoning.
- **Every quote byte-matches its record.** Read them side by side. Tightening a
  quote to fit the text box is the single most common way a readout becomes
  untrue, and it never feels like fabrication while you're doing it.
- **Every number matches `prevalence` exactly.** "5 of 8" is "5 of 8." Not
  "most," not "the majority," not "~60%."
- **`confidence` and `limits` are visible for every finding shown** — on the
  slide or in a clearly-marked notes line. A finding presented without its
  limits reads as stronger than the record says it is.
- **Recommendations on slides carry the owner** from their record.

Then confirm the rest:

- **Every number, stat, percentage, and count** (participant n, completion
  rates, ratings, SDs, "13 of 16") appears in or is directly computed from the
  source. No invented or "rounded-up" figures. If you computed a percentage from
  raw counts, the counts must be in the source.
- **Every quote** is verbatim from the source and attributed exactly as the
  source supports — no paraphrase in quotation marks, no fabricated or composite
  quotes, no invented attributions.
- **Every finding, theme, and observation** is grounded in something a user
  actually did or said in the source — not plausible-sounding filler.
- **Interpretations and recommendations are clearly marked as such** and rest on
  a cited finding; they are the *only* place your own reasoning may appear, and
  they must never be presented as measured results.
- **Names, segments, roles, dates, product details, and methodology facts**
  (sample size, cadence, limitations) match the source exactly.

If a slide needs something the source doesn't cover, do **not** invent it:
either cut it, or flag the gap explicitly to the user ("the source didn't
include a completion rate for task 3"). When in doubt, leave it out. Treat any
unverifiable claim as a defect to fix before declaring done.

- Does every finding have evidence behind it? Any unsupported claims?
- Is observation kept separate from interpretation and recommendation?
- Are all quotes verbatim and attributed? No invented quotes?
- Do the recommendations map back to findings?
- Does the summary actually capture the deck (could someone read only it)?
- Are sample size and limitations stated honestly?

Then re-check the **aesthetic guardrails** (in
[references/deck-structure.md](references/deck-structure.md)) on every slide:

- Is the deck **≤ 15 slides** (or only slightly over for a large study)?
- Any text running off-slide, clipped, or touching an edge? Any overflow?
- Does every text/background pair pass AA contrast? No blue-on-dark, no Yellow 30
  as text, no gray-on-gray?
- One Blue 60 accent per slide, light backgrounds dominant, Gray 100 anchors?
- IBM Plex throughout; images keeping their proportions inside the margins?

Fix content and layout gaps before declaring done. If you had to assume something the
source didn't cover, surface it to the user rather than burying it in a slide.

## Step 7 — You are not the last check

Your QA pass is the producer checking their own work, which is worth doing and
is not independent. If you're running inside the UX Research Skills suite, the
deck still goes through its gates before it's shared — `research-safety-checker`
first, including speaker notes, then `research-synthesis-checker` in deck mode
(re-verifying every slide against the findings records), then
`research-readability-checker`. `EVALUATION-LOOP.md` has the sequence and the
verdict schema.

Two things to hand off cleanly:

- **The record set you rendered from**, so the deck gate can check slides
  against records rather than re-reading transcripts.
- **The declared destination**, so the safety scan applies the right bar.

Screenshots and embedded file metadata can't be machine-checked. List them for
the user by slide number and say plainly that the deck isn't cleared until a
person has looked at them.

Outside the suite, the same principle holds in a lighter form: before this deck
gets presented, someone who didn't build it should read it against the source.

## A note on honesty

A readout's value is that the team can trust it. Don't round a "somewhat agree"
into a "strongly agree," don't promote one comment to "users say," and don't
present an interpretation as a measured result. When the data is thin or mixed,
say so on the slide. An honest "we're not sure yet, here's the early signal" is
more useful to a product team than false confidence.
