# GOV-007 – Azure Policy Strategy

| **Document ID** | GOV-007 |
|-----------------|---------|
| **Version** | 1.0 |
| **Status** | Approved |
| **Owner** | Cloud Platform Team |
| **Audience** | Cloud Architects, Platform Engineers, Security Engineers |

---

# 1. Purpose

This document defines the Azure Policy strategy for the Azure Enterprise Cloud Foundation.

The objective is to enforce governance standards automatically and ensure that Azure resources comply with organizational requirements.

---

# 2. Policy Principles

The Azure Policy strategy follows these principles:

- Enforce governance through automation.
- Prevent non-compliant deployments.
- Apply policies at the highest appropriate scope.
- Use built-in Azure Policies whenever possible.
- Continuously monitor compliance.

---

# 3. Policy Assignment Model

```text
Management Group
        │
        ▼
Azure Policy
        │
        ▼
Subscription
        │
        ▼
Resource Group
        │
        ▼
Azure Resources
```

Policies are inherited through the Azure resource hierarchy, ensuring consistent governance across the platform.

---

# 4. Core Policies

| Policy | Purpose |
|---------|---------|
| **Allowed Regions** | Restrict resource deployment to approved Azure regions. |
| **Mandatory Tags** | Ensure required resource tags are applied. |
| **Allowed Resource Types** | Limit deployment to approved Azure resource types. |
| **HTTPS Only** | Enforce secure communication for supported services. |
| **Diagnostic Settings** | Enable monitoring and logging. |
| **Encryption at Rest** | Ensure data is encrypted by default. |
| **Private Endpoints** | Encourage private connectivity where applicable. |
| **Allowed SKUs** | Restrict deployment to approved service tiers. |

---

# 5. Policy Effects

| Effect | Purpose |
|--------|---------|
| **Deny** | Prevent non-compliant deployments. |
| **Audit** | Identify non-compliant resources without blocking deployment. |
| **DeployIfNotExists** | Automatically deploy required configurations. |

---

# 6. Design Benefits

- Automated governance
- Improved security
- Consistent compliance
- Reduced configuration drift
- Simplified auditing

---

# 7. Design Decision

## Decision

Use Azure Policy as the primary governance mechanism to enforce organizational standards across the platform.

## Rationale

Azure Policy enables consistent, automated governance while reducing manual validation and improving compliance.

---

# 8. Related Documents

| Document | Description |
|----------|-------------|
| GOV-001 | Cloud Governance Strategy |
| GOV-002 | Management Groups Strategy |
| GOV-006 | RBAC Strategy |
| GOV-009 | Landing Zone Design |

---

# Key Takeaways

- Governance is enforced automatically through Azure Policy.
- Policies are assigned at the highest appropriate scope.
- Built-in Azure Policies are preferred over custom policies.
- Compliance is continuously monitored across the platform.
