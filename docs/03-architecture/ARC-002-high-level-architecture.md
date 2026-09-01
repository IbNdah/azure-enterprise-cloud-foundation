# ARC-002 — High-Level Architecture

| Attribute | Value |
|---|---|
| **Document ID** | ARC-002 |
| **Title** | High-Level Architecture |
| **Version** | 1.2 |
| **Status** | Approved |
| **Date** | 2026-08-31 |
| **Program** | OneCloud 2030 |
| **Organization** | Mandara Global |

---

# 1. Purpose

This document provides the high-level architectural view of the Azure Enterprise Cloud Foundation.

It shows how governance, shared platform capabilities, Landing Zones, subscriptions, resource groups and resources relate to each other.

The document intentionally remains at high level. Detailed governance, networking, security and implementation decisions are defined in the related GOV, ADR and Terraform documents.

---

# 2. Architectural Context

The Azure foundation is organized around three main concerns:

| Concern | Purpose |
|---|---|
| Governance | Establish enterprise-wide governance and control |
| Platform | Provide shared enterprise capabilities |
| Landing Zones | Provide governed boundaries for business workloads |

Decommissioned resources or subscriptions are represented separately from the active platform and Landing Zone model.

---

# 3. High-Level Architecture

```text
                         Tenant Root
                              │
                       Mandara Global
                              │
              ┌───────────────┼───────────────┐
              │               │               │
              ▼               ▼               ▼
          Governance       Platform      Decommissioned
                              │
                    Platform Capabilities
                              │
                              ▼
                       Landing Zones
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

This diagram is a conceptual high-level view. It does not imply that every element shown is a Management Group at the same hierarchy level.

---

# 4. Platform Capabilities

The shared platform is organized into five capabilities:

| Capability | Purpose |
|---|---|
| **Management** | Central management and governance-supporting services |
| **Connectivity** | Shared network and connectivity services |
| **Security** | Shared security controls and services |
| **Operations** | Monitoring, logging and operational services |
| **Identity** | Enterprise identity and access services |

These capabilities represent shared platform responsibilities and ownership boundaries.

**Capability is not synonymous with Management Group.** A capability may be implemented across one or more Azure resources, subscriptions or governance scopes depending on the required boundary.

---

# 5. Landing Zones

Landing Zones provide governed environments for business workloads.

The foundation currently defines:

| Landing Zone | Intended Use |
|---|---|
| **Corp** | Enterprise and internal workloads |
| **Online** | Internet-facing or externally accessible workloads |
| **Sandbox** | Controlled experimentation and development |

Corp and Online support Production and Non-Production environments. Sandbox is a separate Landing Zone intended for controlled experimentation.

---

# 6. Subscriptions and Resource Organization

Subscriptions provide an important administrative, security, cost and operational boundary.

Resources are organized within Resource Groups, which provide logical grouping and lifecycle management within a subscription.

The conceptual hierarchy is:

```text
Management / Governance Scope
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

The exact subscription placement and Management Group hierarchy are defined by GOV-002, GOV-003 and ADR-004.

---

# 7. Architectural Boundaries

The architecture separates the following concepts:

```text
Governance
    │
    └── Management Groups / Policies

Platform
    │
    └── Shared Capabilities

Landing Zones
    │
    └── Governed Workload Boundaries

Subscriptions
    │
    └── Administrative / Cost / Security Boundaries

Resource Groups
    │
    └── Resource Organization

Resources
    │
    └── Azure Services
```

This separation prevents platform capabilities, governance scopes and workload boundaries from being treated as the same architectural construct.

---

# 8. Design Principles

The high-level architecture follows these principles:

- Business requirements drive architectural structure.
- Governance is applied at the appropriate scope.
- Shared platform services are centralized where reuse is beneficial.
- Workloads remain isolated within governed Landing Zones.
- Subscriptions provide clear administrative boundaries.
- Infrastructure is managed through Infrastructure as Code.
- The hierarchy remains as simple as practical.

---

# 9. Relationship to Other Documents

| Document | Role |
|---|---|
| **ARC-001** | Architecture principles |
| **ARC-003** | Detailed enterprise reference architecture |
| **GOV-002** | Management Group governance model |
| **GOV-003** | Subscription strategy |
| **GOV-009** | Landing Zone design |
| **ADR-001** | Enterprise Landing Zone architecture |
| **ADR-004** | Management Group hierarchy |
| **ADR-002** | Hub & Spoke network architecture |

---

# 10. Scope and Evolution

This architecture provides the stable conceptual structure for the platform.

Detailed implementation may evolve as Azure services, organizational requirements and workload patterns change, without requiring changes to the high-level model unless a fundamental architectural boundary changes.
