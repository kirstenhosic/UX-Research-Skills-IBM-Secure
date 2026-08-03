# Dr. Morgan — UX Research Mentor Prompts

A suite of AI prompt "agents" that act as a senior UX researcher mentor. They are
designed to be used in IBM Bob (or similar tools that can run skills and agents) and used to guide, challenge, and co-pilot UX research work for **IBM Secure products** (HashiCorp Vault, Boundary, Consul,
and Radar, with the addition of Terraform).

**Nothing here ships unchecked.** Every artifact the suite produces runs an
**evaluation loop** — a sequence of independent evaluator agents that verify it,
hand back blocking items for revision, and cap the number of retries before a
person has to look. See [`EVALUATION-LOOP.md`](EVALUATION-LOOP.md).

The mentor — **Dr. Morgan**, a senior researcher with a PhD in HCI — teaches
through Socratic questioning, challenges weak reasoning, insists on traceable
evidence, and references an established research canon. By default Dr. Morgan coaches; on
request it switches to **Draft mode** and produces a real artifact — a plan,
guide, coding frame, finding, or matrix — then critiques it with you, holding the
same rigor either way.

---

## What's in this repo

There are two ways to use the suite: the **invocable Dr. Morgan agent** (one agent
that routes between every scenario) or an **individual scenario file** (loaded
directly when you already know exactly what you need). The standalone files are
deeper, single-purpose versions; the agent embeds a condensed version of each and
switches between them on demand.

| File | Role | Use it when |
|---|---|---|
| `agents/dr-morgan.agent.md` | **The orchestrator.** One invocable Dr. Morgan agent (VS Code `.agent.md` with frontmatter) with a scenario router that covers all six scenarios (A–F) and switches between them mid-conversation. | You want a single agent for a whole research effort and may move between tasks. |
| `EVALUATION-LOOP.md` | **The orchestration spec.** Which gates run on which artifact, the verdict schema every evaluator emits, the revision cycle and its two-pass cap, escalation triggers, the blocking-vs-flagged rule, and the Definition of Done for each artifact type. | You want to know how an artifact actually gets released, or you're adding a new skill or evaluator. |
| `FINDINGS-CONTRACT.md` | **One shape for a finding**, shared by everything that produces or consumes one. The deck skill can only render fields a record contains — which is what structurally prevents evidence from being invented during deck building. Also carries `participant_type` per evidence entry, which drives the safety bar and the proxy check. | You're synthesizing findings, or building anything that reads them. |
| `VOICE-AND-STYLE.md` | **How outputs should read.** What makes writing land as human rather than generated, how to write one document for engineers, PMs, designers, researchers, and customer reps at once, and a 21-item rubric the readability gate scores against. | Any artifact a stakeholder will open. |
| `agents/research-safety-checker.agent.md` | **Pre-flight — is it safe to share?** Runs first on every artifact, outside the ordered sequence, because a safety scan placed last never executes on an artifact that failed an earlier gate. Calibrated to two things: where the artifact is going (`internal-team` / `internal-org` / `external`) and who the participants were (`customer-direct` / `internal-direct` / `internal-proxy` / `sme-external`). Role and account name are freely shareable internally for every participant type; names, email addresses, and phone numbers block everywhere. Consent terms override the destination tier whenever they are stricter. Reports what it could not inspect (images, embedded metadata) rather than passing it silently. | Every artifact, first, every iteration. |
| `agents/research-synthesis-checker.agent.md` | **Gate 1 — is it true?** Cross-checks every synthesized finding, theme, quote, and statistic against the source-of-truth (transcripts, raw notes, survey CSVs) to catch hallucinated, unsupported, or overstated claims. Has a **deck mode** (re-verifies slides against already-passed finding records) and a **source-integrity mode** (labels competitive claims verified / vendor claim / inference / unknown). For load-bearing claims it identifies which warrant a blind 3-verifier refutation panel and hands you the procedure — it cannot spawn agents itself, and three viewpoints simulated in one context would share the bias the panel exists to avoid. | Any draft synthesis, competitive analysis, or readout deck. |
| `agents/research-significance-checker.agent.md` | **Gate 2 — does it matter?** Builds a bidirectional coverage matrix of research questions × findings; flags findings that map to no question (**retained, never deleted**) and questions no finding addressed. Also checks altitude (observation vs. insight), decision-fit, scope, and whether disconfirming evidence was sought. Catches findings that are true but useless — which gate 1 structurally cannot see. | After gate 1 passes on any findings set. |
| `agents/research-plan-reviewer.agent.md` | **The plan gate.** Audits the upstream decisions (named decision, researchable questions, method fit, participants, analysis plan, ethics), then reviews the discussion guide question by question and maps coverage against the research questions. The only gate that runs *before* the money is spent. | Any research plan or discussion guide, before fieldwork. |
| `agents/research-readability-checker.agent.md` | **The last gate — can a mixed room act on it?** Scores against `VOICE-AND-STYLE.md`: rhythm, exact quantifiers, concrete detail, stated confidence, committed conclusions, audience coverage, jargon, length. Confirms the safety pre-flight already ran; it does not adjudicate safety itself. | Every artifact, last, before it leaves the team. |
| `ux_plan_from_scratch.md` | **Scenario C** — build a research plan from zero through seven phases (frame → questions → participants → method → guide → analysis → output), with depth calibrated to the study's size and stakes (lightweight / standard / high-stakes). | You're starting a brand-new study and have nothing yet. |
| `select_best_method.md` | **Scenario B** — method-selection advisor built around the *Minimum Viable Research Method* and real recruitment constraints. | You need to pick the most rigorous method you can actually execute. |
| `analyze_your_data.md` | **Scenario A** — guides analysis through six stages and pushes findings up the observation → insight ladder, with quantitative-data guardrails (distributions, small-n confidence, significance vs. importance). The quick path; cross-linked to the strict path below. | You have data and need help reaching defensible insights. |
| `challenge_and_refine_plan.md` | **Scenario D** — critical review of an existing plan, method, or discussion guide via a rapid upstream audit + script review — and it knows when to stop refining and send you back to Scenario C for a redesign. | You have a draft and want it stress-tested. |
| `competitive_analysis.md` | **Scenario E** — competitive-analysis co-pilot comparing 2–4 products across UX, capability, and market/strategy lenses, with tiered templates (a core three, plus six you add only when they earn their place), a source-integrity audit, and a **visual-evidence workflow** for sourcing and comparing competitor UI from web pages, screenshots, and demo video. | You're comparing competing products to inform a design, positioning, or roadmap decision. After you synthesize the comparison output, run the gate sequence — safety pre-flight, then the synthesis checker in source-integrity mode — before sharing. |
| `qualitative_data_analysis_skill.md` | **Scenario F** — specialized deep-dive on qualitative analysis with a *mandatory data-integrity audit* (hallucination, confirmation bias, and cherry-picking detection) before any analysis proceeds. | Analysis quality control is the priority and you want the strictest integrity checks. |
| `research-readout-deck.skill` | **Artifact generator** (packaged skill bundle — unzip to inspect) — converts raw research materials (interview notes, usability observations, survey data, verbatim quotes) into a findings-first `.pptx` readout built for a mixed product-team audience (PM + Eng + UXD). Enforces separation of observation, interpretation, and recommendation; calibrates evidence strength; defaults to IBM theming (Carbon Design System / IBM Plex). Bundles a slide-by-slide recipe + theme reference (`references/deck-structure.md`); requires the separate **pptx** skill to render slides. | You've completed a study and need to present findings to your product team. |
| `test-fixtures/` | **Regression test for the gates.** A 5-participant corpus and a synthesis with 12 deliberately planted defects — hallucinated quote, altered quote, vague quantifier, unmapped finding, unaddressed research question, proxy evidence stated as direct customer behavior — plus an answer key and **named controls that must not trigger**. It caught a real architectural flaw on its first run. | Any time you change a gate, a rubric, or `EVALUATION-LOOP.md`. |
| `skills/research-document-generator.py` + configs | **Research Document Template Generator (Scenario G)** — the single template every generated research document goes through. Produces professionally formatted Word documents following IBM Secure's design system (Cambria, grayish-blue palette, callouts, auto-numbered sections, page numbers). Two layouts: the standard **research-plan** layout (purpose → scope → RQs → participants → guide → timeline → deliverables) and a generic **`sections`** layout for rationales, briefs, and one-pagers. Fully customizable via JSON configs. All generated documents follow `DESIGN-SYSTEM.md` standards. | **Any time a research document (.docx) is being produced** — plan, rationale, or brief. Use as an invokable skill in Bob or run the script directly. See `skills/README.md` for full documentation. |

---

## New: Design System & Integration

All research documents generated by skills in this repo (research plans, readout decks, analysis outputs) follow IBM Secure's design system. See `DESIGN-SYSTEM.md` for:
- Color palette (primary/secondary blue, light gray)
- Typography and spacing standards
- Document structure requirements
- Data integrity standards

For **integration details**, maintainers, and developers: see `RESEARCH-PLAN-INTEGRATION.md`.

---

## The six scenarios (Dr. Morgan agent)

The `agents/dr-morgan.agent.md` agent routes between these. You can name a scenario,
let Dr. Morgan auto-detect from your message, or switch at any time.

- **A — Analyze Your Data:** reach insights from research data; pushes every
  finding up the observation → interpretation → insight → recommendation ladder.
- **B — Select Best Method:** recommend the most rigorous method that's actually
  executable, accounting for recruitment reality and decision stakes.
- **C — UX Plan From Scratch:** build a complete research plan through seven phases,
  in order, at a depth calibrated to the study's size and stakes.
- **D — Challenge & Refine Plan:** audit upstream decisions and review a draft
  discussion guide for leading, double-barreled, and hypothetical questions.
- **E — Competitive Analysis:** compare 2–4 products across three lenses,
  research-then-refine, with a verdict tied to a real decision — including
  **side-by-side UI teardowns** built from sourced screenshots, product-tour
  pages, and demo video.
- **F — Deep Qualitative Analysis** (integrity-first): the same territory as A,
  but the strictest QA path — runs a *mandatory data-integrity audit*
  (hallucination, confirmation bias, cherry-picking) before any analysis proceeds.

---

## A through-line: integrity over confidence

Every scenario holds the same bar — **a confident wrong answer is worse than an
honest "I don't know."** That shows up two ways:

- **Data integrity** (Scenarios A, D, and the deep analysis skill): findings must
  be traceable to specific evidence with participant IDs; confirmation bias and
  cherry-picking get named explicitly; analysis from memory is not allowed.
- **Provenance integrity** (everywhere): every piece of evidence records who the
  participant was. An internal colleague reporting on *customers'* experience is
  speaking secondhand — their evidence establishes what they believe about
  customers, not what customers do. Ordinary traceability cannot see the
  difference, so the gates check it separately.
- **Source integrity** (Scenario E): every claim is labeled **[verified]**,
  **[vendor claim]**, **[inference]**, or **[unknown]**; a vendor saying it does X
  is treated as a claim, not a fact, until corroborated; volatile data is dated;
  and citations are never invented. Visual evidence gets the same treatment —
  every screenshot or clip is labeled by source type (**[live product]**,
  **[marketing]**, **[demo video]**, **[third party]**) and dated, and UX is never
  scored from marketing imagery alone.

---

## The evaluation loop

Dr. Morgan drafts. A safety pre-flight plus four independent quality gates
check. Dr. Morgan revises. A person decides.

```
PRE-FLIGHT (everything)  →  safety-checker
Research plan / guide    →  plan-reviewer → readability
Synthesis findings       →  synthesis-checker → significance-checker → readability
Competitive analysis     →  synthesis-checker → significance-checker → readability
Readout deck             →  synthesis-checker (deck mode) → readability
```

**Safety runs first, on everything.** Not last, and not inside the ordered
sequence — the quality gates stop at the first failure, so a safety scan placed
last would never run on an artifact that failed groundedness. Identifying data
would sit undiscovered through two revision cycles, on the one check that is
never negotiable.

It is aware of **two** things: where the artifact is going (`internal-team`,
`internal-org`, `external`) and who the participants were (`customer-direct`,
`internal-direct`, `internal-proxy`, `sme-external`). Internal participants
carry *more* permitted detail — role, product area, and region are how a
colleague's perspective becomes interpretable — while names, email addresses,
and phone numbers block for everyone at every tier.

On destination: the bar for a team readout is not the bar for a conference talk.
Applying the external bar to internal work would block ordinary research over an
account name the whole team already knows — so inside the company, role and
account name are freely shareable ("an SRE at Contoso Financial" is a category
of user at a category of customer, not a person). Where the study's consent terms are stricter than
the destination allows, consent governs — that is what participants were
promised, and an office norm has no standing to relax it.

Gates run in order, and a `FAIL` stops the sequence — there's no point asking
whether a finding matters, or polishing how it reads, before knowing it's
supported. Each gate emits a machine-readable verdict so the result can be
branched on rather than read as prose.

**Evaluators never edit.** An evaluator that rewrites its own input and then
re-checks its own rewrite launders its errors past itself. Revision always goes
back to the producer, scoped to the blocking items only.

**Two revision passes, then a person looks.** If an artifact can't clear the bar
in two tries, the problem is upstream of the wording — the data, the question,
or the method — and a third pass polishes the wrong object.

**Blocking vs. flagged is the load-bearing distinction.** Blocking means the
artifact asserts something untrue, unsupported, or unsafe; it gets fixed.
Flagged means the artifact is accurate but a human should look; it ships
attached to the artifact as Reviewer Notes. A gate that treats judgment calls as
defects trains researchers to delete interesting things to make it go green.

**Coverage is checked in both directions, and nothing gets deleted.** A finding
that maps to no stated research question is retained and flagged — unplanned
findings are often the most valuable thing in a study. A research question no
finding addressed is flagged so the human can decide between a follow-up,
recovering it from the corpus, or rewriting the question. Both gaps travel to
the readout.

**Proxy evidence is flagged, not silently accepted.** When an internal colleague
in customer success or field engineering reports on *customers'* experience, that
is secondhand: it establishes what they believe about customers, not what
customers do. Ordinary traceability can't see the difference — "customers find X
confusing — P3" passes every groundedness check if P3 said exactly that. The
gates flag the phrasing and require the scope line to name the proxy.

**Known limits are stated,** not glossed: LLM evaluators grade leniently on text
that reads rigorous, chained gates compound false positives, and a green verdict
is not a correct study. See §7 of [`EVALUATION-LOOP.md`](EVALUATION-LOOP.md).

---

## Writing that reads human

Every artifact is also gated on how it reads, because a findings document that
sounds generated gets treated as input rather than as a conclusion — it reads as
un-owned, and nobody argues with it, which feels like agreement and isn't.

[`VOICE-AND-STYLE.md`](VOICE-AND-STYLE.md) is the standard. In short:

- **Vary sentence length.** Uniform rhythm is the strongest single tell.
- **Quantify exactly** — "6 of 8," never "most." Precision is a human trait;
  vagueness is what reads generated.
- **Keep one telling detail** that could only come from being in the room — the
  paper cheat sheet, the fourteen open tabs. Unfakeable, and it survives the
  meeting.
- **Let the strong finding take more room.** Equal-sized sections for unequal
  evidence is a lie told through layout.
- **State your confidence and what would change your mind**, in your own voice.
- **Commit to a conclusion** instead of balancing every criticism with a
  compensating positive.
- **Mark the altitude.** The specific failure mode of a mixed-stakeholder
  document is jumping between "operators' mental model of the secret lifecycle"
  and "the modal close target is small" without signalling the shift.
- **One document, not five.** Write the finding once, then a short *"what this
  means for you"* per audience — engineers, PMs, designers, researchers,
  customer reps.

And what *not* to do, since most "sound human" advice makes writing worse: don't
fake casualness, don't add deliberate errors, don't panic about em-dashes
(uniformity is the tell, not punctuation), don't manufacture opinions, and don't
strip precision to sound conversational.

---

## Operating principles (every scenario)

Beyond the scenario-specific guidance, every prompt shares a common set of
guardrails:

- **Calibrates to your experience** — challenges a senior researcher as a peer,
  teaches a novice from fundamentals.
- **Two modes** — Coach (Socratic, default) and Draft (produces a real artifact,
  then critiques it with you).
- **Never fabricates data** — quotes only verbatim text you provided, with your
  participant IDs; asks for missing data rather than reconstructing it.
- **Never fabricates sources or overstates numbers** — cites only verifiable
  sources and frames every sample-size rule or benchmark as a rule of thumb with
  its assumptions.
- **Protects participant data** — prompts you to de-identify transcripts before
  pasting and flags personal data it notices.

---

## Frameworks & canon referenced

The prompts cite an established research literature so guidance is grounded, not
improvised. Full citations live in the individual prompt files.

**Research methods, interviewing & analysis**
- Erika Hall — *Just Enough Research*
- Steve Portigal — *Interviewing Users*
- Rob Fitzpatrick — *The Mom Test*
- Goodman, Kuniavsky & Moed — *Observing the User Experience*
- Braun & Clarke — *Thematic Analysis*
- Johnny Saldaña — *The Coding Manual for Qualitative Researchers*
- Beyer & Holtzblatt — *Contextual Design*
- Indi Young — *Mental Models*
- John W. Creswell — *Research Design*
- Leah Buley — *The User Experience Team of One*

**Quantitative & measurement**
- Sauro & Lewis — *Quantifying the User Experience: Practical Statistics for User Research* (also the source of the SUS ≈68 average benchmark and letter grades)
- Tullis & Albert — *Measuring the User Experience*
- Jakob Nielsen / Nielsen Norman Group — usability heuristics, sample-size guidance

**Competitive analysis (Scenario E)**
- Michael E. Porter — *Competitive Strategy* (1980) — Five Forces, generic strategies
- Christensen, Hall, Dillon & Duncan — *Competing Against Luck* (2016) — Jobs to Be Done
- April Dunford — *Obviously Awesome* (2019) — product positioning
- Marty Cagan — *Inspired* — product judgment
- Amy Schade & Tim Neusesser (Nielsen Norman Group) — competitive usability evaluation

---

## How to use

1. **Invoke the agent** — in IBM Bob or VS Code Copilot Chat, connect this repo so you can access it directly (you can prompt Bob to help you do this). Or, for a single scenario, open one of the
   standalone scenario files and copy its contents into **Copilot Chat or IBM Bob** as a
   system prompt / custom instructions, or as the first message in a new chat.
2. Describe what you're working on. Dr. Morgan will route you to the right scenario
   (or follow the one scenario you loaded) and guide you from there.
3. Paste in your own materials — research questions, transcripts, draft guides,
   competitor notes — when prompted. **Pseudonymize participants first** — replace
   names, email addresses, and phone numbers with participant IDs (P1, P2). Role,
   account name, and region can stay: they are what make a finding actionable, and
   `research-safety-checker` governs where they may travel. Treat the chat as you
   would any external tool handling research data. The more context you provide,
   the sharper the guidance.
4. **Run `research-safety-checker` first**, on every artifact, and tell it where
   the artifact is going (`internal-team` / `internal-org` / `external`). It
   will ask if you don't. This runs before everything else and every iteration.
5. **Then run the quality gates.** Which ones depends on what you made — see the
   table above, or §3 of [`EVALUATION-LOOP.md`](EVALUATION-LOOP.md). Run them in
   order and stop at the first `FAIL`.
   - **A plan or discussion guide** → `research-plan-reviewer`, then
     `research-readability-checker`. This is the only gate that runs before
     fieldwork, so it's the cheapest place to catch a problem.
   - **Findings** → `research-synthesis-checker`, then
     `research-significance-checker`, then `research-readability-checker`.
   - **A competitive analysis** → same three, with the synthesis checker in
     source-integrity mode.
   - **A readout deck** → `research-synthesis-checker` in deck mode (verifying
     slides against finding records that already passed, which is where invented
     evidence historically appears), then `research-readability-checker`.
6. **Act on the verdict.** `REVISE` means fix only the blocking items and re-run
   that gate. `RELEASE` means ship it, with any flags attached as Reviewer Notes.
   `ESCALATE` means stop — the problem isn't the wording.

Each scenario file is self-contained; you don't need the others loaded for it to
work.

---

## Notes

- **Consistent persona & format:** every remaining file uses **Dr. Morgan** and the
  same plain instruction format (`For this conversation, you are Dr. Morgan…`).
- **Intentional overlap:** Scenario A and `qualitative_data_analysis_skill.md` both
  cover analysis. The skill is the stricter, integrity-first deep dive (mandatory
  data-integrity audit before any analysis); Scenario A is the quicker guided path.
  Keep both if you want a fast path and a rigorous path.
- **Five evaluators, five jobs — and each one is blind to the others'.** That's the
  reason there is more than one. A groundedness checker will pass a perfectly-sourced
  finding that answers nothing anyone asked. A significance checker will pass a
  decision-relevant finding built on a fabricated quote. Neither notices a participant's real
  name in the appendix.

  | Agent | Verifies | Cannot see |
  |---|---|---|
  | `research-safety-checker` | Is this safe to share with *this* audience? | Whether any of it is true, relevant, or readable |
  | `research-synthesis-checker` | Is each claim traceable to source text? | Whether the claim matters |
  | `research-significance-checker` | Does it map to a question and a decision? Does it reach insight level? Is the corpus complete? | Whether the claim is true |
  | `research-plan-reviewer` | Will this study answer its question? Is the guide sound? | Anything post-fieldwork |
  | `research-readability-checker` | Will a mixed audience understand and act on it? | Whether any of it is correct, and whether it is safe to share |

- **Three analysis-integrity files, three jobs.** It's easy to confuse these — here's
  the split:
  - `analyze_your_data.md` (**Scenario A**) — *guides you to* insights through six
    stages. Coaching-forward; integrity matters but the emphasis is forward motion.
  - `qualitative_data_analysis_skill.md` (**the skill**) — *audits, then analyzes*.
    Runs a mandatory data-integrity audit (hallucination, confirmation bias,
    cherry-picking) before continuing into synthesis. The rigorous QA path.
  - `agents/research-synthesis-checker.agent.md` (**the agent**) — *pure verifier*.
    Cross-checks a finished synthesis against the source-of-truth and reports
    Supported / Partially Supported / Unsupported per claim. It never analyzes,
    rewrites, or re-synthesizes — use it after synthesis to fact-check the output,
    then run it again after deck drafting as a final integrity pass.
- **`research-readout-deck.skill` and Scenario A serve different phases.** Scenario A is for *analysis* — getting from raw data to defensible insights. The readout skill is for *output* — turning finished findings into a slide deck the team can act on. Run Scenario A first if your findings aren't fully synthesized yet.
- **Keep the Dr. Morgan agent in sync:** `agents/dr-morgan.agent.md` embeds condensed
  copies of each scenario, so when you change a standalone file, mirror the change in
  the agent (or treat the agent as the source of truth and regenerate the standalones).
  They will drift otherwise.
- **Shared blocks are duplicated on purpose.** Each scenario file is self-contained so
  it can be pasted into a chat on its own, which means the `OPERATING PRINCIPLES` block
  (calibrate to experience · Coach/Draft modes · never fabricate data · never fabricate
  sources · protect participant data) is **repeated verbatim** across every skill file.
  That's the price of portability, not an accident. When you edit that block, mirror the
  change to **all** skill files (or pick one as canonical and regenerate the rest) so they
  stay identical. The same applies to the `RELEASE GATE` / `REVISION PROTOCOL` /
  `COVERAGE` / `VOICE` block appended to every skill file.

  Quick drift check — run from the repo root. Each block should report `OK`, and the
  file names next to each hash make a mismatch diagnosable rather than just visible:
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
  Literal prefix matching, not regex, and no GNU-only flags — it runs as-is on macOS.
  Note this covers the six standalone scenario files only. `agents/dr-morgan.agent.md`
  carries the same guidance in markdown rather than plain text, so it can't be hashed
  against them — it's the file most likely to drift, and it has to be checked by reading.

---

## Repo

- **Repository:** [kirstenhosic/UX-Research-Skills-IBM-Secure](https://github.com/kirstenhosic/UX-Research-Skills-IBM-Secure) *(private)*
- **Clone:** `https://github.com/kirstenhosic/UX-Research-Skills-IBM-Secure.git`
- **Product-agnostic sibling:** [kirstenhosic/UX-Research-Skills](https://github.com/kirstenhosic/UX-Research-Skills) — the same suite with fill-in PRODUCT CONTEXT placeholders instead of the IBM Secure context, for use outside this team
- **License:** MIT
- **Maintainer:** [@kirstenhosic](https://github.com/kirstenhosic)
