# Dr. Morgan — UX Research Mentor Prompts

A suite of AI prompt "agents" that act as a senior UX researcher mentor. They are
designed to be used in IBM Bob (or similar tools that can run skills and agents) and used to guide, challenge, and co-pilot UX research work for **IBM Secure products** (HashiCorp Vault, Boundary, Consul,
and Radar, with the addition of Terraform). **For any output created with data analysis skills, the competitive analysis, or the slide deck generator, be sure to run the Research-integrity auditor as a release gate.**

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
| `agents/research-synthesis-checker.agent.md` | **Research-integrity auditor.** Invocable agent that cross-checks every synthesized finding, theme, quote, and statistic against the source-of-truth (transcripts, raw notes, survey CSVs) to catch hallucinated, unsupported, or overstated claims before a synthesis is shared. | You have a draft synthesis and need to verify it is faithfully grounded in the source data; run it again after a draft readout deck is prepared to confirm no invented or falsified evidence made it into slides. |
| `ux_plan_from_scratch.md` | **Scenario C** — build a research plan from zero through seven phases (frame → questions → participants → method → guide → analysis → output), with depth calibrated to the study's size and stakes (lightweight / standard / high-stakes). | You're starting a brand-new study and have nothing yet. |
| `select_best_method.md` | **Scenario B** — method-selection advisor built around the *Minimum Viable Research Method* and real recruitment constraints. | You need to pick the most rigorous method you can actually execute. |
| `analyze_your_data.md` | **Scenario A** — guides analysis through six stages and pushes findings up the observation → insight ladder, with quantitative-data guardrails (distributions, small-n confidence, significance vs. importance). The quick path; cross-linked to the strict path below. | You have data and need help reaching defensible insights. |
| `challenge_and_refine_plan.md` | **Scenario D** — critical review of an existing plan, method, or discussion guide via a rapid upstream audit + script review — and it knows when to stop refining and send you back to Scenario C for a redesign. | You have a draft and want it stress-tested. |
| `competitive_analysis.md` | **Scenario E** — competitive-analysis co-pilot comparing 2–4 products across UX, capability, and market/strategy lenses, with tiered templates (a core three, plus six you add only when they earn their place), a source-integrity audit, and a **visual-evidence workflow** for sourcing and comparing competitor UI from web pages, screenshots, and demo video. | You're comparing competing products to inform a design, positioning, or roadmap decision. After you synthesize the comparison output, run the Research-integrity auditor to verify claims and evidence traceability before sharing. |
| `qualitative_data_analysis_skill.md` | **Scenario F** — specialized deep-dive on qualitative analysis with a *mandatory data-integrity audit* (hallucination, confirmation bias, and cherry-picking detection) before any analysis proceeds. | Analysis quality control is the priority and you want the strictest integrity checks. |
| `research-readout-deck/` | **Artifact generator** — converts raw research materials (interview notes, usability observations, survey data, verbatim quotes) into a findings-first `.pptx` readout built for a mixed product-team audience (PM + Eng + UXD). Enforces separation of observation, interpretation, and recommendation; calibrates evidence strength; defaults to IBM theming (Carbon Design System / IBM Plex). Bundles a slide-by-slide recipe + theme reference (`references/deck-structure.md`); requires the separate **pptx** skill to render slides. | You've completed a study and need to present findings to your product team. |
| `skills/research-plan-generator.py` + configs | **Research Plan Generator (Scenario G — NEW!)** — fast path to publication-ready research plan documents. Configurable, reusable skill that generates professional Word documents following IBM Secure's design system (colors, spacing, typography). Adapts to migration studies, feature evaluations, adoption research, and comparative analysis. Fully customizable via JSON configs; includes templates for each research type. All generated documents follow `DESIGN-SYSTEM.md` standards. | You need a professional research plan in ~30 minutes (instead of 4+ hours). Use `/hashicorp-secure-research-plan` in Claude Code, or run the script directly. See `skills/README.md` for full documentation. |

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
- **Source integrity** (Scenario E): every claim is labeled **[verified]**,
  **[vendor claim]**, **[inference]**, or **[unknown]**; a vendor saying it does X
  is treated as a claim, not a fact, until corroborated; volatile data is dated;
  and citations are never invented. Visual evidence gets the same treatment —
  every screenshot or clip is labeled by source type (**[live product]**,
  **[marketing]**, **[demo video]**, **[third party]**) and dated, and UX is never
  scored from marketing imagery alone.

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
   competitor notes — when prompted. **De-identify transcripts and notes where necessary first**
   (remove names, emails, employer/client details); treat the chat as you would
   any external tool handling research data. The more context you provide, the
   sharper the guidance.
4. **Run the Research-integrity auditor as a release gate** using
   `agents/research-synthesis-checker.agent.md`:
   - First pass: after you have a draft synthesis (themes/findings).
   - Competitive pass: after you synthesize outputs from `competitive_analysis.md`
     (verdict, scorecard, and supporting evidence).
   - Second pass: after you build a draft slide deck, to verify no unsupported,
     invented, or falsified data appeared during story editing.

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
- **`research-readout-deck/` and Scenario A serve different phases.** Scenario A is for *analysis* — getting from raw data to defensible insights. The readout skill is for *output* — turning finished findings into a slide deck the team can act on. Run Scenario A first if your findings aren't fully synthesized yet.
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
  stay identical. Quick drift check — this should print exactly one hash:
  ````
  for f in *.md; do b=$(awk '/^OPERATING PRINCIPLES \(apply throughout/{p=1} /^MENTORING RULES/{p=0} p' "$f"); [ -n "$b" ] && printf '%s' "$b" | md5; done | sort -u
  ````

---

## Repo

- **Repository:** [kirstenhosic/UX-Research-Skills-IBM-Secure](https://github.com/kirstenhosic/UX-Research-Skills-IBM-Secure) *(private)*
- **Clone:** `https://github.com/kirstenhosic/UX-Research-Skills-IBM-Secure.git`
- **Product-agnostic sibling:** [kirstenhosic/UX-Research-Skills](https://github.com/kirstenhosic/UX-Research-Skills) — the same suite with fill-in PRODUCT CONTEXT placeholders instead of the IBM Secure context, for use outside this team
- **License:** MIT
- **Maintainer:** [@kirstenhosic](https://github.com/kirstenhosic)
