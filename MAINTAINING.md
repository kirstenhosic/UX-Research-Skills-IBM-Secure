# Maintaining this repo

Upkeep notes for whoever edits the agents, skills, and rubrics. Nothing here is
needed to *use* them — that's [`README.md`](README.md).

---

## Test fixtures live in a separate repo

Before you change a gate, a rubric, or `EVALUATION-LOOP.md`, run the fixtures in
[kirstenhosic/UX-Research-Skills-testing](https://github.com/kirstenhosic/UX-Research-Skills-testing).
Two of them came from here.

`gate-fixture/` covers the synthesis loop: 15 planted defects, an answer key, and
named controls that must not trigger. It's what caught the safety-scan ordering
flaw — and on a later run it caught two errors in its own answer key, which is the
outcome §7 of `EVALUATION-LOOP.md` tells you to expect. When a gate disagrees with
the key, check the corpus before recording a score.

`survey-fixture/` covers `research-survey-checker` and §4.7: a 28-item instrument
with 48 planted defects, the plan context needed to score them, and a decoy
discussion guide the gate must refuse by name. Its controls include the two items
where the correct answer is a judgment rather than a verdict — the don't-know pair
and the reverse-coded grid row — and a Part 8 check that the gate reviews the
instrument rather than escalating on its defect density. Building it surfaced
five ambiguities in §4.7, the gate, and §2's verdict schema, all listed in
`survey-fixture/README.md`. **Two are closed** — §2 now carries `NOT_APPLICABLE`
and `ROUTE`, and §4.7 item 32 now states that an unmodified standardized
instrument is exempt from the general scale rules. Both were closed because three
runs converged on something no document said. **Three remain open**, and all three
are severity or scope questions the runs disagreed with each other about, which is
why they are still open.

On its first blind run `survey-fixture/` caught all 41 defects then keyed — and
found seven more that were in the instrument and not in the key, plus three broken
controls. Third time a fixture here has found the fault in its own key.

The second run was fielded as **two independent instances on identical text**, and
is the suite's cleanest variance measurement to date. The core held three for
three — the don't-know pair, the Part 8 conditions, the items-in-no-cut list, and
every blocking defect. The edges did not: one item drew a flag, a block, and
silence across three runs. Run it the same way when you need a variance read, and
expect blocking counts to differ by a few without either run being wrong.

Neither fixture has had an adversarial read. Both were built from the rubrics they
score against, by the person who wrote them, so a clean run says the specification
is internally consistent and nothing about whether it is right.

## Product context lives in one place

`product-context/` holds one file per product; `PRODUCT-CONTEXT.md` is the
format and the rules. Dr. Morgan resolves context in a fixed order — a file, then
the IBM Secure default, then a five-question intake, then nothing — and the
`## PRODUCT CONTEXT` section of the agent is the only place that order is
written down.

`product-context/ibm-secure.md` is **mirrored** into the agent, for the same
reason the scenario files are self-contained: a pasted agent has no file access,
and the default context has to survive being pasted. Change one, change the
other. The agent's copy is condensed — personas, workflows, and recurring
themes; the file carries the vocabulary table, recruitment reality, and the
known gaps.

New product files need no code change. They are found by listing the directory.

## Method context lives beside it

`methods/` holds one file per method; `METHODS.md` is the format. Same resolution
pattern as product context — file, nearest neighbour, generic-and-said-so — and
the same rule that it never lowers a bar.

The constraint that keeps this from becoming forty duplicated files: **a method
file carries only what differs by method.** Question craft, the behavioral bar,
sequencing, probing, and the gates are shared and are defined once, in the agent
and in `EVALUATION-LOOP.md` §4.6 — or §4.7 for a self-administered instrument. If
you catch yourself writing the same rule into two method files, it belongs in
neither; lift it to whichever of those two sections covers that instrument mode.

Two fields are load-bearing downstream. `what it cannot tell you` is written to
be pasted into a plan's methodology section, because `plan-reviewer` blocks a
plan that doesn't name its method's blind spot. `counts` is quoted by whichever
instrument gate covers the method — `guide-checker` as a cross-check on session
timing, `survey-checker` as a cross-check on completion time — and overrides the
generic ranges in §4.6 item 27 and §4.7 item 26 respectively.

Unlike product context, no method file is mirrored into the agent. The agent
carries the resolution order only. A pasted Dr. Morgan therefore has the rigor
rules and none of the operational numbers, and is instructed to say so rather
than invent them.

## What is deliberately not product-specific

`DOMAIN CHALLENGES TO ALWAYS RAISE` in the agent holds only challenges that are
true on every product — the configurer/daily-user split, interrogating
"confusion," constraints during the session, deployment scale. Anything true only
of IBM Secure belongs in `product-context/ibm-secure.md` instead. When you add a
challenge, decide which it is before deciding where it goes; a product-specific
rule in the universal block is invisible to the next team that adopts this, and
it will quietly mislead them.

Scenario B's three recruitment constraints are the IBM Secure team's and are
overridden by a `recruitment reality` section in any product context file.

## Consistent persona and format

Every file uses Dr. Morgan and the same plain instruction opener
(`For this conversation, you are Dr. Morgan…`).

## Keep the agent in sync

`agents/dr-morgan.agent.md` embeds condensed copies of each scenario, so a change
to a standalone file needs mirroring into the agent. Or treat the agent as
canonical and regenerate the standalones. They will drift otherwise.

## Shared blocks are duplicated on purpose

Each scenario file has to be self-contained so it can be pasted into a chat alone,
which means the `OPERATING PRINCIPLES` block (calibrate to experience · Coach/Draft
modes · never fabricate data · never fabricate sources · protect participant data)
is repeated verbatim in every skill file. That's the cost of portability. When you
edit that block, mirror it to all skill files, or pick one as canonical and
regenerate the rest. Same goes for the `RELEASE GATE` / `REVISION PROTOCOL` /
`COVERAGE` / `VOICE` block appended to each one.

**Widening the verdict schema is a nine-file edit.** The `result` and
`next_action` enums in §2 of `EVALUATION-LOOP.md` are repeated verbatim in the
output-format block of all seven agents, and `README.md`'s glossary row spells
them out in prose. Adding `NOT_APPLICABLE` and `ROUTE` touched all nine. The
scenario files do not carry the enum, so neither drift check sees this edit —
grep for `PASS_WITH_FLAGS` and confirm the count before and after.

The `RELEASE GATE` block names every gate in order. Adding or removing an
evaluator is the most expensive edit in this repo, and the drift check below
only catches the first item on this list. Adding `research-survey-checker` took
all of it:

1. The `RELEASE GATE` block in all six scenario files, byte-identical
2. The gate matrix in `EVALUATION-LOOP.md` §3, and its preamble sentence, which
   counts the evaluators
3. The evaluator table in §3, whose heading also counts them
4. A new Definition-of-Done section in §4, and a `Why <x> gets its own gate`
   subsection in §3 explaining why the work didn't go into an existing gate
5. §7, if the new gate closes a known limit — and §7 gets the new gate's own
   limits in the same pass, because a gate that ships without them is the thing
   §7 exists to prevent
6. §8's quick-reference sequences, and the sentence in §9 that counts agents
7. The gate table in `agents/dr-morgan.agent.md`, its "N separate agents do the
   checking" line, the drafting guidance for that artifact type, and the count in
   its maintenance note
8. The checker table in `README.md`, its heading and the two cross-references to
   that heading by anchor, the mermaid gate node, the principles bullet, and the
   glossary's `gate` and `artifact` rows
9. The neighbouring gates' `What you are blind to` sections, in both directions —
   a new gate that nobody hands work to never runs
10. `METHODS.md`'s instrument-gate table, and the `Gating` note at the top of any
    `methods/` file the new gate now covers
11. `CITATION.cff`, whose abstract counts them too

Grep for the count words before you commit — `six`, `seven`, `five separate` —
because every one of them is a claim about the suite that goes stale silently.

Quick drift check, run from the repo root. Each block should report `OK`, and the
file names beside each hash make a mismatch diagnosable:

````
check() {
  echo "--- $1"
  for f in *.md; do
    b=$(awk -v s="$1" -v e="$2" 'index($0,s)==1{p=1} e!="" && index($0,e)==1{p=0} p' "$f")
    [ -n "$b" ] && printf '%s  %s\n' "$(printf '%s' "$b" | md5)" "$f"
  done | sort > /tmp/_d
  cat /tmp/_d
  n=$(cut -d' ' -f1 /tmp/_d | sort -u | wc -l | tr -d ' ')
  [ "$n" = 1 ] && echo "    OK — identical across $(wc -l < /tmp/_d | tr -d ' ') files" \
                || echo "    DRIFT — $n variants"
}
check 'OPERATING PRINCIPLES (apply throughout' 'MENTORING RULES'
check 'RELEASE GATE (apply to every artifact' ''
````

Literal prefix matching, no regex, no GNU-only flags. It runs as-is on macOS.

This covers the six standalone scenario files only. `agents/dr-morgan.agent.md`
carries the same guidance in markdown rather than plain text, so it can't be hashed
against them. It's the file most likely to drift, and it has to be checked by
reading — the scenario list in its opening paragraph, the embedded IBM Secure
product context, and its closing sync note are the places that go stale first.

## Three gates read an instrument, and the splits are load-bearing

`research-plan-reviewer` holds the research questions and maps coverage in both
directions. `research-guide-checker` never sees them and reads the guide as a
conversation — question craft, behavioral versus hypothetical, repetition,
sequence. Neither reaches into the other, and each names the other in its own
"what you are blind to" section.

That split is easy to erode: the next person who notices the guide checker can't
tell scope creep from a missing research question will be tempted to hand it the
research questions. Don't. Two gates ruling on the same object is how they start
contradicting each other, and it was the reason for the split in the first place
— `plan-reviewer` used to hold both standards and applied whichever it reached
first. The rationale is written up in `EVALUATION-LOOP.md` §3, under *Why a guide
gets its own gate*.

`research-survey-checker` is the third, and it divides on a different axis:
**instrument mode, not artifact family.** A guide is read as a conversation with
a moderator in it. A survey is read as a document answered alone, where nothing
gets clarified and nobody notices a blank look. That is why widening
`guide-checker` to cover questionnaires was the wrong fix — the rules genuinely
differ, and only two cross over (no leading or presupposing items, no
double-barreled ones), which §4.7 names rather than restates.

Each gate refuses the other's artifact explicitly and by name. Keep that: a gate
that silently reviews the wrong instrument type produces findings that are
confident, specific, and wrong, which is worse than no gate. `guide-checker`
refusing a survey is the behavior, not a gap.

---

*Part of the Dr. Morgan UX research suite. Author: **Kirsten Hosic**, UX Research
Strategy Lead, Security Product Design.*
