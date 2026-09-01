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

`adversarial-reads/` holds the hostile-read transcripts cited below — one per
rubric section, named `<section>-<month>.md`. They are the evidence for the §4.6
and §4.7 changes recorded here, and they live there rather than in this repo
because they carry the fixture text the reads were run against. Cite them by
filename; a claim in this file that rests on a read nobody can open is the thing
`FINDINGS-CONTRACT.md` exists to prevent, applied to the repo's own record.

`survey-fixture/` covers `research-survey-checker` and §4.7: a 28-item instrument
with 48 planted defects, the plan context needed to score them, and a decoy
discussion guide the gate must refuse by name. Its controls include the two items
where the correct answer is a judgment rather than a verdict — the don't-know pair
and the reverse-coded grid row — and a Part 8 check that the gate reviews the
instrument rather than escalating on its defect density. Building and running it has
surfaced thirteen ambiguities in §4.7, the gate, and §2's verdict schema, all
listed in `survey-fixture/README.md`. **Eight are closed** — §2 now carries `NOT_APPLICABLE`
and `ROUTE`, §4.7 item 32 now states that an unmodified standardized
instrument is exempt from the general scale rules, item 21 states how far priming
contamination runs, item 12 is settled as a **flag** at every tier, item 32
**does not step down at the internal-pulse tier**, the two §4.6 carryovers **do**,
item 2's exception preserves severity rather than promoting it, and item 28's
incoherent-reachability clause **is not confined to branching**. Five closed the
same way: independent runs converging on something no document stated. Three did
not, and the differences are worth keeping — see below.

**Five remain open, and all five live at the internal-pulse tier**, which was
specified in three documents and fielded in none of them until 2026-08-31. Run
variant 1 finally put it to a gate — `survey-fixture/survey-plan-pulse.md`, the
plan with the declared type changed and nothing else — in two independent
instances. The tier behaved: every wording defect stepped down, routing and order
held in both. Item 32 **blocked in both**, unhedged, which closed the ambiguity it
was run to close; item 32 is now on the gate's exception list and §4.7 says it does
not step down.

Fielding the tier once closed one ambiguity and opened four, which is what the
first run of an untested branch should be expected to do. One of those four is now
closed: §4.6's carryover items had no stated pulse behavior at all, and both
instances stepped them down while volunteering it as the call they were least sure
of. **They step down, and both files now say so.** "In any mode" says what it
always meant — a moderated guide or a self-administered instrument, not a severity
tier — and the reason is stated: the exception list is not every rule that yields a
number, it is the three whose numbers travel under a name or a benchmark.

That one closed differently from the other five, and the distinction matters for
how the next one gets closed. The others closed on runs converging on something no
document stated. Here the runs converged on a *default* the silence pushed them
into, which is weaker evidence, so it was settled on the principle behind the rule
with the runs as corroboration. §4.6 item 2's self-answering half is named in both
files as the case to reopen if a later run argues it.

A third instance was fielded on 2026-08-31 against the same variant, to verify the
first of those fixes and break the second. **It did both.** It flagged the two
agree/disagree items and quoted the corrected exception to say why, adding that it
had not promoted anything — the fix is now verified in the output and not only in
the document. It blocked the destroyed referent under item 28, making it two of
three, and named the reason that clause is hard to find: it sits inside an item
titled "Skip logic reaches every item it should," illustrated only from the
skip-logic side. §4.7 item 28 and the gate now say incoherent reachability is not
confined to branching. **That run also missed a keyed blocking defect the other two
caught** — the textbook branch case, an open text asking what made a rotation
necessary of people who had just said they never rotate — so the gate names both
directions, because widening an item is exactly the edit that can cost its narrow
half.

Three instances of one instrument have now produced **three different blocking
sets** — 6, 7 and 8 — intersecting on five and uniting on all eight. Only one was
complete, and the two that were not missed different defects, neither a tier
effect. A single instance of this gate is not a measurement of it.

Still open: item 22 states an absolute with no severity attached, and so do twenty
other §4.7 items — three runs have inferred "flag" for all of them and all three
said they were defaulting. The pulse tier's "one level down" is defined for
blocking and undefined for a defect that is already a flag, which is worth roughly
fifteen flags between two conscientious runs and has been silently governing the
flag column for three of them. §4.7's own "reopen if a run argues it" clause on
self-answering items **has now been argued**, and leaving it fired invites the
divergence it exists to prevent. And the gate's Part 1 table carries the undefined
evaluative word, which is §4.6 item 11 — a rule §4.7 says does not carry over —
while all three runs found the defect it names.

On its first blind run `survey-fixture/` caught all 41 defects then keyed — and
found seven more that were in the instrument and not in the key, plus three broken
controls. Third time a fixture here has found the fault in its own key.

The fourth run is the first here to show what a single instance buys you. Its two
instances agreed on six blocking calls and split on two: one **missed a keyed
blocking defect** — Q2's overlapping bands, at a tier that does not touch that
item — and the other caught it and hit the predicted count exactly. Had only the
first been fielded, the record would show item 32 closing on one data point and a
miss reading as a tier effect. Field two.

The second run was fielded as **two independent instances on identical text**, and
is the suite's cleanest variance measurement to date. The core held three for
three — the don't-know pair, the Part 8 conditions, the items-in-no-cut list, and
every blocking defect. The edges did not: one item drew a flag, a block, and
silence across three runs. Run it the same way when you need a variance read, and
expect blocking counts to differ by a few without either run being wrong.

Both fixtures were built from the rubrics they score against, by the person who
wrote them, so a clean run says the specification is internally consistent and
nothing about whether it is right.

**§4.6 has now had one too** — `adversarial-reads/guide-4.6-2026-08.md` in the
testing repo. Five hostile contexts plus a refutation pass, with the
false-positive audit **split in two** so that one context wrote a guide to
professional standard and a different one scored it blind. The headline runs opposite to §4.7's: the defensible guide
drew **2 blocking and 12 flags**, not five blocking with none real. Five Tier 1
findings were fixed and verified the same day by a second blind scoring — §4.6
items 26 and 29, four rules the gate scored with no rubric item behind them (§4.6
gained items 31 and 32, stacked questions were pointed at item 3 which already
covered them, and the gate's Part 1 table gained a Rubric column naming the item
for every row), and a new item 30 for what the participant is told before
questions start, which nothing in the suite was asking on the standalone-guide
path. §4.6 went from 29 numbered items to 32, appended rather than inserted,
because items 2, 3, 5, 10, 11, 24, 25, 27 and 28 are cited by number elsewhere.

Two things that verification did **not** confirm, both worth carrying: the
blocking count fell from 2 to 1 on a call no fix touched — instance variance on
the guide gate, the first measured here, matching what both fixtures show — and
the live uncounted "absolute" that motivated a fifth new item was refuted by the
second run as a misclassification. **That item was added and removed the same
day**, along with its gate row: "have you ever" asks about a single occurrence,
which is the opposite of the self-flattering generalization the rule targets, so
it was left with a sound rationale and no observed instance. Removing it also
retired a §4.6/§4.7 item 32 collision. A rule this suite cannot show catching
anything does not stay in on the strength of sounding right. Also open, and the best-evidenced proposal the read produced:
**both blind runs independently argued that item 14 should permit an unbounded
instance request where the drafter states a base-rate justification and a dating
procedure.** Low-frequency events are the case it does not handle.

**§4.7 has now had an adversarial read** — `adversarial-reads/survey-4.7-2026-08.md`
in the testing repo. Four hostile contexts, plus a skeptic briefed to refute the
first one's claims. It found that item 25 is logically unsatisfiable, that item 23
dropped a carve-out §4.6 has, that item 21 carries a superlative and a blocking
verdict with no citation attached, that item 30 blocks on a yardstick item 26
disclaims, and that several citations do not support what rests on them — including
the don't-know framing in §4.7 item 14 and in §7. An instrument written to be
defensible fires 20 of 36 items and fails on five blocking calls, none of them real.
**All five Tier 1 findings are now fixed** — items 18, 21, 23, 25, 26, and 30 in
§4.7, the matching parts of the gate, and the counts table in `methods/survey.md`
— **and all five are verified** by a third blind run of two instances on identical
text, which returned the same 13 blocking and 29 flags both times. The first Tier 2
finding is fixed too: item 14 and §7 no longer describe the don't-know question as
one the literature has left open, because the work they cite does not leave it
open. The rule did not change — the justification did. The rest of Tiers 2
through 4 — the remaining citation problems, the items that fire on everything,
and the omissions — are open and ranked in that file.

**Editing §4.7 is a four-file edit.** The rubric, the gate that applies it,
`methods/survey.md` where the length conventions actually live, and
`survey-fixture/README.md`, whose answer key goes stale the moment a rule changes.
The item 25 fix moved a keyed defect from 13 items to 12; nothing would have caught
that but reading the key.

**§4.6 has not had one, and the read implicates it twice** — it contains zero
citations, and §4.7 item 21 claims to rest on "the same literature."

`gate-fixture/` has not had one either.

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

**The standalones are canonical; the agent follows them.** This is a decision,
not a preference — the README promises each standalone "goes deeper than the
agent's condensed copy," and that promise only holds in one direction.
`agents/dr-morgan.agent.md` embeds condensed copies of each scenario, so a
change to a standalone file needs mirroring into the agent — and an improvement
drafted in the agent first is not done until it has been written into the
standalone it condenses. They will drift otherwise, and the drift runs
backwards: the agent quietly becomes the richer file, and a researcher who
loads the "deeper" standalone drafts an artifact the suite's own gates flag.

**The guide-craft set is a greppable parity check.** TED+W, the always-probe
word list, and the moderator reminders block must appear together wherever
interview-guide craft is taught or audited: the agent (Scenario C),
`ux_plan_from_scratch.md`, `challenge_and_refine_plan.md`, `EVALUATION-LOOP.md`
§4.6, `agents/research-guide-checker.agent.md`, and the interview-shaped
`methods/` files. When you improve any of them, grep for `TED+W` and
`always-probe` and visit every hit before you commit — the same sweep as the
count words below.

## Shared blocks are duplicated on purpose

Each scenario file has to be self-contained so it can be pasted into a chat alone,
which means the `OPERATING PRINCIPLES` block (calibrate to experience · Coach/Draft
modes · never fabricate data · never fabricate sources · protect participant data)
is repeated verbatim in every skill file. That's the cost of portability. When you
edit that block, mirror it to all skill files, or pick one as canonical and
regenerate the rest. Same goes for the `RELEASE GATE` / `REVISION PROTOCOL` /
`COVERAGE` / `VOICE` block appended to each one.

**`rubrics/` is generated — never edit it.** Each file there is §2 plus one
§4.x of `EVALUATION-LOOP.md`, extracted verbatim by `./build-rubrics.sh` so a
checker session can carry its own rubric without the other six. Edit
`EVALUATION-LOOP.md`, run the script, commit both. The check is the same as
the `.skill` build: run it and confirm `git status` stays clean — a dirty
rubric after a rebuild means someone edited the excerpt instead of the source.

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

1. The `RELEASE GATE` block in all five scenario files, byte-identical
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

### The product-context spine, which wraps differently in every file

The five `PRODUCT CONTEXT` bullets are **not** byte-identical and should not be
made so. Each file wraps to its own width, and each appends its own tail: the two
analysis files add `Key workflows:` and `Common research themes:`,
`select_best_method.md` adds workflows only, `competitive_analysis.md` adds
`Key UI surfaces:`, and the two planning files carry personas alone. That
tailoring is deliberate — a plan file does not need recurring research themes to
write a screener.

What must not drift is the **spine**: the product one-liner and the personas
sentence, which every file carries and which `product-context/ibm-secure.md`
owns. It had drifted four ways before this check existed — Consul lost "across
hybrid environments" in three files, Terraform lost "via Sentinel" in two, Radar
lost "in real time" in two, and two files called it "HashiCorp Vault Radar."
None of it was visible to a byte-hash, because the wrapping differs anyway.

Whitespace-normalized, so wrapping doesn't matter:

````
spine() {
  for f in analyze_your_data.md ux_plan_from_scratch.md \
           challenge_and_refine_plan.md select_best_method.md \
           competitive_analysis.md; do
    miss=$(tr -s ' \n' ' ' < "$f" | grep -c "$1") 
    [ "$miss" = 0 ] && echo "    DRIFT — $f is missing: $1"
  done
}
spine 'service discovery across hybrid environments'
spine 'infrastructure as code with policy enforcement via Sentinel'
spine 'scanning continuously in real time'
spine 'surfacing detected risks by category and rank'
for f in analyze_your_data.md ux_plan_from_scratch.md \
         challenge_and_refine_plan.md select_best_method.md \
         competitive_analysis.md; do
  grep -q 'HashiCorp Vault Radar' "$f" && echo "    DRIFT — $f: product is 'Vault Radar'"
done
````

Silence is a pass. When you edit `product-context/ibm-secure.md`, add the changed
phrase here — this check only catches what it is told to look for, which is the
honest limit of it.

### `MENTORING RULES` is per-scenario on purpose — do not hash it

Six variants, and they should stay six. The planning files cite Portigal, Hall,
Fitzpatrick, Goodman, and Creswell; the analysis files cite Braun & Clarke,
Saldaña, Beyer & Holtzblatt, and Young. `challenge_and_refine_plan.md` adds
seniority-calibrated citation guidance that belongs nowhere else. A drift check
here would report six variants forever and train you to ignore it.

**The pair that used to need this check is now one file.**
`analyze_your_data.md` and `qualitative_data_analysis_skill.md` covered the same
activity at two strictness levels, and their book lists had already diverged —
the standard path cited Tullis & Albert and Sauro & Lewis for the quantitative
stage and the strict path cited neither. They were merged for that reason among
others, so there is no longer a pair to diff. If a second file ever covers an
activity another one already covers, diff their book lists before assuming the
difference was deliberate:

````
diff <(grep '📚' file-a.md) <(grep '📚' file-b.md)
````

Differences here are a decision, not automatically a defect — the strict path may
legitimately not need the quant references. What is a defect is the difference
arriving by accident, which is what happened.

This covers the six standalone scenario files only. `agents/dr-morgan.agent.md`
carries the same guidance in markdown rather than plain text, so it can't be hashed
against them. It's the file most likely to drift, and it has to be checked by
reading — the scenario list in its opening paragraph, the embedded IBM Secure
product context, and its closing sync note are the places that go stale first.

## §10 is advisory on purpose — don't promote it without evidence

The decision checkpoint records an answer and never blocks. That reads like an
oversight next to §9, which blocks by destination, and the temptation for the
next maintainer will be to "finish" it by giving it a dial.

It was a choice, and the reasoning is in §10 itself: the checkpoint fires before
fieldwork, when the team is keenest to start, and a blocking stop at that moment
gets routed around rather than answered. A recorded `not obtained` is worth more
than a stop everyone learns to bypass.

What would justify promoting it: a run of studies where `disposition: not
obtained` is the norm rather than the exception. That is measurable, and it is
the evidence to collect before changing this. If you do promote it, reuse §9's
destination dial — §9 says "don't add a second dial" and that still holds.

The corresponding risk in the other direction is that the four questions grow.
Four is already at the edge of what a stakeholder will answer in one message.
An owner who is asked eight questions answers none of them.

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
