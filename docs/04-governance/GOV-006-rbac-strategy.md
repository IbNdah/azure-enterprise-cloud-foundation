# GOV-006 – RBAC Strategy

| **Document ID** | GOV-006 |
|---|---|
| **Version** | 1.1 |
| **Status** | Approved |
| **Owner** | Cloud Platform Team |
| **Audience** | Cloud Architects, Platform Engineers, Security Engineers |
| **Classification** | Internal Use Only |

---

# 1. Purpose

This document defines the Role-Based Access Control (RBAC) strategy for the Azure Enterprise Cloud Foundation.

The objective is to provide controlled access based on role, responsibility and least privilege.

---

# 2. RBAC Principles

| Principle | Description |
|---|---|
| Least Privilege | Grant only the access required. |
| Group-based Access | Prefer Microsoft Entra ID groups over direct user assignments. |
| Built-in Roles | Prefer Azure built-in roles where they satisfy the requirement. |
| Appropriate Scope | Assign permissions at the smallest practical scope that supports the responsibility; broader scope is used when justified. |
| Separation of Duties | Avoid combining conflicting administrative responsibilities. |
| Regular Review | Access should be reviewed periodically. |

---

# 3. Access Model

```text
Users / Workload Identities
            │
            ▼
     Microsoft Entra ID
            │
            ▼
      Groups / Roles
            │
            ▼
       Azure RBAC
            │
     ┌──────┼──────┐
     ▼      ▼      ▼
Management Subscription Resource Group
Groups
```

---

# 4. Administrative Roles

| Role | Responsibility |
|---|---|
| Platform Administrators | Shared platform services and platform subscriptions |
| Network Administrators | Connectivity and networking |
| Security Administrators | Security controls and security services |
| Application Teams | Application resources within assigned scopes |
| Readers / Auditors | Read-only access for monitoring and review |

Exact Azure built-in roles are selected according to the required permissions.

---

# 5. Scope Assignment

| Scope | Typical Use |
|---|---|
| Management Group | Enterprise governance roles where required |
| Subscription | Platform or workload administration |
| Resource Group | Application team administration |
| Resource | Exceptional or narrowly scoped permissions |

The scope should be no broader than necessary.

---

# 6. Access Lifecycle

RBAC follows:

```text
Request
  ↓
Approval
  ↓
Assignment
  ↓
Review
  ↓
Removal / Adjustment
```

Privileged access should use appropriate controls such as PIM where available and required.

---

# 7. Design Decision

## Decision

Use Microsoft Entra ID groups and Azure RBAC, primarily using built-in roles, with permissions assigned at the appropriate scope.

## Rationale

This provides a manageable access model while supporting least privilege and clear administrative responsibilities.

---

# 8. Related Documents & Key Takeaways

| Document | Relationship |
|---|---|
| GOV-001 | Governance Strategy |
| GOV-002 | Management Groups |
| GOV-003 | Subscription Strategy |
| GOV-007 | Azure Policy |
| ADR-006 | Enterprise Identity Strategy |

**Key takeaway:** RBAC defines who can do what and where; Management Groups and subscriptions provide scopes through which access can be inherited.
