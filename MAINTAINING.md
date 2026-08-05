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
reading — the scenario list in its opening paragraph and its closing sync note are
the two places that go stale first.
