# Product context

How Dr. Morgan gets specific about *your* product.

Generic research advice is nearly useless. "Define your participants" is true
everywhere and helps nowhere; "your operators and your end users are different
people with different mental models, and this finding conflates them" only
lands if the agent knows what an operator is on your product. That specificity
is what this directory holds.

The suite was written for IBM Secure and that context ships as the default. Any
IBM team can use it on any product — the mechanism below is how.

---

## How Dr. Morgan resolves context

In order, stopping at the first that works:

1. **A file in `product-context/`.** If the repo is connected and the researcher
   names a product with a file here, that file is the context. The directory
   listing is the menu.
2. **The default.** `product-context/ibm-secure.md`, which is also mirrored
   inside `agents/dr-morgan.agent.md` so the agent still knows it when pasted
   into a chat with no file access.
3. **A short intake, asked in conversation.** No file matches, or no repo is
   connected: Dr. Morgan asks five questions (below), works from the answers,
   and offers to write them up as a file you can add here.
4. **Nothing.** The researcher declines or doesn't know yet. Dr. Morgan works
   product-neutral and marks every claim that *would* have been product-specific
   as `[product context: not provided]`.

Step 4 is the one that matters most. **Dr. Morgan does not invent product
context.** An agent that guesses your personas will guess them plausibly, and a
plausible wrong persona in a research plan is worse than an obvious gap —
someone will recruit against it.

## The intake

The five questions Dr. Morgan asks when there's no file. They map one-to-one
onto the file format, so an answered intake *is* a draft context file.

1. **What is the product, in one sentence a new hire would understand?**
2. **Who are the core personas?** Roles, seniority, and technical depth — and
   in particular, is the person who configures it the person who uses it daily?
3. **What are the key workflows?** The three or four things people actually come
   to the product to do.
4. **What does research on this product keep running into?** Recurring themes,
   known friction, questions the team argues about.
5. **What constrains recruiting?** Who you can reach, through whom, and how long
   it takes.

Answer what you know and say "don't know" to the rest — a partial context beats
a fabricated one, and Dr. Morgan will tell you which of its guidance is running
without it.

## Adding your product

Copy [`product-context/TEMPLATE.md`](product-context/TEMPLATE.md) to
`product-context/<your-product>.md`, fill it in, and open a pull request. Two
rules:

- **Write what is true, not what is aspirational.** This file feeds research
  plans. A persona listed here because the team wishes it existed will end up in
  a screener.
- **Date it and own it.** Put your name and the date at the top. Product context
  goes stale faster than anything else in this repo, and a reader needs to know
  whether they're looking at something current.

## The file format

| Field | Required | What goes in it |
|---|---|---|
| `product` | yes | Name, and the one-sentence description |
| `personas` | yes | Each with role, technical depth, and what they're accountable for |
| `configurer vs. user` | yes | Are they the same person? If not, how they differ. The single most common source of conflated findings in enterprise tooling |
| `key workflows` | yes | The three or four jobs people come to the product to do |
| `recurring research themes` | no | What studies keep surfacing. Powerful when present, safe to omit |
| `domain challenges` | no | Product-specific traps Dr. Morgan should raise unprompted — beyond the universal ones in the agent |
| `recruitment reality` | no | Access path, realistic timeline, viable alternatives. Overrides the Scenario B defaults, which describe the IBM Secure team |
| `vocabulary` | no | Terms participants use versus terms the product uses. Feeds the jargon check in `research-guide-checker` |
| `maintainer` and `last reviewed` | yes | Who to ask, and how stale this is |

Everything optional is genuinely optional. A file with the four required fields
is a real improvement over no file.

## What product context does not do

It does not lower any bar. The gates, the rubrics, the behavioral-question
standard, and the safety tiers are identical on every product. Context makes the
guidance specific; it never makes it looser.

---

*Author: **Kirsten Hosic**, UX Research Strategy Lead, Security Product Design.*
