# ADR-009 — Enterprise Naming Convention Standard

| **Attribute**    | **Value**                             |
| ---------------- | ------------------------------------- |
| **ADR ID**       | ADR-009                               |
| **Title**        | Enterprise Naming Convention Standard |
| **Status**       | Accepted                              |
| **Date**         | 2026-07-31                            |
| **Authors**      | Cloud Architecture Team               |
| **Program**      | OneCloud 2030                         |
| **Organization** | Mandara Global                        |
| **Category**     | Governance                            |

---

# 1. Executive Summary

As part of the **OneCloud 2030** transformation program, Mandara Global has decided to implement a standardized **Enterprise Naming Convention** for all Azure resources.

A consistent naming standard improves governance, operational efficiency, automation, monitoring, and resource discoverability while reducing ambiguity across the Azure Enterprise Cloud Foundation.

This Architectural Decision Record documents the rationale for adopting a mandatory enterprise naming standard for all cloud resources.

---

# 2. Business Context

Mandara Global manages cloud resources across multiple business units, environments, and Azure subscriptions.

Historically, individual teams adopted their own naming practices, resulting in:

* Inconsistent resource identification
* Difficult operational support
* Confusing monitoring dashboards
* Inefficient automation
* Increased administrative effort
* Poor governance

As the **OneCloud 2030** initiative expands, a common resource naming strategy is required to simplify cloud operations and improve enterprise governance.

---

# 3. Problem Statement

Without a standardized naming convention, Azure environments become increasingly difficult to manage.

Common challenges include:

* Duplicate resource names
* Poor resource discoverability
* Difficult troubleshooting
* Inconsistent automation
* Complex inventory management
* Reduced operational efficiency
* Increased onboarding effort

A unified naming convention is required to ensure consistency across all Azure resources and environments.

---

# 4. Decision

Mandara Global will implement a mandatory enterprise naming convention for all Azure resources.

Resource names will follow a standardized structure incorporating:

* Resource type abbreviation
* Business workload or application
* Environment identifier
* Azure region
* Instance number

Example:

```text id="u9b5sl"
<resource-type>-<workload>-<environment>-<region>-<instance>

vnet-platform-prod-weu-01
kv-identity-prod-weu-01
law-monitoring-prod-weu-01
stapp-sales-dev-neu-02
```

Resource abbreviations will follow Microsoft Azure naming recommendations wherever applicable.

---

# 5. Decision Scope

This decision applies to:

* Resource Groups
* Virtual Networks
* Storage Accounts
* Key Vaults
* Log Analytics Workspaces
* Virtual Machines
* Azure Firewalls
* Managed Identities
* Monitoring resources
* All future Azure services

Exceptions require approval from the Enterprise Architecture Board.

---

# 6. Decision Drivers

This decision supports the following strategic objectives:

* Standardize resource identification
* Simplify cloud operations
* Improve automation
* Strengthen governance
* Reduce operational complexity
* Improve resource discoverability
* Support enterprise scalability
* Enable consistent documentation

---

# 7. Architectural Principles

The naming convention follows these principles:

* Consistency First
* Human Readability
* Automation Friendly
* Standardization over Customization
* Environment Awareness
* Operational Simplicity
* Enterprise Scalability
* Predictable Resource Identification
* Governance by Design
* Lifecycle Maintainability

---

# 8. High-Level Architecture

```text id="llk8wf"
Enterprise Naming Pattern

<Resource Type>
        │
        ▼
<Workload/Application>
        │
        ▼
<Environment>
        │
        ▼
<Azure Region>
        │
        ▼
<Instance Number>

Example

vnet-platform-prod-weu-01
```

---

# 9. Expected Benefits

The selected naming standard provides significant business and technical benefits.

## Business Benefits

* Improved governance
* Faster operational support
* Simplified asset management
* Better auditability
* Consistent enterprise documentation
* Reduced onboarding time

## Technical Benefits

* Predictable resource identification
* Improved automation
* Easier scripting
* Simplified monitoring
* Consistent Infrastructure as Code
* Reduced configuration errors
* Better operational visibility

---

# 10. Alternatives Considered

## Option 1 — Team-Defined Naming

### Advantages

* High flexibility
* Minimal governance effort

### Disadvantages

* Inconsistent naming
* Difficult automation
* Poor governance
* Higher operational costs

**Decision:** Rejected

---

## Option 2 — Microsoft Default Resource Names

### Advantages

* Easy deployment
* Minimal planning

### Disadvantages

* Poor readability
* Inconsistent business context
* Limited operational value

**Decision:** Rejected

---

## Option 3 — Enterprise Naming Convention (Selected)

### Advantages

* Consistent governance
* Predictable resource identification
* Improved automation
* Simplified operations
* Enterprise scalability
* Microsoft-aligned practices

### Disadvantages

* Initial governance effort
* Naming policy maintenance
* Contributor training

**Decision:** Accepted

---

# 11. Consequences

## Positive

* Standardized Azure resource names
* Simplified administration
* Improved automation
* Better monitoring and reporting
* Easier troubleshooting
* Scalable governance model

## Trade-offs

* Initial migration effort
* Ongoing governance enforcement
* Naming policy maintenance

These trade-offs are considered acceptable because a standardized naming convention significantly improves the operational efficiency and maintainability of Mandara Global's Azure platform.

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
* GOV-005 — Naming Convention Standard

---

# 13. Review

This architectural decision will be reviewed annually or whenever significant changes occur in:

* Azure naming recommendations
* Microsoft Cloud Adoption Framework guidance
* Enterprise governance standards
* Automation platform requirements
* Mandara Global's cloud operating model

---

# 14. References

* Microsoft Cloud Adoption Framework (CAF)
* Azure Well-Architected Framework (WAF)
* Azure Resource Naming Rules and Restrictions
* Azure Architecture Center
* Microsoft Enterprise-Scale Landing Zone guidance
