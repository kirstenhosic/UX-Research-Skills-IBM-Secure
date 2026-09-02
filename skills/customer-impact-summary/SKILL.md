---
name: customer-impact-summary
description: >-
  Write a short, customer-facing email that closes the loop with external
  customers who gave research feedback: what we heard (aggregated from
  findings records that already passed the gates) and what the product team
  did about it (impact items, each carrying a status label and a named
  source). Use this whenever someone wants to show customers their feedback
  was used, thank research participants with substance, or send a "you said,
  we did" update. Trigger on "customer impact summary," "closing the loop,"
  "share findings with customers," "feedback follow-up email," "show
  customers what we did with their feedback," or "participant thank-you with
  updates," even when the word "skill" isn't used. The destination is
  external by definition, the safety bar is the highest in the suite, and a
  person sends the email; this skill only drafts it.
---

# Customer Impact Summary

Draft the email a customer actually wants to receive after giving feedback:
short, specific, and honest about what happened to what they said. Closing
the loop is the cheapest way to keep customers willing to talk to research
again. An email that says "we heard you, here is what changed, here is what
hasn't yet" earns the next study; a vague thank-you or an overpromise spends
it.

This artifact is **`external`, always.** That is not a field to fill in; it
is what the artifact is. Every rule below follows from two facts: the reader
is a customer, and the sender is a person on the team whose name is on it.

## What this skill draws from

Two kinds of claim go into this email, and they have different sources.

**"What we heard" comes from findings records** that already passed the
findings sequence (`FINDINGS-CONTRACT.md`; §4.2 of `EVALUATION-LOOP.md`).
Same rendering rule as every downstream artifact in this suite: if it isn't
in a passed record, it doesn't go in the email. Aggregate before rendering
(see the privacy rules below).

**"What we did" comes from impact items**, which are claims about the
product, not about the research, so no findings record can carry them.
Collect each one from the user and hold it to this shape:

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

- **No other participant is identifiable.** No names, no companies, no
  roles-plus-context that narrow to a person ("the platform lead at a
  Nordic bank we spoke to"), and **no quotes from anyone other than the
  recipient**. A quote is identifiable to its speaker even without a name.
- **Aggregate the counts.** "Feedback from operators at eight
  organizations," not "5 of 8 operators." Exact small-n counts are the
  right discipline internally and an identification risk externally: a
  participant who knows the study size can start subtracting.
- **The recipient's own words:** referencing their own feedback back to
  them is the point of the email, and it is fine when the consent terms
  cover it. Paraphrase rather than quote unless consent explicitly covered
  quoting, and never reveal that their individual comment was or wasn't
  the deciding one.
- **Send individually.** One recipient (or one account team) per email,
  mail-merged if needed. Never a visible CC list of research participants;
  the list itself is a disclosure.
- **Recontact must be consented.** Only email people whose consent terms
  cover follow-up contact. If the user isn't sure, that is a question for
  them to resolve before a draft exists, not after.
- Nothing internal travels: no internal links, dashboards, code names,
  ticket numbers, or unreleased-feature detail beyond what the impact
  item's source already makes shareable.

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
- **Never comes from Dr. Morgan.** The sender is a named person on the
  team (the researcher or the PM). The draft says who.

## Structure

Target 200 to 350 words. A customer gives this one read on a phone.

1. **Subject line** — plain and specific: "What we did with your feedback
   on Vault auth methods." Not clever, not marketing.
2. **Thanks, anchored** (1-2 sentences) — which study, roughly when, on
   what topic. "Earlier this year you spent an hour with us on Vault's
   auth method setup."
3. **What we heard** (2-4 short lines) — the aggregated themes, in
   customer language. Each line traces to finding IDs in your working
   notes; the IDs themselves stay out of the email.
4. **What we've done** (the core, one line per impact item) — lead with
   `shipped` items, then `in-progress`, then `planned`, each labeled in
   plain words: "shipped in 1.19," "being built now," "on the roadmap,
   no date yet."
5. **What we're still weighing** (optional, 1-2 lines) — the honest
   section. One line per unmoved theme, no defensiveness.
6. **The door stays open** (1-2 sentences) — how to keep the feedback
   coming, and whether the team would welcome a follow-up session.
7. **Sign-off** — a named person, their role, their real address.

### Skeleton

```
Subject: What we did with your feedback on <product / topic>

Hi <name>,

<Thanks, anchored to the study.>

Here's what we heard from you and others we spoke with:

- <theme 1, in customer language>
- <theme 2>

And here's where that's landed:

- <change> — shipped in <release>.
- <change> — being built now.
- <change> — on the roadmap; no date to share yet.

<One honest line about what's still being weighed, if anything.>

<Door-open line.>

<Name>
<Role>, <team>
```

Adapt freely; the skeleton is a shape, not boilerplate to fill. Write it
per `VOICE-AND-STYLE.md`: plain sentences, varied length, no sentence
interrupted by an em dash or en dash, no vendor-speak vocabulary. Warm is
good; casual-for-effect is not.

## QA before it goes to the gates

- Every "what we heard" line maps to passed finding records; every "what
  we've done" line maps to an impact item with status, source, and date.
  Anything unmapped comes out.
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
`research-safety-checker` first, at the **external** bar, then
`research-synthesis-checker` in impact mode (heard-lines against findings
records, did-lines against sourced impact items), then
`research-readability-checker`. §4.9 of `EVALUATION-LOOP.md` is the
Definition of Done.

Two sign-offs sit outside the gates, and the draft is not done without
them:

1. **The product owner confirms every impact item** — status and wording.
   The gate can check that a source is named; only the PM can check that
   the source is still true.
2. **A person sends it**, from their own address, after reading it as
   themselves. This skill drafts; it never sends, schedules, or addresses
   mail, and it flags any request to do so back to the user.

---

*Part of the Dr. Morgan UX research suite. Author: **Kirsten Hosic**, UX
Research Strategy Lead, Security Product Design.*
