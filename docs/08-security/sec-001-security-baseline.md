# SEC-001 — Security Baseline

## Objective
Establish the minimum security baseline for the Azure Enterprise Cloud Foundation.

## Controls
- **Identity:** Microsoft Entra ID and Azure RBAC.
- **Least privilege:** Permissions are assigned only where required and at the smallest practical scope.
- **Managed Identity:** Preferred over static credentials for Azure workload/service authentication.
- **Secrets:** Stored in Azure Key Vault; no secrets in Terraform code or Git.
- **Network security:** Private connectivity is preferred for supported Azure services.
- **Logging:** Security-relevant resource diagnostics are sent to the centralized Log Analytics Workspace.
- **Posture management:** Foundational CSPM is enabled through Defender for Cloud.
- **Infrastructure as Code:** Terraform changes are validated and security-scanned through CI.

## Baseline Principle
Security is implemented as a layered control model: **Identity → Network → Secrets → Monitoring → Posture → IaC**.
