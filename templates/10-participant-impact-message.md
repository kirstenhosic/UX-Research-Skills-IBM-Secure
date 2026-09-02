*Dr. Morgan UX research suite — author: **Kirsten Hosic**, UX Research Strategy Lead, Security Product Design. MIT licensed.*

---

# Participant impact message

The email a participant actually wants after giving feedback: short,
specific, and honest about what happened to what they said. The spine is
"here is what you taught us," not "here is what we changed." Most of the
time no product decision has been made yet, and that is normal, not a gap to
paper over. §4.9 of `EVALUATION-LOOP.md` is the Definition of Done;
`skills/participant-impact-summary` carries the full rules.

**Target 200–350 words.** The recipient gives this one read on a phone.

## The two tiers

The destination is set by who the recipient is, never chosen:

| Recipient (`participant_type`) | Tier |
|---|---|
| `customer-direct`, `sme-external` | external (the highest bar in the suite) |
| `internal-direct`, `internal-proxy` | internal-org |

A study with both kinds of participant gets **two drafts**, one per tier.
Never one email serving both. The tracker's "impact message" columns record
which draft went to whom.

## Three kinds of claim, three different bars

1. **"What we heard"** comes from passed findings records, aggregated. If it
   is not in a record, it is not in the email.
2. **"How it's informing us"** is always available, in one of two honest
   forms. What the research surfaced or recommended is attributed to the
   research ("this pushed our research to recommend rethinking the setup
   order"). "We're considering X" is a claim about the team and needs the
   team behind it: a PM's confirmation or a planning item, with a name and
   date. Without that, write what the research recommended instead.
3. **"What changed in the product"** comes from sourced impact items
   (change, status, source, date, finding IDs). **Zero impact items is the
   normal case** shortly after a study, and an email with none is complete.
   No source, no status, no email line. Never upgrade a status; "planned"
   does not become "coming soon."

## Privacy: the recipient learns nothing about anyone else

- No other participant is identifiable at either tier: no names, no
  companies, no narrowing role-plus-context, and no quotes from anyone but
  the recipient.
- Aggregate the counts ("feedback from operators at eight organizations,"
  not "5 of 8").
- Send individually; never a visible CC list of participants.
- Only email people whose consent covers recontact (check the tracker).
- Nothing internal travels to an external recipient: no links, code names,
  or ticket numbers.

## Structure

1. **Subject** — plain and honest: "What we learned from your feedback on
   [product/topic]." Not "what we did" unless shipped changes anchor it.
2. **Thanks, anchored** (1–2 sentences) — which study, roughly when, what
   topic.
3. **What we heard** (2–4 short lines) — aggregated themes in the
   recipient's language; finding IDs stay in your working notes.
4. **How it's informing us** (the core, always present) — each line in its
   honest form. When nothing is decided yet, say so plainly: "no decisions
   yet; the findings are in front of the team now."
5. **What's changed in the product** (only when sourced items exist; omit
   the section entirely otherwise) — shipped first, then in-progress, then
   planned, each labeled in plain words.
6. **What we're still weighing** (optional, 1–2 lines) — one line per
   unmoved theme, no defensiveness.
7. **The door stays open** (1–2 sentences).
8. **Sign-off** — a named person, their role, their real address. Never
   from Dr. Morgan, and never sent by anyone but that person.

## Before it sends

Read it as the recipient six months from now, checking it against the
product: no sentence they could reasonably have heard as a commitment the
team never made. Read it as their colleague who was not in the study: no
other participant inferable. The product owner confirms every impact item
and every "considering" line. Then the gates, then the sign-off (§11), then
a person sends it from their own address.

---

*Part of the Dr. Morgan UX research suite. Manual alternative to
`skills/participant-impact-summary`; §4.9 applies either way.*
