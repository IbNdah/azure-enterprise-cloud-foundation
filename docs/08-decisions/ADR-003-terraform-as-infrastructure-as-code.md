# ADR-003 — Terraform as Infrastructure as Code

| **Attribute**    | **Value**                           |
| ---------------- | ----------------------------------- |
| **ADR ID**       | ADR-003                             |
| **Title**        | Terraform as Infrastructure as Code |
| **Status**       | Accepted                            |
| **Date**         | 2026-07-31                          |
| **Authors**      | Cloud Architecture Team             |
| **Program**      | OneCloud 2030                       |
| **Organization** | Mandara Global                      |
| **Category**     | Platform Engineering                |

---

# 1. Executive Summary

As part of the **OneCloud 2030** transformation program, Mandara Global has decided to standardize the provisioning and lifecycle management of Azure infrastructure using **Terraform**.

Terraform will serve as the enterprise Infrastructure as Code (IaC) platform, enabling automated, version-controlled, repeatable, and auditable deployments across the Azure Enterprise Cloud Foundation.

This Architectural Decision Record documents the rationale behind selecting Terraform as the strategic provisioning technology for the cloud platform.

---

# 2. Business Context

Mandara Global is transforming its IT operating model from manually managed infrastructure to a fully automated cloud platform.

Historically, Azure resources were provisioned through the Azure Portal or ad hoc deployment scripts. This approach resulted in:

* Configuration drift
* Manual deployment errors
* Limited deployment repeatability
* Difficult change tracking
* Slow environment provisioning
* Inconsistent resource configurations

To support enterprise-scale cloud adoption, the **OneCloud 2030** initiative requires a standardized Infrastructure as Code approach capable of managing the entire Azure platform consistently across all environments.

---

# 3. Problem Statement

Manual infrastructure provisioning does not scale to enterprise cloud environments.

Without Infrastructure as Code, Mandara Global would face:

* Inconsistent platform deployments
* Manual configuration drift
* Difficult disaster recovery
* Poor auditability
* Limited automation
* Increased operational costs
* Slower delivery of new cloud services

A centralized Infrastructure as Code platform is required to automate provisioning while ensuring governance, consistency, and operational efficiency.

---

# 4. Decision

Mandara Global will adopt **Terraform** as the standard Infrastructure as Code solution for provisioning and managing Azure infrastructure.

Terraform will be used to deploy and manage:

* Management Groups
* Subscriptions
* Resource Groups
* Networking
* Identity integrations
* Security services
* Monitoring resources
* Shared platform services
* Landing Zones

Infrastructure definitions will be maintained in version-controlled Git repositories and deployed through automated CI/CD pipelines.

Terraform modules will be designed to maximize reusability, maintainability, and scalability across the Azure Enterprise Cloud Foundation.

---

# 5. Decision Scope

This decision applies to:

* All Azure infrastructure
* Shared platform services
* Landing Zone deployments
* Enterprise networking
* Governance resources
* Monitoring infrastructure
* Security platform components

Manual creation of production infrastructure is prohibited except in approved emergency situations.

---

# 6. Decision Drivers

This decision supports the following strategic objectives:

* Standardize infrastructure deployments
* Eliminate configuration drift
* Improve deployment consistency
* Enable DevOps practices
* Strengthen governance
* Increase deployment speed
* Improve auditability
* Reduce operational risk
* Support enterprise scalability

---

# 7. Architectural Principles

Terraform adoption follows these principles:

* Infrastructure as Code
* Automation First
* Immutable Infrastructure
* Version Control
* Modular Design
* Reusability
* Idempotent Deployments
* Environment Consistency
* Security by Design
* Operational Excellence

---

# 8. High-Level Architecture

```text id="8jpkwy"
Git Repository
       │
       ▼
Terraform Modules
       │
       ▼
CI/CD Pipeline
       │
       ▼
Terraform Plan
       │
       ▼
Terraform Apply
       │
       ▼
Azure Enterprise Landing Zone
```

---

# 9. Expected Benefits

The selected approach provides significant business and technical benefits.

## Business Benefits

* Faster infrastructure delivery
* Reduced operational costs
* Improved governance
* Better change management
* Consistent cloud platform
* Reduced deployment risk

## Technical Benefits

* Repeatable deployments
* Version-controlled infrastructure
* Reusable modules
* Automated provisioning
* Simplified disaster recovery
* Reduced configuration drift
* Easier platform maintenance

---

# 10. Alternatives Considered

## Option 1 — Manual Azure Portal Deployments

### Advantages

* Simple for small environments
* No Infrastructure as Code expertise required

### Disadvantages

* Configuration drift
* Difficult auditing
* Poor scalability
* High operational effort

**Decision:** Rejected

---

## Option 2 — Azure Bicep

### Advantages

* Native Azure integration
* Strong Microsoft ecosystem support
* Declarative syntax

### Disadvantages

* Azure-specific technology
* Less suitable for future multi-cloud scenarios
* Smaller ecosystem than Terraform

**Decision:** Rejected

---

## Option 3 — Terraform (Selected)

### Advantages

* Cloud-agnostic platform
* Mature ecosystem
* Extensive Azure provider support
* Strong module ecosystem
* Enterprise adoption
* Excellent CI/CD integration

### Disadvantages

* Learning curve
* State management complexity
* Additional tooling requirements

**Decision:** Accepted

---

# 11. Consequences

## Positive

* Fully automated infrastructure provisioning
* Consistent Azure environments
* Improved governance
* Better operational efficiency
* Simplified platform maintenance
* Enterprise-scale Infrastructure as Code

## Trade-offs

* Initial investment in Terraform expertise
* State management responsibilities
* Increased CI/CD dependency

These trade-offs are acceptable because they provide the automation, consistency, and governance required to support Mandara Global's long-term cloud strategy.

---

# 12. Related ADRs

* ADR-001 — Enterprise Landing Zone Architecture
* ADR-002 — Hub & Spoke Network Architecture
* ADR-004 — Management Group Hierarchy
* ADR-005 — Private Networking Strategy
* ADR-006 — Identity Strategy
* ADR-007 — Monitoring Strategy
* ADR-008 — Security Baseline

---

# 13. Review

This architectural decision will be reviewed annually or whenever significant changes occur in:

* Terraform capabilities
* Azure Resource Provider support
* Enterprise DevOps strategy
* CI/CD platform architecture
* Mandara Global's cloud operating model

---

# 14. References

* Terraform Documentation
* Azure Provider for Terraform
* Microsoft Cloud Adoption Framework (CAF)
* Azure Well-Architected Framework (WAF)
* Azure Architecture Center
