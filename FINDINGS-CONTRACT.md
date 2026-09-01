# Findings Contract

One shape for a finding, shared by everything that produces or consumes one.

Analysis skills emit findings in this shape. `research-synthesis-checker` and
`research-significance-checker` verify against it. `research-readout-deck`
renders from it — and, critically, **can only render fields that exist in a
record**. That constraint is the point: it is what structurally prevents
evidence from being invented during deck building, which is the failure mode
this suite has always worried about and never actually prevented.

If a slide needs a quote, the quote has to already be in a record. If it isn't,
the deck can't produce it — the gap becomes visible instead of getting filled.

---

## The record

Human-writable form. This is what you actually type during synthesis.

```
FINDING F1
  statement:   Vault operators treat auth methods as a permissions system,
               but Vault models them as a method-selection step. The mismatch
               causes operators to grant broader access than they intend.
  level:       insight
  rq:          RQ1
  prevalence:  5 of 8 participants (all operators; no end-users showed this)
  scope:
    product:   Vault
    persona:   platform operators, multi-namespace deployments
    condition: configuring a new auth method for an existing team
  evidence:
    - quote:     "I just want to say 'this team gets these secrets' — I don't
                  care which method does it."
      source:    P3, transcript-p3.txt, 14:22
      participant_type: customer-direct
    - quote:     "I picked userpass because it was first. I assumed I'd set
                  the permissions after."
      source:    P7, transcript-p7.txt, 09:48
      participant_type: customer-direct
    - behavior:  P2 configured, then reconfigured, the same auth method three
                 times before reaching the policy screen.
      source:    session-notes-p2.md, line 61
      participant_type: customer-direct
  disconfirming:
    P5 described the method-first model correctly and unprompted. P5 is the
    only participant who had completed HashiCorp certification.
  confidence:  high — consistent across 5 sessions, two data types, one
               explained counter-case
  limits:      Does not extend to end-users, who never configure auth methods.
               Not tested on single-namespace deployments.
  recommendation:
    action:    Surface the permission outcome before method selection in the
               auth method setup flow.
    owner:     [TBD — needs an owner before release]
    depends_on: F1, F3
    horizon:   this-quarter
    confidence: medium — F1 is high, F3 is medium, and this action needs both
    alternatives_considered:
      - Inline help on the method selector. Rejected: P3 and P7 both read the
        existing help and still chose method-first, so more text at the same
        point is unlikely to move it.
      - Reordering the whole Access section. Rejected as out of proportion to
        the evidence; nothing in the corpus is about navigation.
    reverses_if:
      Operators who complete the redesigned flow still grant broader access
      than they intend. That would put the cause somewhere other than the
      ordering, and this action would be the wrong fix.
  telling_detail:
    P2 kept a hand-written list of namespace paths on a sticky note beside the
    monitor, and checked it twice while configuring.
  artifact_ref:
    Vault UI — Access › Auth Methods, step 2 of 3, the method-type selector
  theme_review:
    reviewer:    [name or role of the person who reviewed the theme]
    date:        2026-07-28
    disposition: revised — original theme said "operators find auth methods
                 confusing"; narrowed to the mental-model mismatch after
                 review, because "confusing" covered two different problems
    set_summary: 9 themes reviewed · 5 accepted · 2 revised · 1 split ·
                 1 rejected
```

### Field rules

| Field | Required | Rule |
|---|---|---|
| `statement` | yes | One finding. If it contains "and," check whether it's two. |
| `level` | yes | `observation` / `interpretation` / `insight` / `recommendation`. A findings document should be mostly `insight`. |
| `rq` | yes | Research question ID, or the literal `UNMAPPED`. Never blank. |
| `prevalence` | yes | Exact counts. `5 of 8`. Never `most`, `many`, `several`, `a number of`. |
| `scope.product` | yes | Named product. Never "IBM Secure." |
| `scope.persona` | yes | Named persona. Never "users" or "engineers." |
| `scope.condition` | yes | What they were doing, under what constraints. |
| `evidence[]` | yes, ≥1 | Verbatim `quote` or observed `behavior`, each with a locatable `source` and a `participant_type`. |
| `participant_type` | yes, per evidence entry | `customer-direct` / `internal-direct` / `internal-proxy` / `sme-external`. Determines whether the evidence is about the user or about someone's account of the user. |
| `disconfirming` | yes | What contradicts this — or `none found` / `not sought`. Blank is not allowed. |
| `confidence` | yes | `high` / `medium` / `low`, **and why**. |
| `limits` | yes | What this does not apply to. |
| `recommendation` | no | If present, needs an `owner`. `[TBD]` is acceptable in draft, blocking at release. The five sub-fields below apply whenever it is present. |
| `recommendation.depends_on` | yes, if a recommendation exists | The finding IDs this action rests on. A recommendation citing no finding did not come from the research. |
| `recommendation.horizon` | yes, if a recommendation exists | `this-quarter` (specific enough to act on now) or `direction-of-travel`. Both legitimate; the label is what stops one being read as the other. |
| `recommendation.confidence` | yes, if a recommendation exists | `high` / `medium` / `low`, **and why**. Should not exceed the weakest finding in `depends_on` without saying what justifies the step up. |
| `recommendation.alternatives_considered` | yes, if a recommendation exists | What else was on the table and why it lost. `none — this was the only action the evidence pointed to` is an answer. Blank is not. |
| `recommendation.reverses_if` | yes, if a recommendation exists | What would show this was the wrong call. Same discipline as `disconfirming`, pointed forward instead of backward. |
| `telling_detail` | no | One concrete specific that could only have come from being in the session. Verbatim or observed, like any evidence — not colour added later. |
| `artifact_ref` | no | The screen, flow, state, or document this happened on. Required in practice for any finding about an interface. |
| `theme_review` | conditional | Who reviewed the theme this finding came from, when, and their disposition. **Required when the analysis ran in Draft mode.** Blocking at `internal-org` and `external`; flagged at `internal-team`. Omit entirely for Coach-mode analysis — see below. |

### `theme_review` — who decided this was a theme

In Draft mode, Dr. Morgan codes the corpus and clusters the codes. A person has
to look at the themes before synthesis builds findings on top of them; §9 of
`EVALUATION-LOOP.md` is the procedure. This field is where that review lands, and
it travels on every finding derived from the theme.

`disposition` is the reviewer's decision — `accepted`, `revised`, `split`, or
`rejected` — and for anything other than `accepted`, what changed and why. The
why is the part worth writing. "Revised" without a reason is a timestamp
pretending to be a judgment.

`set_summary` records the shape of the whole review, not just this theme. A
reviewer who accepts every theme on every study is not reviewing, and no single
finding can show that. The summary makes the pattern visible across studies.

**In Coach mode the field is omitted, not left blank.** The researcher did the
coding and clustering themselves; there is no separate thing to review, and
asking them to sign off on their own work would make the field meaningless
everywhere else it appears.

### The two optional fields, and why they exist

`telling_detail` and `artifact_ref` are optional because plenty of findings
don't have them. They're in the contract because the readout deck needs them and
had no way to get them.

`telling_detail` is the detail that proves someone was in the room — the
participant who kept a cheat sheet in a text file, the sticky note on the
monitor, the third reconfiguration. `VOICE-AND-STYLE.md` treats this as the
strongest signal that a human wrote a document. Structured records tend to strip
exactly that, because it fits no field and reads as extraneous. So it gets a
field. It is still evidence: verbatim or observed, sourced like anything else.
A detail invented to make a slide feel real is a fabrication, and a worse one
than most because it is designed to be convincing.

`artifact_ref` is the screen the finding happened on. Without it a deck builder
has to guess which screenshot belongs to which finding, and a confidently wrong
screenshot misdirects every engineer who reads the slide.

### The recommendation is a different kind of claim

Everything else in this record is a claim about what happened. A recommendation
is a claim about what to do, and the two do not answer to the same evidence.

The gates already handle the first kind well. `research-synthesis-checker`
verifies a finding against the transcript; `research-significance-checker`
verifies it matters. Neither can tell you whether the action actually follows
from the finding, because that inference is not in the corpus — it is a judgment
about design, cost, and what an organization can absorb. A perfectly grounded
finding can carry a recommendation that does not follow from it at all, and
every gate will pass it.

The five sub-fields do not fix that. What they do is make the inference
*visible*, so a person reviewing the readout can disagree with the reasoning
rather than only with the finding:

- **`depends_on`** is the load-bearing one. It forces the recommendation to name
  its findings, which is what makes the leap inspectable. A recommendation that
  cannot name one came from somewhere other than the research — which is
  allowed, and needs saying.
- **`confidence`, against `depends_on`.** Three medium findings can honestly
  support a confident action when they converge, but the step up is an argument
  and it should be written down. The failure this catches is common and quiet:
  medium-confidence findings aggregating into a roadmap commitment that nobody
  remembers was medium.
- **`alternatives_considered`** is where a recommendation earns being the
  recommendation. One option presented alone reads as inevitable; naming what
  lost, and why, is the difference between a proposal and an assertion.
- **`reverses_if`** is `disconfirming` pointed forward. A researcher who has
  already said what would prove them wrong is much harder to ambush in the
  room — and, six months on, it is the only line that tells anyone whether the
  call held.
- **`horizon`** stops a direction of travel being read as a commitment for this
  quarter, which is how roadmap arguments start.

None of this makes the recommendation right. It makes it arguable, which is the
most a contract can do for a judgment.

### The fields people want to skip

`disconfirming` and `limits` are the two that get left blank, and they're the
two that make a finding survive a skeptical room. A researcher who has already
named what would undercut their own finding cannot be ambushed by it. Leaving
them blank is a validation error, not a formatting preference — `not sought` is
an acceptable answer and an honest one; empty is neither.

`rq: UNMAPPED` is also an acceptable answer. See §5 of `EVALUATION-LOOP.md` —
unmapped findings are retained and flagged, never deleted. Marking a finding
`UNMAPPED` costs nothing and is not a defect.

---

## Competitive-analysis variant

Scenario E claims aren't grounded in participant data, so `evidence` and
`prevalence` are replaced by source labeling. Everything else holds.

```
CLAIM C1
  statement:   Competitor X supports dynamic database credentials for
               PostgreSQL and MySQL only.
  label:       [verified]
  source:      competitor-x docs, /docs/secrets/databases, retrieved 2026-07-28
  volatile:    yes — feature scope; re-check before any external use
  bearing:     Supports the "capability parity" section of the verdict
  limits:      Did not test the integration; documentation only.
```

`label` is one of `[verified]` / `[vendor claim]` / `[inference]` / `[unknown]`.
IBM and HashiCorp materials get `[vendor claim]` on exactly the same terms as a
competitor's — a vendor saying it does X is evidence that the vendor says X.

`volatile: yes` requires a retrieval date. Pricing, feature scope, integrations,
and limits change fast enough that an undated claim is a liability.

---

## JSON form

For the document template, the deck skill, and anything scripted. Same
semantics, same required fields.

```json
{
  "study": "vault-auth-methods-2026-07",
  "destination": "internal-team",
  "research_questions": [
    { "id": "RQ1", "text": "How do operators reason about auth method selection?" },
    { "id": "RQ2", "text": "How do operators decide when to rotate a secret manually?" }
  ],
  "findings": [
    {
      "id": "F1",
      "statement": "…",
      "level": "insight",
      "rq": "RQ1",
      "prevalence": { "n": 5, "of": 8, "note": "all operators; no end-users" },
      "scope": { "product": "Vault", "persona": "platform operators", "condition": "…" },
      "evidence": [
        { "type": "quote", "text": "…", "participant": "P3", "participant_type": "customer-direct", "source": "transcript-p3.txt", "locator": "14:22" }
      ],
      "disconfirming": "…",
      "confidence": { "level": "high", "why": "…" },
      "limits": "…",
      "recommendation": {
        "action": "…", "owner": null,
        "depends_on": ["F1", "F3"],
        "horizon": "this-quarter",
        "confidence": { "level": "medium", "why": "…" },
        "alternatives_considered": [ { "option": "…", "rejected_because": "…" } ],
        "reverses_if": "…"
      },
      "telling_detail": { "text": "…", "participant": "P2", "source": "session-notes-p2.md", "locator": "line 22" },
      "artifact_ref": "Vault UI — Access › Auth Methods, step 2 of 3, the method-type selector",
      "theme_review": {
        "reviewer": "…", "date": "2026-07-28", "disposition": "revised",
        "note": "…what changed and why…",
        "set_summary": { "themes": 9, "accepted": 5, "revised": 2, "split": 1, "rejected": 1 }
      }
    }
  ],
  "coverage": {
    "unmapped_findings": ["F4"],
    "unaddressed_rqs": ["RQ2"]
  }
}
```

`coverage` is populated by `research-significance-checker`, not by the
researcher. It travels with the findings so the deck and the readout can
surface both kinds of gap rather than silently dropping them.

---

## Deck rendering rule

`research-readout-deck` renders **only** from passed records.

- Every claim on a slide carries its finding ID
- A quote on a slide must byte-match the `quote` in its record
- A number on a slide must match `prevalence` — `5 of 8` cannot become "most"
- `confidence` and `limits` must appear somewhere for every finding shown
- A screenshot is chosen from `artifact_ref`, not from the deck builder's guess
  about which screen a finding refers to
- Anything on a slide with no matching record is a **blocking** defect

The last rule is the whole reason this file exists. A deck that can only show
what a record contains cannot quietly gain evidence between synthesis and the
readout meeting.

---

## Participant type

Every evidence entry records who the participant was:

| Value | Meaning |
|---|---|
| `customer-direct` | An external customer who is the user in question |
| `internal-direct` | An internal employee who is themselves the user |
| `internal-proxy` | An internal employee reporting on *customers'* experience — customer success, solution architects, support, field engineering |
| `sme-external` | An external subject-matter expert matching the persona, not a customer |

`internal-proxy` is the one that changes how a finding may be phrased. That
evidence is secondhand: it establishes what a customer-facing colleague
believes and repeats, which is worth knowing and often actionable, but it is not
a record of customer behavior. A claim written as "customers do X" on proxy
evidence gets flagged by `research-synthesis-checker`, and its scope line gets
flagged by `research-significance-checker` if it doesn't name the proxy.

The field also drives the safety bar: internal participants carry more permitted
detail (role, product area, region are fine internally) while names, email
addresses, and phone numbers block for everyone.

---

## Destination

Every findings set declares where it is going: `internal-team`, `internal-org`,
or `external`. `research-safety-checker` applies a different bar to each, and
asks rather than guessing if the field is absent.

It keeps working after the gate: a deck marked `internal-team` still says so
when someone forwards it, and forwarding is the actual leak path for this
material.

---

## Minimum viable record

Not every study needs the full shape. A lightweight study can drop
`disconfirming` detail to a single line and skip `recommendation` until the
findings are agreed. What can never be dropped, at any study size:

- `statement`
- `evidence` (at least one, verbatim, with a source)
- `prevalence` (exact)
- `scope` (product + persona)
- `rq` (an ID or `UNMAPPED`)
- `participant_type` on every evidence entry

Those six are what make a finding checkable at all. Below that it isn't a
finding, it's a recollection.

---

*Part of the Dr. Morgan UX research suite. Author: **Kirsten Hosic**, UX Research
Strategy Lead, Security Product Design.*
