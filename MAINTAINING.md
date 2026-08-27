# Maintaining this repo

Upkeep notes for whoever edits the agents, skills, and rubrics. Nothing here is
needed to *use* them — that's [`README.md`](README.md).

---

## Test fixtures live in a separate repo

Before you change a gate, a rubric, or `EVALUATION-LOOP.md`, run the fixtures in
[kirstenhosic/UX-Research-Skills-testing](https://github.com/kirstenhosic/UX-Research-Skills-testing).
`gate-fixture/` is the one that came from here: 13 planted defects, an answer key,
and named controls that must not trigger. It's what caught the safety-scan ordering
flaw.

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

The `RELEASE GATE` block names every gate in order. Adding or removing an
evaluator means editing that block in all six scenario files, the gate matrix in
`EVALUATION-LOOP.md` §3, the gate table in the agent, and the checker table in
`README.md` — five places, and the drift check below only catches the first.

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

## Two gates read the discussion guide, and the split is load-bearing

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

---

*Part of the Dr. Morgan UX research suite. Author: **Kirsten Hosic**, UX Research
Strategy Lead, Security Product Design.*
