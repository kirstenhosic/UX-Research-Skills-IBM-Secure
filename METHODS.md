# Method context

How Dr. Morgan gets operationally specific about *how a study is run*.

`PRODUCT-CONTEXT.md` answers "who are these people and what are they doing." This
answers "what does a good instrument for this method actually look like." They
are the two axes of a specific piece of advice, and the suite was thin on the
second one: it knew a great deal about whether a guide was *sound* and very
little about how many questions belong in a 60-minute session.

---

## How Dr. Morgan resolves method context

In order, stopping at the first that works:

1. **A file in `methods/`.** If the repo is connected and the method is named or
   detectable, that file supplies structure, counts, craft rules, and what the
   method cannot tell you. The directory listing is the menu.
2. **The nearest neighbour, declared.** No exact file, but a close one — a
   remote moderated concept test against `methods/concept-test.md`. Dr. Morgan
   says which file it is working from and what differs.
3. **Generic, and said out loud.** No file is close. The rigor rules still
   apply — they live in the agent and the gates, not here — but the operational
   numbers do not, and Dr. Morgan says so rather than inventing a task count.

**Method context never lowers a bar.** The gates, the safety tiers, and §4.6 are
identical whatever method is running. These files make the *draft* better; they
do not make the *check* easier.

## Why this is a directory and not more agent

Every scenario in Dr. Morgan applies to every method, and every method has
fifteen operational specifics that matter only to it. Multiplying those out and
putting the result inline gives you an agent nobody can read and a context window
spent on nine methods to answer a question about one.

The alternative some suites take — one self-contained skill per method — buys
that same depth and pays for it in duplication: the probing rules, the sample-size
guidance, and the question-craft standards get restated in every file, and drift
apart the first time one is improved. This directory carries **only what differs
by method.** Everything shared stays in the agent and in `EVALUATION-LOOP.md`,
defined once.

If you find yourself writing a rule into two method files, it belongs in neither.

## Not every method has a gate

The evaluation loop was built around instruments the gates can read: a plan, a
discussion guide, a survey instrument, a synthesis, a deck. One method in this
directory still falls outside it, and the file says so at the top rather than
letting a reader assume coverage.

| Method | Instrument gate | What still runs |
|---|---|---|
| Interview, usability, diary, concept test | `guide-checker` (§4.6) | Everything |
| Tree test | `guide-checker`, task rules only — the interview items don't apply | Everything |
| Survey | `survey-checker` (§4.7). Not `guide-checker`, which declares survey instruments out of scope on purpose: self-administered wording answers to a different literature, and the guide rubric would give confident, wrong advice on one | Everything |
| **A/B test** | **None.** No guide, no recruited participants, no transcript — there is no artifact of the shape the loop expects | Pre-flight safety, and the findings downstream |

There were two gaps here. The survey one was closed the way a gap like this has
to be closed — a separate gate with its own literature, `research-survey-checker`
against §4.7, rather than a widened `guide-checker` holding two standards for the
same word. The experiment gap is still open, and `methods/ab-test.md` carries the
craft standards instead. A second human reader matters more there than anywhere
else in the suite.

Say which case you are in when you hand something to a gate. A tree-test task set
sent to `guide-checker` without that context gets scored against TED+W and the
behavioral bar, and comes back full of findings that do not apply — and a
questionnaire sent to the same gate gets refused outright and pointed at
`survey-checker`, which is the behavior you want.

## The file format

| Field | Required | What goes in it |
|---|---|---|
| `method` | yes | Name, and the one-sentence version |
| `what it can tell you` | yes | Claims this method actually supports |
| `what it cannot tell you` | yes | The blind spot. `plan-reviewer` blocks a plan that doesn't state this, so this is where the content comes from |
| `session shape` | yes | Sections in order, with time |
| `counts` | yes | Questions or tasks by session length, as a rule of thumb with its assumptions |
| `instrument craft` | yes | Rules specific to writing *this* instrument, beyond the universal ones in §4.6 |
| `sample size` | no | With its rationale, and per segment rather than total |
| `logistics` | no | Compensation, tooling, devices, remote vs. in person, cadence |
| `analysis note` | no | What the data wants when it arrives |
| `common failure` | no | The one this method fails at most often |
| `maintainer` and `last reviewed` | yes | Who to ask, and how stale this is |

## Adding a method

Copy [`methods/TEMPLATE.md`](methods/TEMPLATE.md), fill in the six required
fields, and open a pull request. Two rules:

- **Write only what differs by method.** If the rule holds for interviews and for
  diary studies, it is a §4.6 item, not a method file.
- **Numbers are rules of thumb with assumptions attached.** "8–12 main questions
  in 60 minutes" is a planning heuristic that assumes substantive open questions
  with probes and a participant who talks most of the time. Say the assumption.
  A number without one gets treated as a measurement, and this suite's whole
  posture is that it should not be.

---

*Author: **Kirsten Hosic**, UX Research Strategy Lead, Security Product Design.*
