# ADR-004 — Enterprise Management Group Hierarchy

| **Attribute**    | **Value**                             |
| ---------------- | ------------------------------------- |
| **ADR ID**       | ADR-004                               |
| **Title**        | Enterprise Management Group Hierarchy |
| **Status**       | Accepted                              |
| **Date**         | 2026-07-31                            |
| **Authors**      | Cloud Architecture Team               |
| **Program**      | OneCloud 2030                         |
| **Organization** | Mandara Global                        |
| **Category**     | Governance                            |

---

# 1. Executive Summary

As part of the **OneCloud 2030** transformation program, Mandara Global has decided to implement a standardized **Azure Management Group hierarchy** to govern all Azure subscriptions consistently across the enterprise.

The Management Group hierarchy establishes a scalable governance model that enables centralized policy enforcement, role-based access control (RBAC), budget management, and operational consistency while allowing individual business units to operate independently within defined governance boundaries.

This Architectural Decision Record documents the rationale behind adopting a structured enterprise Management Group hierarchy aligned with Microsoft Cloud Adoption Framework (CAF) guidance.

---

# 2. Business Context

Mandara Global is expanding its Azure footprint across multiple business units, development teams, and geographical regions.

Without a standardized governance hierarchy, Azure subscriptions would evolve independently, making it increasingly difficult to:

* Apply enterprise security policies
* Standardize access management
* Manage compliance
* Control cloud spending
* Delegate operational responsibilities
* Scale governance as the organization grows

The **OneCloud 2030** program requires a governance model capable of supporting enterprise-scale cloud adoption while balancing centralized control and operational autonomy.

---

# 3. Problem Statement

Azure subscriptions represent administrative boundaries but do not provide enterprise governance on their own.

Without a Management Group hierarchy, Mandara Global would face:

* Inconsistent Azure Policy assignments
* Fragmented RBAC administration
* Duplicate governance configurations
* Difficult compliance reporting
* Complex subscription onboarding
* Limited operational visibility
* Increased governance overhead

A hierarchical governance structure is required to standardize policy enforcement and simplify enterprise cloud management.

---

# 4. Decision

Mandara Global will organize all Azure subscriptions using a hierarchical **Management Group** structure.

The hierarchy will separate **Platform** services from **Landing Zones** while providing dedicated governance boundaries for Production, Non-Production, and Sandbox environments.

Enterprise governance components—including Azure Policy, RBAC assignments, budget controls, and compliance initiatives—will be assigned at the highest appropriate Management Group level to maximize consistency and reduce administrative overhead.

The hierarchy will remain flexible enough to support future acquisitions, additional business units, and regional expansion without requiring structural redesign.

---

# 5. Decision Scope

This decision applies to:

* All Azure subscriptions
* All Management Groups
* Enterprise governance assignments
* Azure Policy initiatives
* RBAC inheritance
* Cost management structure
* Future Landing Zone deployments

Any deviation from the approved hierarchy requires review and approval by the Enterprise Architecture Board.

---

# 6. Decision Drivers

This decision supports the following strategic objectives:

* Standardize enterprise governance
* Simplify subscription management
* Strengthen security enforcement
* Improve compliance
* Reduce governance complexity
* Enable scalable cloud growth
* Improve operational consistency
* Simplify onboarding of new business units
* Centralize governance management

---

# 7. Architectural Principles

The Management Group hierarchy follows these principles:

* Governance by Design
* Hierarchical Policy Inheritance
* Least Privilege Administration
* Separation of Duties
* Enterprise Standardization
* Scalable Governance
* Platform before Workloads
* Automation First
* Operational Simplicity
* Compliance by Default

---

# 8. High-Level Architecture

```text id="2hyqwf"
Tenant Root Group
│
└── Mandara Global
    │
    ├── Platform
    │     ├── Identity
    │     ├── Connectivity
    │     ├── Management
    │     └── Security
    │
    ├── Landing Zones
    │     ├── Production
    │     ├── Non-Production
    │     └── Sandbox
    │
    └── Decommissioned
```

---

# 9. Expected Benefits

The selected governance model delivers significant business and technical benefits.

## Business Benefits

* Enterprise-wide governance consistency
* Simplified compliance management
* Better financial control
* Faster onboarding of new subscriptions
* Improved operational transparency
* Reduced governance overhead

## Technical Benefits

* Centralized Azure Policy assignments
* Simplified RBAC inheritance
* Consistent security baseline
* Reduced administrative duplication
* Standardized subscription organization
* Scalable governance architecture
* Easier lifecycle management

---

# 10. Alternatives Considered

## Option 1 — Flat Subscription Model

### Advantages

* Easy to understand
* Minimal initial setup

### Disadvantages

* Poor scalability
* Difficult governance
* Weak policy enforcement
* Inconsistent administration

**Decision:** Rejected

---

## Option 2 — Business Unit–Managed Hierarchies

### Advantages

* High operational autonomy
* Flexible administration

### Disadvantages

* Inconsistent governance
* Duplicate policy management
* Increased operational complexity
* Difficult compliance reporting

**Decision:** Rejected

---

## Option 3 — Enterprise Management Group Hierarchy (Selected)

### Advantages

* Centralized governance
* Scalable architecture
* Consistent Azure Policy enforcement
* Simplified RBAC administration
* Microsoft-recommended approach
* Supports enterprise growth

### Disadvantages

* Initial governance planning effort
* Requires organizational alignment
* Additional platform administration

**Decision:** Accepted

---

# 11. Consequences

## Positive

* Consistent governance across all Azure subscriptions
* Simplified enterprise administration
* Reduced policy duplication
* Improved compliance reporting
* Scalable governance model
* Easier cloud expansion

## Trade-offs

* Greater upfront governance design
* Ongoing platform governance responsibilities
* Organizational dependency on standardized processes

These trade-offs are acceptable because they establish a sustainable governance framework that supports Mandara Global's long-term cloud strategy.

---

# 12. Related ADRs

* ADR-001 — Enterprise Landing Zone Architecture
* ADR-002 — Hub & Spoke Network Architecture
* ADR-003 — Terraform as Infrastructure as Code
* ADR-005 — Private Networking Strategy
* ADR-006 — Identity Strategy
* ADR-007 — Monitoring Strategy
* ADR-008 — Security Baseline
* GOV-002 — Management Group Strategy
* GOV-006 — RBAC Strategy
* GOV-007 — Azure Policy Strategy

---

# 13. Review

This architectural decision will be reviewed annually or whenever significant changes occur in:

* Microsoft Management Group capabilities
* Azure governance recommendations
* Organizational structure
* Regulatory or compliance requirements
* Mandara Global's cloud operating model

---

# 14. References

* Microsoft Cloud Adoption Framework (CAF)
* Azure Well-Architected Framework (WAF)
* Azure Architecture Center
* Azure Management Groups documentation
* Azure Enterprise-Scale Landing Zone guidance
