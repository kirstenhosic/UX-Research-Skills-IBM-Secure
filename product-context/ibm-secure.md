# IBM Secure

> **Maintainer:** Kirsten Hosic, UX Research Strategy Lead, Security Product Design
> · **Last reviewed:** 2026-08 · **Status:** current
>
> The default context for this suite, and the one mirrored inside
> `agents/dr-morgan.agent.md` so it survives being pasted into a chat with no file
> access. Format: [`../PRODUCT-CONTEXT.md`](../PRODUCT-CONTEXT.md).

**One sentence:** IBM Secure is a family of infrastructure security products —
HashiCorp Vault, Boundary, Consul, Terraform, and Vault Radar — used by platform,
security, and DevOps teams to manage secrets, access, service networking,
infrastructure as code, and secret sprawl.

Five products, one context file. They share a persona population and a set of
research traps; where they diverge, the per-product sections say so.

---

## Personas

- **Platform engineers** — mid to senior. Accountable for the infrastructure other
  teams build on. Deep technical depth; low tolerance for a study that wastes
  their time.
- **Security engineers** — mid to senior. Accountable for credential hygiene,
  access policy, and audit posture. Reads everything through a risk lens.
- **DevOps engineers / SREs** — accountable for delivery and uptime. Encounter
  these products as dependencies rather than as their primary tool.
- **IT and infrastructure admins** — accountable for access provisioning and
  standing infrastructure. Heaviest users of Boundary.
- **Application security (AppSec) and enterprise InfoSec teams** — accountable for
  findings triage and remediation across many development teams. Primary Vault
  Radar personas.
- **Governance and compliance teams** — accountable for policy enforcement and
  audit evidence. Encounter Terraform through Sentinel policy sets.

## Configurer vs. daily user

**Different people, almost always, and this is the trap to watch.** The person who
configures these tools is rarely the person using them daily. A platform engineer
who sets up a Vault auth method and an application developer who authenticates
through it hold different mental models, pursue different goals, and hit
different walls. Challenge any finding that conflates them; require every finding
to say which role it applies to.

## Key workflows

**HashiCorp Vault** — secrets management
- Secret engines, auth methods, policies, leasing and renewal

**HashiCorp Boundary** — secure remote access without VPNs
- Target management, session recording, identity-based access

**HashiCorp Consul** — service networking and network security
- Service mesh, health checking, service discovery across hybrid environments

**Terraform** — infrastructure as code with policy enforcement via Sentinel
- Workspace management, policy sets, state management, remote runs

**Vault Radar** — automated detection of unmanaged secrets in code, scanning
continuously in real time for secrets, PII, and non-inclusive language (NIL),
surfacing detected risks by category and rank for remediation
- Risk dashboard triage, reviewing detections by category and severity,
  remediation

## Recurring research themes

- **Vault** — cognitive load of policy management; mental models around the
  secret lifecycle; operator versus end-user splits
- **Boundary** — trust and visibility; access anxiety; workflow disruption during
  incidents
- **Consul** — observability mental models; complexity at scale; cross-team
  coordination friction
- **Terraform** — policy-as-code adoption friction; collaboration between platform
  and app teams; compliance visibility
- **Vault Radar** — finding trust and noise; prioritization under volume;
  remediation workflow friction across dev and security teams

## Domain challenges

- **High-stakes, compliance-sensitive environments.** When interpreting behavior,
  always ask whether participants were operating under real constraints —
  security policy, audit requirements, incident pressure. If so, that context is
  part of the finding, not background to it.
- **Deployment scale and regulatory environment change everything.** Findings from
  a ten-person startup using Vault are not transferable to a regulated financial
  institution. Challenge any synthesis that ignores deployment scale, regulatory
  environment, or organizational structure.
- **Don't conflate practitioners across products.** A Vault engineer and a
  Terraform engineer may share a job title and have very different contexts.
  Every finding names which product and which persona.
- **Realistic environment versus lab task.** For enterprise infrastructure tools,
  whether a participant worked in their own environment or a simplified lab task
  significantly changes what the data supports. Ask, every time.

## Recruitment reality

- **No direct user access.** Customer recruitment routes through Product Managers
  or Customer Account teams, who email customers directly. Weeks, not days;
  dependent on PM and Account availability; subject to customer response rates;
  inappropriate for high-frequency or longitudinal studies; often limited in
  screener specificity.
- **External SMEs as the alternative.** Practitioners in matching roles who are
  not IBM customers. Faster and more flexible; directionally valid but not
  customer-specific; better suited to generative, mental-model, and workflow
  research than to evaluative research on IBM-specific implementations. Requires
  a careful screener, and is always disclosed in findings as "external SME
  participants, not IBM customers."
- **Senior technical participant profile.** Recruiting is slower than consumer
  research, tolerance for a poorly designed study is low, sessions must be
  tightly scoped, and async methods (diary studies, unmoderated testing) are
  often better received than synchronous ones.

*Confirm these still hold before planning against them — access, panels, and
tooling change, and a stale constraint quietly shrinks the options.*

## Vocabulary

Product and domain jargon is generally correct with this audience; stripping it
sounds condescending and costs precision. The mismatches worth watching are
abstractions the product team uses and practitioners don't.

| Participants say | The product says |
|---|---|
| "creds", "certs", "keys" | "secrets" |
| "who can get to what" | "access policy", "entitlements" |
| "rotating a password" | "lease renewal", "dynamic credentials" |
| naming the specific tool | "secrets-management posture", "security posture" |

## What we do not know

- How much of the operator/end-user split holds outside Vault and Boundary
- Whether Vault Radar's finding-trust theme is about the detections themselves or
  about the volume they arrive in
