# ADR-001 — Enterprise Landing Zone Architecture

| **Attribute** | **Value** |
|---|---|
| **ADR ID** | ADR-001 |
| **Title** | Enterprise Landing Zone Architecture |
| **Version** | 1.1 |
| **Status** | Accepted |
| **Date** | 2026-08-31 |
| **Authors** | Cloud Architecture Team |
| **Program** | OneCloud 2030 |
| **Organization** | Mandara Global |
| **Category** | Enterprise Architecture |

---

# 1. Executive Summary

Mandara Global will establish an **Enterprise Azure Landing Zone Architecture** as the foundation for Azure workloads.

The Landing Zone model provides governed workload boundaries while shared platform capabilities provide common identity, connectivity, security, management and operational services.

This decision builds on the business requirements, cloud strategy, architecture principles and governance framework already established for OneCloud 2030.

---

# 2. Business Context

Mandara Global is a multinational enterprise with multiple Business Units and geographic regions.

Historically, cloud resources have been provisioned independently, creating inconsistent governance, duplicated infrastructure, fragmented security controls and limited operational visibility.

The OneCloud 2030 program requires a common cloud foundation that can:

| Requirement | Architectural Response |
|---|---|
| Consistent governance | Central governance and policy |
| Secure workloads | Shared identity and security controls |
| Scalable cloud adoption | Standard Landing Zone model |
| Faster onboarding | Reusable platform capabilities |
| Operational visibility | Shared monitoring and operations |
| Controlled infrastructure | Terraform-based Infrastructure as Code |

These requirements are consistent with BR-001, BR-003, BR-005, BR-006, BR-007 and BR-009. fileciteturn16file9L1-L15

---

# 3. Problem Statement

Without a common Landing Zone model, Azure adoption can result in:

- inconsistent subscription structures;
- duplicated platform services;
- fragmented identity and access management;
- inconsistent security baselines;
- policy drift;
- limited operational visibility;
- difficult onboarding of new Business Units.

The architecture therefore needs a repeatable boundary between **shared enterprise platform services** and **business workloads**.

---

# 4. Decision

Mandara Global will implement an **Enterprise Azure Landing Zone Architecture** as the standard foundation for Azure workloads.

The architecture separates:

1. **Enterprise governance** — Management Groups, Policy and standards;
2. **Shared platform capabilities** — Management, Connectivity, Security, Operations and Identity;
3. **Landing Zones** — governed workload boundaries;
4. **Subscriptions** — administrative, security, cost and operational boundaries;
5. **Business workloads** — applications and services deployed within approved Landing Zones.

The five platform capabilities are implementation and ownership boundaries. They are **not Management Groups** and do not replace the governance hierarchy defined in GOV-002.

---

# 5. Target Landing Zone Model

The current Landing Zone model is:

```text
Azure Enterprise Cloud Foundation
│
├── Governance
│   └── Management Groups / Policy
│
├── Shared Platform Capabilities
│   ├── Management
│   ├── Connectivity
│   ├── Security
│   ├── Operations
│   └── Identity
│
└── Landing Zones
    ├── Corp
    │   ├── Production
    │   └── Non-Production
    │
    ├── Online
    │   ├── Production
    │   └── Non-Production
    │
    └── Sandbox
```

Production and Non-Production are workload environments within the Corp and Online Landing Zone model. They are not separate platform capabilities.

A Landing Zone may contain one or more subscriptions when a separate administrative, security, cost or operational boundary is justified.

---

# 6. Decision Scope

This decision applies to:

- Azure workload subscriptions;
- shared platform services;
- enterprise networking;
- identity and access;
- security and governance controls;
- monitoring and operational services;
- Terraform-managed infrastructure within the foundation.

Exceptions require documented architectural justification and approval through the established governance process.

---

# 7. Decision Drivers

| Driver | Why it matters |
|---|---|
| Scalability | Support new Business Units, regions and workloads |
| Governance | Apply consistent enterprise controls |
| Security | Provide common identity and security controls |
| Standardization | Reduce unnecessary variation between workloads |
| Operational efficiency | Reuse shared services |
| Automation | Provision infrastructure consistently through IaC |
| Workload autonomy | Allow Business Units to deploy within defined boundaries |

These drivers directly support the established business requirements and architecture principles. fileciteturn16file6L1-L15 fileciteturn16file8L1-L25

---

# 8. Architectural Principles

The decision aligns with the following principles:

| Principle | Application |
|---|---|
| Business Before Technology | Landing Zones address defined business requirements |
| Platform over Projects | Common services are shared where practical |
| Infrastructure as Code | Terraform manages the infrastructure |
| Security by Design | Security controls are part of the platform |
| Zero Trust | Identity and least privilege guide access |
| Standardization over Customization | Common Landing Zone patterns are preferred |
| Shared Services First | Common platform services are centralized |
| Observability by Default | Workloads and platform services provide operational visibility |

These principles are defined in ARC-001. fileciteturn16file17L1-L25

---

# 9. Expected Benefits

| Area | Expected Benefit |
|---|---|
| Cloud adoption | Faster and more consistent workload onboarding |
| Governance | Centralized and repeatable controls |
| Security | Consistent identity and security baseline |
| Operations | Shared monitoring and operational services |
| Cost | Reduced duplication of common services |
| Scalability | Standard model for additional subscriptions and regions |
| Engineering | Reusable Terraform modules and platform capabilities |

---

# 10. Alternatives Considered

| Option | Decision | Rationale |
|---|---|---|
| **Single Subscription** | Rejected | Limited isolation, governance and scalability |
| **Independent Subscriptions** | Rejected | Duplicated services and inconsistent governance |
| **Enterprise Landing Zone** | **Selected** | Provides governed boundaries, shared services and scalable onboarding |

The selected approach retains workload autonomy while establishing common enterprise controls.

---

# 11. Consequences

### Positive

- Standardized Azure onboarding
- Clear separation between platform and workloads
- Consistent governance and security
- Reusable shared services
- Scalable subscription model
- Better operational visibility
- Reduced configuration drift

### Trade-offs

- Higher initial platform design effort
- Shared services create some platform dependencies
- Contributors must follow established governance and Terraform patterns
- Landing Zone design requires ongoing governance

These trade-offs are accepted because the platform is intended to support long-term enterprise cloud adoption.

---

# 12. Relationship to Other Architecture Decisions

| ADR | Relationship |
|---|---|
| ADR-002 | Defines the Hub & Spoke network architecture |
| ADR-003 | Defines Terraform as the IaC implementation standard |
| ADR-004 | Defines the Management Group hierarchy |
| ADR-005 | Defines private networking |
| ADR-006 | Defines enterprise identity |
| ADR-007 | Defines monitoring and observability |
| ADR-008 | Defines the security baseline |
| ADR-009 | Defines naming standards |
| ADR-010 | Defines tagging standards |

The Landing Zone decision is therefore the architectural umbrella under which these more specific decisions operate.

---

# 13. Review

This decision shall be reviewed when significant changes occur to:

- Azure Landing Zone guidance;
- enterprise cloud strategy;
- organizational structure;
- security or compliance requirements;
- subscription or workload operating model.

---

# 14. References

- Microsoft Cloud Adoption Framework
- Azure Architecture Center
- Azure Well-Architected Framework
- GOV-002 — Management Group Strategy
- GOV-003 — Subscription Strategy
- GOV-009 — Landing Zone Design
- ARC-002 — High-Level Architecture
- ARC-003 — Enterprise Reference Architecture
