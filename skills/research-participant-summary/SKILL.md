---
name: research-participant-summary
description: >-
  Produce the artifact that goes back to the people who gave you their time:
  a sanitized, high-level summary of what a study heard, written for study
  participants and participating accounts rather than for internal
  stakeholders. Default output is a one-page "At a Glance" card (PNG, IBM
  Carbon design system); also produces a short email body, a "You said / We
  heard" one-pager .docx, and a slide-ready summary. Use whenever someone
  wants to close the loop with participants, thank an account, share results
  back with customers, or send a study recap externally. Trigger on "close
  the loop," "share back with participants," "participant summary," "customer
  recap," "thank-you summary," "what we heard card," or "send results to the
  accounts we interviewed," even when the word "skill" isn't used. This is an
  externally-destined artifact and is governed by the commitment-safety rules
  below, which are stricter than any internal report.
---

# Research Participant Summary

The findings report tells your organization what to build. This tells the
people you interviewed that talking to you mattered. Different reader,
different risk profile, different document — and the second one is the one
that keeps your recruiting pipeline alive for the next study.

Most teams skip it, then wonder why the same accounts stop returning emails.
A participant who sees their own words shape a roadmap says yes again. One
who hears nothing for six months assumes the session went into a drawer.

> **This artifact leaves your company.** Everything in
> `research-findings-report/SKILL.md` about participant anonymization applies
> here and then some. The rules in "The commitment problem" below are not
> style preferences; they are the reason this skill exists as its own thing
> instead of a smaller findings report.

## The reader you're actually writing for

Not your PM. Not your director. A platform engineer at a regulated bank who
gave you sixty minutes between incidents, and who may forward this to their
own leadership to justify having spent that hour.

That last clause governs the whole document. Write something they can forward
without it creating a problem for them or for you.

Three consequences:

- **Punchy, not playful.** These are senior practitioners in security and
  infrastructure. Humor reads as unserious to someone who told you a bad
  transition would blow up their architecture review. Get your energy from
  density and specificity, never from jokes or exclamation points.
- **Their language, not your taxonomy.** No finding IDs, no RQ numbers, no
  "prevalence," no method vocabulary. If a sentence would need a glossary,
  rewrite it.
- **Show their fingerprints.** The delight here is recognition: seeing their
  own requirement in print, in their words. That is the entire emotional
  payload. Nothing else needs to carry it.

## The commitment problem — read this before writing a word

A participant summary states requirements that came *from customers* on a
document that carries *your company's logo*. Without deliberate framing,
every requirement reads as a promise. A customer holds it up in a QBR nine
months later, and your PM has a problem you created.

**The attribution rule — non-negotiable.** Every substantive statement opens
with an explicit attribution to the participant, not to the company:

| Write this | Never this |
|---|---|
| "You described success as…" | "Success means…" |
| "You asked for a compatibility layer" | "We will ship a compatibility layer" |
| "You told us NHI support is why you run this" | "NHI parity is a prerequisite" |
| "You also told us predictability matters" | "We are publishing a timeline" |

The second column is what a first draft always produces. Check every line.

**Topics that need a commercial or legal owner before they appear.** These
are not yours to communicate, even when a participant raised them, and even
when you frame them as their request. Putting them in writing to a customer
sends a signal their procurement team will act on.

- **Retirement, end-of-life, sunset, or deprecation timing.** The highest-risk
  item on this list. Writing "you asked for a retirement date" tells a
  customer's commercial team that retirement is being actively planned, which
  can trigger contract renegotiation or a competitive evaluation. Default:
  **cut it.** Express the underlying need as *predictability* or *planning
  horizon* instead.
- **Licensing, pricing, and commercial terms.** Owned by PM and commercial
  leadership. Default: cut, or replace with the governance-support need
  underneath it.
- **Open-source status, support windows, and contractual commitments.** Same
  rule.
- **Specific implementation approaches.** Name the *capability* the customer
  asked for; offer any mechanism only as illustration, never as a description
  of what is being built. "A compatibility layer — for example, a proxy or
  wrapper — that accepts your existing calls" demonstrates that you understood
  the mechanism without previewing a design.

When you cut one of these, say so to the researcher in chat, name what you
replaced it with, and tell them who owns the message. Don't silently drop a
finding.

**Framing: conditions for success, not a list of blockers.** The same
evidence can read as "here is what makes this work for you" or as "here are
three unsolved problems with our product." A customer executive who wasn't in
the sessions reads the second one as a warning. Organize around enablement.
This is honest — the findings genuinely describe what success requires — and
it is far stronger.

**Never mirror your own doubt back at a customer.** Lines like "you're not
saying no" or "you're not rejecting this" reveal that refusal was live inside
your company. The customer never framed it that way. Say what makes adoption
work, not what you were afraid of.

**Word choice.** Prefer **adoption** over **migration**. "Migration" frames
the customer as the object of something being done to them and centers cost
and disruption; "adoption" centers their decision and their timeline. Sweep
for derived forms too ("migration tooling," "migrating workloads"). Product
teams that have standardized on other neutral vocabulary should follow their
own convention — the principle is that the customer is the actor.

## Anonymization: stricter than the internal report

The findings report uses numeric participant IDs (`P1`–`P10`). **A participant
summary carries no IDs at all.**

IDs are internal scaffolding. To a participant they mean nothing, and worse,
they signal that per-person attribution exists somewhere — which invites a
reader at a multi-participant account to work out who said what. Aggregate
everything into "you" and "participants."

Also excluded:

- **Company and account names**, including the reader's own. Yes, they know
  who they are. The document still gets forwarded.
- **Exact prevalence counts** ("3 of 4 direct customers"). Counts are load-
  bearing internally and identifying externally: at a four-person account,
  "3 of 4" is a puzzle with a solvable answer. Use unquantified aggregate
  language here. This is the one place in the suite where dropping exact
  counts is correct, and it is because the audience changed, not because the
  standard relaxed.
- **Verbatim quotes.** A distinctive phrasing identifies its speaker to
  colleagues who were in the room. Paraphrase into collective voice.
- **Role titles specific enough to identify one person** ("your Field CTO").

Carry over unchanged from the internal standard: no names, no emails, no
phone numbers, and the name-to-ID mapping never touches a file.

## Formats

Default to the **At a Glance card**. Offer the others; build what they pick.
More than one is often right — the email carries the message, the card
carries the credibility.

| Format | Output | Best for | Effort |
|---|---|---|---|
| **At a Glance card** (default) | `.png` from HTML | Email embed, Slack, forwarding. Highest reach, lowest friction | Low |
| **Short email body** | Markdown | No attachment to open on a locked-down corporate laptop. Highest open rate of anything here | Lowest |
| **"You said / We heard" one-pager** | `.docx` | The artifact a participant forwards to their own leadership | Medium |
| **Slide summary** | `.pptx` or PDF | An account walking their own team through it | Medium |
| **Video walkthrough** | script only | Warmest, but cannot be redacted after sending. Requires comms/legal sign-off; produce a script, never the recording | High |

**Recommended pairing:** short email body with the At a Glance card embedded.
The email carries the punch, the card carries the credibility, and the reader
chooses how deep to go.

## The At a Glance card — required structure

One page, portrait, 1200×1500 CSS pixels rendered at 2× for retina. Full
build instructions and the reference HTML: `references/at-a-glance-card.md`.

Six zones, top to bottom:

1. **Eyebrow** — `Secure UX Design  |  [Product]`, uppercase, Gray 70. The
   team branding standard applies to this artifact like every other.
2. **Title + subtitle** — Title is `What You Told Us About Adopting [Product]`,
   Blue 60, 50pt, two lines. The second person is the whole point; do not
   retitle this to something about the study. Subtitle names the study and
   what the reader is looking at. Never describe the document as "sanitized"
   or "anonymized" in the subtitle — that language belongs in the footer as a
   disclosure, and in the title area it makes a warm document feel legal.
3. **Three stat tiles** — Gray 10 fill, Blue 60 left accent bar. Participant
   count with a role descriptor, a qualitative depth marker, and the number of
   conditions. **Do not put session length here.** Nobody outside research
   cares, and "60 min" invites sample-size arithmetic. Prefer "In depth" over
   any duration.
4. **Headline callout** — Gray 10 with the Blue 60 accent bar, one sentence,
   the single thing you heard. Enablement framing, bold on the operative
   phrase. This is the sentence that gets remembered; write it last, after the
   three conditions are settled.
5. **Three numbered conditions** — bordered rows, Blue 60 numbered square,
   bold title, then a supporting line that **opens with "You described / You
   asked for / You told us."** Three is the number: two looks thin, four
   stops being scannable at a glance.
6. **Secondary list** — the non-technical needs, blue square bullets. Three
   items. This is where commercially-owned topics get replaced with their
   underlying need.

**Footer, two halves.** Left: a thank-you plus a soft impact statement.
Right: the anonymization disclosure and a **month and year**. The date is
required — an undated customer-facing artifact circulates indefinitely and
gets read as current a year later.

**Footer language is a commitment surface.** "Informing our product thinking"
is safe. "Shaping the roadmap" is a soft promise. Use the former.

## Voice

`VOICE-AND-STYLE.md` governs, with these emphases:

- **Second person throughout.** "You told us," "your application teams,"
  "environments like yours." A participant summary written in third person
  has missed the point.
- **No em dash interrupting a sentence** (item 22). This bites harder here
  than anywhere else in the suite, because the format invites appositives.
  "You asked for a compatibility layer, for example a proxy or wrapper, that
  accepts your existing calls" — commas, not dashes.
- **No exact counts, and this is the exception to the usual rule.** See
  anonymization above. Everywhere else in the suite, "6 of 8" beats "most."
  Here, aggregate language is required.
- **Warm, not effusive.** One genuine thank-you in the footer. Not three.
- **Expand every acronym on first use.** "Non-Human Identity (NHI)" — a
  participant knows their own domain, but this document gets forwarded to
  people who don't.

## Workflow

1. **Start from the internal findings report or findings records.** If neither
   exists, say that this artifact should follow synthesis rather than
   substitute for it.
2. **Select three conditions.** The ones with the strongest evidence that are
   also safe to state externally. Strength alone doesn't qualify a finding.
3. **Run the commitment scan.** Every line against the attribution rule and
   the restricted-topic list. Report what you cut and who owns it.
4. **Run the anonymization scan.** Names, accounts, IDs, counts, quotes,
   identifying roles.
5. **Draft the copy, then write the headline callout last.**
6. **Render**, and view the rendered PNG before returning it. A layout that
   overflows is not a deliverable.
7. **Hand off with the review reminder** (below).

## Gates and handoff

`EVALUATION-LOOP.md` §4.9 is the Definition of Done for this artifact. Runs
`research-safety-checker` (pre-flight, mandatory, at the `external` bar —
this artifact leaves the company) and `research-readability-checker`.
`research-synthesis-checker` applies when findings records exist.

§4.9 makes seven items blocking, and three of them invert rules that hold
everywhere else in the suite: no participant IDs, no exact counts, no
verbatim quotes. That is deliberate. The audience changed, not the standard.

Add one check the other gates don't cover: **the commitment scan**. Re-read
every line as an unfriendly reader at the participant's company. Does any
sentence, absent its attribution, read as something the customer could hold
you to? Fix by restoring the attribution, softening to a capability, or
cutting.

Close every delivery with this, in the researcher's chat:

> This is a customer-facing artifact. Please review it yourself before it
> leaves IBM, and route it through whoever owns customer communications for
> your product — commitment language is easy to introduce and expensive to
> retract. Confirm your PM is comfortable with the capability statements
> before it goes to a named account.

Never present a participant summary as ready to send. It is ready to review.

## Naming

`[Product]_ParticipantSummary_AtAGlance_[YYYY-MM].png` alongside its `.html`
source, so copy can be edited and re-rendered without rebuilding the layout.
