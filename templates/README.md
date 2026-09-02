*Dr. Morgan UX research suite — author: **Kirsten Hosic**, UX Research Strategy Lead, Security Product Design. MIT licensed.*

---

# Templates — do the work yourself, in the same shape

These templates are the manual path through the study lifecycle. Use them when
you feel confident doing the work yourself, or when you want to be challenged
to try it without Dr. Morgan's immediate help. Each one shows the structure
the suite uses for that artifact, with brief guidance on what belongs in each
section. Dr. Morgan produces the same structures; an artifact built from a
template should be indistinguishable in shape from one Dr. Morgan drafted.

**What the templates do not replace.** The quality bar is the same on both
paths. A released artifact still clears the suite's gates
(`EVALUATION-LOOP.md` §4 is the Definition of Done for each type), participants
still appear as P-IDs only in anything released, and the release sign-off
(§11: you read the whole output and made your own edits) applies to your own
work exactly as it applies to Dr. Morgan's. You can run any checker on a
manually built artifact at any time; the templates make that easier, not
optional.

## The set, in lifecycle order

| # | Template | Use it when | Aligns with |
|---|---|---|---|
| 01 | [Study intake](01-study-intake.md) | Someone asks for research and you need to decide whether a study is warranted, and if so which method | `select_best_method.md` (MVRM) |
| 02 | [Research plan](02-research-plan.md) | The study is a go and you are planning it | `ux_plan_from_scratch.md`, §4.1 |
| 03 | [Study at a glance](03-study-at-a-glance.md) | You need a shareable one-page summary of a completed plan | Condenses 02; not a peer document |
| 04 | [Participant screener](04-participant-screener.md) | Recruiting, before any session is scheduled | Plan §8–9 |
| 05 | [Discussion guide](05-discussion-guide.md) | Writing the session script or interview guide | §4.6, `methods/` |
| 06 | [Participant tracker](06-participant-tracker.xlsx) | Create it during planning, before recruitment starts | Plan §8–10, §14; P-ID discipline |
| 07 | [Findings record](07-findings-record.md) | Synthesizing data into findings | `FINDINGS-CONTRACT.md`, §4.2 |
| 08 | [Research report](08-findings-report.md) | Writing the findings and recommendations document | `skills/research-findings-report`, §4.8 |
| 09 | [Readout deck](09-readout-deck.md) | Building the share-out slides | `skills/research-readout-deck`, §4.4 |
| 10 | [Participant impact message](10-participant-impact-message.md) | Closing the loop with participants after release | `skills/participant-impact-summary`, §4.9 |

## Shareable copies and page furniture

Each markdown template has a Word copy in [`docx/`](docx/), rendered in the
suite's Carbon styling with the shared page furniture: a **Secure UX Design**
running header, and a footer carrying the suite note on the left and the page
number on the right. The participant tracker carries the same header and
footer on every sheet when printed. Hand the `.docx` and `.xlsx` files to
partners; keep edits in the `.md` files.

**The markdown files and `build-tracker.py` are the source of truth; the
`.docx` files and the `.xlsx` are generated.** After editing, regenerate with:

```bash
python3 templates/build-docx.py
```

```bash
python3 templates/build-tracker.py
```

(`build-docx.py` needs python-docx; `build-tracker.py` needs openpyxl.)

## Three rules that apply to every template

1. **Evidence discipline.** Quotes and counts trace to a source. Downstream
   artifacts (report, deck, impact message) render only what exists in a
   findings record; if a slide needs a quote, the quote has to already be in
   a record.
2. **P-IDs only.** Real identities live in exactly one place: the participant
   tracker, which is access-restricted and never released. Everything released
   uses P1, P2, and so on.
3. **Prose standard.** `VOICE-AND-STYLE.md` applies. In particular: exact
   counts rather than "most" or "several," at most one hedge per claim, and no
   sentence interrupted by an em dash or en dash. Finish the thought; then
   start a new sentence.

When a template feels insufficient partway through, that is a fine moment to
bring the draft to Dr. Morgan rather than starting over. The structures match,
so a half-finished template pastes straight into a Dr. Morgan session.
