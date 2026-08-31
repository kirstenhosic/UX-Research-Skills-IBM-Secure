# Survey

> **Maintainer:** Kirsten Hosic · **Last reviewed:** 2026-08 · **Status:** current
>
> Format: [`../METHODS.md`](../METHODS.md).

**One sentence:** A self-administered instrument answered without a researcher
present, used to measure how widely something holds across a population you
already understand.

**Gating — read this before you draft one.** The instrument goes to
`research-survey-checker`, scored against §4.7 of `EVALUATION-LOOP.md`. **Not**
`research-guide-checker`, which declares survey instruments out of scope
deliberately: question wording in a self-administered instrument answers to a
different literature (response scales, acquiescence, satisficing, item order
within a matrix), and applying the discussion-guide rubric to a survey gives
confident, wrong advice. Send it to the right one and say which it is.

The craft rules below are the operational half of that rubric. Two things the
gate cannot do for you, and both are named in every report it writes: it is not a
cognitive pretest, and it cannot see who answered or who didn't. Pilot it, and
have a second human read it — on this method more than any other, because you
only get one field.

## What it can tell you

- How widely something holds — prevalence, distribution, and the size of a
  segment
- Whether a pattern found in interviews generalizes, which is this method's best
  use in a mixed design
- Comparisons across segments, when each segment is separately powered
- Change over time, when the instrument is held stable between waves
- Self-reported frequency and satisfaction, with all the caveats that carries

## What it cannot tell you

Use this verbatim in the plan's methodology section.

- **Anything you didn't already know enough to ask.** A survey can only return
  answers to questions someone wrote in advance. It is an instrument of
  confirmation and measurement, not discovery — running one first, before any
  qualitative work, is the most common and most expensive mistake with this
  method.
- **Why.** Open-text boxes produce fragments from the minority of people who
  bother. That is not qualitative research; it is qualitative-shaped exhaust.
- **What people will do.** Stated intent again, with no moderator to probe it.
- **Anything from a sample you cannot describe.** Who answered, and who didn't,
  is the whole validity question, and a survey pushed to a channel of willing
  respondents measures the willing.
- **Nuance in an unfamiliar domain.** If you cannot predict the plausible answer
  set, you cannot write the options, and forced-choice options you invented
  become the finding.

## Session shape

There is no session. The equivalent design decisions:

| Component | Detail |
|---|---|
| Screener | The first questions, gating who continues. Keep short; it is where drop-off is highest |
| Warm-up | One easy, relevant question. Not demographics |
| Core blocks | Grouped by topic, one construct per block, most important first — attention decays through the instrument |
| Open text | One or two, late, and optional |
| Classification | Demographics and firmographics **last**, where they cost you nothing if abandoned |
| Close | Thanks, what happens next, recontact permission |

## Counts

Rule of thumb. Assumes a professional respondent answering unpaid.

| Target completion time | Questions |
|---|---|
| 3–5 min | 10–15 |
| 5–8 min | 15–20 |
| 8–10 min | 20–30 |
| 15 min+ | Expect meaningful drop-off and degraded quality in the final third |

Longer instruments do not fail by being abandoned so much as by being
straightlined — answered without reading, in a vertical column down the middle
option. Length is a data-quality decision, not just a response-rate one.

## Instrument craft

Beyond the universal rules (no leading, double-barreled, or presupposing
questions, which apply here too):

**Every question earns its place against a stated goal.** Write the analysis plan
first — what will you cross-tabulate against what — and delete any question that
appears in no planned cut. "Nice to know" questions are how a 5-minute survey
becomes 15.

**Match the scale to the construct and keep it consistent.** Mixing 5-point and
7-point scales in one instrument makes the results incomparable and the
respondent's job harder. Label every point, not just the ends.

**Offer "not applicable" wherever the item can be inapplicable.** Forcing a
choice there manufactures data, and it is the single most common way a survey
generates a finding about nothing.

**"Don't know" is yours to decide, item by item.** The intuitive rule is to
always offer a no-opinion out, and the evidence does not support it: no-opinion
options don't improve data quality and can discard real if weakly held attitudes,
because the people who take the out include the ones answering the whole
instrument as fast as possible. Think hard about it on attitude questions, where
that evidence lands. Offer it on knowledge questions — that half is our judgment
and not a finding; the evidence is about attitudes. `survey-checker` flags this
in both directions and blocks in neither, on purpose: the call is yours, not the
gate's.

**Balance the poles.** As many favourable options as unfavourable, worded with
matching intensity. An imbalanced scale is a leading question with numbers.

**Randomise option order** where the list has no natural sequence, and randomise
block order where blocks are independent — otherwise position becomes part of
the finding.

**Beware the matrix grid.** Long grids invite straightlining. Break them up.
Reverse-coding an item or two detects it, at the cost of confusing respondents
and introducing a method artifact of its own — a trade-off worth making
knowingly, not a default.

**Pilot it.** Ten people, watched or debriefed, before it goes out. Cognitive
pretesting exists as a discipline because reading a question is a bad predictor
of how it lands, and a survey cannot be re-run on the same population once
you've spent them.

## Sample size

Driven by the smallest segment you intend to report on, not by the total. A
survey with 400 responses and 11 people in the segment carrying the decision is
a survey with n=11. Decide the cuts before fielding, and if a segment cannot be
powered, say in the plan that it will be reported qualitatively or not at all.

## Analysis note

Report distributions before averages — a bimodal split and a moderate mean look
identical in a summary table and mean opposite things. Open-text responses are
qualitative data: code them, don't tally keywords. And report the response rate
and who is missing from it, every time; non-response is a finding about your
sample, not a footnote.

## Common failure

Running the survey first. A survey written before anyone has talked to a user
asks the questions the team already had, in the team's vocabulary, with answer
options the team invented — and returns a confident measurement of the team's
existing assumptions.
