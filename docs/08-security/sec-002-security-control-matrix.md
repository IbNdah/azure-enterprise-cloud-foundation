# SEC-002 — Security Control Matrix

| Control | Implementation | Status |
|---|---|---|
| IAM / Least Privilege | Azure RBAC + dedicated role assignment module | Implemented |
| Managed Identity | User-assigned Managed Identity for platform Key Vault access | Implemented |
| Secrets | Azure Key Vault with RBAC authorization | Implemented |
| Private Connectivity | Private Endpoint + Private DNS for Key Vault | Implemented |
| Logging / Audit | Diagnostic Settings → centralized Log Analytics | Implemented |
| CSPM | Defender for Cloud Foundational CSPM (Free) | Configured |
| Terraform Security | CI validation + IaC security scanning | In progress |

## Key Principle
Each control has a defined implementation location, owner, and validation method. Security controls are enforced through reusable Terraform modules where appropriate.
