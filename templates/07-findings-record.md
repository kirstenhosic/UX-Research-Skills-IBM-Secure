*Dr. Morgan UX research suite — author: **Kirsten Hosic**, UX Research Strategy Lead, Security Product Design. MIT licensed.*

---

# Findings record

One shape for a finding, shared by everything downstream. The report and the
deck can only render what exists in a record; if a slide needs a quote, the
quote has to already be here. That constraint is what structurally prevents
evidence from being invented during writing, and it works exactly as well on
the manual path as it does for Dr. Morgan. `FINDINGS-CONTRACT.md` is the
authority; this template is its human-writable form with the field rules
compressed.

Write one record per finding. If the statement contains "and," check whether
it is two findings.

```
FINDING F1
  statement:   [One finding, as a claim. Not a topic, not an observation
                dump.]
  level:       observation / interpretation / insight / recommendation
               [a findings set should be mostly insight]
  rq:          [RQ id, or the literal UNMAPPED — never blank]
  prevalence:  [exact counts: "5 of 8 participants (all operators)".
                Never "most", "many", "several".]
  scope:
    product:   [named product, never "IBM Secure"]
    persona:   [named persona, never "users"]
    condition: [what they were doing, under what constraints]
  evidence:    [at least one entry; verbatim quote or observed behavior]
    - quote:     "[verbatim — bracketed [P4] substitutions are the only
                  permitted edit]"
      source:    [P-ID, file, timestamp or line — locatable]
      participant_type: customer-direct / internal-direct /
                        internal-proxy / sme-external
    - behavior:  [what you observed them do, not what they said]
      source:    [file, line]
      participant_type: [as above]
  disconfirming: [what contradicts this — or "none found" / "not sought".
                  Blank is not allowed.]
  confidence:  high / medium / low — and why
  limits:      [what this finding does not apply to]
```

Optional fields, required in specific situations:

```
  recommendation:            [if present, all five sub-fields are required]
    action:      [an action, not a theme]
    owner:       [named owner; "[TBD]" passes in draft, blocks at release]
    depends_on:  [finding IDs this rests on — a recommendation citing no
                  finding did not come from the research]
    horizon:     this-quarter / direction-of-travel
    confidence:  high / medium / low — and why; should not exceed the
                 weakest finding in depends_on without justification
    alternatives_considered: [what else was on the table and why it lost;
                 "none — the only action the evidence pointed to" is an
                 answer, blank is not]
    reverses_if: [what future observation would show this was the wrong
                  call]
  telling_detail: [one concrete specific that could only come from being
                   in the session]
  artifact_ref:   [the screen, flow, or document this happened on —
                   required in practice for any interface finding]
  theme_review:   [required when analysis ran in Draft mode: reviewer,
                   date, disposition with reasons, set_summary. Omit
                   entirely for Coach-mode analysis.]
```

## Before these go downstream

- Every record has statement, level, rq, prevalence, full scope, at least
  one sourced evidence entry, disconfirming, confidence, and limits.
- Counts in `prevalence` match the evidence you can point to.
- Findings with `rq: UNMAPPED` are flagged and kept, never deleted. Research
  questions with no findings are flagged for a human to address (§5 of
  `EVALUATION-LOOP.md` covers both directions).
- `research-synthesis-checker` and `research-significance-checker` verify
  records against the contract; run them before writing the report or deck.

---

*Part of the Dr. Morgan UX research suite. `FINDINGS-CONTRACT.md` governs;
if this template and the contract disagree, the contract is right.*
