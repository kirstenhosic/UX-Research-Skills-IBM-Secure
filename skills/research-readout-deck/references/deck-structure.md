# Deck structure — slide-by-slide recipes

Read this when building the deck. It expands the arc in SKILL.md into concrete
slide types, each with what goes on it and a layout. Use the ones that fit the
study; omit the rest. The order below is the default sequence.

A readout has a *rhythm*: dense content slides broken up by sparse section
dividers and single-quote slides. Don't run ten data slides in a row. Let the
deck breathe.

**Slide budget: target ~15.** The slide types below are a *menu*, not a
checklist — a tight readout is **≤ 15 slides**. Use the essentials (Title, Summary,
Recommendations shortlist, one Methodology, Findings summary, the 4-6 strongest
evidence slides, one synthesis, What's next, Full recommendations) and treat the
rest — Agenda, Context, extra per-participant slides, standalone quote slides,
Appendix — as optional, to be cut or merged first when you're over budget. A
large multi-method study may run slightly over, but never pad.

---

## Table of contents

1. Title
2. Agenda
3. Context (current vs. new / what was tested)
4. Summary (three-column)
5. Recommendations — shortlist
6. Section divider
7. Methodology ("Who we spoke to" / "Who participated")
8. Findings summary (per method)
9. Per-participant deep-dive
9a. Usability: task results
9b. Usability: issues by severity
10. Single-insight / synthesis statement
11. Quote slide
12. Survey: primary findings (three-column thematic)
13. Survey: ratings table
14. Ranked list
15. Open-ended ("magic wand") grouped by theme
16. Themed deep-dive with interpretation (three-column)
17. Panel / feature feedback (positives + a challenge)
18. What's next
19. Full list of recommendations & feature requests
20. Thanks
21. Appendix

---

## 1. Title

The opener. Big feature name, clear label, who and when.

- **Feature/product name** — largest text on the slide.
- **Subtitle**: "UX Research Findings & Recommendations" (adjust if it's a
  specific method, e.g. "Usability Findings & Recommendations").
- **Contributors with roles**: `name (Secure UX), name (PM), name (UXD), name (Eng)`.
- **Date** (month + year is enough).
- Optional: a short link/location for the full research doc.

Layout: title left or centered, contributors + date small and lower. A single
brand or product mark is fine. No bullet content.

---

## 2. Agenda

Orient the reader. List the sections the deck will cover, in order:

- The summary and shortlist of recommendations
- Findings (by method — e.g. interview findings, survey findings)
- Full list of recommendations and feature requests
- What's next
- Appendix

Plain, scannable. This is one of the few acceptable simple-list slides.

---

## 3. Context (optional)

Only if the team needs grounding in what was tested. Good for before/after or
old/new comparisons.

- Short claim title ("New Explorer").
- 2-3 sentences of plain description, left.
- A screenshot or mock, right (half-bleed or framed). Screenshots carry these
  slides — don't describe a UI you could just show.

Use one slide per state (e.g. "Current" then "New") or a side-by-side.

### Screenshots are the backbone of a usability readout

This deck is usually about an interface, so *show the interface*. Beyond the
context slide, put real screenshots on per-task and per-participant slides, on
issue slides (the exact screen where people stalled), and in before/after
comparisons. Annotate them: a numbered marker, an arrow, or a circle in the
accent color on the spot that matters, with a one-line caption. A cropped,
annotated screen communicates a finding faster than a paragraph and gives
engineers and designers the precise reference they need. Crop tight to the
relevant region. If the study genuinely has no screens (a card sort or tree
test), say so and lean on the data visuals instead.

---

## 4. Summary (three-column) — the most important slide

If someone reads only one slide, it's this one. Three columns:

| Column | Content |
|--------|---------|
| **What went well** ("This is a success!") | The headline stat or win, stated boldly. e.g. a top-line preference %, the most-valued capability, the adjectives users used. |
| **Where it can evolve** ("There is room to evolve further") | The main gap or friction, stated without spin. |
| **How we move forward** ("How we can move forward") | The 2-4 things the team should lean into next, as a short bullet list. |

Lead the first column with the single biggest number or takeaway. Keep each
column to a few short lines. This slide often appears twice — once near the
front, once near the end as a recap.

---

## 5. Recommendations — shortlist

The 3-6 recommendations that matter most. Numbered. **Bold the key phrase** of
each so it's scannable (e.g. "Help users **build a useful query**…"). Full
sentence after the bold phrase giving the specifics. Keep the long tail for the
"full list" section near the end.

---

## 6. Section divider

Rhythm-setter. Full-color background, one short phrase, large, centered or
left. Examples: "Interviews," "Survey data," "Alignment," "What would you
change?," "Now what?" No other content. For IBM theming, dividers alternate
between Gray 100 (`#161616`) and Blue 60 (`#0F62FE`) backgrounds so consecutive
dividers differ; keep the phrase in White either way.

---

## 7. Methodology — "Who we spoke to" / "Who participated"

Transparency about the sample. A short bulleted list:

- Total participants (n).
- Segments (e.g. "4 enterprise companies"; name them only if non-confidential).
- Experience-level breakdown (e.g. "Advanced: 4, Novice/Intermediate: 3").
- For surveys: usage cadence ("50% weekly, 31% daily"), % enterprise, how much
  time they spent with the thing before responding.
- Any limitations worth flagging.

Honesty matters here: a small n is fine, but say it's small. Don't imply
representativeness you don't have.

---

## 8. Findings summary (per method)

Right after the methodology for a method, a numbered summary of that method's
key takeaways (2-4 of them). Bold the actionable core of each. This lets a
reader skip the per-participant detail if they want the gist.

---

## 9. Per-participant deep-dive

For interview studies, one slide per participant (or per company), structured:

- **User type**: advanced / intermediate / novice (or persona).
- **Primary use case**: what they're actually trying to do, italicized.
- **Unmet needs**: where the product falls short for them, with a possible
  short-term solution noted (and whether it's already resolved).

Often pair with a following slide showing that participant's actual screen /
query / artifact. Keep the verbal slide and the screenshot slide adjacent.

---

## 9a. Usability: task results

For usability tests, summarize how people did per task. A table or row-per-task
layout:

| Task | Outcome | Notes |
|------|---------|-------|
| Configure a new policy | 4/6 completed | 2 couldn't find the entry point |
| Rotate a secret | 6/6 completed, slowly | All hesitated at the confirm step |

Report what you actually measured. If you tracked completion, report completion;
if you tracked time-on-task or errors, add columns for them; if you only have
qualitative observation, say so and skip the numbers rather than inventing them.
Small n means raw counts ("4 of 6"), not percentages that imply precision you
don't have. Lead the slide with the task that mattered most, not task 1.

## 9b. Usability: issues by severity

The core usability-readout slide. List the problems you observed, each tagged
with a severity, ordered worst-first:

- **Severity** — use a simple, consistent scale (e.g. Critical / Serious /
  Minor, or 1-4). State the scale on the slide. If the team has no standard
  scale, this default is fine — just label it as the researcher's assessment.
  Severity is your judgment of impact + frequency; mark it as your assessment,
  not a measured value.
- For each issue: a one-line description of the *behavior observed* (what
  happened), then the *interpretation* (why it happened / what it means), then
  the *recommendation*. Keep those three separated, as everywhere else.
- Anchor the worst issues with a verbatim quote or a screenshot of the moment.

This slide is what engineering and design will triage from, so make each issue
specific and actionable. "Users missed the save button" is weaker than "4 of 6
scrolled past the save button because it sat below the fold on the policy form."

---

## 10. Single-insight / synthesis statement

A full-bleed slide with one sentence in large text and lots of whitespace. Names
the throughline or the "so what." A small supporting note can sit at the bottom
("This is supported by recent CSAT data," or "Future work will address this in
the PRD"). Use these sparingly — 3-5 across a deck — to mark the big moments.

Examples of the move: "The root of their challenges largely lies with query
building." / "Users may be able to interpret their charts, but they lack
confidence building the right one."

---

## 11. Quote slide

One verbatim quote, large, centered, with a decorative quote mark. Attribution
beneath: company or segment (bold) + role. No other content.

- Use real, verbatim quotes only. Never paraphrase into quotation marks.
- Anonymize: attribute by role/segment, not personal name, unless cleared.
- Interleave these between dense slides; don't stack them.

---

## 12. Survey: primary findings (three-column thematic)

For survey data, a three-column slide grouping the top themes. The example used:

| Column | Content |
|--------|---------|
| **Hardest tasks** | What users rated most difficult, + a sentence on why it matters. |
| **Easiest tasks** | What came easily, + a caveat (e.g. they avoid functions they don't understand). |
| **How they learn** | Preferred learning mode (e.g. "80% prefer trial and error"), + the implication for the design. |

Pick the 3 themes that carry your survey; relabel columns to fit.

---

## 13. Survey: ratings table

A clean table for Likert-style statements:

| Statement (1 = strongly disagree, 5 = strongly agree) | Avg (SD) | In words |
|--------------------------------------------------------|----------|----------|
| The new X is easy to use | 4.81 (.39) | Strongly agree |
| I prefer X to the old version | 4.31 (.98) | Somewhat agree |

Three columns: the statement, the number (include SD if you have it), and a
plain-language translation. Don't round a "somewhat agree" up to "strongly."
Include a reverse-scored sanity item if the study used one, and note it.

---

## 14. Ranked list

A simple ordered list, "most → least." Used for "preferred learning methods" or
"tasks by difficulty." Label the direction explicitly ("Ranked from MOST to
LEAST difficult"). Numbered.

---

## 15. Open-ended ("magic wand") grouped by theme

When you asked "what would you change?", group the responses into 2-4 themes
(e.g. Chart usability / Query building / Alerting) and list the requests under
each. A multi-column layout works. This surfaces the user's own priorities in
their own framing.

---

## 16. Themed deep-dive with interpretation (three-column)

The workhorse evidence slide and the clearest example of observation-vs-
interpretation discipline. Pick one theme (e.g. "creating multiple queries,"
"alignment"). Three sub-points across the top, each with a stat:

- **Awareness** — e.g. "3 of 16 (19%) didn't know they could do X."
- **Ease of use** — e.g. "8 of 16 (50%) found Y difficult."
- **Usefulness** — e.g. "13 of 16 (81%) called it very/extremely useful."

Under each, an **Interpretation** block (visually distinct — different color or
italic) giving your read and the "but…" nuance. Keep the data and the
interpretation visually separated so no one mistakes one for the other.

---

## 17. Panel / feature feedback (positives + a challenge)

For feedback on a specific surface or feature, two short sections:

- **Positive experiences** — what's working (bulleted).
- **A challenge and a suggestion** — the friction + a concrete idea.

Pair with a screenshot of the surface being discussed.

---

## 18. What's next

Roadmap and ownership. Bullets covering:

- What ships when (preview/launch milestones with rough timing).
- Who's already working on what (name + the workstream).
- Upcoming research and design work, with months.
- How this study connects to that future work.

Keep timing in durable terms where you can ("Q2," "next half") rather than
brittle exact dates, unless the team needs the exact date.

---

## 19. Full list of recommendations & feature requests

The complete backlog, after the narrative. Two numbered lists, often spanning
multiple slides:

- **Recommendations** — the full set (the shortlist from slide 5 plus the rest),
  each mapped to a finding.
- **Feature requests** — specific asks users made (verbatim intent), numbered.

This is the reference section PMs and eng will come back to. Completeness beats
polish here.

---

## 20. Thanks

A closing slide. Product/team mark + "Thanks!" Keep it simple.

---

## 21. Appendix

Reference documents and links: the research plan, the PRD that prompted the
study, related CSAT/sentiment data, related design plans. Group them; link or
name each. This is where the "show your work" lives.

---

## Adapting the arc to other study types

The two primary methods for this team are **usability testing** and
**interviews**, both covered above (usability evidence in 9a/9b, interview
evidence in 9 and 16). The same arc holds for less common methods:

- **Survey**: lead the relevant findings with the ratings table and ranked
  lists; keep summary, recommendations, and full-list sections identical.
- **Diary / longitudinal**: organize evidence by phase or week instead of by
  participant.
- **Concept test**: lead the summary with the go/no-go signal; organize evidence
  by concept.
- **Mixed methods** (e.g. a usability test plus follow-up interviews): one
  "Findings" section per method, each with its own methodology +
  findings-summary + evidence block, then a combined synthesis statement before
  "What's next."

In every case: summary first, evidence in the middle, full backlog and next steps
at the end, quotes and dividers for rhythm.

---

## Theme & aesthetic guardrails (reference)

The readout skill defaults to **IBM theming** — light-dominant, Blue 60 as the
single accent, Gray 100 dark anchors — drawn from the IBM Design Language and
the Carbon Design System. If the deck is not for IBM, keep the same discipline
and swap Blue 60 for the other brand's primary accent.

### Color — Carbon tokens

Build **light-dominant with Blue 60 as the single accent**: white/Gray 10
content slides, Gray 100 for title/divider/closing backgrounds, Blue 60 used
sparingly for the one focal element per slide.

| Role | Carbon token | Hex | Use |
|------|--------------|-----|-----|
| IBM Blue | Blue 60 `$interactive` | `0F62FE` | The single accent: kicker text, big stat numbers, accent rules, key callouts, annotation markers on screenshots |
| Dark anchor | Gray 100 `$background` | `161616` | Title, divider, and closing backgrounds — the dark 20-30% of the deck |
| Primary text | Gray 100 `$text-primary` | `161616` | Titles and body on light slides |
| Secondary text | Gray 70 `$text-secondary` | `525252` | Subtitles, captions, quote attributions |
| Page background | White `$background` | `FFFFFF` | Default content-slide background — the dominant surface |
| Layer / card | Gray 10 `$layer-01` | `F4F4F4` | Card fills, the one featured panel per slide, table zebra rows |
| Border / line | Gray 20 `$border-subtle` | `E0E0E0` | Dividers, table rules, card borders |
| Text on dark | White `$text-on-color` | `FFFFFF` | Type on Gray 100 backgrounds |

Status colors (Carbon support tokens — use only for severity or sentiment, never
as the brand accent): success Green 50 `24A148`, error/critical Red 60 `DA1E28`,
caution Yellow 30 `F1C21B` (always paired with Gray 100 text — never used as a
text color), info Blue 70 `0043CE`. The verified source is the Carbon Design
System (carbondesignsystem.com/elements/color) and the IBM Design Language
(ibm.com/design/language).

### Typography — IBM Plex

Headings and body in **IBM Plex Sans**; data, tables, and figures in **IBM Plex
Mono**; large pull-quotes may use **IBM Plex Serif**. If the renderer lacks IBM
Plex, fall back to a clean grotesque (Helvetica Neue / Arial) — never a default
serif like Times.

### Aesthetic guardrails (every slide must pass)

These exist so nothing reads as broken on screen. Enforce them while building
and again in QA:

- **Margins / safe area.** Keep a consistent margin (~0.5 in / 40 px) on all
  four edges. Nothing touches the edge except a deliberate full-bleed background
  or image. No element bleeds off-slide.
- **No overflow, ever.** Text must fit inside its box at the chosen size. If it
  doesn't fit, *cut words* — don't shrink type below the minimums (titles ≥ 28 pt,
  body ≥ 18 pt, captions/attribution ≥ 14 pt). Prefer fewer words to smaller type.
- **Word budgets.** Title ≤ ~10 words. ≤ 6 bullets per slide, ≤ ~12 words each.
  One idea per slide; if it needs more, it's two slides.
- **Readable contrast (WCAG AA).** Every text/background pair meets 4.5:1 (small)
  or 3:1 (large, ≥ 24 px). Use Carbon's safe pairings: Gray 100 text on White or
  Gray 10; White text on Gray 100; Blue 60 only on white or Gray 100. Never blue
  text on a dark fill, never Yellow 30 as text, never gray-on-gray midtones.
- **One accent per slide.** Blue 60 marks a single focal point — don't flood a
  slide with it. Restraint is the IBM look.
- **Align to a grid.** Left-align titles and body; keep consistent column edges;
  centered text only on quote and single-insight slides.
- **Images keep their proportions.** Never stretch or squash a screenshot; crop
  instead. Keep images inside the margins and annotate in Blue 60.
