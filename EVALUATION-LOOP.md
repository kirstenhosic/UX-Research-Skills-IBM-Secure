# Evaluation Loop

How outputs from this suite get checked, revised, and released.

Before this file existed, the release gate was a suggestion: the README told a
human to run the integrity auditor, the auditor wrote a report, and nothing
caught the report. That is a one-shot audit, not a loop. This file makes it a
loop — with an explicit bar, a revision step, a cap on iterations, and a
defined moment where the machine stops and a person decides.

**The human is always the final gate.** Everything below is a filter that
removes work you shouldn't have to do by hand. It is not an approval.

---

## 1. The cycle

```
◆ DECISION CHECKPOINT ◆ ──► PLAN ──► FIELDWORK ──► CODE ──┐
(the decision's owner                                     │
 answers — §10, advisory)                                 │
                                                          ▼
CODE ──► CLUSTER ──► ◆ THEME CHECKPOINT ◆ ──► SYNTHESIZE ──┐
(Dr. Morgan,          (a person decides — §9)              │
 Draft mode only)                                          │
                                                           ▼
   ┌──────────────────────────────────────────────────────────────┐
   │                                                              │
   ▼                                                              │
DRAFT ──► PRE-FLIGHT ──► GATE 1 ──► GATE 2 ──► GATE 3 ──► RELEASE │
(Dr.       (safety)        │          │          │               │
 Morgan)       │           │          │          │               │
               └───────────┴──────────┴──────────┴──► REVISE ─────┘
                                               │   (Dr. Morgan,
                                               │    blocking items only)
                                               │
                                               └──► ESCALATE ──► human
```

The top two rows are a different kind of thing from the rest of the diagram.
Everything after `DRAFT` is a machine filter. The two **checkpoints** are people.
The **decision checkpoint** is the decision's owner, before the study exists —
§10, advisory, and the asking is what's required. The **theme checkpoint** is a
person in the middle, before synthesis — §9, and it blocks by destination.

Between them they cover the two things a gate structurally cannot reach: whether
the study is worth running, and what the data means.

### Pre-flight — safety runs before everything

`research-safety-checker` runs **first, on every artifact, every iteration** —
outside the ordered sequence below.

This is deliberate, and it is the one thing about the ordering that is easy to
get wrong. The quality gates run in order and stop at the first failure. A
safety scan placed last therefore would not run *at all* on an artifact that
failed groundedness — identifying data could sit undiscovered through two full
revision cycles, on the one check that is never negotiable. Safety is not a
quality check and does not queue behind one.

The scan is destination-aware: the bar for a team-internal readout is not the
bar for a conference talk, and applying the external bar to internal work blocks
ordinary research over an account name the whole team already knows. Where the
study's consent terms are stricter than the destination allows, consent governs.
See `agents/research-safety-checker.agent.md` for the tier table.

**Producers draft. Evaluators verify. Only the producer revises.**

Evaluators never edit the artifact. This is deliberate: an evaluator that
rewrites its own input then re-checks its own rewrite launders its errors past
itself, and you lose the independence that makes the check worth running. The
existing `research-synthesis-checker` already holds this line ("You do NOT
improve, rewrite, or re-synthesize"). Every evaluator holds it.

### Iteration cap

| Iteration | What happens |
|---|---|
| 1 | Draft produced. Gates run. |
| 2 | First revision. Blocking items only. Gates re-run. |
| 3 | Second revision. Gates re-run. |
| — | Still `FAIL` after iteration 3 → **ESCALATE**. Stop. |

Two revision passes, then it goes to a person. If an artifact can't clear the
bar in two tries, the problem is upstream of the wording — the data, the
question, or the method — and another pass just polishes the wrong object.
(This is the same judgment Scenario D applies to research plans: *know when to
stop refining and redesign.*)

Revision is **narrow**. Pass the producer the blocking items and the evidence
the source actually supports — not the whole artifact with "make it better."
Open-ended revision reintroduces problems the earlier gates already cleared,
and the iteration count stops meaning anything.

### Escalate immediately, regardless of iteration count

Some failures aren't fixable by revision. Any evaluator that finds one stops
the loop on the spot and says so:

- The data corpus is incomplete, or only the "interesting" sessions were analyzed
- The method structurally cannot answer the research question
- No decision is attached to the study
- The participant definition is wrong — the sessions studied the wrong people
- Analysis was done from memory; there is no traceable corpus
- Identifying data is present that redaction cannot fix — the finding itself
  depends on naming the account, or the corpus lacks consent for the intended
  destination (`research-safety-checker` raises this; ordinary redactable
  findings are a `REVISE`, not an escalation)

---

## 2. Verdict schema

Every evaluator ends its report with this block, verbatim in this shape. It is
the machine-readable part — the thing that lets a person, a script, or an
orchestrating agent branch on the result instead of reading prose.

```
=== VERDICT ===
gate:        <agent name>
artifact:    <file or artifact name>
iteration:   <1 | 2 | 3>
result:      PASS | PASS_WITH_FLAGS | FAIL | NOT_APPLICABLE
blocking:    <count>
flags:       <count>
blocking_ids: [<claim/section ids>]
flag_ids:     [<claim/section ids>]
next_action: RELEASE | REVISE | ESCALATE | ROUTE
note:        <one line, plain language>
=== END VERDICT ===
```

### Result semantics

| Result | Meaning | `next_action` |
|---|---|---|
| `PASS` | Nothing blocking, nothing flagged. | `RELEASE` |
| `PASS_WITH_FLAGS` | Nothing blocking. Some items need **human judgment**, not correction. | `RELEASE` |
| `FAIL` | At least one blocking defect. The artifact is wrong, not merely debatable. | `REVISE` (or `ESCALATE` at cap) |
| `NOT_APPLICABLE` | **The artifact is out of this gate's scope and was not reviewed.** Counts are zero because nothing was scored, not because nothing is wrong. `note` must name the gate that owns it. | `ROUTE` |

`NOT_APPLICABLE` is a routing outcome, not a judgment, and it is the only result
that asserts nothing about the artifact. It exists because the other three all
lie in this situation: `PASS` and `PASS_WITH_FLAGS` claim the artifact cleared a
review it never received, and `FAIL` tells the drafter to revise against a rubric
that does not apply to it. A gate handed the wrong artifact type — a survey to
`guide-checker`, a discussion guide to `survey-checker` — returns this, names the
right gate, and stops.

It was added because two gates in separate contexts independently invented the
same value when the schema gave them nothing usable, and one said so in its own
output. When an evaluator has to depart from this block to be honest, the block
is wrong.

Do not use `NOT_APPLICABLE` for an artifact this gate owns but cannot score for
want of an input — that is a `FAIL` or an `ESCALATE`, and §4.7's missing-analysis-
plan case is the worked example.

**Blocking vs. flagged is the most important distinction in this file.**

- **Blocking** = the artifact asserts something untrue, unsupported, or unsafe.
  A hallucinated quote. A statistic the data doesn't support. PII in a
  shareable document. These are defects. They get fixed.
- **Flagged** = the artifact is accurate, but a human should look. An
  unexpected finding outside the study's stated questions. A research question
  no finding addressed. A recommendation with no named owner. These are
  *judgment calls*, and an evaluator that treats them as defects will push the
  researcher to delete interesting things to make a gate go green.

`PASS_WITH_FLAGS` releases. Flags travel with the artifact as a short
**Reviewer Notes** section so the human sees them at the moment of decision,
not in a report they've already closed.

---

## 3. Gate matrix

Gates attach to **artifact types**, not to skills. One pre-flight plus six
evaluators cover them, and no artifact runs all seven — most run the pre-flight
and two or three gates. The last row, the theme set, has no agent gate at all: it
gets a human checkpoint instead (§9).

Every row below is preceded by `research-safety-checker` (pre-flight, always).

| Artifact | Produced by | Gates, in order |
|---|---|---|
| **Theme set** | Scenario A, F — Draft mode only | **Human checkpoint, no agent gate.** See §9 |
| **Research plan, no guide attached** | Scenario C, D; `research-document-template` | `plan-reviewer` → `readability-checker` |
| **Research plan with a discussion guide** | Scenario C, D; `research-document-template` | `plan-reviewer` → `guide-checker` → `readability-checker` |
| **Discussion guide / interview script, standalone** | Scenario C, D; any Draft-mode guide | `guide-checker` → `readability-checker` |
| **Research plan with a survey instrument** | Scenario C, D; `research-document-template` | `plan-reviewer` → `survey-checker` → `readability-checker` |
| **Survey instrument, standalone** | Scenario C, D; any Draft-mode questionnaire | `survey-checker` → `readability-checker` |
| **Synthesis findings** | Scenario A, F | `synthesis-checker` → `significance-checker` → `readability-checker` |
| **Competitive analysis** | Scenario E | `synthesis-checker` (source-integrity mode) → `significance-checker` → `readability-checker` |
| **Readout deck** | `research-readout-deck` | `synthesis-checker` (re-verify against the findings contract) → `readability-checker` |

Run gates **in order**. Groundedness before significance before readability —
there's no point assessing whether a finding matters, or polishing how it
reads, if it turns out not to be supported. A `FAIL` at any gate stops the
sequence; later gates don't run until the artifact clears the earlier one.

### Why a guide gets its own gate

`plan-reviewer` used to review the guide's questions itself, in a short pass
appended to the upstream audit. That pass was doing two jobs badly. Deciding
whether a guide *points at the right targets* needs the research questions in
hand; deciding whether its questions are *any good* needs to read the guide as a
conversation and needs no plan at all. Splitting them means each gate can be run
alone — a guide with no plan yet still gets a real review — and it removes the
case where one agent held two standards for the same question and quietly
applied whichever it reached first.

**The split:** `plan-reviewer` maps the guide against the research questions in
both directions, weighs coverage against stated priority, and checks that the
instrument is the right *kind* for the method. `guide-checker` reads the
instrument itself: question craft, the behavioral-versus-hypothetical balance,
the same question asked twice in different words, and the order — including the
priming failure where a stimulus appears before the unprimed baseline questions.
Neither reaches into the other.

**A guide is gated the moment it is drafted, not when the study is planned.**
Draft mode produces guides in several places — Scenario C phase 5, Scenario D
after a rebuild, a standalone request — and every one of them runs this gate
before a session is scheduled. A defect in a guide has a hard deadline: it stops
being fixable the moment the first participant answers the question.

### Why a survey gets its own gate rather than a share of the guide's

`guide-checker` declares survey instruments out of scope, and did so before there
was anywhere to send them. That exclusion was right and it stays: question wording
in a self-administered instrument answers to a different literature — response
scales, acquiescence, satisficing, primacy in a visual option list, item order
inside a matrix — and §4.6 scored against a questionnaire produces confident,
wrong advice. Widening `guide-checker` to cover both would have meant one gate
holding two standards for the same word, which is the failure the guide split
existed to fix.

So the gates divide by **instrument mode, not by artifact family**. A guide is
read as a conversation with a moderator in it. A survey is read as a document
answered alone, where nothing gets clarified and nobody notices a blank look.
Only two rules cross the line — no leading or presupposing items, no
double-barreled ones — and §4.7 names them rather than restating them.

**A survey's deadline is harder than a guide's.** A defect in a guide stops being
fixable when the first participant answers the question; the second participant
can still get the corrected version. A survey has no second participant. Field it
and the list is spent — the people who answered will not answer a revision, and
the distribution you got is the one you will report. That is why the gate runs the
moment the instrument is drafted, and why the pilot in §4.7 item 33 is closer to
mandatory than the equivalent item for a guide.

**What it still cannot see is bigger than what it can.** Non-response decides
whether a survey means anything, and it is invisible until after fielding. The
gate reads the instrument; the sample belongs to `plan-reviewer` and to a person.

### Why the deck is re-checked

The deck gate exists because story-editing is where invented evidence
historically appears — a quote gets tightened to fit a slide, a "4 of 8"
becomes "most," a hedge gets dropped for punch. The deck gate re-verifies the
deck against `FINDINGS-CONTRACT.md`, not against the transcripts: every claim
on a slide must map to a finding record that already passed. Anything on a
slide with no matching record is blocking.

### Why the document template isn't

`research-document-template` has two invocation paths, and only one of them
produces anything. The row above means the first.

**Invoked as a skill**, it composes the config from the conversation. That is
content, and it is gated as a plan — `plan-reviewer` → `readability-checker`,
like any other plan, regardless of what renders it afterward.

**Run as a script** against a config that already exists, it applies typography
and nothing else. No gate. Adding one would re-read a plan that already passed,
using evaluators that cannot see the only thing that changed. The template
holds no prose of its own: two fields used to default to boilerplate that
asserted the scope was deliberately narrowed and the questions well-grounded,
which put unchecked claims into a checked artifact. Both were removed. Keep it
that way — a renderer that supplies sentences is a producer wearing a
renderer's name.

What it can still do is leave something out. Empty sections are skipped so the
document never carries an orphaned heading, which means the `.docx` can contain
less than the plan that cleared the gates. So the template reports every
section it dropped and why, on the same principle the deck skill applies to
finding records: gaps are named, never filled in and never hidden.

That report is a warning, not a verdict. Nothing passes, fails, or gets revised
on it. It exists so that whoever compares the document against the reviewed
plan is told what is missing instead of being left to notice.

### The seven evaluators

| Agent | Verifies | Cannot see |
|---|---|---|
| `research-safety-checker` | Is this safe to share with *this* audience? | Whether any of it is true, relevant, or readable |
| `research-synthesis-checker` | Is each claim traceable to source text? | Whether the claim matters |
| `research-significance-checker` | Does it map to a question and a decision? Does it reach insight level? Is the corpus complete? | Whether the claim is true |
| `research-plan-reviewer` | Will this study answer its question? Does the guide cover it? | Anything post-fieldwork; the wording, order, and repetition inside the guide |
| `research-guide-checker` | Are the questions well-formed, behavioral, non-repeating, and in an order a conversation could follow? | Whether the study is worth running; whether the guide covers the research questions; **the moderator**, where most leading actually happens |
| `research-survey-checker` | Are the items, response options, order, and routing sound enough to field once? | Whether a survey should answer this at all; **the sample and non-response**, where a survey's validity actually lives |
| `research-readability-checker` | Will a mixed stakeholder audience understand and act on it? Is it free of PII? | Whether any of it is correct |

Each column-3 entry is the reason there is more than one evaluator. A
groundedness checker will pass a perfectly-sourced finding that answers nothing
anyone asked. A significance checker will pass a decision-relevant finding
built on a fabricated quote. Neither notices a participant's employer in
paragraph four.

---

## 4. Definition of Done

The bar each artifact is measured against. Evaluators are handed the relevant
section as their rubric — so the standard lives in one place and the evaluator
isn't inventing it fresh each run.

### 4.1 Research plan

1. A named decision, with an owner and a date. What changes because of this?
2. Research questions that are specific, researchable, and prioritized
3. Method stated with its rationale, and with what it **cannot** tell you
4. Participants defined by persona and product — not "users" or "engineers" —
   with sample size given as a rule of thumb plus its assumptions
5. Recruitment path realistic against the team's actual constraints, with a
   timeline that reflects them
6. Every question in the guide maps to a research question, and every research
   question is served by at least one — anything mapping to none is cut or
   justified
7. The guide itself clears §4.6
8. An analysis plan exists before fieldwork starts
9. Consent, de-identification, storage, and retention are addressed
10. Out-of-scope is stated explicitly
11. Meets `VOICE-AND-STYLE.md`

### 4.2 Synthesis findings

1. Every claim traces to specific source text — verbatim quote, participant ID,
   locatable position
2. Every finding conforms to `FINDINGS-CONTRACT.md`
3. Quantifiers are exact ("6 of 8"), never vague ("most," "many," "several")
4. Every finding is scoped: which product, which persona, under what conditions
   — and where the evidence is `internal-proxy`, the scope says so rather than
   presenting secondhand accounts as direct customer behavior
5. Findings reach **insight** level, not observation level
6. Every research question is either addressed or explicitly flagged as
   unaddressed (see §5)
7. Findings that map to no research question are **kept and flagged** (see §5)
8. Disconfirming evidence was sought, and is reported where found
9. The full corpus was analyzed — not just the memorable sessions
10. Recommendations have named owners
11. Cleared by `research-safety-checker` for the artifact's declared destination
12. Meets `VOICE-AND-STYLE.md`
13. Where the analysis ran in Draft mode, a person reviewed the themes these
    findings were built on, and `theme_review` records it. Blocking at
    `internal-org` and `external`; flagged at `internal-team`. Omitted, not
    blank, for Coach-mode analysis. See §9

### 4.3 Competitive analysis

1. A named decision the analysis serves
2. Every claim labeled `[verified]` / `[vendor claim]` / `[inference]` / `[unknown]`
3. Volatile claims — pricing, features, integrations — carry a date
4. IBM/HashiCorp materials labeled `[vendor claim]` on the same terms as a competitor's
5. UX judgments come from the live product or a rubric-scored teardown, never
   from marketing imagery alone
6. Criteria and weights defined **before** rating
7. Wins / loses / uniquely-differentiated stated per product; white space named
8. Conclusions resting on `[inference]` or `[vendor claim]` are marked as such
9. No invented capability, price, integration, statistic, or citation
10. Meets `VOICE-AND-STYLE.md`

### 4.4 Readout deck

1. Every claim on every slide maps to a finding record that already passed
   §4.2 — no new evidence introduced during deck building
2. Quotes are verbatim and attributed to the right participant
3. Observation, interpretation, and recommendation stay visually distinct
4. Evidence strength is stated, not implied by confident formatting
5. Sample and method appear somewhere a skeptical reader will find them
6. Recommendations have owners
7. Cleared by `research-safety-checker` for the declared destination — including
   speaker notes. Images and embedded metadata cannot be machine-checked; the
   scan lists them for human review and the deck is not clear until someone has
   actually looked
8. Meets `VOICE-AND-STYLE.md`

### 4.5 Theme set — the human checkpoint

Not an agent rubric. This is what the review packet a person receives has to
contain for the review to be possible at all. Full procedure in §9.

1. Every theme carries a meaning-level definition, not a topic label
2. Every theme carries exact prevalence and one example quote with a locator
3. Themes are ordered by **risk of being wrong**, not by importance
4. The risk flags are shown per theme: single participant, concentrated
   evidence, no disconfirming evidence found, topic-level, confirms a stated
   hypothesis, mostly proxy evidence
5. Codes merged, codes dropped, and themes considered-and-rejected are listed
   with reasons — the reasoning, not just the conclusions
6. Each theme has a disposition field: accept / revise / split / reject
7. The outcome is recorded as `theme_review` on every finding derived from it

---

### 4.6 Discussion guide / interview script

The bar `research-guide-checker` scores against. It sits after 4.5 because it
was added last, not because it runs last — a guide is gated the moment it is
drafted. §4.1 covers the plan around it; this covers the instrument.

**Severity scales with the kind of guide.** A verbatim script is held to every
item below at full strength. A semi-structured guide — a roadmap the interviewer
departs from, which is what most of these are — is held at full strength on
structure, sequence, and priming, and one level down on wording, except items 2
and 4, which stay blocking because they set the moderator's framing even when the
exact words change. A topic list gets structure and sequence review only.

**Question craft**

1. Main questions open with TED+W — Tell me about, Explain, Describe, Walk me
   through. A positive rule, and the one that prevents most of the rest: a
   question that genuinely opens this way is hard to make leading, compound, or
   yes/no. Reported as a share rather than enforced per question, since a
   well-formed "what happened next" fails it harmlessly
2. No leading, self-answering, or presupposing questions — including the
   "because" form ("did you pick that because it was faster?")
3. No double-barreled or compound questions
4. No future-hypothetical question is the only route to a topic. Hypotheticals
   are legitimate with a stimulus present or as a counterfactual probe on a real
   event — and when used, the guide says the resulting data is stated
   preference, not behavior
5. Questions ask what happened, not why the participant thinks they did it.
   People have little introspective access to their own decision processes and
   supply a plausible theory instead; interpretation is the researcher's job
6. No question asks a participant to form an opinion they don't already hold —
   establish the topic is live for them before asking what they think of it
7. Sensitive questions carry a normalizing preamble and forgiving wording, not
   just careful placement
8. Yes/no questions carry a probe
9. Every section has written-in follow-up probes, and the guide balances main
   questions, follow-ups, and probes rather than only the first
10. In a usability script, every task carries a user goal, lean realistic
   context, the information the participant needs, and a reachable end state —
   and its wording names no control, presupposes no desire to perform it, and
   carries no loaded or emotionally charged framing. In a measured session, no
   probes are written into the task sequence
11. The guide instructs the moderator to probe subjective and evaluative
   language — *easy, hard, confusing, obvious, intuitive, seamless, fine,
   frustrating, overwhelming, straightforward* — and no such word appears inside
   a question, where it supplies the evaluation the participant should supply
12. The guide ends with a moderator reminders block: the always-probe list,
   TED+W openers for going off-guide, mirroring, the pause after the participant
   stops speaking, and permission to depart from the guide. This is the only
   lever any gate has on live moderation, which is where most leading happens

**Evidence hierarchy**

13. **Every topic the guide covers is reachable through at least one behavioral
    question** — a specific past instance, not a generalized habit. This is the
    bar
14. Behavioral questions bound the recall window, by recency or by a landmark
    event. An unbounded "tell me about a time…" invites reconstruction and
    telescoping
15. Counts and ratio per section are reported. **No published work supports any
    particular ratio** — roughly two-thirds behavioral in the core is a
    reasonable place to start an argument about the balance, and nothing more
    than that. The per-topic rule in item 13 is the requirement
16. The guide does not imply that retrospective self-report is observed
    behavior. An interview produces self-report throughout; a specific past
    instance is better-quality self-report, not behavioral data. Where a
    research question needs behavior an interview can't reach, that is flagged
    and handed to `plan-reviewer`, which owns method fit

**Repetition**

17. No verbatim or near-verbatim duplicate question
18. Two questions eliciting the same construct in different words are either
    marked as a deliberate re-approach or flagged as a probable drafting
    accident. Not called triangulation, which means combining methods, sources,
    investigators, or theories — not re-asking inside one interview
19. No question re-collects what the screener or intake already has

**Sequence**

20. A warm-up precedes the core questions; nothing touching competence,
    mistakes, or workarounds sits in the opening section
21. Broad before narrow, within the guide and within each section. A grand-tour
    opener is legitimate; a section that ends on the generalization without ever
    reaching an instance is not
22. Questions about a workflow follow the order the participant lives it
23. No question depends on a concept the guide has not yet introduced
24. Unprimed questions — current workflow, expectations, unmet needs — come
    before any stimulus, concept description, or feature name that would answer
    them for the participant. The evidence is real but borrowed: it is survey
    attitude-order work (Schuman & Presser 1981; Tourangeau, Rips & Rasinski
    2000), and what transfers to a moderated interview is the accessibility
    mechanism rather than the measured effects. **This item used to call itself
    the best-evidenced on the list.** It carried no citation, as this section
    carries none anywhere, and §4.7 item 21 had already declined to inherit the
    claim; the superlative came out 2026-08-31 rather than sit above a blocking
    rule that is also an escalation condition
25. Screener and demographic questions sit at the end unless they gate a branch
26. A wrap-up exists, including "what haven't I asked about?" and the referral
    ask. The referral half was added 2026-08-31: the gate and
    `methods/interview-generative.md` have
    always required the referral and this item did not, so a guide could clear the
    rubric and draw a flag from the gate for the same wrap-up

**Timing and piloting**

27. Question count and per-section estimates are stated, and the total is
    compared against the stated session length, cross-checked against the
    planning ranges (45 min: 6–8 interview questions or 5–7 tasks · 60 min: 8–12
    or 5–7 · 90 min: 12–17 or 8–12). A substantive open question with probes runs
    perhaps 4–6 minutes. All of these are working heuristics with assumptions
    attached, not measured rates, so an overrun is flagged rather than blocking,
    and a `methods/` file with better numbers for that method overrides them
28. The guide has been piloted with someone who resembles a participant, or a
    pilot is scheduled. The gate is not a pilot and says so

29. Meets `VOICE-AND-STYLE.md` **in the prose a participant hears** — the
    introduction, the consent language, the questions as spoken, and the close.
    Scoped 2026-08-31, copying §4.7 item 34: that file applies to "anything a
    stakeholder will open" and names neither guides nor this gate, so its Part 4
    rubric — lead with the answer, a verbatim quote per finding, every
    recommendation an action with an owner — has no coherent reading against an
    interview instrument, and applying it literally generates nonsense failures

**Appended items.** The three below were added 2026-08-31 and sit outside the
thematic blocks above on purpose. Items 2, 3, 5, 10, 11, 24, 25, 27 and 28 are
cross-referenced from §4.7, both gates, `methods/tree-testing.md` and the survey
fixture, so inserting anything in place would renumber rules other documents cite
by number. Out of order and correct beats tidy and broken.

A fourth was added and **removed the same day**. It banned absolutes — "do you
always review the audit log?" — and was added because a blind run had identified
one in a real guide and had no item to file it under. A second blind run refuted
the classification: the question was "have you *ever*," which asks about a single
occurrence and is the opposite defect. The rule was left with a sound rationale
and no observed instance, so it came out rather than stand on evidence that had
dissolved. The gate's matching table row came out with it. Its removal also
retires a §4.6/§4.7 item 32 collision, and this section has already been bitten
once by both having an item 2.

30. **The guide states, or points at, what the participant is told before the
    questions start** — that the session is recorded, who else is present or
    watching, that they may decline any question or stop at any time, and what
    happens to the recording afterwards. A pointer to a separate consent script
    satisfies this; the words do not have to live here. Storage, retention and
    de-identification are §4.1 item 9 and stay there — this is only what is said
    in the room. Added because a standalone guide routes `guide-checker` →
    `readability-checker` with no `plan-reviewer` in the path, so nothing else in
    the suite was asking. A guide can otherwise clear all 29 items above while
    telling the participant nothing at all
31. **The vocabulary is the participant's, not the product's.** Flag a genuine
    mismatch, not domain jargon a senior technical audience uses daily — stripping
    that sounds condescending and is usually wrong. §4.7 item 6 is the same rule
    for surveys and has always had one; this section did not, while its gate
    scored the defect anyway
32. **A rating scale asked in a session carries an anchor.** "On a scale of 1 to
    10, how usable was it?" produces a number nobody can interpret and a story
    nobody told. This item is about the ad-hoc number. **A standardized block
    inside a moderated session — SUS, SEQ, UMUX-Lite — is a known routing gap and
    is not covered here or anywhere**: §4.7 item 32 holds the rule that a modified
    instrument reported under its own name is blocking, but `research-survey-
    checker` declares moderated scripts out of scope and stops, so an eight-item
    "SUS" with relabelled anchors currently reaches no gate. Name it in your
    report and say no gate owns it, rather than scoring it against this section

**What this rubric cannot reach.** It scores a document. It cannot see the
moderator, and most leading happens live — in an unwritten follow-up, in a
silence filled with a hypothesis. A clean guide in the wrong hands produces
contaminated data and passes every item above.

---

### 4.7 Survey instrument

The bar `research-survey-checker` scores against. §4.1 covers the plan around it
— the decision, the research questions, the sample, the analysis plan. This
covers the instrument: the items, the response options, the order, and the
routing.

**Only two items of §4.6 carry over**, and they are not restated below. §4.6 item
2 (leading, self-answering, presupposing) and §4.6 item 3 (double-barreled) are
defects in any instrument in any **mode** — meaning a moderated guide or a
self-administered instrument, which is the only thing "mode" means here. It is
**not** a claim about severity tiers, and it does not exempt these two from the
tier rule below. Everything else in §4.6 assumes a moderator in the room — probes,
follow-ups, someone to notice a blank look — and a survey has none of that. Which
is the reason this section exists rather than a note saying "as above."

Throughout this section, a bare item number means a **§4.7** item. The two
carryovers are always written as "§4.6 item 2" and "§4.6 item 3", because both
sections have an item 2 and they are different rules.

**Severity scales with what happens to the numbers.**

- **Tracking or benchmark wave** — full strength throughout, and a wording change
  between waves is itself a defect: an item reworded mid-track breaks the
  comparison that was the whole reason to field it twice.
- **One-off instrument informing a named decision** — full strength.
- **Internal pulse to a colleague-adjacent audience, reported as texture rather
  than as measurement** — full strength on routing, order, and structure; wording
  defects one level down. **§4.7 items 2, 8, and 32 do not step down** — see
  `research-survey-checker`, which carries the list and the reasoning for each
  entry. Do not read the shorter statement here as a different rule.

  **The two §4.6 carryovers do step down**, settled 2026-08-31. They are wording
  defects, repaired by rewriting the item, and the exception list is not "every
  rule that yields a number" — it is the three whose numbers *travel*: an
  agree/disagree share read as an attitude rate, an invented band set read as
  prevalence, a standardized score read against published norms. Each borrows an
  authority it has not earned. A presupposing or double-barreled item yields a
  number that means nothing on its own and carries no name to lend it weight, so
  on a pulse reported as texture it costs a flag, not a fail. The case worth
  reopening if a run argues it is self-answering: a study's own hypothesis handed
  back as agreement is the one §4.6 item 2 defect that travels well *as* texture.

If you weren't told which it is, infer it, say which you assumed, and note that
the severity calls depend on the assumption.

**Item craft**

1. Frequency and duration items carry a bounded reference period — "in the last
   30 days," "since the last upgrade" — not "typically" or "how often do you
   usually." Nobody's memory holds a rate. An unbounded frequency item returns a
   self-image, and it returns it as a number, which is worse
2. No agree/disagree, true/false, or yes/no attitude items. Ask the construct
   directly, with labelled points — "how difficult or easy was it to…" rather
   than "I found it easy to… (agree/disagree)." Agree/disagree formats carry
   acquiescence bias: a measurable share of respondents agree with whatever is
   put to them, in both directions, and the effect is concentrated in the
   respondents already doing the least work (Krosnick & Presser, 2010).
   **Blocking** where the instrument is built on the format; flagged for one or
   two items
3. No item asks a respondent to explain their own behavior, or to predict it.
   Same reason as §4.6 item 5, and worse here — there is no follow-up to catch
   the theory being invented
4. No item asks for an opinion the respondent may not hold. The query effect
   operates in self-administered instruments too, and here it produces a
   distribution rather than a sentence. Filter first — establish the topic is
   live for them — then ask
5. Sensitive items carry a normalizing preamble and forgiving wording. Self-
   administration already reduces misreporting relative to an interviewer being
   present (Tourangeau & Yan, 2007), which is a reason to choose the mode, not a
   reason to skip the framing
6. The vocabulary is the respondent's, not the product's. In an interview a
   mismatch gets queried out loud; in a survey it is answered anyway, and the
   answer is to a different question
7. No item depends on a term, feature, or concept the instrument has not yet
   defined. A forward reference in a survey does not get clarified — it gets
   guessed at, silently

**Response options and scales**

8. Options are exhaustive and mutually exclusive. Overlapping bands and a list
   that omits a real case are the two common forms, and both are **blocking**:
   neither is recoverable in analysis
9. Every scale point is labelled, not only the endpoints. Fully labelled scales
   are more reliable than endpoint-anchored ones (Krosnick & Presser, 2010)
10. Bipolar constructs use 5 or 7 points, and the instrument uses the same length
    throughout. Mixing 5-point and 7-point scales makes items non-comparable to
    each other and makes the respondent re-learn the task each block
11. Poles are balanced — as many favourable options as unfavourable, at matching
    intensity. An imbalanced scale is a leading question with numbers on it
12. The response range does not itself tell the respondent what is normal.
    Offering "fewer than 1 / 1–2 / 3–5 / more than 5" and offering "fewer than 5
    / 5–10 / more than 10" for the same behavior produce different reported
    frequencies *and* different self-assessments (Schwarz et al., 1985). Where
    the plausible range is genuinely unknown, ask an open numeric item rather
    than inventing bands, because invented bands become the finding. **Flag.**
    Settled as a flag on 2026-08-31 after this item drew a flag from five
    independent gate runs out of five, against a rubric that had assigned it no
    severity at all and a gate whose pulse-tier exception implied blocking. It
    stays a flag at every tier: it is not a wording defect, so the internal-pulse
    step-down does not reach it either
13. "Not applicable" is offered wherever the item can be inapplicable. Forcing a
    choice there manufactures data — the most common way a survey generates a
    finding about nothing
14. **"Don't know" is a judgment call, and this rubric declines to make it for
    the researcher.** That is a policy choice, not a report that the field is
    divided — the cited work leans one way. The intuitive rule, always offer a
    no-opinion out, is not supported: no-opinion options do not improve data
    quality and can discard real if weakly held attitudes, because the people who
    take them include the ones satisficing (Krosnick et al., 2002; Krosnick &
    Presser, 2010). The 2002 recommendation to omit them is itself hedged as
    worth further testing, which is why this rubric declines to turn it into a
    rule. Flag the option's *presence* on attitude items the respondent plausibly
    has a view on, and cite that work when you do. Flag its *absence* on
    knowledge-dependent items too — but mark that half as this rubric's own
    judgment rather than a finding, because the cited work is about attitude
    questions and says nothing about knowledge ones. Neither call blocks
15. Option order is randomized where the list has no natural sequence. Visually
    presented lists show primacy — options near the top are chosen more (Krosnick
    & Alwin, 1987) — and a fixed order makes position part of the result
16. Ordinal scales are never randomized, and neither are items whose order is
    load-bearing. Randomization is a defect when applied to a sequence that means
    something

**Order and context**

17. The screener runs first, stays short, and does not reveal which answer
    qualifies. A screener that names its own target — "do you manage secrets
    daily?" — recruits the people who want to be recruited
18. A warm-up item precedes the core blocks: one easy, relevant question.
    Demographics are not a warm-up — **unless the item also gates a branch**, in
    which case it has to run early and doubles as the warm-up. Say that is what
    it is doing
19. General before specific within a construct. Asking the specific item first and
    the general one after produces part-whole effects that are large, documented,
    and invisible in the results (Schuman & Presser, 1981; Tourangeau, Rips &
    Rasinski, 2000)
20. One construct per block, most important block first, and independent blocks
    randomized. Attention decays through the instrument, so the order is a
    decision about what you are willing to measure badly
21. No item primes a later one, in the specific and describable sense: **text
    that names a concept, feature, design, or hypothesis**, placed before the
    items meant to measure the unprimed baseline. That is **blocking**, and the
    contaminated items are named in full — **every item after the priming text**,
    because contamination does not stop at the block boundary that introduced it.
    An instrument that must show a concept shows it after every unprimed measure.

    **This is not a rule against order effects in general, and it must not be
    applied as one.** Every item conditions every later item; order effects are
    conserved, not eliminated, and a reading that forbids them cannot be satisfied
    by any instrument with more than one item. In particular it does not fire on
    item 19's general-before-specific ordering, and it does not fire on item 20's
    randomized independent blocks — item 20 *mandates* an arrangement that a
    general reading of this item would forbid. Where the effect is real but not
    nameable, that belongs in the report as a limit, not here as a defect.

    The mechanism is the standard account of context effects in survey response
    (Tourangeau, Rips & Rasinski, 2000). Note that §4.6 item 24 calls itself the
    best-evidenced item on its list and carries no citation, as §4.6 carries none
    anywhere; this item no longer inherits that claim
22. Sensitive items sit after the constructs they could contaminate, never in the
    opening block
23. Classification items — demographics, firmographics, role — sit **last**,
    where abandonment costs you nothing, **unless they gate a branch**. This is
    §4.6 item 25's clause, which this section dropped and should not have: an item
    that routes the instrument cannot sit after the routing
24. Open-text items are few, late, and optional, and nothing in the instrument or
    the plan treats them as qualitative data. They produce fragments from the
    minority who bother

**Length, and the analysis discipline that sets it**

25. Every item appears in at least one planned analysis cut, **except the items
    this rubric requires that cannot be in one**: the screener (item 17), the
    warm-up (item 18), open-text items (item 24, which forbids analysing them),
    and consent, contact, and recontact fields. Without those exemptions this item
    contradicts items 17, 18, and 24 outright — it would be unsatisfiable by any
    instrument that obeys them, and it fires on every instrument ever written.
    Everything else is in a cut or is cut. The analysis plan is attached or
    referenced; without it, length cannot be judged and the gate says so rather
    than guessing — this is §4.1 item 8 doing work it can only do before fielding
26. Item count is stated and compared against the stated completion time, using
    the ranges in `methods/survey.md` (3–5 min: 10–15 items · 5–8 min: 15–20 ·
    8–10 min: 20–30 · 15 min+: expect degradation in the final third). Those are conventions with
    assumptions attached — a professional respondent, answering unpaid — not
    measured rates, so an overrun is flagged rather than blocking. Say that
27. Matrix grids are short, or broken up. Long grids invite straightlining, which
    is the form survey fatigue actually takes: not abandonment but a vertical
    column of middle options answered without reading (Krosnick, 1991). Note that
    reverse-coded items detect it at the cost of confusing respondents and
    introducing a method artifact — a trade-off to state, not a rule to enforce

**Routing and mechanics**

28. Skip logic reaches every item it should and no item it shouldn't. Trace each
    branch: an item reachable by someone for whom it is incoherent is **blocking**,
    and so is a branch that dead-ends. **Incoherent reachability is not confined
    to branching**, settled 2026-08-31. An item whose referent an earlier item
    destroyed — a singular "that method" after a select-all — is incoherent for
    everyone who reaches it, and it is this item's defect rather than a wording
    one, even though no branch is involved. The test is whether the respondent has
    something coherent to answer, not how they arrived. Two of three independent
    pulse-tier runs filed such an item here; the third read this item as strictly
    about branches and filed it as a forward-reference flag, which is a step-down
    tier and one blocking finding lighter
29. Forced response is used only where an unanswered item invalidates the record.
    Making every item required converts a hesitation into an abandonment
30. The instrument opens by stating what the data is for, the estimated
    completion time, and who to contact — and the estimate is consistent with the
    count in item 26. It is the one claim in a survey the respondent can check
    while answering. **Blocking only where the gap is gross — the real length is
    double the stated one or more**, or the count sits two bands away. A smaller
    overrun is item 26's flag and nothing more: item 26 marks its own ranges as
    conventions rather than measured rates, and this item must not block on a
    yardstick the rubric declines to stand behind. Count grid rows as items
31. The instrument renders on the device the population will actually answer it
    on. Grids in particular do not survive a phone

**Standardized instruments**

32. A standardized instrument — SUS, UMUX-Lite, SEQ, NPS — is used **unmodified,
    or is not called by its name.** Dropping items, relabelling points, or
    changing the scale length forfeits the norms and the psychometrics that were
    the only reason to use it, and the resulting number is then reported against
    a benchmark it no longer belongs to. **Blocking.** An unmodified one is
    correspondingly **exempt from items 2, 9, 10, and 11** — its response format,
    its labelling, its length, and its balance are fixed by the published form,
    and changing any of them to satisfy those items would be the modification
    this rule blocks. Item 2 is on that list because SUS and UMUX-Lite are
    agree/disagree instruments by construction: without the exemption item 2
    blocks them for being what they are, and no compliant instrument containing
    one could exist. Score
    it against the published version and nothing else, and say you excepted it so
    a reader does not think you missed it. Three independent runs inferred that
    exemption before it was written down, which is why it is written down.
    **This item does not step down at the internal-pulse tier**, settled
    2026-08-31 on two independent pulse-tier runs that both blocked a modified SEQ
    and neither of which counted the call as close. Note separately that NPS's
    business claims are contested in the measurement literature; that is a
    method-fit question for `plan-reviewer`, not a reason to fail the instrument

**Piloting**

33. The instrument has been piloted — ten people, watched or debriefed — or a
    pilot is scheduled. Cognitive pretesting exists as a discipline because
    reading a question predicts poorly how it lands (Willis, 2005). The gate is
    not a pilot and says so
34. Meets `VOICE-AND-STYLE.md` in the prose a respondent reads: the invitation,
    the preamble, the close

**What this rubric cannot reach.** It scores an instrument. It cannot see the
sample frame, the invitation list, or who declines — and non-response is the
whole validity question for a survey, answered after fielding and not by any
gate here. It also cannot re-run: an interview guide gets another participant, a
survey population gets spent. A clean instrument fielded to the willing measures
the willing, and passes every item above.

---

## 5. Research-question coverage — flag both directions

A coverage check that only runs one way misses half the problem. Run it both
ways, and treat the two directions differently.

The `research-significance-checker` builds a coverage matrix of research
questions × findings, then reports the orphans on each axis.

### Findings with no research question → **FLAG. Never delete.**

A finding that answers nothing you asked is frequently the most valuable thing
in a study. It is what you didn't know to look for. The gate's job is to
surface it as unplanned, not to suppress it for being off-plan.

Report as:

> **[Unmapped — retain]** F4: "Operators keep a personal cheat sheet of
> namespace paths outside Vault." Maps to no stated research question.
> Retained. Consider: amend the study's questions, or log as a candidate for
> follow-up research.

This is `PASS_WITH_FLAGS`, never `FAIL`. An evaluator must never recommend
cutting a finding for being unmapped, and must never let a mapped-but-trivial
finding pass just because it has a question attached.

The one exception: an unmapped finding is still subject to every other gate. It
must be grounded, scoped, and evidenced like any other. Unplanned is not
unverified.

### Research questions with no findings → **FLAG. Human revises.**

An unaddressed question is a gap someone needs to know about — before the
readout, not during it. It usually means one of four things, and the evaluator
should say which it looks like:

1. The data doesn't answer it — the study needs a follow-up
2. It was answered but the answer got dropped in synthesis — recoverable
3. It was never really researchable as written — rewrite it
4. The analysis drifted toward what was interesting — go back to the corpus

Report as:

> **[Unaddressed RQ]** RQ2: "How do operators decide when to rotate a secret
> manually?" No finding addresses this. Sessions 3 and 7 touch the topic but
> were not coded to it. Looks like (2) — recoverable from the corpus.

Also `PASS_WITH_FLAGS`. It doesn't block the artifact, because findings that
*are* supported are still worth shipping. But it must appear in Reviewer Notes,
and it must appear in the readout — a study that quietly drops a question its
stakeholders are still expecting an answer to will get asked about in the room.

---

## 6. Adversarial pass (selective)

For the small number of claims that actually carry a recommendation, one
verifier is thin. Run a refutation panel — but only on those claims.

**Trigger it when any of:**

- The claim is load-bearing: a recommendation depends on it
- The claim came back `Partially Supported` but is being kept
- The decision is high-stakes, expensive, or hard to reverse

**The researcher runs this by hand.** No agent in this suite can spawn another —
they all have `read` and `search` only. Three "verifiers" simulated inside one
conversation share a context and therefore share a bias, which is exactly what
the panel exists to avoid. `research-synthesis-checker` identifies which claims
warrant a panel; a person runs it.

**How:**

1. Open **three fresh sessions** — a new chat each, no shared history.
2. In each, paste **only the source material and the one claim** — not the
   synthesis, not the reasoning that produced it, not the other sessions'
   verdicts. Fresh context is what makes the evaluator blind, and a blind
   evaluator is much harder to talk into agreeing than one shown the argument.
3. Ask each to **refute** the claim rather than assess it, defaulting to
   refuted when uncertain.
4. Kill the claim on 2-of-3 refutations.

**Do not run this on every claim.** The cost is real — three hand-run sessions
per claim — and past the load-bearing few the return drops sharply. A
twenty-claim synthesis with three recommendation-critical claims warrants three
panels, not twenty.

---

## 7. Known limits

Stated plainly, because a QA system that oversells itself is worse than none —
which is the same standard this suite holds research to.

- **LLM evaluators grade leniently on text that reads rigorous.** Formatting,
  hedged phrasing, and confident structure all bias a judge toward passing.
  Strict-verdict rules and blind context reduce this; they don't remove it.
- **An evaluator sharing a model and context with the producer shares its blind
  spots.** Blind evaluation (source + claim only) is the main defense.
- **Chained gates compound false positives.** Six gates each with a small
  false-alarm rate produce a system that flags something almost every run. If
  flags become noise, people stop reading them. Watch for gates that flag
  constantly, and tighten the ones that do.
- **Gates check artifacts, not conversation.** Never run this loop on Dr.
  Morgan's Coach mode. Socratic dialogue has no output to grade, and wrapping
  it in evaluation would make the coaching slower and more hedged for no gain.
- **A hand-built answer key is the most likely thing in the room to be wrong.**
  In the one place this suite's claims have been measured against ground truth,
  nine of the ten errors found were in the human-written key and its parser, not
  in the model — and each produced a confident, plausible number that looked
  like a capacity effect. When an evaluation disagrees with the thing being
  evaluated, check the disagreement against the source before recording a score.
- **A green verdict is not a correct study.** These gates catch fabrication,
  irrelevance, incoherence, and opacity. They cannot catch a well-executed
  study of the wrong question that everyone agreed on at the start. §10's
  decision checkpoint is the partial answer — it asks the decision's owner
  whether the question is the right one while that is still cheap to change.
  Partial because it is advisory: it records the answer, it does not require
  one, and a team that agreed on the wrong question can agree on it there too.
- **`guide-checker` is not a pilot, and it cannot see the moderator.** It reads a
  document. Whether a question is ambiguous *to a platform engineer at a
  regulated bank at 4pm on a Thursday* is the only version of that question that
  matters, and one pilot session answers it better than this gate ever will —
  which is why §4.6 item 28 asks for one. It is also blind to the largest source
  of leading in real sessions: the unwritten follow-up, and the silence a nervous
  moderator fills with a hypothesis. A clean guide can still produce contaminated
  data.
- **An A/B test design has no instrument gate.** An experiment produces findings
  the loop checks and no artifact of the shape any gate here expects — no guide,
  no questionnaire, no recruited participants, no transcript. `methods/ab-test.md`
  states this at the top and carries the craft standards instead, and a second
  human reader is the control. This was one of two such gaps; the survey half was
  closed by `research-survey-checker` and §4.7, which is what the shape of a fix
  looks like if anyone takes on the experiment half: a separate gate with its own
  literature, not a widened existing one.
- **`survey-checker` cannot see the sample, which is where a survey's validity
  lives.** It reads the instrument. Who was invited, who answered, and who
  declined decide whether the numbers mean anything, and none of it exists until
  after fielding. A clean instrument pushed to a channel of willing respondents
  measures the willing and passes this gate. It is also not a cognitive pretest —
  same limit `guide-checker` has with piloting, and it bites harder here, because
  a guide gets another participant and a survey population is spent on the first
  field.
- **A rubric with blocking verdicts is a contested instrument for qualitative
  work.** Braun and Clarke — cited throughout this suite — reject reporting
  checklists such as COREQ and SRQR as incongruent with the values of reflexive
  thematic analysis, and published their own reporting guidelines in 2024 to
  replace them. §4.6 is a checklist that issues blocking verdicts on a
  qualitative instrument, which is exactly the form of that objection. The
  defense is narrow and worth stating: these gates check *craft defects with
  known mechanisms* — a presupposition in a question, a stimulus placed before
  the baseline — not the interpretive quality of the research, which is why the
  theme checkpoint (§9) is a person and not one more rubric. Where the two
  collide, the researcher's judgment wins and the flag rides along as a Reviewer
  Note.
- **Some rules here are convention, not evidence.** The behavioral-question
  ratio, the 4–6 minutes per question, and the survey length-to-item-count table
  in §4.7 item 26 have no published basis and are marked as such where they
  appear. The priming rule, the hypothetical rule, the double-barreled rule, and
  most of §4.7's scale and order items do have one — and §4.7 item 14 is a third
  case worth keeping distinct: a policy choice made across the grain of the
  evidence it cites. The cited work leans against routinely offering a no-opinion
  out; item 14 flags in both directions and blocks in neither anyway, because the
  call belongs to the researcher. One half of it — flagging the option's absence
  on knowledge-dependent items — has no source at all, and says so. Don't let the
  file's uniform tone flatten these differences — an evaluator that cites a
  convention, or a policy choice, as though it were a finding is doing the thing
  this suite exists to catch.

---

## 8. Quick reference

**Producing findings:**

```
0. THEME CHECKPOINT (Draft mode only)  → a person accepts/revises/splits/rejects
                                          each theme before synthesis. §9
1. Draft synthesis (Dr. Morgan, Scenario A)
2. Emit findings per FINDINGS-CONTRACT.md, with a declared destination
   and theme_review carried through from step 0
3. research-safety-checker         → PRE-FLIGHT, always runs first
4. research-synthesis-checker      → FAIL? revise blocking claims, re-run
5. research-significance-checker   → FAIL? revise, re-run. Flags → Reviewer Notes
6. research-readability-checker    → FAIL? revise, re-run
7. Release with Reviewer Notes attached
```

**Producing a plan:**

```
0. DECISION CHECKPOINT (advisory)  → the decision's owner answers four
                                     questions; the disposition is recorded in
                                     the plan whatever it is, including
                                     `not obtained`. Never blocks. §10
1. Draft plan (Dr. Morgan, Scenario C or D)
2. research-safety-checker         → PRE-FLIGHT, always runs first
3. research-plan-reviewer          → FAIL? revise, re-run
4. research-guide-checker          → only if a guide is attached. FAIL? revise,
                                      re-run
   research-survey-checker         → only if a survey instrument is attached.
                                      FAIL? revise, re-run
5. research-readability-checker    → FAIL? revise, re-run
6. Release
```

**Producing a discussion guide or interview script on its own:**

```
1. Draft guide (Dr. Morgan, Scenario C phase 5 or Scenario D)
2. research-safety-checker         → PRE-FLIGHT, always runs first
3. research-guide-checker          → FAIL? revise blocking items, re-run
4. research-readability-checker    → FAIL? revise, re-run
5. Release
```

A guide drafted inside a plan runs the same gate; it does not wait for the whole
plan to be finished.

**Producing a survey instrument:**

```
1. Draft instrument (Dr. Morgan, Scenario C or D)
2. research-safety-checker         → PRE-FLIGHT, always runs first
3. research-survey-checker         → FAIL? revise blocking items, re-run
4. research-readability-checker    → FAIL? revise, re-run
5. Pilot it with ten people before the link goes out. The gate is not a pilot,
   and the population can only be fielded once
6. Release
```

**Producing a deck:**

```
1. Findings must have cleared the findings sequence first
2. research-readout-deck validates its input — records exist, each carries the
   minimum viable fields, destination is declared. Gaps are reported by finding
   ID, never filled in
3. Draft deck (research-readout-deck)
4. research-safety-checker (deck mode — speaker notes and screenshots included)
5. research-synthesis-checker (deck mode — verify against findings records)
6. research-readability-checker
7. Release
```

Cap: 2 revisions per gate. Then a person looks at it.

## 9. The theme checkpoint — a person in the middle, not only at the end

Everything above this section is a machine filter. Seven agents check artifacts
and return verdicts; the human decides at the end. That works well for findings,
because a finding is a checkable object — a quote either matches the transcript
or it doesn't.

It does nothing for the stage where the interpretive commitments are actually
made.

Look at the six-stage framework: Orient, Organize, **Code & Tag**, **Find
Patterns**, Synthesize, Communicate. The gates in §3 attach to plans, findings,
competitive analyses, and decks. None of them is a codebook or a theme set. So
in Draft mode, Dr. Morgan can code a corpus, cluster those codes into themes,
and synthesize findings from them without a person having looked at either. Then
every gate downstream verifies — correctly, thoroughly — that the findings are
faithful to themes nobody checked.

That is the gap this section closes.

### A checkpoint is not a gate

| | Gate | Checkpoint |
|---|---|---|
| Who runs it | An evaluator agent | A person |
| Produces | A verdict block | A disposition per theme |
| On failure | `REVISE` / `ESCALATE` | Whatever the reviewer decides |
| Blocks on | Defects | Nothing — it blocks on *not having happened* |

A checkpoint is a **stop-and-wait**: Dr. Morgan emits a review packet and does
not proceed to Stage 5 until a person returns decisions.

One more *agent* would not do this job. An LLM judging an LLM's themes is a
second opinion from the same kind of reasoner, drawn from the same context, with
the same blind spots — §7 already says so about evaluators generally. What is
missing at this stage isn't verification. It's judgment about what the data
means, which is the part of research that belongs to the researcher.

### Coach mode is exempt

In Coach mode the researcher does the coding and the clustering themselves.
There is nothing to review that they did not write. Running the checkpoint there
would ask someone to approve their own work, which is the fastest way to teach
them that the checkpoint is theatre. **Draft mode only.**

### When it blocks

Reuse the destination the artifact already declares. Don't add a second dial.

| Destination | Theme checkpoint |
|---|---|
| `internal-team` | **Flagged.** Themes travel with the findings for review |
| `internal-org` | **Blocking.** Synthesis does not proceed until reviewed |
| `external` | **Blocking.** |

A three-session study read by four people who all sat in the sessions does not
need a formal stop. The same themes in front of a VP, a customer, or a
conference room do.

### The review packet

Reviewing twelve themes is real work, and a checkpoint that is expensive to
satisfy gets satisfied carelessly. Build the packet to make the wrong theme
**fast to find**.

**Order themes by how likely they are to be wrong — not by how important they
are.** Riskiest first, so the first thing the reviewer reads is the thing that
most needs them. Rank by:

1. **n = 1** — the theme rests on a single participant
2. **Concentrated evidence** — one participant supplies most of the segments,
   even when several are cited
3. **`disconfirming: none found`** — nothing was found to contradict it, which
   is more often a failed search than a fact about the world
4. **Topic-level, not meaning-level** — "auth methods" is a topic;
   "participants treat auth methods as a permissions system, not a method
   selection" is a code
5. **Confirms a stated pre-study hypothesis** — the confirmation-bias candidates
6. **Mostly `internal-proxy` evidence** — a theme about customers assembled from
   colleagues' accounts of customers

**Per theme, show:** the statement, the meaning-level definition, exact
prevalence, one example quote with its locator, and whichever risk flags apply.

**Then show what the output hides.** This is the part that gets left out, and
it is the most useful page in the packet:

- **Codes merged** into this theme, and what each one originally meant
- **Codes dropped**, with the reason
- **Themes considered and rejected**, with the reason
- **Segments coded to more than one theme**, where the assignment was a judgment
  call

A finished codebook shows conclusions. The merges, drops, and rejections are the
*reasoning* — and they are where an experienced researcher will disagree.

### Ask for a decision, not for feedback

"Any thoughts on these themes?" produces silence, or "looks good." Ask for one
of four dispositions per theme:

- **ACCEPT** — as written
- **REVISE** — the theme is real but the statement is wrong; say what it should be
- **SPLIT** — this is two themes
- **REJECT** — not supported, or not a theme

**No bulk accept.** Every theme gets its own disposition. A reviewer who
genuinely accepts all of them can say so one at a time; that is the cost of the
checkpoint, and it is not a high one.

### Record the outcome

The result goes onto every finding derived from those themes, as `theme_review`
in `FINDINGS-CONTRACT.md`: who reviewed, when, and the disposition. Three weeks
later that is the only way to tell whether a theme is Dr. Morgan's or the
researcher's — and that question comes up precisely when a finding is being
challenged.

The record also carries **how many themes were modified**. A reviewer who
accepts every theme on every study is not reviewing, and nothing makes that
visible unless something counts it. It is not a defect on any single study.
It is worth being able to see across several.

### The codebook checkpoint — conditional, not default

A second, earlier checkpoint at the end of Stage 3, before codes are clustered
into themes. A wrong code propagates into every theme built on it, which makes
this by far the cheapest place to catch one. It is not the default anyway,
because two mandatory stops on a small study is friction people route around —
and a checkpoint people route around is worse than no checkpoint, since it still
produces the paperwork that says review happened.

Run it when the corpus is larger than can be coded in a single attentive pass.

**Where that threshold sits is still unmeasured — but one explanation for it has
now been ruled out.** An earlier version of this section asserted that what
degrades first as a corpus grows is not theme discovery but *prevalence*, the
exact counts this whole contract is built on. That was a guess presented as a
mechanism, and measurement contradicted it: across 69 runs on a 42-transcript
corpus, exact prevalence held through 13 transcripts (~59k words, ~79k tokens)
in four separate variables, with no degradation by corpus size and no position
effect within the prompt.

**That result is narrower than it sounds, and the narrowness is the point.** It
measures *extraction* — locating an explicit answer that sits where you expect
it. Coding is *interpretation*. Whether "5 of 8 expressed distrust" survives a
growing corpus depends on whether the judgment about what counts survives it,
and nothing here tests that. The trigger stays where it is.

Use **more than five hour-long transcripts coded in one pass** as the working
trigger, and present it as a rule of thumb rather than a finding, exactly as
this suite requires of any other number. Justify the checkpoint on the ground
that survives measurement: interpretive coding decisions benefit from human
review regardless of corpus size. That argument does not rest on a capacity
number, so a capacity number cannot dissolve it — which is precisely what
happened to the justification it replaces.

The packet has the same shape: codes ordered by risk, merges and drops shown, a
disposition each.

### The code reuse check — whenever a codebook is produced

Not conditional, and not tied to either checkpoint: any time the producer builds
a codebook, it reports four numbers before clustering. How many codes it defined,
how many segments it coded, what share of codes it applied exactly once, and the
most-reused code with its count.

A code names a pattern. One applied exactly once is a paraphrase of a single
passage with a label on it, and a codebook made mostly of those produces themes
that are all n = 1 — the first risk signal the review packet ranks. The failure
runs the other way too: an over-split codebook reaches the checkpoint with
everything flagged, which reviews the same as nothing flagged. That is why this
sits beside the checkpoints rather than inside one — it is what keeps a
checkpoint from being handed an unreviewable packet.

The producer asks rather than deciding alone: are the single-use codes genuine
one-offs worth keeping, or one idea split across several labels? Merge before
clustering.

---

## 10. The decision checkpoint — before the study, not after it

§7 states the limit this closes, in its own words: *a green verdict is not a
correct study. These gates catch fabrication, irrelevance, incoherence, and
opacity. They cannot catch a well-executed study of the wrong question that
everyone agreed on at the start.*

Every gate in §3 runs **after** the study exists. The commitment that justifies
the study — that there is a real decision, that it is still open, that these
questions would move it — is made before any of them, usually by someone who is
not in the room when the gates run. `research-plan-reviewer` checks that a
decision is *named* (§4.1 item 1). Nothing checks that the named decision is
*real*.

A model cannot check this. Whether a VP will actually change the roadmap in
November is a fact about an organization, not a property of a document, and no
amount of reading the plan reveals it. The only instrument is asking the person.

### It is advisory, and that was a choice

| | Theme checkpoint (§9) | Decision checkpoint |
|---|---|---|
| Blocks | Yes, scaled by destination | **Never** |
| Required | The stop is required | **The asking is required** |
| On no answer | Synthesis does not proceed | Recorded as `not obtained`, work continues |

Dr. Morgan must raise it and must record what comes back. It does not stop the
study, and a non-answer is a legitimate outcome that gets written down rather
than chased.

Be honest about what that buys and what it doesn't. A checkpoint that cannot
stop anything is weaker than one that can, and §9 says plainly that a checkpoint
people can walk past teaches them it is theatre. The counterweight is that this
one fires at the moment when stopping is most expensive and least welcome —
before fieldwork, when the team is keen to start — and a blocking stop there
gets routed around rather than answered. Recorded non-answers are worth more
than a stop everyone learns to bypass. If that turns out to be wrong, the
evidence will be a run of studies where `disposition: not obtained` is the norm;
raise it to blocking at `internal-org` and `external` and reuse §9's dial rather
than inventing a second one.

### Who answers

**The person who owns the decision**, named in the record. Not the researcher —
unless the researcher genuinely owns it, in which case say so in the record.
Self-confirmation is weaker evidence than a stakeholder's, and a reader should
be able to tell at a glance which one they are looking at. §9's rule holds here
too: asking someone to sign off on their own reasoning is not a checkpoint.

### The four questions

Ask all four. They are short on purpose; the second is the one that does the
work.

1. **What decision does this inform, who makes it, and by when?**
2. **What would you do if this research came back empty, or came back after
   your date?** If the answer is "the same thing," the study is not informing
   the decision. That is worth knowing in week one rather than at the readout.
3. **Which of these research questions, answered either way, would change what
   you do?** Ask them to name the ones that wouldn't. Those are candidates for
   cutting, and cutting them buys session time for the ones that would.
4. **What answer would you find hardest to accept?** This surfaces the
   pre-study hypothesis while it is still cheap. It feeds two things
   downstream: it is a full-form trigger for the integrity audit in
   `analyze_your_data.md`, and it is risk signal 5 in §9's theme ranking —
   *confirms a stated pre-study hypothesis*.

### Ask for a disposition, not a conversation

As in §9. One of four, recorded:

- **CONFIRMED** — the decision is real, open, and these questions bear on it
- **RESCOPED** — real decision, wrong questions; say which ones changed
- **NOT A DECISION** — nothing changes based on the outcome. The study may still
  be worth running as groundwork, but it is not decision research and the plan
  should stop calling it that
- **DEFERRED** — the owner cannot answer yet. Record who and when, and carry it

`NOT A DECISION` does not stop the study here. It does travel:
`research-significance-checker` escalates when a findings set has no named
decision at all, so a study that starts here and does not resolve it will meet
that verdict later. Better to have the sentence on record from week one.

### The record

Goes in the plan, under the decision. Carry it into the findings set when there
is one — `research-significance-checker` asks for the named decision, and this
is where the good version of that answer comes from.

```
decision_review:
  owner:       [name or role of the person who makes the decision]
  is_researcher: no
  date:        2026-09-01
  disposition: rescoped — RQ3 (pricing perception) dropped; the owner said
               pricing is set regardless of what we find. RQ1 and RQ2 confirmed
               as decision-bearing.
  counterfactual: "We'd ship the current design and fix it in Q1." Real
               alternative, so the study is load-bearing.
  hardest_to_accept: "That operators don't want the unified dashboard at all."
               → treat as a stated hypothesis; full-form integrity audit at
               analysis, and rank any theme confirming it as at-risk.
```

`not obtained` is a valid disposition. Write it, say who was asked and when,
and move on.

### What it does not do

- It does not block, override the researcher, or gate the plan
- It does not replace §4.1 item 1. That checks the plan *names* a decision;
  this asks whether the named one is real. A plan can pass the gate and fail
  this conversation
- It is not a stakeholder alignment exercise. Four questions, one owner, a
  disposition. If it turns into a workshop, it has stopped being a checkpoint

---

*Part of the Dr. Morgan UX research suite. Author: **Kirsten Hosic**, UX Research
Strategy Lead, Security Product Design.*
