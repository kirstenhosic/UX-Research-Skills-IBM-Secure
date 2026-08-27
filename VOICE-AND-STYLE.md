# Voice & Style

How research outputs from this suite should read.

Applies to research plans, analysis summaries, findings documents, competitive
analyses, and readout decks — anything a stakeholder will open. Enforced by
`research-readability-checker` as the last gate before release.

---

## Why this is a gate and not a preference

A research document does one job: get a room of busy people to believe
something and act on it. Writing that reads machine-made loses that job on
contact, for a reason that has nothing to do with taste — **it reads as
un-owned**. Findings that sound like nobody stood behind them get treated as
input, not as conclusions. Engineers skim for the repro condition and leave.
PMs skim for the ask and leave. Nobody argues with it, which feels like
agreement and isn't.

The fix isn't personality. It's the specific things a person who actually sat
in those sessions would write, and a generator wouldn't.

---

## Part 1 — What makes writing read as machine-made

Diagnosable tells, roughly in order of how much damage they do.

### 1.1 Uniform rhythm

The single strongest tell. Every sentence lands in the same 15–25 word band.
Every paragraph runs three sentences. Every list has three items. Every finding
gets the same amount of space.

Human writing is lumpy. A four-word sentence sits next to a thirty-word one
because the four-word thought was small and the thirty-word one wasn't.
Sentence length in real prose tracks the size of the idea; in generated prose
it tracks nothing.

> Machine: "Participants encountered difficulties during the configuration
> process. The interface presented several usability challenges. Users
> expressed frustration with the workflow."
>
> Human: "Configuration broke down at the same place for six of eight
> participants — the auth method screen, before they ever reached policies.
> Two gave up. P7 said the quiet part out loud: 'I picked userpass because it
> was first.'"

### 1.2 False parallelism

Three findings, each with three bullets, each bullet the same shape and
roughly the same length. It looks organized. It's actually a lie about the
evidence: findings never have equal weight, and forcing them into a grid hides
which one matters. When Finding 2 rests on one participant and Finding 1 rests
on six, they should not occupy the same footprint on the page.

**Let the strong finding take more room.** Asymmetry is information.

### 1.3 Hedge stacking

"This may potentially suggest that some users could possibly experience
difficulty."

Researchers hedge *precisely* and hedge *once*. The uncertainty goes in the
numbers and the scope, not into a fog of modal verbs.

> Machine: "Users may find the rotation workflow somewhat confusing at times."
>
> Human: "Two of eight misread the rotation schedule. Both were end-users, not
> operators. I wouldn't generalize past that."

Note what happened: the human version is *more* uncertain and *more* useful.
Precision about limits is not hedging.

### 1.4 Nominalization and abstraction drift

Turning verbs into nouns, and actors into abstractions. Machine prose drifts
up the abstraction ladder because the safe middle is always available.

> Machine: "The utilization of the configuration interface presented
> challenges relating to information architecture."
>
> Human: "Operators couldn't find the policy screen. It's two levels below
> where they looked."

Name the actor. Use the verb.

### 1.5 Throat-clearing and empty connectives

"It's important to note that…" · "This finding highlights the fact that…" ·
"In today's fast-paced enterprise environments…" · "It's worth considering…"

Every one of these can be deleted with no loss. If a sentence's first six words
don't carry content, cut them and start at the content.

### 1.6 Summaries that restate instead of conclude

> Machine: "In conclusion, participants had a range of experiences with the
> auth method workflow, with both positive and negative feedback emerging."

That sentence contains nothing. A human summary commits:

> "The auth method flow is the problem. Fix the ordering there and three of
> these five findings go away."

### 1.7 The balanced-both-sides reflex

Every criticism gets a compensating positive. It reads as fairness and
functions as evasion. Real research reaches verdicts — some things are working,
some are broken, and the proportion isn't 50/50 just because that feels safer.

### 1.8 Missing the telling detail

The strongest signal that a person was actually in the room. Machine prose
generalizes to the safe middle and drops the odd specific thing.

The operator who kept a paper cheat sheet of namespace paths taped to their
monitor. The participant with fourteen browser tabs open, all Vault docs. The
person who said "I'll just ask Dave" three separate times.

These details do work no summary can: they're unfakeable, they're memorable,
and they carry the finding into the next meeting after the deck is closed.
**Every findings document should contain at least one detail that could only
have come from being there.**

### 1.9 Vocabulary tells

Words that cluster in generated text and rarely in a researcher's notes:

> delve · leverage (as a verb) · robust · seamless · landscape · underscore ·
> crucial · pivotal · realm · tapestry · navigate the complexities · testament
> to · plays a vital role · in the ever-evolving world of · it's not just X,
> it's Y · unlock · empower · streamline · holistic

Not banned — some are ordinary words with ordinary uses. But three of them in
one paragraph is a signature.

### 1.10 Over-signposting

"First, we'll examine the methodology. Then we'll turn to findings. Finally,
we'll conclude with recommendations."

Headings already do this. Announcing structure that's visible on the page is
wasted words and reads as filler.

### 1.11 Decoration as structure

Bold used on every third phrase, emoji as section markers, tables where a
sentence would do. When emphasis is everywhere it stops marking anything.
Bold should mark the two or three things that survive a skim — no more.

---

## Part 2 — What makes writing read human

The positive version. These are habits, not rules.

**Lead with the answer.** Not the method, not the background. The first line of
a findings document should be the thing you'd say if you had one sentence in a
hallway. Method goes lower, where a skeptic will look for it.

**One idea per sentence.** Concrete nouns, active verbs, named actors. If a
sentence has two ideas joined by "and," it's usually two sentences.

**Quantify exactly.** "6 of 8," not "most." "2 of 8, both operators," not "some
users." Exact counts at small n are honest twice over — they give the real
number and they show the reader how small the sample is.

**Let quotes do work prose can't.** A verbatim quote carries tone, hesitation,
and vocabulary that no paraphrase survives. It's also the least fakeable thing
in the document. Use them where the participant said it better than you can.

**Commit to a verdict, then bound it.** "The auth flow is broken for operators.
It's fine for end-users, who never touch it." Two clauses: the claim and its
edge.

**Say what you don't know.** "I'm not confident in Finding 3 — only two
participants hit it, and both were in the same session block." Stating your own
weak spot is the strongest credibility move available, and no generator does it
unprompted.

**Say what would change your mind.** One line. It converts a finding from an
assertion into a position, and it's what a senior stakeholder is silently
testing for.

**Write recommendations as actions with owners.** "Reorder the auth setup flow
so permissions come first — Design, this sprint." Not "consideration should be
given to reordering."

**Read it aloud.** If you wouldn't say the sentence out loud in a standup
without embarrassment, cut it. This one test catches most of Part 1.

---

## Part 3 — Writing for a mixed stakeholder room

These documents get read by software engineers, customer representatives, UX
designers and researchers, and product managers — usually the same document, at
the same time. That's the actual constraint.

### The failure mode specific to mixed audiences

Not tone. **Unmarked altitude switching.** One paragraph sits at "operators'
mental model of the secret lifecycle" and the next at "the modal's close button
is 4px too small." Both may be true. A reader who came for one gets thrown by
the other and stops trusting their footing in the document.

Mark the level. Group findings by altitude, or label them — `[systemic]`,
`[workflow]`, `[interface]` — so a reader can find their layer and skim the
rest without feeling lost.

### What each reader needs from the same finding

| Reader | Reads for | Give them |
|---|---|---|
| **Software engineers** | Mechanism and reproducibility | The condition it happens under, what the system did, how often. Precision over narrative. They will check your numbers. |
| **Product managers** | The decision and its cost | What changes, what it costs to fix, what it costs to ignore, by when. Lead with the ask. |
| **UX designers** | The flow and the mental-model gap | Where in the journey, what the user expected vs. what happened, which screen. |
| **UX researchers** | Method and defensibility | Sample, recruitment, what you did about disconfirming evidence, what you'd caveat. |
| **Customer representatives** | The customer-facing symptom | What the customer will say when they hit this, and what the rep can say back. Whether it's shipped, planned, or under discussion. |

**One document, not five.** Write the finding once, then a short *"What this
means for you"* block with a line or two per audience. Splitting into five
documents guarantees four go stale.

### Jargon discipline

- Expand every acronym on first use, including the ones you think are obvious.
  SUS is not obvious to a customer rep.
- Research jargon stays out unless it's carrying weight. "Thematic saturation,"
  "affinity mapping," and "axial coding" describe *your* process; stakeholders
  need your *conclusions*. Method detail belongs in a method note, not in the
  finding.
- Product jargon is fine and welcome — this is a technical audience and
  "namespace," "lease," and "auth method" are the actual words. Don't
  over-simplify for an audience that knows more than the document does.

### Length

A findings readout that runs past two pages loses the PM. Two pages, or a
one-pager with an appendix. If it can't be cut to that, the study answered too
many questions and the findings need prioritizing, not more space.

---

## Part 4 — The rubric

What `research-readability-checker` scores. Each item is pass/fail on the
artifact as a whole.

**Structure**
1. Leads with the answer, not the method or the background
2. Findings ordered by importance, not by chronology or by research question number
3. Visual weight tracks evidence strength — the strongest finding is not the shortest section
4. Altitude is marked or grouped; no unsignalled jumps between systemic and interface level
5. Fits its budget (findings readout ≤ 2 pages, or 1 page + appendix)

**Sentences**
6. Sentence length varies. A document where nearly every sentence lands in the same band fails.
7. No stacked hedges — at most one hedge per claim, and it's a specific one
8. Active voice with named actors dominates; nominalization is the exception
9. No throat-clearing openers
10. Bold marks only what should survive a skim

**Substance**
11. Every quantifier is exact. Any instance of `most`, `many`, `several`, `a number of`, or `some users` where a count exists is a failure.
12. At least one verbatim quote per major finding
13. At least one concrete, specific detail that could only come from having been there
14. Confidence and limits stated in the researcher's own voice, not only in a table
15. Every recommendation is an action with an owner
16. The summary concludes rather than restates — it would be wrong if the findings were different
17. No unearned both-sidesing

**Audience**
18. Acronyms expanded on first use
19. Research-process jargon confined to the method note
20. A "what this means for you" pass exists for the audiences who will act

**Safety**
21. Cleared by `research-safety-checker` for this artifact's declared
    destination (`internal-team` / `internal-org` / `external`). That gate holds
    the tier table and the consent rule; this rubric defers to its verdict
    rather than re-deciding it.

Items 11, 15, and 16 are blocking. Item 21 is owned by the safety gate, which
runs before any of this. The rest are
flags — style disagreements are a human's call, and a gate that hard-fails on
voice will get ignored or switched off.

---

## Part 5 — Do not over-correct

Half of the "sounds human" advice in circulation makes writing worse. Guard
against these:

**Don't fake casualness.** Slang and jokes in a findings document read as
nervous, not human. The register here is *a competent colleague explaining
something they know well* — plain, direct, unhurried. Plain is not casual.

**Don't add errors on purpose.** Typos and deliberate grammatical roughness
don't read as authentic, they read as careless, and in a document asking a room
to spend money that's expensive.

**Don't panic about punctuation.** Em-dashes, semicolons, and the serial comma
are not tells. Uniformity is the tell. A document with varied sentence lengths
and one em-dash per page is fine; a document with no em-dashes and metronomic
rhythm still reads generated.

**Don't manufacture opinions.** "I think" attached to a claim you can't defend
is worse than the neutral version. Stance has to be earned by evidence — the
credibility comes from *having a defensible position*, not from the first
person.

**Don't strip precision to sound conversational.** "About 5 or 6 people" is not
warmer than "6 of 8." It's just less useful. Exactness is a human trait; it's
vagueness that reads generated.

**Don't over-apply this to a plan.** A research plan is a working document and
some of it is legitimately a form — timeline, consent, screener criteria. Voice
matters in the framing, the questions, and the rationale. It does not need to
be present in the logistics table.

---

*Part of the Dr. Morgan UX research suite. Author: **Kirsten Hosic**, UX Research
Strategy Lead, Security Product Design.*
