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
    - quote:     "I picked userpass because it was first. I assumed I'd set
                  the permissions after."
      source:    P7, transcript-p7.txt, 09:48
    - behavior:  P2 configured, then reconfigured, the same auth method three
                 times before reaching the policy screen.
      source:    session-notes-p2.md, line 61
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
| `evidence[]` | yes, ≥1 | Verbatim `quote` or observed `behavior`, each with a locatable `source`. |
| `disconfirming` | yes | What contradicts this — or `none found` / `not sought`. Blank is not allowed. |
| `confidence` | yes | `high` / `medium` / `low`, **and why**. |
| `limits` | yes | What this does not apply to. |
| `recommendation` | no | If present, needs an `owner`. `[TBD]` is acceptable in draft, blocking at release. |

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

For the document generator, the deck skill, and anything scripted. Same
semantics, same required fields.

```json
{
  "study": "vault-auth-methods-2026-07",
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
        { "type": "quote", "text": "…", "participant": "P3", "source": "transcript-p3.txt", "locator": "14:22" }
      ],
      "disconfirming": "…",
      "confidence": { "level": "high", "why": "…" },
      "limits": "…",
      "recommendation": { "action": "…", "owner": null }
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
- Anything on a slide with no matching record is a **blocking** defect

The last rule is the whole reason this file exists. A deck that can only show
what a record contains cannot quietly gain evidence between synthesis and the
readout meeting.

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

Those five are what make a finding checkable at all. Below that it isn't a
finding, it's a recollection.
