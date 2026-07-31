# ADR-006 — Enterprise Identity Strategy

| **Attribute**    | **Value**                    |
| ---------------- | ---------------------------- |
| **ADR ID**       | ADR-006                      |
| **Title**        | Enterprise Identity Strategy |
| **Status**       | Accepted                     |
| **Date**         | 2026-07-31                   |
| **Authors**      | Cloud Architecture Team      |
| **Program**      | OneCloud 2030                |
| **Organization** | Mandara Global               |
| **Category**     | Identity & Security          |

---

# 1. Executive Summary

As part of the **OneCloud 2030** transformation program, Mandara Global has decided to adopt **Microsoft Entra ID** as the centralized identity and access management platform for the Azure Enterprise Cloud Foundation.

This decision establishes a unified identity architecture that enables secure authentication, centralized authorization, and enterprise governance across all Azure resources while supporting Zero Trust principles.

This Architectural Decision Record documents the rationale for implementing a centralized enterprise identity strategy aligned with Microsoft's Cloud Adoption Framework (CAF) and Zero Trust architecture guidance.

---

# 2. Business Context

Mandara Global operates multiple business units, development teams, and cloud workloads requiring secure and consistent access to enterprise resources.

Historically, application teams managed permissions independently, leading to:

* Inconsistent access control
* Excessive administrative privileges
* Difficult user lifecycle management
* Limited auditability
* Security risks caused by manual permission assignments

The **OneCloud 2030** initiative requires a centralized identity platform capable of supporting enterprise governance while enabling secure collaboration across the organization.

---

# 3. Problem Statement

Managing identities independently across cloud resources creates operational and security challenges.

Without a centralized identity strategy, Mandara Global would face:

* Privilege escalation risks
* Inconsistent RBAC implementation
* Difficult identity lifecycle management
* Limited governance over administrative accounts
* Weak authentication controls
* Compliance challenges
* Increased operational overhead

A unified identity platform is required to secure access to enterprise cloud resources while simplifying governance and administration.

---

# 4. Decision

Mandara Global will adopt **Microsoft Entra ID** as the enterprise identity provider for all Azure environments.

The identity strategy will include:

* Microsoft Entra ID for centralized identity management
* Role-Based Access Control (RBAC)
* Managed Identities for Azure resources
* Privileged Identity Management (PIM)
* Conditional Access policies
* Multi-Factor Authentication (MFA)
* Enterprise application integration
* Single Sign-On (SSO)

Long-lived credentials and embedded application secrets will be minimized through the use of Managed Identities and Azure Key Vault.

---

# 5. Decision Scope

This decision applies to:

* Azure subscriptions
* Azure management plane access
* Azure resource authorization
* Platform administrators
* Enterprise users
* Service principals
* Managed identities
* Enterprise applications

Exceptions require approval from both the Enterprise Architecture Board and the Information Security Office.

---

# 6. Decision Drivers

This decision supports the following strategic objectives:

* Strengthen enterprise security
* Reduce identity-related risks
* Simplify access management
* Improve governance
* Enable Zero Trust
* Support regulatory compliance
* Standardize authentication
* Improve operational efficiency

---

# 7. Architectural Principles

The Enterprise Identity Strategy follows these principles:

* Identity is the Primary Security Boundary
* Zero Trust Authentication
* Least Privilege Access
* Just-In-Time Administration
* Centralized Identity Governance
* Secure by Default
* Passwordless-Ready Architecture
* Managed Identities First
* Continuous Verification
* Operational Excellence

---

# 8. High-Level Architecture

```text id="e4xv0m"
              Microsoft Entra ID
                      │
         ┌────────────┼────────────┐
         │            │            │
       Users      Administrators  Applications
         │            │            │
         └────────────┼────────────┘
                      │
              Conditional Access
                      │
                      MFA
                      │
             Azure Role Assignments
                      │
      ┌───────────────┼────────────────┐
      │               │                │
 Landing Zones    Platform Services  Workloads
      │               │                │
      └──────── Managed Identities ────┘
                      │
                 Azure Key Vault
```

---

# 9. Expected Benefits

The selected identity architecture delivers significant business and technical advantages.

## Business Benefits

* Improved security posture
* Centralized access governance
* Simplified compliance audits
* Better operational efficiency
* Faster user onboarding
* Reduced identity management costs

## Technical Benefits

* Consistent RBAC implementation
* Secure authentication
* Reduced credential exposure
* Automated identity lifecycle
* Centralized auditing
* Secure workload identities
* Stronger Zero Trust implementation

---

# 10. Alternatives Considered

## Option 1 — Local Identity Management

### Advantages

* Simple for isolated environments
* Minimal initial setup

### Disadvantages

* Poor scalability
* Weak governance
* Difficult auditing
* High operational effort

**Decision:** Rejected

---

## Option 2 — Mixed Identity Providers

### Advantages

* Flexibility
* Supports legacy environments

### Disadvantages

* Operational complexity
* Inconsistent authentication
* Difficult governance
* Increased security risk

**Decision:** Rejected

---

## Option 3 — Microsoft Entra ID (Selected)

### Advantages

* Native Azure integration
* Centralized governance
* Conditional Access
* Privileged Identity Management
* Managed Identities
* Microsoft-recommended architecture
* Supports Zero Trust

### Disadvantages

* Requires organizational adoption
* Licensing considerations
* Initial governance planning

**Decision:** Accepted

---

# 11. Consequences

## Positive

* Enterprise-wide identity governance
* Consistent RBAC implementation
* Reduced credential management
* Improved regulatory compliance
* Stronger authentication controls
* Simplified identity lifecycle management

## Trade-offs

* Increased identity governance responsibilities
* Initial implementation effort
* User adoption and training requirements

These trade-offs are considered acceptable because centralized identity management is fundamental to protecting Mandara Global's cloud platform and supporting long-term enterprise growth.

---

# 12. Related ADRs

* ADR-001 — Enterprise Landing Zone Architecture
* ADR-002 — Hub & Spoke Network Architecture
* ADR-003 — Terraform as Infrastructure as Code
* ADR-004 — Enterprise Management Group Hierarchy
* ADR-005 — Private Networking Strategy
* ADR-007 — Monitoring Strategy
* ADR-008 — Security Baseline
* GOV-006 — RBAC Strategy
* GOV-007 — Azure Policy Strategy

---

# 13. Review

This architectural decision will be reviewed annually or whenever significant changes occur in:

* Microsoft Entra ID capabilities
* Zero Trust architecture guidance
* Regulatory or compliance requirements
* Enterprise identity governance standards
* Mandara Global's cloud operating model

---

# 14. References

* Microsoft Cloud Adoption Framework (CAF)
* Azure Well-Architected Framework (WAF)
* Microsoft Entra documentation
* Microsoft Zero Trust Architecture guidance
* Azure RBAC documentation
* Microsoft Privileged Identity Management (PIM) documentation
