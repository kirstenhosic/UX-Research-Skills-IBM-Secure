# Findings report — section-by-section structure

Read `SKILL.md` first for the rendering rule and the three-tier sorting rule.
This file is the recipe: what each section contains, how long it runs, how it
renders in the design system, and what good looks like against what doesn't.
Target lengths assume the 3-5 page body; a lightweight study compresses
toward 3, a multi-method study stretches toward 5. The appendix has no page
budget, only a relevance bar.

The structure follows the shape of well-constructed UX research reports in
general circulation (findings-first, evidence one layer down, method visible
but brief, recommendations as actions) and renders in IBM Secure's design
system via the research-document-template. Nothing here changes the rendering
rule: every claim, quote, and count comes from a findings record.

---

## 1. Title page

Renders from the template's standard cover: title, subtitle, accent rule,
metadata block.

- **Title:** the product and study, plain. "Vault Auth Methods Study"
- **Subtitle:** "UX Research Findings & Recommendations"
- **Metadata lines:** org and team · contributors with roles · date ·
  declared destination · study window · link/location of this report's
  materials folder

The destination appears here *and* in the footer note. Forwarding is the real
leak path, and the title page is the one part of a document everyone sees.

## 2. Executive summary — ≤ half a page

The most-read and often only-read section. Three moves, in order:

1. **The headline, first sentence.** The thing you'd say with one sentence in
   a hallway. Render it as a callout box (design-system `callout` block) so
   it survives a skim.
2. **The decision it informs.** One sentence: what this research was for and
   what can now be decided.
3. **The featured findings as one-liners.** Each with its ID, exact count,
   and confidence label. Bullets, one line each.

The summary **concludes**. Test: would this paragraph be wrong if the
findings were different? If it would survive any set of findings, it's a
restatement, and it fails.

> **Weak:** "This study explored how operators configure authentication,
> surfacing a range of experiences and several opportunities for
> improvement."
>
> **Strong:** "The auth method flow is the problem. Operators treat auth
> methods as a permissions system, Vault models them as a method-selection
> step, and the mismatch caused 5 of 8 operators to grant broader access
> than they intended [F1, high confidence]. Fix the ordering there and three
> of the five findings in this report follow."

## 3. Method note — ≤ a third of a page

Sits high, before the findings, because a skeptical reader looks for it
before granting the findings anything. Brief on purpose; the appendix
carries the rest.

- Method(s) and session shape ("8 moderated 60-minute sessions, remote")
- Who: n, persona per `scope`, segments, recruiting source
- When: fieldwork dates
- The one or two limits that most constrain the findings, in your own voice.
  ("All 8 were multi-namespace operators; nothing here speaks to
  single-namespace deployments.")

Never let the method note swell into a methods chapter. "How we coded" and
"how themes were reviewed" belong in the appendix.

## 4. Findings — the core, roughly 1.5 to 3 pages

Feature 3-6 findings. Order by importance, never by chronology or research
question number. Give the strongest finding the most room; a finding resting
on 6 of 8 should not occupy the same footprint as one resting on 2 of 8.
Asymmetry is information.

**Each featured finding is a repeating unit:**

- **Heading: the claim itself**, with its ID and an altitude label where the
  report mixes levels. "Operators treat auth methods as a permissions system
  [F1] [systemic]" beats "Finding 1: Authentication."
- **The finding, one short paragraph.** Statement first, then prevalence with
  the exact count and who ("5 of 8, all operators; no end-user showed
  this"), then the condition it happens under, from `scope.condition`.
- **Evidence.** One verbatim quote, attributed by participant ID, rendered
  distinctly (italic paragraph or a quote-styled callout). Where the record
  carries an observed behavior or a `telling_detail`, use it here; it's the
  least fakeable thing on the page. If a participant name appears inside the
  quote, substitute the bracketed ID ("I'll just ask [P4]"); that bracketed
  substitution is the one permitted alteration to a verbatim quote (see
  SKILL.md, "Participant identity").
- **Interpretation, marked as yours.** "My read:" or "What I think is
  happening:" One or two sentences. Never smuggled into the evidence.
- **Strength and limits, in your own voice.** Confidence with its why, the
  disconfirming evidence where found, and what the finding does not cover.
  Two sentences usually do it: the claim's edge, then its counter-case.
  ("High confidence: five sessions, two data types. P5 is the explained
  counter-case; they were the only participant with HashiCorp
  certification.")
- **Where it happened**, when the finding is about an interface: the
  `artifact_ref`, so an engineer can find the screen.

**Non-featured findings get one line each** at the end of this section, with
IDs and counts, pointing to their full records in the appendix. Named, never
silently dropped.

> **Weak (finding buried, vague count, no strength):** "Participants
> encountered some difficulties during configuration, which may suggest
> usability challenges in this area."
>
> **Strong:** "Configuration broke down at the same place for 6 of 8
> participants: the auth method screen, before they ever reached policies
> [F1]. Two gave up entirely. P7 said the quiet part out loud: 'I picked
> userpass because it was first.' High confidence; the two who succeeded had
> both configured Vault before."

## 5. Recommendations — half a page to a page

Numbered, and rendered as a design-system table so the room can scan it:

| # | Action | Owner | Depends on | Horizon | Confidence |
|---|---|---|---|---|---|
| 1 | Surface the permission outcome before method selection in auth setup | Design | F1, F3 | this-quarter | medium |

- **Action** is a verb phrase someone could put on a board this week, not
  "consider exploring."
- **Owner** is a named role or person. `[TBD]` is acceptable in draft and
  blocking at release.
- **Depends on** carries the finding IDs. An empty cell is blocking: the
  action did not come from the research.
- **Horizon** distinguishes `this-quarter` from `direction-of-travel`. The
  label is what stops a direction being read as a commitment in the room.
- **Confidence** should not exceed the weakest finding in Depends on without
  a stated reason.

Below the table, one short paragraph per recommendation *only where the table
row can't carry the reasoning*. `alternatives_considered` and `reverses_if`
go to the appendix, one entry per recommendation; they ship with the report
because they are what the room will ask for.

## 6. What this means for you — optional, ≤ a third of a page

For a report traveling beyond the immediate team. One or two lines per
audience; skip audiences with nothing specific.

- **PM:** the decision, the cost of acting, the cost of not acting, by when
- **Engineering:** the condition each featured finding reproduces under, and
  the screen or flow (`artifact_ref`)
- **Design:** where in the journey, expected vs. observed, which screen
- **Customer-facing:** what a customer hitting this will say, and what to
  say back

Skip the section entirely for a small, close team; a report to five people
who share a standup doesn't need it, and padding it in reads as filler.

## 7. Reviewer Notes — a few lines to a third of a page

The flags that rode along from the gates, in plain language. This is where
the study stays honest in public:

- **Unmapped findings, retained.** "[F4] maps to no stated research question.
  Kept; candidate for follow-up research."
- **Unaddressed research questions.** "RQ2 (manual rotation) has no finding.
  Sessions 3 and 7 touch it but weren't coded to it; recoverable from the
  corpus."
- **Open judgment calls** from the gates that a human should weigh.

Never resolve a flag by deleting the thing that caused it. If this section is
empty because the gates raised nothing, say that in one line rather than
omitting the section: "No open flags from review."

## 8. Appendix — summarized in the .docx, full content in the companion .md

The `.docx` carries a one-paragraph appendix summary: what the appendix
contains and where it lives. The full appendix is a companion Markdown file,
named `[Report]_Appendix.md`, kept beside the `.docx` so the pointer
resolves.

Standard appendix contents, in order. Include what exists; never pad:

1. **Full findings records**, featured and non-featured alike, in the
   `FINDINGS-CONTRACT.md` human-writable form. This is the skeptic's
   destination: every quote, count, disconfirming note, and theme-review
   disposition, checkable.
2. **Research-question coverage matrix.** RQs × findings, with both kinds of
   orphan visible.
3. **Method detail.** Recruiting and screener summary, session structure,
   analysis approach (coding, clustering, theme review and its
   `set_summary`), and the tools used.
4. **Participant profile table.** By ID, never by name: ID, role, company or
   segment, persona, experience level, `participant_type`. Role and company
   stay because they are what make a finding actionable; names, emails, and
   phone numbers never appear at any destination. The safety checker reads
   this table against the destination, and for `external` it may require
   generalizing a company to a description ("a large EU bank").
5. **Recommendation detail.** Per recommendation: `alternatives_considered`
   with why each lost, and `reverses_if`.
6. **Anything else a challenger would ask for**, named and sourced.

The appendix follows every rule the body follows (verbatim quotes, exact
counts, no dash-interrupted sentences). Depth is not an excuse for drift.

## 9. Additional materials — a linked list, in both files

The re-user's tier: what someone needs to build on, extend, or audit this
study. A design-system table or a flat list, one entry per material:

```
- Discussion guide (final, as fielded) — the instrument behind sessions 1-8.
  Open when replicating or extending the study.
  Location: [repo path or drive link]
- Theme review packet — the 9 themes as reviewed, with dispositions.
  Open when questioning how a finding was derived.
  Location: [link] · Access: research team drive, request via #uxr-secure
- De-identified transcript index — session list with dates and durations.
  Transcripts themselves: available on request from the research lead.
```

Rules:

- Every entry: a **name**, a **one-line description of what it is and when to
  open it**, a **location**, and an **access note** where access is
  restricted.
- **Never invent a link.** If the user hasn't given a location, ask, or list
  the material with "location TBD" and flag it.
- **Never link what the destination doesn't permit.** Raw transcripts and
  anything carrying participant-identifying data are listed by name with an
  access route ("available on request from [role]"), not linked, unless
  destination and consent both permit. The safety checker reads this list;
  make its job possible.
- Link `.md` materials by relative path when the report lives in a repo, so
  the links survive a clone.

---

## Rendering notes (research-document-template `sections` config)

The report uses the template's custom `sections` layout
(`skills/CONFIG-SCHEMA.md`), not the research-plan layout. Skeleton:

```json
{
  "product_name": "Vault Auth Methods Study",
  "plan_title": "UX Research Findings & Recommendations",
  "metadata": [
    "IBM HashiCorp Secure  |  UX Research",
    "Author: [name]  |  Contributors: [names, roles]  |  [date]",
    "Destination: internal-team  |  Materials: [folder link]"
  ],
  "footer_note": "Confidential — Internal Use Only · internal-team",
  "page_header": { "title": "Vault Auth Methods — Findings", "context": "IBM HashiCorp Secure · UX Research · 2026-09" },
  "sections": [
    { "heading": "Executive Summary", "blocks": [
      { "type": "callout", "title": "Headline", "text": "..." },
      { "type": "paragraph", "text": "..." },
      { "type": "bullets", "items": ["[F1] ... (5 of 8, high) ...", "..."] }
    ]},
    { "heading": "Method", "blocks": [ { "type": "paragraph", "text": "..." } ]},
    { "heading": "Findings", "blocks": [
      { "type": "subheading", "text": "Operators treat auth methods as a permissions system [F1] [systemic]" },
      { "type": "paragraph", "text": "..." },
      { "type": "paragraph", "italic": true, "text": "\"I just want to say 'this team gets these secrets'...\" — P3" },
      { "type": "paragraph", "text": "My read: ..." }
    ]},
    { "heading": "Recommendations", "blocks": [
      { "type": "table", "headers": ["#", "Action", "Owner", "Depends on", "Horizon", "Confidence"], "rows": [["1", "...", "Design", "F1, F3", "this-quarter", "medium"]] }
    ]},
    { "heading": "Reviewer Notes", "blocks": [ { "type": "bullets", "items": ["..."] } ]},
    { "heading": "Appendix", "blocks": [ { "type": "paragraph", "text": "Full records, coverage matrix, and method detail: [Report]_Appendix.md, alongside this document." } ]},
    { "heading": "Additional Materials", "blocks": [ { "type": "table", "headers": ["Material", "What it is / when to open it", "Location", "Access"], "rows": [["Discussion guide", "...", "...", "..."]] } ]}
  ]
}
```

Design-system specifics the template already owns (don't restyle):
IBM Plex Sans throughout · Blue 60 #0F62FE titles and H1 · Gray 70 #525252
H2 · callouts on Gray 10 #F4F4F4 with a Blue 60 accent bar · table headers
Gray 10 with bold Gray 100 text · Gray 100 #161616 body. The quote paragraph
inside a finding renders italic; the headline renders as a callout. One
callout in the executive summary is emphasis; a callout per section is
noise.

**Length check before rendering:** the body sections (1-7) should land at
3-5 pages once rendered. The template's omission report tells you what was
dropped; the page count you check by opening the document. Over 5 pages,
push detail down a tier before cutting a finding.
