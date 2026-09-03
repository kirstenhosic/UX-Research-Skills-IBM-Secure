---
name: participant-impact-summary
description: >-
  Write a short, participant-facing email that closes the loop with the
  people who gave research feedback — external customers and internal
  participants alike: what we heard (aggregated from findings records that
  already passed the gates), how it is informing the team, and — only when
  they exist and are sourced — what changed in the product. Use this whenever
  someone wants to show participants their feedback was used, thank research
  participants with substance, or send a "you said, we did" update. Trigger
  on "participant impact summary," "customer impact summary," "closing the
  loop," "share findings with participants," "feedback follow-up email,"
  "show customers what we did with their feedback," or "participant
  thank-you with updates," even when the word "skill" isn't used. Dr. Morgan
  offers this at the end of every findings sequence. The safety destination
  is set by who the recipient is, never chosen, and a person sends the
  email; this skill only drafts it.
---

# Participant Impact Summary

Draft the email a participant actually wants to receive after giving
feedback: short, specific, and honest about what happened to what they said.
Closing the loop is the cheapest way to keep people willing to talk to
research again, and that is as true of the platform engineer two floors up
as of the customer.

**The honest core of this email is "here is what you taught us," not "here
is what we changed."** Most of the time this email goes out, no product
decision has been made yet — the findings are days or weeks old, and that
is normal, not a gap to paper over. What the feedback *informed* is always
true and always sayable: what the team now understands, what it is weighing
as a result. Concrete product changes are the bonus section, present only
when they actually exist and can be sourced. An email that says "here is
what we learned from you and what we're considering" earns the next study;
one that dresses consideration up as commitment spends it, and gets checked
against the product later.

**The destination is set by the recipient, never chosen:**

| Recipient (`participant_type`) | Destination | The bar |
|---|---|---|
| `customer-direct` / `sme-external` | `external` | The highest in the suite |
| `internal-direct` / `internal-proxy` | `internal-org` | An email inside IBM gets forwarded inside IBM |

A study with both kinds of participant gets **two drafts**, one per tier,
each cleared at its own bar. Never one email serving both: the internal
version legitimately carries detail the external one must not, and a single
text either leaks to the customer or patronizes the colleague.

Every rule below follows from two facts: the reader took part in the study,
and the sender is a person on the team whose name is on it.

## What this skill draws from

Three kinds of claim go into this email, and they have different sources.

**"What we heard" comes from findings records** that already passed the
findings sequence (`FINDINGS-CONTRACT.md`; §4.2 of `EVALUATION-LOOP.md`).
Same rendering rule as every downstream artifact in this suite: if it isn't
in a passed record, it doesn't go in the email. Aggregate before rendering
(see the privacy rules below).

**"How it's informing us" is a claim about the team's understanding**, and
it is the one kind that is always available, because a finding that passed
the gates *did* inform the team by existing. Two honest forms, and know
which you are writing:

- *What the research surfaced or recommended* — sourced by the findings
  records themselves, and attributed to the research: "this pushed our
  research to recommend rethinking the setup order." True the moment the
  findings released, and it commits the team to nothing.
- *What the team is actually weighing* — "we're considering X" is a claim
  about the team, and it needs the team behind it: a PM's confirmation, a
  backlog or planning item, with a name and date. Without that, don't write
  "we're considering"; write what the research recommended, which is the
  claim you can stand behind. The gap between those two sentences is
  exactly where participants get misled.

**"What changed in the product" comes from impact items**, which are claims
about the product, so no findings record can carry them. This section is
the bonus, not the spine: **zero impact items is the normal case** shortly
after a study, and an email with none is complete. When they exist, collect
each one from the user and hold it to this shape:

```
IMPACT I1
  change:    Permission outcomes now appear before method selection in
             the auth setup flow.
  status:    shipped            (shipped / in-progress / planned /
                                 under-consideration)
  source:    Vault 1.19 release notes            (or: PM name + date of
                                                  confirmation)
  date:      2026-08-14
  from:      F1, F3             (the finding IDs this change answers)
```

No source, no status, no email line. A product claim you cannot source is
not cautious phrasing away from being usable; it is missing. Ask the user
for the source or drop the item, and never upgrade a status ("planned"
does not become "coming soon" because it reads better).

## Privacy rules — the recipient must learn nothing about anyone else

This is the rule the safety gate will hold hardest, so build to it from the
first line:

- **No other participant is identifiable — at either tier.** No names, no
  companies, no roles-plus-context that narrow to a person ("the platform
  lead at a Nordic bank we spoke to"), and **no quotes from anyone other
  than the recipient**. A quote is identifiable to its speaker even without
  a name. This holds for internal recipients too, and if anything bites
  harder there: a colleague who knows the org can subtract their way to a
  roster far faster than a customer can.
- **Aggregate the counts.** "Feedback from operators at eight
  organizations," not "5 of 8 operators." Exact small-n counts are the
  right discipline in the findings report and an identification risk in
  this email: a recipient who knows the study size can start subtracting.
  Both tiers.
- **The recipient's own words:** referencing their own feedback back to
  them is the point of the email, and it is fine when the consent terms
  cover it. Paraphrase rather than quote unless consent explicitly covered
  quoting, and never reveal that their individual comment was or wasn't
  the deciding one.
- **Send individually.** One recipient (or one account team) per email,
  mail-merged if needed. Never a visible CC list of research participants;
  the list itself is a disclosure.
- **Recontact must be consented.** Only email people whose consent terms
  cover follow-up contact — internal participants consented to terms too,
  and theirs govern the same way. If the user isn't sure, that is a
  question for them to resolve before a draft exists, not after.
- **What travels scales with the tier.** To an external recipient, nothing
  internal: no internal links, dashboards, code names, ticket numbers, or
  unreleased-feature detail beyond what the impact item's source already
  makes shareable. To an internal recipient, internal detail is welcome
  where it helps — the ticket that tracked their issue, the internal
  feature name, a link to the released docs — provided the impact item's
  source supports it and it identifies no other participant.

## What the email never does

- **Never promises.** `shipped` is a fact; `in-progress` and `planned` are
  labeled as intentions and carry no dates unless the source carries one
  the team is willing to be quoted on; `under-consideration` says exactly
  that. The reader should be unable to construct a commitment the team
  didn't make.
- **Never oversells.** No "we're thrilled," no "game-changing," no claims
  that the product is now excellent. The email's credibility is its
  restraint; the customer will check the claims against the product.
- **Never hides the unmoved feedback.** If a theme they raised has no
  action yet, say so in one honest line. Customers know their feedback
  didn't all land; pretending otherwise reads as spin and burns the next
  study's goodwill.
- **Never implies a decision that hasn't been made.** This is the failure
  the email is most prone to, because it happens through phrasing rather
  than through any false sentence: "we're considering" when only the
  research recommended, "informing our roadmap" when nothing has reached a
  roadmap, a confident paragraph rhythm that lets a reader hear commitment
  in a list of maybes. Consideration is not commitment, a recommendation is
  not a plan, and when no decision exists yet the email says so in plain
  words — "no decisions yet; the findings are in front of the team now" —
  which participants consistently receive as honesty, not as failure.
- **Never comes from Dr. Morgan.** The sender is a named person on the
  team (the researcher or the PM). The draft says who.

## Structure

Target 200 to 350 words. A customer gives this one read on a phone.

1. **Subject line** — plain and specific, and honest in all cases: "What we
   learned from your feedback on Vault auth methods." Not clever, not
   marketing, and not "what we did" unless shipped changes actually anchor
   the email.
2. **Thanks, anchored** (1-2 sentences) — which study, roughly when, on
   what topic. "Earlier this year you spent an hour with us on Vault's
   auth method setup."
3. **What we heard** (2-4 short lines) — the aggregated themes, in
   customer language. Each line traces to finding IDs in your working
   notes; the IDs themselves stay out of the email.
4. **How it's informing us** (the core, always present) — what the
   feedback changed about the team's understanding and what's being
   weighed as a result, each line in its honest form: research
   recommendation attributed to the research, or team consideration backed
   by the team. When no decision exists yet, this section says so in plain
   words rather than reaching for momentum it doesn't have.
5. **What's changed in the product** (only when sourced impact items
   exist — omit the section entirely otherwise, never pad it) — `shipped`
   first, then `in-progress`, then `planned`, each labeled in plain words:
   "shipped in 1.19," "being built now," "on the roadmap, no date yet."
6. **What we're still weighing** (optional, 1-2 lines) — one line per
   unmoved theme, no defensiveness.
7. **The door stays open** (1-2 sentences) — how to keep the feedback
   coming, and whether the team would welcome a follow-up session.
8. **Sign-off** — a named person, their role, their real address.

### Skeleton

```
Subject: What we learned from your feedback on <product / topic>

Hi <name>,

<Thanks, anchored to the study.>

Here's what we heard from you and others we spoke with:

- <theme 1, in customer language>
- <theme 2>

Here's how that's shaping our thinking:

- <what the team now understands differently, or what the research
  recommended — attributed as such>
- <what the team is actually weighing — only with the team behind it>

[Only if sourced impact items exist:]
And some of it has already landed:

- <change> — shipped in <release>.
- <change> — being built now.

<The honest line. When nothing is decided yet, say it plainly:
"We don't have product changes to point to yet — the findings are in
front of the team now, and they're shaping how we think about <topic>.">

<Door-open line.>

<Name>
<Role>, <team>
```

Adapt freely; the skeleton is a shape, not boilerplate to fill. Write it
per `VOICE-AND-STYLE.md`: plain sentences, varied length, no sentence
interrupted by an em dash or en dash, no vendor-speak vocabulary. Warm is
good; casual-for-effect is not.

## QA before it goes to the gates

- Every "what we heard" line maps to passed finding records; every
  "informing us" line is in its honest form (research recommendation
  attributed to the research, or team consideration with a named team
  source); every product-change line maps to an impact item with status,
  source, and date. Anything unmapped comes out.
- Read it as the recipient, six months from now, checking it against the
  product: is there any sentence they could reasonably have heard as a
  commitment the team never made? "Considering," "weighing," and
  "recommended" must read as exactly what they are.
- If no decision has been made yet, does the email say so plainly, or
  does the phrasing manufacture momentum? The plain version is the one
  that survives the recipient's memory.
- Read it as the recipient's colleague who wasn't in the study: can they
  identify any other participant, or infer the study's size or roster?
  If yes, aggregate harder.
- Read it as the team's PM: does any line commit to anything the source
  doesn't support? Planned items carry no implied dates?
- Count the words. Over 350, cut impact items before cutting honesty.
- Participant names, emails, and phone numbers appear nowhere; the
  recipient's own name and address are the only personal data present.

## The gates, and the two humans

The draft goes through the suite's gates before anyone sends it:
`research-safety-checker` first, at the bar the recipient sets (`external`
for customers and external SMEs, `internal-org` for internal participants;
a two-tier study's two drafts each clear their own), then
`research-synthesis-checker` in impact mode (heard-lines against findings
records, informing-lines against their honest source — the research itself,
or a named team confirmation — and product-change lines against sourced
impact items), then
`research-readability-checker`. §4.9 of `EVALUATION-LOOP.md` is the
Definition of Done.

Two sign-offs sit outside the gates, and the draft is not done without
them:

1. **The product owner confirms every impact item and every "we're
   considering" line** — status and wording. The gate can check that a
   source is named; only the PM can check that the source is still true,
   and that the team would recognize itself in what the email says it is
   weighing.
2. **A person sends it**, from their own address, after reading every word
   as themselves, making their own edits, and recording the release
   sign-off (§11 of `EVALUATION-LOOP.md`). Of every artifact in this
   suite, this is the one where an unread sentence costs the most: it
   lands in a participant's inbox under a real name. This skill drafts; it
   never sends, schedules, or addresses mail, and it flags any request to
   do so back to the user.

---

*Part of the Dr. Morgan UX research suite. Author: **Kirsten Hosic**, UX
Research Strategy Lead, Security Product Design.*
