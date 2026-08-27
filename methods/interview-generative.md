# Generative 1:1 interview

> **Maintainer:** Kirsten Hosic · **Last reviewed:** 2026-08 · **Status:** current
>
> Format: [`../METHODS.md`](../METHODS.md). Shared question rules: `EVALUATION-LOOP.md` §4.6.

**One sentence:** A semi-structured conversation with one person at a time, used
to understand how they work, what they are trying to accomplish, and where the
current world gets in the way.

## What it can tell you

- How someone describes their own workflow, and what they treat as normal
- What they were trying to accomplish in a specific past episode, and what they
  did about it
- The vocabulary they use, which is rarely the product's vocabulary
- Where a mental model diverges from the system's model — the single most
  valuable thing this method surfaces
- What they consider a problem worth solving, in their own priority order

## What it cannot tell you

Use this verbatim in the plan's methodology section.

- **What people actually do.** Every answer is self-report, filtered through
  recall. A specific past instance is better-quality self-report than a
  prediction; it is not observation.
- **Frequencies, durations, or counts.** Nobody's memory holds "about four times
  a week" reliably. If a number is load-bearing, instrument it.
- **What someone will do with something that does not exist.** Reactions to a
  concept are stated preference. That is a concept test, and it is a different
  file.
- **Prevalence.** Eight interviews tell you a pattern exists among eight people.
  They do not tell you how common it is.
- **Anything the participant is not the right person to know.** An operator can
  describe what they configured; they are guessing about what the developers
  downstream experienced.

## Session shape

| Section | Time (60 min) | Purpose |
|---|---|---|
| Warm-up | 5–8 min | Rapport and orientation. Not data collection. Explain that they are the expert, thinking aloud helps, and "I don't know" is a real answer |
| Context | 8–12 min | Their role, scale, constraints, who else is involved. Unprimed — no stimulus, no feature names |
| Core | 30–35 min | One cluster per topic, each entered through a specific past instance |
| Stimulus reactions, if any | 5–8 min | Last, always. Labeled as stated preference |
| Wrap-up | 5 min | "What haven't I asked that I should have?", referrals, next steps |

## Counts

Rule of thumb. Assumes substantive open questions with probes, a participant who
talks most of the time, and a moderator who follows the conversation rather than
the page.

| Session length | Main questions | Per topic area |
|---|---|---|
| 45 min | 6–8 | 8–10 min |
| 60 min | 8–12 | 10–15 min |
| 90 min | 12–17 | 12–18 min |

**A guide with more questions than the time allows does not run long — it runs
shallow**, because the moderator cuts probes to make up time and the probes were
where the data was. Cut questions, not conversation.

Target: the participant talks roughly 90% of the time. If a transcript shows
otherwise, the guide or the moderation is the problem, not the participant.

## Instrument craft

**Open every main question with TED+W** — Tell me about, Explain, Describe, Walk
me through. This is the TED convention from investigative interviewing (the UK
PEACE model), where open prompts are used to obtain a free narrative before any
probing; "walk me through" is the workflow-research extension. It is a positive
rule rather than a prohibition, which is why it is worth having: it tells a
drafter what to write, not only what to avoid.

**Probe every subjective or evaluative word.** These mean different things to
different people and must never pass at face value:

> *easy · hard · simple · complex · confusing · obvious · intuitive · seamless ·
> clunky · messy · fine · frustrating · annoying · overwhelming · straightforward*

The probe is "explain what you mean by ___" or "describe what that looked like."
Every guide should carry this list in its moderator reminders.

**Carry a probe bank**, not a probe per question. Written into the guide, drawn
on anywhere: *tell me more about that · what happened next · what were you
expecting there · in what sense · how so.* Two techniques worth naming in the
reminders because they are hard under pressure — mirroring (repeat their last
few words back as a statement, then stop) and waiting three seconds after they
finish before responding.

**"Why" splits two ways, and the guide should reflect it.** "Why did you choose
that approach?" asks someone to explain their own decision process, which returns
a plausible theory rather than a cause. "Why?" as a probe on a story already in
play invites elaboration and is good interviewing. Write the first out of the
guide; keep the second in the probe bank.

**Never ask the participant to design.** "What would you change?" outsources the
job to someone with no view of the constraints. Ask what got in the way.

## Sample size

Rule of thumb, per segment rather than total: 5–8 per segment surfaces the
dominant patterns; 10–15 per segment for a segment you intend to make decisions
about on its own. Two segments at n=5 is ten sessions, not five. Confirm against
a primary source before putting a number in a plan.

## Analysis note

Codes at the level of meaning, not topic. "Auth methods" is a topic; "participants
treat auth methods as a permissions system rather than a method choice" is a
code. Expect the good material to come from the wrap-up question and from
whatever the participant raised that you did not ask about.

## Common failure

The guide is fine and the session is not, because the moderator filled a silence
with a hypothesis. No document review catches this. The countermeasures are the
moderator reminders block, a pilot session, and reviewing one recording against
the guide before the rest of the sessions run.
