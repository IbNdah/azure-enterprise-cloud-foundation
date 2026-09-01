# GOV-007 – Azure Policy Strategy

| **Document ID** | GOV-007 |
|---|---|
| **Version** | 1.1 |
| **Status** | Approved |
| **Owner** | Cloud Platform Team |
| **Audience** | Cloud Architects, Platform Engineers, Security Engineers |
| **Classification** | Internal Use Only |

---

# 1. Purpose

This document defines how Azure Policy is used to enforce governance standards across the Azure Enterprise Cloud Foundation.

The objective is to automate compliance while applying controls at the highest appropriate scope.

---

# 2. Policy Principles

| Principle | Description |
|---|---|
| Policy-driven | Use Azure Policy for standards that can be reliably evaluated. |
| Highest Appropriate Scope | Assign policies where they provide useful inheritance without excessive exceptions. |
| Built-in First | Prefer built-in definitions when they meet the requirement. |
| Appropriate Effect | Use Deny, Audit or DeployIfNotExists according to the control objective. |
| Continuous Review | Monitor compliance and adjust policies as requirements evolve. |

---

# 3. Policy Assignment Model

```text
Management Group
        │
        ▼
   Policy Assignment
        │
        ▼
   Subscription
        │
        ▼
 Resource Group / Resource
```

Policy inheritance follows the Azure resource hierarchy.

---

# 4. Current Governance Policies

| Policy Area | Purpose | Typical Effect |
|---|---|---|
| Allowed Locations | Restrict deployment to approved regions | Deny |
| Required Tags | Require defined metadata | Deny / Modify where appropriate |
| Resource Types | Restrict selected resource types where required | Deny |
| Secure Configuration | Enforce supported secure settings | Deny / Audit |
| Diagnostics | Enable required diagnostics where practical | DeployIfNotExists |
| Encryption | Require supported encryption controls | Deny / Audit |

Private connectivity and service-specific controls are applied where justified by workload requirements rather than through a blanket requirement for every resource.

---

# 5. Policy Effects

| Effect | Use |
|---|---|
| Deny | Block non-compliant deployments. |
| Audit | Record non-compliance without blocking deployment. |
| DeployIfNotExists | Deploy required supporting configuration when appropriate. |
| Modify | Adjust resource properties when supported and appropriate. |

---

# 6. Implementation & Lifecycle

Policies are managed through Infrastructure as Code.

```text
Policy Definition
       ↓
Policy Assignment
       ↓
Terraform
       ↓
Azure
       ↓
Compliance Monitoring
```

Policy changes are reviewed and validated before deployment.

---

# 7. Design Decision

## Decision

Use Azure Policy as the primary mechanism for automated Azure governance.

## Rationale

Azure Policy provides centralized enforcement and compliance visibility while reducing reliance on manual controls.

---

# 8. Related Documents & Key Takeaways

| Document | Relationship |
|---|---|
| GOV-001 | Governance Strategy |
| GOV-002 | Management Groups |
| GOV-003 | Subscription Strategy |
| GOV-006 | RBAC |
| GOV-008 | Tagging |
| GOV-009 | Landing Zones |
| ADR-008 | Security Baseline |

**Key takeaway:** Azure Policy enforces defined standards; it does not replace architecture, RBAC or operational processes.
