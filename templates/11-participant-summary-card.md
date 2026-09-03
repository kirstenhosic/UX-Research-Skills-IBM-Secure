*Dr. Morgan UX research suite — author: **Kirsten Hosic**, UX Research Strategy Lead, Security Product Design. MIT licensed.*

---

# Participant summary card

The one-page artifact that goes back to the people who gave you their time.
Template 10 is the email; this is what the email attaches or embeds. Most
studies send both, and a study that does runs both gates.

`EVALUATION-LOOP.md` §4.10 is the Definition of Done, and **§4.9 items 1-6
apply to this card in full** — same recipient tiering, same aggregation rule,
same ban on implying decisions that have not been made. Read template 10
first; this template covers only what a designed document adds.
`skills/research-participant-summary` carries the full rules and the
reference HTML.

## Why a card needs its own bar

An email reads as one person writing to another. A card carries your
company's logo and the authority of a designed document, and a requirement
laid out in a numbered list under that logo reads as a roadmap rather than as
something a customer said.

That single difference generates every rule below.

## The framing test

Before drafting, settle three things. Getting these wrong is not a style
problem; it is the difference between an artifact that builds trust and one
your PM has to walk back.

1. **Whose voice?** Every substantive line is the participant's, marked as
   theirs: *"You described…"*, *"You asked for…"*, *"You told us…"* A
   requirement without visible attribution is a commitment, however carefully
   the rest of the sentence is hedged.
2. **Conditions or blockers?** The same evidence reads as "here is what makes
   this work for you" or as "here are three unsolved problems with our
   product." A customer executive who wasn't in the sessions reads the second
   as a warning. Organize around enablement — it is equally honest and far
   stronger.
3. **Who is the actor?** Prefer "adoption" over "migration." One centers the
   customer's decision and timeline; the other frames them as the object of
   something being done to them. Sweep derived forms too. A product team with
   its own neutral vocabulary follows that instead; the principle governs.

## What never appears

Stricter than any internal artifact, and stricter than you will expect:

| Excluded | Why |
|---|---|
| Participant IDs (`P1`, `P2`) | Internal scaffolding. To a participant they mean nothing, and they signal that per-person attribution exists — which invites a reader at a multi-participant account to work out who said what |
| Exact counts ("3 of 4") | At a four-person account this is a puzzle with a solvable answer. Aggregate instead. This inverts the usual rule, deliberately |
| Verbatim quotes | A distinctive phrasing identifies its speaker to colleagues who were in the room. Paraphrase into collective voice |
| Company and account names | Including the reader's own. They know who they are; the document still gets forwarded |
| Role titles that identify one person | "Your Field CTO" names somebody |
| Retirement, end-of-life, deprecation timing | The highest-risk item here. Writing it down tells a customer's commercial team that retirement is being planned, which can trigger contract renegotiation. Express the need as **predictability** instead |
| Licensing, pricing, support windows, contractual terms | Owned by PM, commercial, and legal. Replace with the governance-support need underneath |

Naming a **capability** the customer asked for is fine. Previewing an
implementation is not: *"a compatibility layer, for example a proxy or
wrapper"* shows you understood the mechanism without committing to a design.

When you cut a restricted topic, tell the researcher what you cut, what
replaced it, and who owns the message. Never drop a finding silently.

## Structure

Six zones. Full specification, palette values, and reference HTML:
`skills/research-participant-summary/references/at-a-glance-card.md`.

```
1  EYEBROW          Secure UX Design  |  [Product]

2  TITLE            What You Told Us About Adopting [Product]
   SUBTITLE         [Study] — what we heard from you, at a glance
                    Never call it "sanitized" here. That belongs in the
                    footer as a disclosure; in the title area it makes a
                    warm document feel legal.

3  THREE STATS      [N] participants with a role descriptor
                    A qualitative depth marker — never a session duration
                    The number of conditions

4  HEADLINE         One sentence. The single thing you heard, framed as
                    enablement. Write this last, after the conditions
                    are settled.

5  THREE CONDITIONS Each: a condition-for-success title, then a line
                    opening with "You described / You asked for /
                    You told us."
                    Three is the number. Two looks thin; four stops
                    being scannable at a glance.

6  SECONDARY LIST   Three non-technical needs. Where commercially-owned
                    topics get replaced by the need underneath them.

   FOOTER           Left: thanks + soft impact statement
                    Right: anonymization disclosure + Month Year
```

**The footer is a commitment surface.** "Informing our product thinking" is
safe. "Shaping the roadmap" is a soft promise that comes back. The date is
required: an undated customer-facing artifact circulates indefinitely and
gets read as current a year later.

## Voice

`VOICE-AND-STYLE.md` governs, with three emphases:

- **Second person throughout.** A participant summary in third person has
  missed the point.
- **No em dash interrupting a sentence** (item 22). This bites hardest here,
  because the format invites appositives. Use commas.
- **Expand every acronym on first use.** The participant knows their domain;
  the colleague they forward it to may not.

Warm, not effusive. One genuine thank-you, in the footer. Not three.

## Before it goes out

**Safety** — no IDs, names, accounts, counts, quotes, or identifying roles.

**Commitment** — every condition opens with an attribution verb; no
restricted topics; mechanisms marked "for example"; footer language soft;
month and year present.

**Framing** — "adoption" not "migration"; conditions not blockers; no line
mirroring internal doubt back at the customer.

**Craft** — second person; no mid-sentence em dashes; acronyms expanded;
rendered output *viewed*, not just generated, with nothing clipped or
overflowing.

A card that passes §4.10 is **ready for review, not ready to send.** You read
it yourself, then whoever owns customer communications reads it, and per §4.9
item 8 the product owner confirms the wording before it reaches a named
account. No other artifact in the suite carries that caveat; this one always
does.
