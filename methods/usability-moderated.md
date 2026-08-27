# Moderated usability test

> **Maintainer:** Kirsten Hosic · **Last reviewed:** 2026-08 · **Status:** current
>
> Format: [`../METHODS.md`](../METHODS.md). Shared question rules: `EVALUATION-LOOP.md` §4.6.

**One sentence:** A participant attempts realistic tasks with a product or
prototype while a moderator observes, to find where the design fails people.

## Establish which kind this is before writing anything

These are two different studies that share a name, and the session structure is
not compatible between them. If a request says "usability testing" without
qualifying it, ask.

**Quantitative usability test** — measures effectiveness, efficiency, and
satisfaction. The participant works mostly in silence; you observe and record.
Use when you need numbers to benchmark or to prove a regression. Requires
complete, navigable flows.

**Qualitative usability test** — gathers experiential feedback on a design that
is not finished. Closer to a structured reaction session than a measurement.
Uses TED+W questions rather than scored tasks. Use when the team needs direction,
not performance data.

Deciding question: *is this high-fidelity with flows the participant can actually
complete, or mid-fidelity where the team wants direction?* Running the
quantitative structure on a mid-fidelity prototype produces numbers that describe
the prototype's incompleteness.

## What it can tell you

- Whether people can complete a task, and where they stop
- What they expected to happen at the moment it did not
- Which parts of a flow generate errors, backtracking, or hesitation
- Where the product's language and the participant's diverge, under load
- (Quant only) Task success, time on task, error counts, and standardized
  satisfaction scores against a benchmark

## What it cannot tell you

Use this verbatim in the plan's methodology section.

- **Preference between designs.** Whichever one they saw second benefits from
  what they learned in the first. That is a different study design.
- **Whether anyone wants the thing.** A task someone completes flawlessly may be
  a task nobody would ever choose to perform.
- **Behavior outside the session.** The participant is doing your task, in your
  window, while being watched. Real work has interruptions, stakes, and
  colleagues.
- **Statistical significance at typical sample sizes.** Small-n differences are
  directional. Report intervals, not point estimates.
- **Why they did it**, beyond what they say in the moment — and what they say in
  the moment while being observed is its own artifact.

## Session shape

| Section | Time (60 min) | Purpose |
|---|---|---|
| Warm-up and setup | 5 min | Rapport, consent and recording, screen-share check |
| Orientation | 3–5 min | What they will see, that you did not build it, that you want their honest reaction, that any trouble is the design's fault |
| Pre-task context | 5 min | Their relevant experience — unprimed, before any screen is shown |
| Tasks | 30–35 min | One at a time. Post-task question after each, if using one |
| Post-session | 5–8 min | Overall reactions, SUS or equivalent if quantitative |
| Wrap-up | 3–5 min | Anything missed, thanks, next steps |

## Counts

Rule of thumb. Assumes tasks of moderate complexity and a moderator who does not
intervene early.

| Session length | Tasks |
|---|---|
| 45–60 min | 5–7 |
| 90 min | 8–12 |

Confirm with a dry run before real sessions. Task count is the estimate people
get wrong most often, in the optimistic direction.

## Instrument craft

**Every task needs four things before it is written:**

1. **A user goal** — what the person wants at the end. Start here, not from the
   control you want exercised.
2. **Context** — a realistic reason to care. Lean, not fiction.
3. **The information they need** — dates, names, values. Do not make them invent
   inputs; you will measure their invention.
4. **A reachable end state** — a clear "done." If you cannot define it, the task
   is not ready, and if the prototype cannot reach it, the task is not runnable.

Then write it as one or two plain sentences in second person.

**Task-wording rules:**

- **Never use the interface's own words.** If the button says "Rotate," the task
  says "change the credential" — otherwise you are testing reading, not finding.
- **Never presuppose they would want to do it.** A task that assumes the goal is
  the task-shaped version of a leading question.
- **No loaded language.** "Find the best option" and "take advantage of the
  discount" both pre-load the answer.
- **No elaborate backstory.** Two sentences. Long scenarios get skimmed, and the
  detail you needed is the part they skipped.
- **Avoid emotionally charged framing** — health, money troubles, bereavement,
  family occasions. It costs you rapport and buys nothing.

**In a quantitative session, do not probe during tasks.** Interrupting changes
the time on task you are recording and prompts a participant who was about to
recover. Save it for the post-task question or the debrief. In a qualitative
session the opposite holds: the probing is the data.

**Metrics, if quantitative.** Task success (binary, or three-point to record
struggle), error count, time on task (start when they begin reading, stop at end
state or abandonment), SEQ after each task, SUS at the end. Benchmark SUS against
≈68 as the published average — a rule of thumb with assumptions, not a threshold.

## Sample size

Per segment, never total. 5 per segment is the working minimum for a moderated
qualitative test; 10–15 per segment if the segment carries a decision on its own.
Unmoderated quantitative wants 15+ per segment, because the data arrives messier
and some of it is unusable.

## Analysis note

A stoplight grid reads faster than prose for task-level results: participants as
columns, tasks as rows, green / amber / red per cell, with time in the cell for a
quantitative run. Put the grid next to the three findings that explain it — the
grid shows what happened, and only the findings say why it matters.

## Common failure

The team reads task failure as user confusion. Interrogate the design first:
with senior technical practitioners, someone who administers production
infrastructure is not confused by a well-built interface. The finding is about
the product until the evidence says otherwise.
