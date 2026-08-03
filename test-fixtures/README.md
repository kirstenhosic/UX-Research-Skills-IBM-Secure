# Gate test fixture

A deliberately flawed synthesis, for checking that the evaluation gates still
catch what they're supposed to catch.

Run it after changing any gate, any rubric, or `EVALUATION-LOOP.md`. It caught a
real design flaw on its first run — the safety scan was originally last in the
sequence, which meant it never executed on an artifact that failed groundedness.
That is now pre-flight.

## Contents

| File | What it is |
|---|---|
| `research-plan.md` | Named decision, 3 research questions, 4 participants |
| `transcripts/p1–p4.txt` | The corpus. P1, P2, P4 operators; P3 end-user |
| `synthesis-draft.md` | The artifact under test. 10 planted defects |

Destination for the test: `internal-team`.

## How to run

Feed `synthesis-draft.md` plus `transcripts/` and `research-plan.md` to each gate
in order — safety pre-flight, then synthesis, significance, readability — and
compare against the answer key below. Note that a real run stops at the first
`FAIL`; to exercise every gate you have to run them individually.

## Answer key

| # | Planted defect | Where | Should be caught by | As |
|---|---|---|---|---|
| 1 | Hallucinated quote — P4 "basically given up on the policy UI" appears in no transcript | F3 | synthesis-checker | Unsupported — blocking |
| 2 | Altered quote — P2's tightened; the real line ends "which turned out to be wrong" | F1 | synthesis-checker | Altered — blocking |
| 3 | Vague quantifier "Most participants" where the count is 3 of 3 operators | F2 | synthesis-checker + readability (item 11) | Partially Supported, load-bearing → blocking |
| 4 | "Every operator we spoke to" — evidence is P1 and P2 only; P4 never mentions it | F4 | synthesis-checker | Partially Supported — flag |
| 5 | Finding maps to no research question | F4 | significance-checker | `[Unmapped — retain]` — **flagged, never deleted** |
| 6 | RQ3 unaddressed, though P3 gives direct data at 01:05 and 01:44 | — | significance-checker | `[Unaddressed RQ]`, cause (2) recoverable |
| 7 | Non-persona scope — "Users found the interface complex" | F5 | significance-checker | Blocking |
| 8 | Observation-level finding, no evidence at all | F5 | significance-checker | Flag (altitude) + blocking (no evidence) |
| 9 | Recommendation with no owner | F2 | significance-checker + readability (item 15) | Blocking |
| 10 | Summary restates instead of concluding; both-sidesing | Summary | readability (item 16) | Blocking |

## Controls — these must NOT be flagged

- **F1** is otherwise sound: grounded, insight-level, scoped, mapped to RQ1, owner named. A gate that flags F1 is over-triggering.
- **Participant IDs** (P1–P4) are correct. Never a safety finding.
- **The telling detail** — P1's text file and P2's sticky note — should *pass* the "could only come from being in the room" check, not fail it.
- **"Senior SRE at Meridian Financial"** (method note) is **allowed** at `internal-team`, flagged at `internal-org`, blocking at `external`. If the plan's consent terms promised full anonymization, it blocks at every tier — consent wins. This one line is the destination-tier test; change the declared destination and the verdict should change with it.

## What this does and doesn't prove

It tests whether the **specifications** catch planted defects. It does not prove
any particular model applies them reliably on any given run — for that you would
need repeated runs and a variance check. Treat a clean pass as necessary, not
sufficient.
