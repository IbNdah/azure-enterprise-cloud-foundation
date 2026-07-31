# ADR-010 — Enterprise Tagging Strategy

| **Attribute**    | **Value**                   |
| ---------------- | --------------------------- |
| **ADR ID**       | ADR-010                     |
| **Title**        | Enterprise Tagging Strategy |
| **Status**       | Accepted                    |
| **Date**         | 2026-07-31                  |
| **Authors**      | Cloud Architecture Team     |
| **Program**      | OneCloud 2030               |
| **Organization** | Mandara Global              |
| **Category**     | Governance                  |

---

# 1. Executive Summary

As part of the **OneCloud 2030** transformation program, Mandara Global has decided to establish a standardized **Enterprise Tagging Strategy** for all Azure resources.

Tags provide essential business and operational metadata that enable cost management, governance, automation, inventory management, ownership tracking, and compliance reporting across the Azure Enterprise Cloud Foundation.

This Architectural Decision Record documents the rationale for adopting a mandatory enterprise tagging strategy.

---

# 2. Business Context

Mandara Global manages Azure resources owned by multiple business units, application teams, and platform services.

Without standardized metadata, cloud resources become difficult to manage at enterprise scale, resulting in:

* Unclear resource ownership
* Difficult cost allocation
* Inefficient automation
* Limited governance visibility
* Inconsistent reporting
* Increased operational overhead

As the **OneCloud 2030** initiative expands, the organization requires a consistent metadata strategy to improve operational efficiency and financial governance.

---

# 3. Problem Statement

Azure resource names alone cannot provide sufficient business context.

Without mandatory enterprise tags, Mandara Global would experience:

* Difficult chargeback and showback
* Poor ownership tracking
* Limited lifecycle management
* Inefficient resource inventory
* Reduced automation capabilities
* Incomplete governance reporting
* Compliance challenges

A standardized tagging strategy is required to enrich Azure resources with business, operational, and governance metadata.

---

# 4. Decision

Mandara Global will implement a mandatory enterprise tagging strategy across all Azure resources.

The strategy defines a standard set of business and operational tags that must be applied to supported Azure resources.

The mandatory baseline includes:

* Application
* BusinessUnit
* Environment
* Owner
* CostCenter
* Criticality
* DataClassification
* ManagedBy
* BackupRequired
* DisasterRecovery

Azure Policy will automatically audit and enforce compliance with the approved tagging standard where supported.

---

# 5. Decision Scope

This decision applies to:

* Azure subscriptions
* Resource Groups
* Networking resources
* Compute resources
* Storage services
* Platform services
* Monitoring resources
* Security resources
* Future Azure services supporting resource tags

Exceptions require approval from the Enterprise Architecture Board.

---

# 6. Decision Drivers

This decision supports the following strategic objectives:

* Improve governance visibility
* Enable financial accountability
* Standardize resource metadata
* Simplify automation
* Improve compliance reporting
* Support lifecycle management
* Increase operational efficiency
* Improve enterprise scalability

---

# 7. Architectural Principles

The Enterprise Tagging Strategy follows these principles:

* Metadata by Design
* Governance First
* Business Context Everywhere
* Automation Friendly
* Financial Transparency
* Standardization
* Lifecycle Awareness
* Operational Simplicity
* Compliance by Design
* Enterprise Scalability

---

# 8. High-Level Architecture

```text
                Azure Resource
                       │
          Mandatory Enterprise Tags
                       │
     ┌─────────────────┼─────────────────┐
     │                 │                 │
 Business Metadata  Operational Metadata  Financial Metadata
     │                 │                 │
     └─────────────────┼─────────────────┘
                       │
                Azure Policy
                       │
          Compliance & Governance
                       │
      Cost Management / Automation /
      Inventory / Reporting / Auditing
```

---

# 9. Expected Benefits

The selected tagging strategy provides significant business and technical benefits.

## Business Benefits

* Improved cost transparency
* Better ownership accountability
* Enhanced governance reporting
* Simplified chargeback and showback
* Improved compliance reporting
* Better business visibility

## Technical Benefits

* Standardized resource metadata
* Improved automation
* Simplified inventory management
* Better lifecycle management
* Consistent policy enforcement
* Easier operational reporting
* Enhanced resource discoverability

---

# 10. Alternatives Considered

## Option 1 — Optional Resource Tags

### Advantages

* Minimal governance effort
* Flexible implementation

### Disadvantages

* Inconsistent metadata
* Poor reporting
* Limited automation
* Weak governance

**Decision:** Rejected

---

## Option 2 — Team-Specific Tagging Standards

### Advantages

* Team flexibility
* Local optimization

### Disadvantages

* Inconsistent reporting
* Difficult cost management
* Limited enterprise governance
* Increased operational complexity

**Decision:** Rejected

---

## Option 3 — Enterprise Tagging Strategy (Selected)

### Advantages

* Standardized governance
* Improved financial visibility
* Better automation
* Enterprise-wide consistency
* Microsoft CAF alignment
* Scalable operating model

### Disadvantages

* Initial governance effort
* Policy maintenance
* Contributor training

**Decision:** Accepted

---

# 11. Consequences

## Positive

* Enterprise-wide metadata consistency
* Improved governance and compliance
* Better cost allocation
* Simplified automation
* Enhanced operational reporting
* Scalable cloud operations

## Trade-offs

* Ongoing tag governance
* Azure Policy maintenance
* Additional operational discipline
* Initial adoption effort

These trade-offs are considered acceptable because standardized resource metadata is essential for operating a large-scale Azure environment efficiently and transparently.

---

# 12. Related ADRs

* ADR-001 — Enterprise Landing Zone Architecture
* ADR-002 — Hub & Spoke Network Architecture
* ADR-003 — Terraform as Infrastructure as Code
* ADR-004 — Enterprise Management Group Hierarchy
* ADR-005 — Private Networking Strategy
* ADR-006 — Enterprise Identity Strategy
* ADR-007 — Enterprise Monitoring & Observability Strategy
* ADR-008 — Enterprise Security Baseline
* ADR-009 — Enterprise Naming Convention Standard
* GOV-008 — Enterprise Tagging Strategy

---

# 13. Review

This architectural decision will be reviewed annually or whenever significant changes occur in:

* Azure tagging capabilities
* Microsoft Cloud Adoption Framework guidance
* Enterprise governance requirements
* Financial management processes
* Mandara Global's cloud operating model

---

# 14. References

* Microsoft Cloud Adoption Framework (CAF)
* Azure Well-Architected Framework (WAF)
* Azure Resource Manager Tags documentation
* Azure Policy documentation
* Azure Cost Management documentation
* Azure Architecture Center
* Microsoft Enterprise-Scale Landing Zone guidance
