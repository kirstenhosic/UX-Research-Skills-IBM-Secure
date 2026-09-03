# At a Glance card — build reference

The reference implementation for the default participant-summary format.
Governed by `../SKILL.md`; palette and type come from `DESIGN-SYSTEM.md`.

## Specification

| Property | Value |
|---|---|
| Canvas | 1200 × 1500 CSS px, portrait |
| Export | PNG at `--force-device-scale-factor=2` → 2400 × 3000 |
| Padding | 64px top/bottom, 72px left/right |
| Font | IBM Plex Sans (Google Fonts import, system sans fallback) |
| Title | 50pt, 700, Blue 60 `#0F62FE`, two lines via `<br>` |
| Subtitle | 22pt, 400, Gray 70 `#525252` |
| Accent rule | 4px, Blue 60, full width |
| Stat tiles | Gray 10 `#F4F4F4`, 6px Blue 60 left bar, 40pt number |
| Callout | Gray 10, 6px Blue 60 left bar, 25pt text |
| Section labels | 19pt, 700, Gray 70, uppercase, `.07em` tracking |
| Condition rows | 1px `#E4EAEF` border, 52px Blue 60 numbered square |
| Bullets | 10px Blue 60 squares (`::before`), never round |
| Footer | 1px top border, 14pt Gray 70, `space-between` |

Card height is fixed. `margin-top: auto` on the footer absorbs slack, so
moderate copy changes reflow without breaking the layout. If content
overflows, cut copy — do not shrink the type below the sizes above.

## Render

```bash
"/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" \
  --headless --disable-gpu --hide-scrollbars \
  --force-device-scale-factor=2 --window-size=1200,1500 \
  --screenshot="Product_ParticipantSummary_AtAGlance_2026-09.png" \
  at-a-glance.html
```

Any Chromium binary works. **A browser-tool screenshot is not a substitute** —
a shared browser window is viewport-constrained and silently clips the card.
Always render headless, then view the PNG to confirm.

## Copy patterns

### Title
```
What You Told Us About Adopting [Product]
```
Second person, always. Not "Study 1 Results," not "What We Learned."

### Subtitle
```
[Study name] — what we heard from you, at a glance
```
Never "a sanitized summary for our participants." See `SKILL.md`.

### Stat tiles
```
10          | platform, security, and field practitioners
In depth    | one-on-one conversations
3           | conditions that make adoption work
```
Tile 1 is a count with a role descriptor, not a bare number. Tile 2 is
qualitative; never a session duration. Tile 3 matches the conditions below.

### Headline callout
Label `WHAT WE HEARD`, then one sentence, bold on the operative phrase:

```
Adoption moves fastest when the platform team can make the change on
their own terms, without asking application teams to do anything
differently.
```

Enablement framing. Not "you are not saying no," not "three unsolved
problems." Write this last.

### Conditions

Title is a condition for success. Body opens with an attribution verb.

```
1  Application teams should never feel the change
   You described success as an adoption your application teams never
   notice. Platform engineering makes the change, with no application
   code changes and no re-approvals.

2  Existing API calls should keep working as they are
   You asked for a compatibility layer, for example a proxy or wrapper,
   that accepts your existing API calls and routes them behind the
   scenes, so hundreds of working integrations stay untouched.

3  Non-Human Identity support from the start
   You told us NHI management is why many of your organizations run this
   at all, so seeing those workflows fully supported is what makes
   adoption feel realistic.
```

Condition 2 is the pattern for naming a capability without previewing a
design: the capability is "a compatibility layer," the mechanism is
explicitly "for example."

### Secondary list

Where restricted commercial topics get replaced by the need underneath:

```
Clear guidance you can take into your own governance and approval processes
Evidence and examples that reflect environments like yours, not demo conditions
Predictability, so adoption can be planned well ahead rather than reacted to
```

The third line is the safe expression of a retirement-timeline request.
It carries the participant's actual need without signaling an end-of-life
plan to their procurement team.

### Footer
```
left:  Thank you for your time and candor. What you shared is informing
       our product thinking.
right: Anonymized — no names, accounts, or individual attribution  |  [Month Year]
```
"Informing our product thinking," never "shaping the roadmap." Date required.

## Reference HTML

```html
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>[Study] — At a Glance</title>
<style>
  @import url('https://fonts.googleapis.com/css2?family=IBM+Plex+Sans:wght@400;600;700&display=swap');
  * { box-sizing: border-box; margin: 0; padding: 0; }
  body { font-family: 'IBM Plex Sans', -apple-system, 'Segoe UI', Helvetica, Arial, sans-serif; background: #fff; }
  .card { width: 1200px; height: 1500px; padding: 64px 72px; display: flex; flex-direction: column; }
  .eyebrow { font-size: 17px; font-weight: 600; color: #525252; letter-spacing: .06em; text-transform: uppercase; }
  h1 { font-size: 50px; font-weight: 700; color: #0F62FE; line-height: 1.1; margin-top: 16px; }
  .sub { font-size: 22px; color: #525252; margin-top: 14px; }
  .rule { height: 4px; background: #0F62FE; margin: 28px 0 36px; }

  .stats { display: flex; gap: 20px; }
  .stat { flex: 1; background: #F4F4F4; border-left: 6px solid #0F62FE; padding: 22px 24px; }
  .stat .n { font-size: 40px; font-weight: 700; color: #161616; line-height: 1.05; }
  .stat .l { font-size: 15px; color: #525252; margin-top: 10px; line-height: 1.35; }

  .headline { background: #F4F4F4; border-left: 6px solid #0F62FE; padding: 28px 30px; margin: 36px 0 40px; }
  .headline .k { font-size: 15px; font-weight: 700; color: #0F62FE; text-transform: uppercase; letter-spacing: .06em; }
  .headline p { font-size: 25px; color: #161616; line-height: 1.42; margin-top: 12px; }
  .headline b { font-weight: 600; }

  h2 { font-size: 19px; font-weight: 700; color: #525252; text-transform: uppercase; letter-spacing: .07em; margin-bottom: 22px; }

  .reqs { display: flex; flex-direction: column; gap: 18px; }
  .req { display: flex; gap: 22px; align-items: flex-start; border: 1px solid #E4EAEF; padding: 22px 24px; }
  .req .num { flex: 0 0 52px; height: 52px; background: #0F62FE; color: #fff; font-size: 24px; font-weight: 700;
              display: flex; align-items: center; justify-content: center; }
  .req .t { font-size: 22px; font-weight: 600; color: #161616; line-height: 1.3; }
  .req .d { font-size: 16px; color: #525252; margin-top: 8px; line-height: 1.45; }

  .next { margin-top: 36px; }
  .next ul { list-style: none; display: flex; flex-direction: column; gap: 12px; margin-top: 6px; }
  .next li { font-size: 17px; color: #161616; padding-left: 26px; position: relative; line-height: 1.4; }
  .next li::before { content: ''; position: absolute; left: 0; top: 8px; width: 10px; height: 10px; background: #0F62FE; }

  footer { margin-top: auto; border-top: 1px solid #E4EAEF; padding-top: 18px;
           display: flex; justify-content: space-between; font-size: 14px; color: #525252; }
</style>
</head>
<body>
<div class="card">
  <div class="eyebrow">Secure UX Design &nbsp;|&nbsp; [Product]</div>
  <h1>What You Told Us About<br>Adopting [Product]</h1>
  <div class="sub">[Study] &mdash; what we heard from you, at a glance</div>
  <div class="rule"></div>

  <div class="stats">
    <div class="stat"><div class="n">[N]</div><div class="l">[role descriptor]</div></div>
    <div class="stat"><div class="n">In&nbsp;depth</div><div class="l">one-on-one conversations</div></div>
    <div class="stat"><div class="n">3</div><div class="l">conditions that make adoption work</div></div>
  </div>

  <div class="headline">
    <div class="k">What we heard</div>
    <p>[One sentence, <b>bold on the operative phrase</b>.]</p>
  </div>

  <h2>The three conditions you told us matter most</h2>
  <div class="reqs">
    <div class="req">
      <div class="num">1</div>
      <div>
        <div class="t">[Condition]</div>
        <div class="d">You described [...]</div>
      </div>
    </div>
    <!-- conditions 2 and 3 follow the same block -->
  </div>

  <div class="next">
    <h2>You also told us the non-technical side matters</h2>
    <ul>
      <li>[Need]</li>
    </ul>
  </div>

  <footer>
    <span>Thank you for your time and candor. What you shared is informing our product thinking.</span>
    <span>Anonymized &mdash; no names, accounts, or individual attribution &nbsp;|&nbsp; [Month Year]</span>
  </footer>
</div>
</body>
</html>
```

## Pre-release checklist

**Safety**
- No participant IDs, names, company or account names
- No exact prevalence counts
- No verbatim quotes
- No role title identifying one person

**Commitment**
- Every condition body opens with "You described / You asked for / You told us"
- No retirement, end-of-life, licensing, pricing, or support-window language
- Mechanisms appear as "for example," never as description
- Footer says "informing our product thinking," not "shaping the roadmap"
- Month and year present

**Framing**
- "Adoption," not "migration," including derived forms
- Conditions for success, not blockers
- No line mirroring internal doubt back at the customer
- Subtitle does not call the document "sanitized"

**Craft**
- Second person throughout
- No em dash interrupting a sentence
- Acronyms expanded on first use
- Rendered headless, PNG viewed, nothing clipped or overflowing

## Other formats

**Short email body.** Drafted by the `participant-impact-summary` skill, not
this one. 150 words max. Three bolded conditions inline, one line
on what happens next, card embedded. No attachment: the highest open rate of
anything here, because corporate laptops make downloads a chore.

**"You said / We heard" one-pager (`.docx`).** Two columns: the requirement
in their language, then what it means for product thinking. Renders through
`research-document-template.py` with a `sections` config. Set
`footer_note` to the anonymization disclosure and destination.

**Slide summary.** Five slides: what we asked, three conditions, what happens
next. Export PDF so it renders on any machine.

**Video walkthrough.** Script only. Video cannot be redacted after sending
and is difficult to review before it goes out; requires comms/legal sign-off.
