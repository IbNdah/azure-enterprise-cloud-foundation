# ADR-004 — Enterprise Management Group Hierarchy

| **Attribute**    | **Value**                             |
| ---------------- | ------------------------------------- |
| **ADR ID**       | ADR-004                               |
| **Title**        | Enterprise Management Group Hierarchy |
| **Status**       | Accepted                              |
| **Date**         | 2026-08-24                            |
| **Authors**      | Cloud Architecture Team               |
| **Program**      | OneCloud 2030                         |
| **Organization** | Mandara Global                        |
| **Category**     | Governance                            |

---

# 1. Executive Summary

Mandara Global will use a structured Azure Management Group hierarchy to organize subscriptions and apply enterprise governance consistently.

The hierarchy separates shared platform subscriptions from workload subscriptions and provides distinct governance boundaries for Corp, Online and Sandbox workloads.

The hierarchy is intentionally kept simple to avoid unnecessary Management Group complexity.

---

# 2. Business Context

As the Azure footprint grows, subscriptions require a consistent governance structure for:

* Azure Policy
* RBAC
* Security controls
* Subscription organization
* Cost governance
* Compliance

A Management Group hierarchy provides the required governance boundaries while allowing subscriptions to remain independently managed within those boundaries.

---

# 3. Problem Statement

Subscriptions alone do not provide an enterprise hierarchy for applying common governance controls.

Without Management Groups, governance would require repeated configuration at subscription level and would become harder to maintain as the number of subscriptions increases.

A common hierarchy is therefore required to provide consistent governance inheritance.

---

# 4. Decision

Mandara Global will organize Azure subscriptions using the following Management Group hierarchy:

```text
Tenant Root
│
└── Mandara Global
    │
    ├── Platform
    │
    ├── Landing Zones
    │   ├── Corp
    │   ├── Online
    │   └── Sandbox
    │
    └── Decommissioned
```

The hierarchy defines governance boundaries.

The `Platform` Management Group contains subscriptions hosting shared platform services.

The `Landing Zones` Management Group contains workload subscriptions.

`Corp`, `Online` and `Sandbox` provide different workload governance boundaries.

The `Decommissioned` Management Group contains subscriptions that are no longer active but must remain under controlled governance.

Platform capabilities such as Management, Connectivity, Security, Operations and Identity are **not** represented as separate Management Groups unless a future governance requirement explicitly requires such a boundary.

---

# 5. Decision Scope

This decision applies to:

* Azure Management Groups
* Azure subscriptions
* Azure Policy assignments
* RBAC inheritance
* Governance initiatives
* Subscription placement
* Future Landing Zone deployments

Architectural exceptions require review by the Enterprise Architecture Board.

---

# 6. Decision Drivers

The hierarchy is designed to:

* Provide clear governance boundaries
* Support policy inheritance
* Simplify subscription organization
* Separate platform and workloads
* Avoid unnecessary hierarchy depth
* Support future subscription growth
* Maintain clear ownership boundaries

---

# 7. Architectural Principles

The Management Group hierarchy follows these principles:

* Governance through hierarchy
* Policy inheritance
* Least Privilege
* Separation of Platform and Workloads
* Clear Subscription Placement
* Minimal Hierarchy
* Automation through Infrastructure as Code
* Explicit Governance Boundaries

---

# 8. High-Level Architecture

```text
                         Tenant Root
                              │
                       Mandara Global
                              │
             ┌────────────────┼────────────────┐
             │                │                │
             ▼                ▼                ▼
         Platform       Landing Zones     Decommissioned
                              │
                    ┌─────────┼─────────┐
                    │         │         │
                   Corp     Online    Sandbox
                    │         │         │
                    └─────────┼─────────┘
                              │
                        Subscriptions
                              │
                        Resource Groups
                              │
                           Resources
```

Governance flows through the hierarchy:

```text
Management Group
        │
        ├── Azure Policy
        ├── RBAC
        └── Governance Controls
        │
        ▼
Subscription
        │
        ▼
Resource Group
        │
        ▼
Resource
```

Management Groups organize subscriptions for governance. They do not represent platform capabilities or workload environments.

---

# 9. Expected Benefits

## Business Benefits

* Consistent governance
* Clear subscription organization
* Easier onboarding
* Controlled subscription lifecycle

## Technical Benefits

* Policy inheritance
* Consistent RBAC boundaries
* Reduced governance duplication
* Clear platform/workload separation
* Simple and extensible hierarchy

---

# 10. Alternatives Considered

| Option                                    | Decision     | Main Reason                                                  |
| ----------------------------------------- | ------------ | ------------------------------------------------------------ |
| **Flat Subscription Model**               | Rejected     | Governance becomes repetitive and difficult to scale         |
| **Business Unit Hierarchies**             | Rejected     | Can create inconsistent governance structures                |
| **Enterprise Management Group Hierarchy** | **Selected** | Provides common governance boundaries while remaining simple |

---

# 11. Consequences

## Positive

* Consistent governance inheritance
* Clear subscription placement
* Separation of platform and workload governance
* Reduced policy duplication
* Simple hierarchy

## Trade-offs

* Requires centralized governance ownership
* Subscription placement must follow defined rules
* Changes to the hierarchy require governance review

These trade-offs are accepted to maintain a consistent enterprise governance model.

---

# 12. Related Documents

* GOV-002 — Management Groups Strategy
* GOV-003 — Subscription Strategy
* GOV-006 — RBAC Strategy
* GOV-007 — Azure Policy Strategy
* GOV-009 — Landing Zone Design
* ADR-001 — Enterprise Landing Zone Architecture
* ADR-002 — Hub & Spoke Network Architecture
* ADR-005 — Private Networking Strategy
* ADR-006 — Enterprise Identity Strategy
* ADR-008 — Enterprise Security Baseline

---

# 13. Review

This decision should be reviewed when significant changes occur to:

* Azure Management Group capabilities
* Governance requirements
* Organizational structure
* Security or compliance requirements
* Enterprise cloud operating model

---

# 14. References

* Microsoft Cloud Adoption Framework
* Azure Management Groups documentation
* Azure Architecture Center
* Azure Landing Zone guidance
