# Tree testing

> **Maintainer:** Kirsten Hosic · **Last reviewed:** 2026-08 · **Status:** current
>
> Format: [`../METHODS.md`](../METHODS.md). Shared question rules: `EVALUATION-LOOP.md` §4.6.

**One sentence:** Participants find things in a stripped-down text version of your
navigation, with no visual design, search, or page content — isolating whether the
structure and its labels work.

**Gating:** the task set is an instrument `research-guide-checker` can read. Its
task-wording rules apply in full (§4.6 item 10); its interview-specific items —
TED+W, the behavioral bar, probe banks — do not. Say which you are running when
you send it.

## What it can tell you

- Whether people can find a given thing in the structure, and how directly
- Which labels are ambiguous, and which *other* label they pull traffic toward
- Where two branches compete for the same mental category
- Whether a proposed restructure beats the current one, when you test both
- The specific wrong turn, which is more actionable than the failure rate

## What it cannot tell you

Use this verbatim in the plan's methodology section.

- **Whether the real site works.** Search, breadcrumbs, cross-links, visual
  hierarchy, and recognisable page content all rescue people in production. Tree
  testing deliberately removes every one of them, so failure rates run
  pessimistic and are not a prediction of live behavior.
- **Why a label is wrong.** You get the wrong turn, not the reasoning. Pair with
  a few moderated sessions or an open-ended follow-up if you need the why.
- **What the structure should be.** It evaluates a tree; it does not generate
  one. That is card sorting, and it runs before this.
- **Anything about content quality.** There is no content.
- **Whether people would ever look for that thing.** You told them to.

## Session shape

Unmoderated and asynchronous by default. There is no session to shape — the
design work is entirely in the tree and the tasks.

| Component | Detail |
|---|---|
| Tree | Full depth, real labels, no design. Include the whole structure, not just the branches you care about — a tree with only the relevant branches makes every task trivially easy |
| Tasks | Randomised order across participants |
| Per task | Participant clicks down the tree until they commit to an answer, or gives up |
| Follow-up | Optional single open question per task, or one at the end |

Budget 10–15 minutes of participant time. Beyond that, attention degrades and the
later tasks measure fatigue.

## Counts

Rule of thumb. Assumes a tree of moderate depth and tasks with a single correct
destination.

| Session budget | Tasks |
|---|---|
| 10 min | 8–10 |
| 15 min | 10–15 |

More than about 15 tasks and completion drops. Randomise order so fatigue
distributes across tasks rather than concentrating on whichever ones you listed
last.

## Instrument craft

**The task must not contain the label.** This is the failure that invalidates
tree tests, and it is easy to commit without noticing: if the destination is
"Access Policies" and the task says "find where you'd manage access policies,"
you have tested reading. Use the participant's framing of the goal instead —
"you need to stop a contractor from reaching the production cluster. Where would
you go?"

**One correct destination per task**, decided before you launch. If two branches
are both arguably right, that ambiguity is a finding — but decide in advance how
you'll score it, or you will decide after seeing the data, which is a different
thing.

**Write tasks as goals, not as categories.** "Where would you find billing
information?" tests whether they can match a word. "Your team's invoice is
higher than last month and you want to see what changed" tests whether the
structure supports the actual job.

**Cover the whole tree, not just the contested branch.** Tasks clustered on the
part you are worried about tell you nothing about whether your fix pushed the
problem somewhere else.

**Test the current structure alongside the proposed one** where the decision is
whether to restructure. An absolute success rate on a new tree is hard to
interpret; a comparison against the existing one is not.

## Sample size

30–50 per tree is the working range for stable rates; you can read directional
signal at 15–20 but should say so. Per tree, not total — testing two structures
means two samples. Confirm against a primary source before a number goes in a
plan.

## Analysis note

Three measures, read together:

- **Success** — did they reach the right place
- **Directness** — did they get there without backtracking, which separates "knew
  it" from "found it eventually"
- **First click / wrong turn** — where the failures went

The four combinations are the actual finding. High success with low directness
means the label is findable but not obvious. Low success with high directness is
the dangerous one: people are confidently going somewhere else, which means a
competing label is winning, and adding signposting will not fix it.

## Common failure

Reading the failure rate as a prediction of live performance and putting it in a
readout without the caveat. The method strips away everything that helps people
in production. The comparison between trees is trustworthy; the absolute number
is not.
