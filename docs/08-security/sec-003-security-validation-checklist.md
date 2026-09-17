# SEC-003 — Security Validation Checklist

## Identity & Access
- [x] Managed Identity created.
- [x] Azure RBAC role assignment configured.
- [x] Key Vault access validated.
- [x] No static secret required for platform identity.

## Network
- [x] Key Vault Private Endpoint deployed.
- [x] Private DNS zone `privatelink.vaultcore.azure.net` configured.
- [x] VNet link configured.
- [x] Private DNS resolution validated.

## Logging & Audit
- [x] Central Log Analytics Workspace used.
- [x] Key Vault Diagnostic Settings configured.
- [x] Key Vault audit events visible in Log Analytics.
- [x] Successful `SecretResourceGet` event validated.

## Posture Management
- [x] Foundational CSPM configured as Free.
- [ ] Azure posture assessment completed/visible.

## Terraform
- [x] Remote state architecture established.
- [x] Secrets excluded from Git.
- [ ] CI validation and IaC scan finalized.

## Result
Implemented controls have been technically validated where marked `[x]`. Items marked `[ ]` remain open.
