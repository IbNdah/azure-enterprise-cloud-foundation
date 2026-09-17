# SEC-005 — Defender for Cloud / CSPM

## Objective
Provide baseline cloud security posture management for the Azure foundation.

## Design Decision
The foundation uses **Defender for Cloud Foundational CSPM (Free)**.

This provides a baseline posture-management capability without enabling the paid Defender CSPM plan.

## Terraform
```hcl
resource "azurerm_security_center_subscription_pricing" "defender_cspm" {
  tier          = "Free"
  resource_type = "CloudPosture"
}
```

## Validation
- Foundational CSPM: **Free**
- Status: **On**
- Paid Defender CSPM: **Off**
- Current assessment/recommendation data: pending Azure posture assessment.

## Architectural Role
CSPM complements, but does not replace:
- Azure RBAC
- Private connectivity
- Key Vault
- Logging and audit
- Terraform security controls

## Status
**Configured — validation of posture assessment remains open.**
