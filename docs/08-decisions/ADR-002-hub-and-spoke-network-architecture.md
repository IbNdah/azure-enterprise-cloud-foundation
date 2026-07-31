# ADR-002 — Hub & Spoke Network Architecture

| **Attribute**    | **Value**                        |
| ---------------- | -------------------------------- |
| **ADR ID**       | ADR-002                          |
| **Title**        | Hub & Spoke Network Architecture |
| **Status**       | Accepted                         |
| **Date**         | 2026-07-31                       |
| **Authors**      | Cloud Architecture Team          |
| **Program**      | OneCloud 2030                    |
| **Organization** | Mandara Global                   |
| **Category**     | Enterprise Networking            |

---

# 1. Executive Summary

Following the adoption of the Enterprise Azure Landing Zone (ADR-001), Mandara Global has decided to implement a **Hub & Spoke network architecture** as the enterprise networking model for the **OneCloud 2030** transformation program.

The Hub & Spoke architecture provides centralized connectivity, security, and shared network services while allowing business workloads to remain isolated within dedicated spoke virtual networks.

This decision establishes a secure, scalable, and standardized networking foundation capable of supporting future cloud expansion across multiple business units and geographical regions.

---

# 2. Business Context

Mandara Global operates multiple business domains with different security, operational, and compliance requirements.

Historically, networking components were deployed independently for each project, resulting in:

* Duplicated network infrastructure
* Inconsistent security controls
* Complex routing configurations
* Higher operational costs
* Difficult connectivity management
* Limited scalability

As part of the **OneCloud 2030** initiative, the organization requires a centralized networking model that enables secure communication between workloads while maintaining strong isolation and governance.

---

# 3. Problem Statement

Deploying Azure workloads using isolated virtual networks without a standardized enterprise topology creates several challenges:

* Duplicate Azure Firewall deployments
* Multiple VPN or ExpressRoute gateways
* Inconsistent DNS architecture
* Difficult traffic inspection
* Increased operational overhead
* Limited governance over network security
* Poor scalability as new workloads are introduced

A centralized networking architecture is required to provide shared connectivity services while maintaining workload isolation.

---

# 4. Decision

Mandara Global will implement a **Hub & Spoke network topology** as the standard networking architecture for all Azure Landing Zones.

The Hub Virtual Network will host shared enterprise services including:

* Azure Firewall
* VPN Gateway
* ExpressRoute Gateway (future)
* Private DNS
* Bastion
* Shared network services

Each business workload will be deployed into a dedicated Spoke Virtual Network connected to the Hub using Virtual Network Peering.

Direct communication between spoke networks is not permitted unless explicitly approved through the enterprise network architecture.

---

# 5. Decision Scope

This decision applies to:

* All Azure virtual networks
* All Landing Zone subscriptions
* Shared networking services
* Hybrid connectivity
* Future regional Azure deployments
* Enterprise network security architecture

Exceptions require approval from the Enterprise Architecture Board.

---

# 6. Decision Drivers

This decision supports the following strategic objectives:

* Centralize enterprise networking
* Improve network security
* Reduce duplicated infrastructure
* Simplify operations
* Enable hybrid connectivity
* Support business growth
* Standardize network architecture
* Improve operational resilience

---

# 7. Architectural Principles

The networking platform follows these principles:

* Centralized Connectivity
* Network Segmentation
* Zero Trust Networking
* Shared Platform Services
* Secure by Default
* Least Connectivity Required
* Infrastructure as Code
* High Availability
* Scalability by Design
* Operational Simplicity

---

# 8. High-Level Architecture

```text
                    On-Premises
                         │
               VPN / ExpressRoute
                         │
                ┌───────────────────┐
                │   Hub Network      │
                │--------------------│
                │ Azure Firewall     │
                │ VPN Gateway        │
                │ Private DNS        │
                │ Azure Bastion      │
                │ Shared Services    │
                └───────────────────┘
                   │      │      │
          ─────────┘      │      └─────────
                          │
          ┌────────────┐  │  ┌────────────┐
          │ Spoke A    │  │  │ Spoke B    │
          │ Production │  │  │ Non-Prod   │
          └────────────┘  │  └────────────┘
                          │
                    ┌────────────┐
                    │ Sandbox    │
                    └────────────┘
```

---

# 9. Expected Benefits

The selected architecture provides significant business and technical advantages.

## Business Benefits

* Lower networking costs
* Standardized connectivity
* Faster workload onboarding
* Improved governance
* Simplified compliance
* Better operational visibility

## Technical Benefits

* Centralized traffic inspection
* Reusable network services
* Simplified routing
* Reduced infrastructure duplication
* Secure workload isolation
* Scalable regional expansion
* Simplified hybrid connectivity

---

# 10. Alternatives Considered

## Option 1 — Flat Network

### Advantages

* Simple deployment
* Minimal configuration

### Disadvantages

* Weak isolation
* Poor scalability
* Difficult governance
* Increased security risks

**Decision:** Rejected

---

## Option 2 — Independent Virtual Networks

### Advantages

* Good workload isolation
* Independent administration

### Disadvantages

* Duplicate gateways
* Duplicate firewalls
* Increased operational cost
* Complex connectivity

**Decision:** Rejected

---

## Option 3 — Hub & Spoke Architecture (Selected)

### Advantages

* Centralized security
* Shared connectivity services
* Lower operational costs
* Microsoft-recommended enterprise architecture
* Highly scalable
* Simplified governance

### Disadvantages

* Higher initial implementation effort
* More complex routing design
* Requires centralized platform management

**Decision:** Accepted

---

# 11. Consequences

## Positive

* Enterprise-standard networking
* Centralized security controls
* Simplified hybrid connectivity
* Reduced operational complexity
* Consistent network governance
* Easier onboarding of future workloads

## Trade-offs

* Increased architectural complexity
* Dependency on shared Hub services
* Higher initial platform investment

These trade-offs are considered acceptable because they provide a secure and scalable networking foundation for long-term enterprise cloud adoption.

---

# 12. Related ADRs

* ADR-001 — Enterprise Landing Zone Architecture
* ADR-003 — Terraform as Infrastructure as Code
* ADR-004 — Management Group Hierarchy
* ADR-005 — Private Networking Strategy
* ADR-006 — Identity Strategy
* ADR-007 — Monitoring Strategy
* ADR-008 — Security Baseline

---

# 13. Review

This architectural decision will be reviewed annually or whenever significant changes occur in:

* Azure networking capabilities
* Microsoft Cloud Adoption Framework guidance
* Hybrid connectivity requirements
* Enterprise security strategy
* Mandara Global's cloud operating model

---

# 14. References

* Microsoft Cloud Adoption Framework (CAF)
* Azure Well-Architected Framework (WAF)
* Azure Architecture Center
* Azure Hub & Spoke Network Topology guidance
* Azure Virtual Network documentation
