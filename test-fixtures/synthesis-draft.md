# Vault auth method configuration — draft findings

## Summary

In conclusion, participants had a range of experiences with the auth method
workflow, with both positive and negative feedback emerging. Some areas worked
well for participants. Other areas presented challenges for participants. The
team should consider several improvements to the overall experience.

## F1 — Operators think in permissions, not methods

Operators approach auth method configuration with a permission-based mental
model, while Vault presents a method-based one. This mismatch causes them to
grant broader access than intended.

- 3 of 4 participants (P1, P2, P4 — all operators)
- P1: "I want to say this team gets these secrets. I don't really care whether
  that's userpass or OIDC underneath."
- P2: "I picked userpass because it was first, and assumed permissions would
  follow."
- P4: "Auth methods map to how the org is structured, not how Vault is
  structured. That mismatch is where people get lost."

Scope: Vault, platform operators, configuring a new auth method.
Disconfirming: none found.
Recommendation: Surface the permission outcome before method selection.
Owner: Priya (Design).

## F2 — Manual rotation is effectively unused

Most participants said they never rotate secrets manually, relying on
automation instead.

- P1: "Rotation? We automate it. I've never done one by hand."
- P2: "Manual rotation, no. That's a scripted thing for us."

Scope: Vault, platform operators.
Recommendation: Deprioritise manual rotation improvements for Q4.

## F3 — The policy screen is a dead end

Operators repeatedly fail to reach the policy screen from the method picker,
and some have stopped trying.

- P2: "It took me three tries to get to the policy screen."
- P4: "I've basically given up on the policy UI, I just use the CLI now."

Scope: Vault, platform operators.

## F4 — Operators keep path references outside Vault

Every operator we spoke to maintains a personal, external record of namespace
paths because Vault offers no scannable view of them.

- P1: "I keep a text file with all our namespace paths. Vault doesn't show them
  anywhere I can scan quickly."
- P2: "I've got a sticky note on my monitor with the paths. Everyone does."

Scope: Vault, platform operators.

## F5 — Users found the interface complex

Users found the interface complex and had difficulty completing tasks.

## Method note

4 remote sessions, July 2026. P1, P2, P4 platform operators; P3 (Senior SRE at
Meridian Financial) is an application developer consuming secrets.
