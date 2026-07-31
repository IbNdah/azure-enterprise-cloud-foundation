# ADR-008 — Enterprise Security Baseline

| **Attribute**    | **Value**                    |
| ---------------- | ---------------------------- |
| **ADR ID**       | ADR-008                      |
| **Title**        | Enterprise Security Baseline |
| **Status**       | Accepted                     |
| **Date**         | 2026-07-31                   |
| **Authors**      | Cloud Architecture Team      |
| **Program**      | OneCloud 2030                |
| **Organization** | Mandara Global               |
| **Category**     | Security                     |

---

# 1. Executive Summary

As part of the **OneCloud 2030** transformation program, Mandara Global has decided to establish an **Enterprise Security Baseline** that defines the minimum mandatory security controls for all Azure platform services, subscriptions, and workloads.

The Security Baseline provides a consistent security foundation across the Azure Enterprise Cloud Foundation, ensuring that governance, identity, networking, monitoring, and workloads are protected using Microsoft's security best practices and Zero Trust principles.

This Architectural Decision Record documents the rationale for implementing a standardized enterprise security baseline.

---

# 2. Business Context

Mandara Global operates critical business services in the cloud that process sensitive corporate and customer information.

As cloud adoption expands across the organization, inconsistent implementation of security controls increases the likelihood of:

* Security misconfigurations
* Unauthorized access
* Regulatory non-compliance
* Data exposure
* Operational disruptions
* Increased cybersecurity risks

The **OneCloud 2030** initiative requires every cloud workload to inherit a common set of enterprise security controls before entering production.

---

# 3. Problem Statement

Without a standardized security baseline, each project team would define its own security controls, resulting in inconsistent protection levels and increased operational risk.

Potential consequences include:

* Weak security configurations
* Inconsistent Azure Policy enforcement
* Excessive administrative permissions
* Poor compliance reporting
* Increased attack surface
* Delayed incident response
* Difficult security governance

A unified enterprise security baseline is required to ensure that every Azure deployment meets Mandara Global's minimum security requirements.

---

# 4. Decision

Mandara Global will implement a mandatory **Enterprise Security Baseline** across the Azure Enterprise Cloud Foundation.

The baseline will include standardized security controls covering:

* Microsoft Defender for Cloud
* Azure Policy security initiatives
* Microsoft Entra ID security controls
* Multi-Factor Authentication (MFA)
* Privileged Identity Management (PIM)
* Azure Key Vault
* Private Networking
* Azure Firewall
* Microsoft Defender for Servers
* Microsoft Defender for Storage
* Microsoft Defender for Key Vault
* Azure Monitor security alerts
* Security Center recommendations
* Secure configuration standards

All production workloads must comply with the approved enterprise security baseline before deployment.

---

# 5. Decision Scope

This decision applies to:

* Azure subscriptions
* Platform services
* Landing Zones
* Azure virtual networks
* Azure PaaS services
* Azure IaaS workloads
* Identity services
* Shared enterprise services

Exceptions require approval from the Enterprise Architecture Board and the Information Security Office.

---

# 6. Decision Drivers

This decision supports the following strategic objectives:

* Strengthen enterprise cybersecurity
* Standardize security controls
* Reduce cyber risk
* Improve regulatory compliance
* Support Zero Trust architecture
* Protect business-critical assets
* Simplify security governance
* Increase operational resilience

---

# 7. Architectural Principles

The Security Baseline follows these principles:

* Security by Default
* Zero Trust Architecture
* Least Privilege Access
* Defense in Depth
* Continuous Security Assessment
* Secure Configuration Management
* Policy-Driven Governance
* Infrastructure as Code
* Continuous Monitoring
* Compliance by Design

---

# 8. High-Level Architecture

```text id="fep8ur"
              Microsoft Entra ID
                     │
          Conditional Access / MFA
                     │
             Azure Policy & RBAC
                     │
      ┌──────────────┼───────────────┐
      │              │               │
 Azure Firewall  Private Link   Azure Key Vault
      │              │               │
      └──────────────┼───────────────┘
                     │
         Microsoft Defender for Cloud
                     │
             Azure Monitor & Alerts
                     │
           Security Operations Team
```

---

# 9. Expected Benefits

The selected security baseline provides significant business and technical advantages.

## Business Benefits

* Stronger cybersecurity posture
* Improved regulatory compliance
* Reduced operational risk
* Better protection of business data
* Increased customer confidence
* Standardized enterprise security

## Technical Benefits

* Consistent security configuration
* Automated policy enforcement
* Centralized security monitoring
* Reduced attack surface
* Improved threat detection
* Standardized security controls
* Simplified security operations

---

# 10. Alternatives Considered

## Option 1 — Project-Specific Security Controls

### Advantages

* Flexible implementation
* Team autonomy

### Disadvantages

* Inconsistent protection
* Difficult governance
* Higher operational risk
* Poor compliance consistency

**Decision:** Rejected

---

## Option 2 — Minimum Azure Default Security

### Advantages

* Simple deployment
* Low administrative effort

### Disadvantages

* Limited enterprise protection
* Reactive security model
* Insufficient governance

**Decision:** Rejected

---

## Option 3 — Enterprise Security Baseline (Selected)

### Advantages

* Consistent protection
* Microsoft-recommended practices
* Centralized governance
* Automated compliance
* Zero Trust alignment
* Enterprise scalability

### Disadvantages

* Initial implementation effort
* Ongoing governance responsibilities
* Continuous policy maintenance

**Decision:** Accepted

---

# 11. Consequences

## Positive

* Enterprise-wide security consistency
* Reduced cyber risk
* Improved compliance posture
* Stronger protection of Azure resources
* Simplified security governance
* Scalable enterprise security architecture

## Trade-offs

* Increased governance effort
* Additional security monitoring costs
* Ongoing policy management
* Initial organizational adoption

These trade-offs are considered acceptable because a standardized security baseline is fundamental to protecting Mandara Global's cloud platform while enabling secure and sustainable growth.

---

# 12. Related ADRs

* ADR-001 — Enterprise Landing Zone Architecture
* ADR-002 — Hub & Spoke Network Architecture
* ADR-003 — Terraform as Infrastructure as Code
* ADR-004 — Enterprise Management Group Hierarchy
* ADR-005 — Private Networking Strategy
* ADR-006 — Enterprise Identity Strategy
* ADR-007 — Enterprise Monitoring & Observability Strategy
* GOV-006 — RBAC Strategy
* GOV-007 — Azure Policy Strategy
* GOV-008 — Tagging Strategy

---

# 13. Review

This architectural decision will be reviewed annually or whenever significant changes occur in:

* Microsoft Defender capabilities
* Azure security recommendations
* Zero Trust guidance
* Regulatory or compliance requirements
* Mandara Global's enterprise security strategy

---

# 14. References

* Microsoft Cloud Adoption Framework (CAF)
* Azure Well-Architected Framework (WAF)
* Microsoft Defender for Cloud documentation
* Microsoft Zero Trust Architecture guidance
* Azure Security Benchmark
* Azure Architecture Center
* Azure Policy documentation
