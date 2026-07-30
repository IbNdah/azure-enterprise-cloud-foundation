# GOV-006 – RBAC Strategy

| **Document ID** | GOV-006 |
|-----------------|---------|
| **Version** | 1.0 |
| **Status** | Approved |
| **Owner** | Cloud Platform Team |
| **Audience** | Cloud Architects, Platform Engineers, Security Engineers |

---

# 1. Purpose

This document defines the Role-Based Access Control (RBAC) strategy for the Azure Enterprise Cloud Foundation.

The objective is to ensure secure and controlled access to Azure resources based on the principle of least privilege.

---

# 2. RBAC Principles

The RBAC strategy follows these principles:

- Apply the Principle of Least Privilege.
- Assign permissions to groups rather than individual users.
- Use Azure built-in roles whenever possible.
- Grant permissions at the highest appropriate scope.
- Review access permissions regularly.

---

# 3. Access Model

```text
Users
   │
   ▼
Microsoft Entra ID Groups
   │
   ▼
Azure RBAC Roles
   │
   ▼
Management Groups
Subscriptions
Resource Groups
Resources
```

---

# 4. Administrative Roles

| Role | Responsibility |
|------|----------------|
| **Platform Administrators** | Manage the Azure platform and shared services. |
| **Network Administrators** | Manage networking and connectivity resources. |
| **Security Administrators** | Manage security policies and identity services. |
| **Application Teams** | Deploy and manage application resources. |
| **Readers** | Read-only access for auditing and reporting. |

---

# 5. Scope Assignment

| Scope | Typical Assignment |
|-------|--------------------|
| Management Group | Platform governance roles |
| Subscription | Platform and application administrators |
| Resource Group | Application teams |
| Resource | Exceptional cases only |

---

# 6. Design Benefits

- Improved security
- Simplified administration
- Consistent access management
- Reduced operational risk
- Scalable permission model

---

# 7. Design Decision

## Decision

Use Microsoft Entra ID groups with Azure RBAC built-in roles to manage access across the platform.

## Rationale

Group-based access management improves security, simplifies administration and reduces the risk of permission inconsistencies.

---

# 8. Related Documents

| Document | Description |
|----------|-------------|
| GOV-001 | Cloud Governance Strategy |
| GOV-002 | Management Groups Strategy |
| GOV-003 | Subscription Strategy |
| GOV-007 | Azure Policy Strategy |

---

# Key Takeaways

- Access is granted through Microsoft Entra ID groups.
- Permissions follow the Principle of Least Privilege.
- Azure built-in roles are preferred over custom roles.
- RBAC assignments are applied at the highest appropriate scope.
