# SEC-007 — Security Governance

## Objective

Ensure that security controls remain traceable, reviewable, and aligned with the enterprise governance model.

## Governance Principles

- Security controls are defined before implementation.
- Azure Policy provides the primary governance mechanism for enforceable controls.
- Terraform is the authoritative implementation mechanism for managed infrastructure.
- Security-relevant changes are reviewed through Git and CI.
- Security exceptions must be explicit, justified, scoped, and time-bound.
- Central logging supports auditability and operational review.
- Security posture is continuously improved through compliance and control reviews.

## Security Governance Baseline

The Security & Governance Baseline is implemented through an Azure Policy Initiative:

| Control | Effect |
|---|---|
| Allowed resource locations | Deny |
| Required resource tags | Deny |
| Key Vault diagnostic settings | DeployIfNotExists |

The initiative is assigned at subscription scope using a SystemAssigned managed identity.

## Control Ownership

| Area | Responsibility |
|---|---|
| Azure Policy / Governance | Platform Management |
| Identity / RBAC | Platform Security |
| Key Vault / Secrets | Platform Security |
| Connectivity Security | Connectivity / Platform |
| Logging / Audit | Management + Security |
| Terraform / CI | Platform / Engineering |
| Exceptions | Security Governance |

## Policy Remediation

Policy remediation uses least-privilege RBAC for the SystemAssigned policy identity.

`DeployIfNotExists` was validated with the Key Vault diagnostic settings policy. During testing, remediation conflicted with an existing Terraform-managed diagnostic setting.

No additional policy or Terraform abstraction was introduced.

Terraform remains responsible for managed infrastructure; Azure Policy provides governance and compliance enforcement.

## Security Exceptions

Security exceptions must be documented, justified, scoped, and time-bound where applicable.

No active exception is currently defined for the implemented S9 controls.

## Status

**Implemented — S9 Security / Governance Hardening completed.**

Final architectural consolidation is part of **S10 — Final Architecture**.
