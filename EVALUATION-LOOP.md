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

The top row is new, and it is a different kind of thing from the rest of the
diagram. Everything after `DRAFT` is a machine filter. The **theme checkpoint**
is a person, in the middle, before synthesis — see §9.

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
result:      PASS | PASS_WITH_FLAGS | FAIL
blocking:    <count>
flags:       <count>
blocking_ids: [<claim/section ids>]
flag_ids:     [<claim/section ids>]
next_action: RELEASE | REVISE | ESCALATE
note:        <one line, plain language>
=== END VERDICT ===
```

### Result semantics

| Result | Meaning | `next_action` |
|---|---|---|
| `PASS` | Nothing blocking, nothing flagged. | `RELEASE` |
| `PASS_WITH_FLAGS` | Nothing blocking. Some items need **human judgment**, not correction. | `RELEASE` |
| `FAIL` | At least one blocking defect. The artifact is wrong, not merely debatable. | `REVISE` (or `ESCALATE` at cap) |

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

Gates attach to **artifact types**, not to skills. Four artifact types are gated
by agents — one pre-flight plus four evaluators in sequence — so most run the
pre-flight and two or three gates rather than all of them. The fifth row, the
theme set, has no agent gate at all: it gets a human checkpoint instead (§9).

Every row below is preceded by `research-safety-checker` (pre-flight, always).

| Artifact | Produced by | Gates, in order |
|---|---|---|
| **Theme set** | Scenario A, F — Draft mode only | **Human checkpoint, no agent gate.** See §9 |
| **Research plan / discussion guide** | Scenario C, D; `research-document-generator` | `plan-reviewer` → `readability-checker` |
| **Synthesis findings** | Scenario A, F | `synthesis-checker` → `significance-checker` → `readability-checker` |
| **Competitive analysis** | Scenario E | `synthesis-checker` (source-integrity mode) → `significance-checker` → `readability-checker` |
| **Readout deck** | `research-readout-deck` | `synthesis-checker` (re-verify against the findings contract) → `readability-checker` |

Run gates **in order**. Groundedness before significance before readability —
there's no point assessing whether a finding matters, or polishing how it
reads, if it turns out not to be supported. A `FAIL` at any gate stops the
sequence; later gates don't run until the artifact clears the earlier one.

### Why the deck is re-checked

The deck gate exists because story-editing is where invented evidence
historically appears — a quote gets tightened to fit a slide, a "4 of 8"
becomes "most," a hedge gets dropped for punch. The deck gate re-verifies the
deck against `FINDINGS-CONTRACT.md`, not against the transcripts: every claim
on a slide must map to a finding record that already passed. Anything on a
slide with no matching record is blocking.

### The five evaluators

| Agent | Verifies | Cannot see |
|---|---|---|
| `research-safety-checker` | Is this safe to share with *this* audience? | Whether any of it is true, relevant, or readable |
| `research-synthesis-checker` | Is each claim traceable to source text? | Whether the claim matters |
| `research-significance-checker` | Does it map to a question and a decision? Does it reach insight level? Is the corpus complete? | Whether the claim is true |
| `research-plan-reviewer` | Will this study answer its question? Is the guide sound? | Anything post-fieldwork |
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

### 4.1 Research plan / discussion guide

1. A named decision, with an owner and a date. What changes because of this?
2. Research questions that are specific, researchable, and prioritized
3. Method stated with its rationale, and with what it **cannot** tell you
4. Participants defined by persona and product — not "users" or "engineers" —
   with sample size given as a rule of thumb plus its assumptions
5. Recruitment path realistic against the team's actual constraints, with a
   timeline that reflects them
6. Every question in the guide maps to a research question; anything mapping to
   none is cut or justified
7. No leading, double-barreled, or future-hypothetical questions
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
- **Chained gates compound false positives.** Four gates each with a small
  false-alarm rate produce a system that flags something almost every run. If
  flags become noise, people stop reading them. Watch for gates that flag
  constantly, and tighten the ones that do.
- **Gates check artifacts, not conversation.** Never run this loop on Dr.
  Morgan's Coach mode. Socratic dialogue has no output to grade, and wrapping
  it in evaluation would make the coaching slower and more hedged for no gain.
- **A green verdict is not a correct study.** These gates catch fabrication,
  irrelevance, incoherence, and opacity. They cannot catch a well-executed
  study of the wrong question that everyone agreed on at the start.

---

## 8. Quick reference

**Producing findings:**

```
0. THEME CHECKPOINT (Draft mode only)  → a person accepts/revises/splits/rejects
                                          each theme before synthesis. §9
1. Draft synthesis (Dr. Morgan, Scenario A or F)
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
1. Draft plan (Dr. Morgan, Scenario C or D)
2. research-safety-checker         → PRE-FLIGHT, always runs first
3. research-plan-reviewer          → FAIL? revise, re-run
4. research-readability-checker    → FAIL? revise, re-run
5. Release
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

Everything above this section is a machine filter. Five agents check artifacts
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

A sixth *agent* would not do this job. An LLM judging an LLM's themes is a
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

**Where that threshold sits is currently unmeasured.** The honest answer is that
nobody here knows yet. What degrades first as a corpus grows is not theme
discovery but *prevalence* — the exact counts this whole contract is built on —
and that is measurable, but it has not been measured. Until it is, use **more
than five hour-long transcripts coded in one pass** as the working trigger, and
present it as a rule of thumb rather than a finding, exactly as this suite
requires of any other number.

The packet has the same shape: codes ordered by risk, merges and drops shown, a
disposition each.
