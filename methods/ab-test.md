# A/B test

> **Maintainer:** Kirsten Hosic · **Last reviewed:** 2026-08 · **Status:** current
>
> Format: [`../METHODS.md`](../METHODS.md).

**One sentence:** A controlled online experiment splitting live traffic between a
control and one or more variants, to measure whether a change moves a metric.

**Gating — this one sits outside the current loop.** An A/B test has no
discussion guide, no participants you recruited, and no transcript, so
`guide-checker` doesn't apply and there is no gate for an experiment design. The
findings that come out are gated normally — `synthesis-checker`,
`significance-checker`, `readability-checker` — but the design that produced them
is not reviewed by anything here. Have a second person read the hypothesis, the
metric, and the sample-size calculation before you launch. That is the gap, and
it is worth knowing rather than assuming coverage.

## What it can tell you

- Whether a specific change causes a change in a specific metric, at scale, in
  real conditions with real consequences. This is the only method in this
  directory that establishes **causation**
- The size of that effect, with an interval around it
- Whether an effect holds across segments, when the test is powered for the cut
- That a change you were confident about does nothing, which is its most common
  and most useful result

## What it cannot tell you

Use this verbatim in the plan's methodology section.

- **Why.** You get a number and no explanation. An A/B test tells you the door on
  the left gets used more; it will never tell you what people thought the doors
  were for. Pair it with qualitative work or you will ship a win you cannot
  reason about or repeat.
- **Anything about a change nobody encounters.** Low-traffic surfaces cannot be
  tested this way in any reasonable timeframe, and most enterprise infrastructure
  workflows are low-traffic surfaces.
- **Long-run effects.** A two-week test measures two weeks. Novelty inflates
  early results and habituation deflates them.
- **What to build.** It compares options someone already thought of. It is
  evaluative to the core and generates nothing.
- **Anything, if the sample size was decided after seeing the data.** Stopping
  when the result looks good is how a coin flip becomes a statistically
  significant finding.

## Design shape

| Step | Detail |
|---|---|
| Hypothesis | Written before anything else, in the form: because we observed X, we believe changing Y will cause Z, measured by M |
| Variable | **One.** Change two things and you learn that something worked |
| Primary metric | One, chosen in advance, tied to the decision. Guardrail metrics named alongside it |
| Sample size and duration | Calculated in advance from the baseline rate and the smallest effect worth acting on. Fixed before launch |
| Assignment | Random, and split evenly. Randomised at the level of the person, not the session, or the same user sees both |
| Run | To the pre-registered end. No peeking-and-stopping |
| Decision | Ship, kill, or iterate — written down before launch for each outcome |

## Counts

There is no question count. The number that matters is **duration**, and it has a
floor independent of traffic: run at least one full business cycle — typically
two weeks — so that weekday/weekend and start/end-of-sprint patterns are
represented in both arms. A test that reaches significance in three days should
still run the fortnight.

## Instrument craft

**Write the hypothesis first, and make it falsifiable.** "We think the new
onboarding is better" is not a hypothesis. "Because 6 of 8 operators failed to
locate the policy step, we believe surfacing it in the primary nav will increase
first-week policy creation, measured by the share of new workspaces with a policy
in seven days" is.

**Pick the smallest effect worth acting on, before the calculation.** Sample size
falls out of that number. Choosing it afterwards is how a test gets sized to be
convenient rather than conclusive.

**Name guardrails.** The metric you are moving is not the only one that can move.
Decide in advance what you will not accept as collateral — error rates, support
volume, time to complete an adjacent task.

**Pre-register the decision rule.** What ships if it wins, what happens if it
loses, and what happens if it does nothing. Written before launch, this takes
five minutes; written after results, it takes a week of argument.

**Treat a null result as a result.** It is evidence that the thing you were sure
about does not matter, which is genuinely valuable and routinely buried.

## Sample size

Calculated, never estimated. It depends on the baseline conversion rate, the
minimum detectable effect, the significance level, and the power you want.
Enterprise products frequently cannot reach it — that is a legitimate finding
about the method's fit, and the right response is a different method, not a
smaller threshold. If the arithmetic is load-bearing, have a statistician or a
primary source check it rather than eyeballing it.

## Analysis note

Report the effect size with its interval, not just whether it cleared a
threshold. Statistical significance and practical importance are different
questions: at large n a trivial difference is significant, and at small n a
substantial one is not detectable. Say which you have.

## Common failure

Running it in place of the qualitative work rather than after it. A test can
tell you B beats A among the options someone happened to draft. It cannot tell
you that the whole framing was wrong, and it will happily deliver a measured,
significant, permanent improvement to the wrong thing.
