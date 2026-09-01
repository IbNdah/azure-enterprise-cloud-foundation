# REF-001 — Enterprise Landing Zone Reference Architecture

| Attribute | Value |
|---|---|
| **Reference ID** | REF-001 |
| **Title** | Enterprise Landing Zone Reference Architecture |
| **Version** | 1.1 |
| **Status** | Approved |
| **Date** | 2026-09-01 |
| **Authors** | Cloud Architecture Team |
| **Program** | OneCloud 2030 |
| **Organization** | Mandara Global |
| **Category** | Reference Architecture |

---

# 1. Executive Summary

The Mandara Global Azure Enterprise Cloud Foundation provides a governed platform for hosting enterprise workloads.

The reference architecture separates:

- enterprise governance;
- shared platform capabilities;
- Landing Zones;
- subscriptions and resource organization;
- business workloads.

The platform is organized into five capabilities: **Management, Connectivity, Security, Operations and Identity**.

Landing Zones provide governed workload boundaries and are currently organized as **Corp, Online and Sandbox**.

---

# 2. Purpose

This reference architecture provides the common architectural model for Azure Landing Zones and the shared platform services they consume.

It establishes a consistent reference for:

- governance;
- shared platform services;
- workload isolation;
- subscription organization;
- connectivity;
- identity;
- security;
- operations.

It is a reference architecture rather than a detailed implementation specification.

---

# 3. Scope

This architecture covers:

- Azure tenant and governance scope;
- Management Groups;
- shared Platform Capabilities;
- Landing Zones;
- subscriptions;
- resource groups;
- shared connectivity;
- identity and access;
- security;
- monitoring and operations;
- business workload boundaries.

Detailed Terraform implementation is documented separately in `10-terraform`.

---

# 4. Architectural Model

The architecture follows this logical structure:

```text
                         Tenant Root
                              │
                       Mandara Global
                              │
              ┌───────────────┼───────────────┐
              ▼               ▼               ▼
          Governance       Platform      Decommissioned
                              │
                 ┌────────────┴────────────┐
                 │   Shared Capabilities   │
                 │                         │
                 │ Management              │
                 │ Connectivity            │
                 │ Security                │
                 │ Operations              │
                 │ Identity                │
                 └────────────┬────────────┘
                              │
                              ▼
                       Landing Zones
                    ┌─────────┼─────────┐
                    │         │         │
                   Corp      Online    Sandbox
                    │         │         │
                    └─────────┼─────────┘
                              │
                        Subscriptions
                              │
                        Resource Groups
                              │
                           Resources
```

This is a conceptual architecture view.

**Platform Capabilities are shared platform responsibilities, not Management Groups.** The five capabilities — Management, Connectivity, Security, Operations and Identity — support the Landing Zones but do not represent an additional level in the Management Group hierarchy.

---

# 5. Platform Capabilities

The shared platform is organized into five capabilities:

| Capability | Purpose |
|---|---|
| **Management** | Shared management and governance-supporting services |
| **Connectivity** | Shared network and connectivity services |
| **Security** | Shared security controls and services |
| **Operations** | Monitoring, logging and operational services |
| **Identity** | Enterprise identity and access services |

The capabilities may be implemented through multiple Azure resources, subscriptions or governance scopes where required.

They should not be interpreted as additional levels in the Management Group hierarchy.

---

# 6. Landing Zones

Landing Zones provide governed environments for business workloads.

| Landing Zone | Intended Use |
|---|---|
| **Corp** | Enterprise and internal workloads |
| **Online** | Internet-facing or externally accessible workloads |
| **Sandbox** | Controlled experimentation and development |

Corp and Online support **Production** and **Non-Production** environments.

Sandbox is a separate Landing Zone intended for controlled experimentation.

The Landing Zone classification and the environment are therefore different concepts.

```text
Landing Zone
    │
    ├── Corp
    │    ├── Production
    │    └── Non-Production
    │
    ├── Online
    │    ├── Production
    │    └── Non-Production
    │
    └── Sandbox
         └── Controlled Experimentation
```

---

# 7. Governance and Management Groups

Management Groups provide the governance hierarchy used to organize subscriptions and apply policies.

They are distinct from:

- Platform Capabilities;
- Landing Zones;
- subscriptions;
- resource groups.

Governance controls such as Azure Policy can be applied at appropriate Management Group or subscription scopes.

The exact Management Group hierarchy is defined by **GOV-002** and **ADR-004**.

---

# 8. Subscriptions and Resource Organization

Subscriptions provide administrative, security, cost and operational boundaries.

Resources are organized within Resource Groups according to their lifecycle and purpose.

```text
Governance Scope
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

The subscription strategy is defined in **GOV-003**.

A Landing Zone is therefore not synonymous with a subscription. A Landing Zone defines a governed workload environment, while subscriptions provide concrete administrative and resource boundaries within that model.

---

# 9. Shared Platform Services

Landing Zones consume shared platform capabilities where appropriate.

Examples include:

| Capability | Example Services |
|---|---|
| **Management** | Resource organization and governance-supporting services |
| **Connectivity** | Hub VNet, Azure Firewall, Private DNS, VPN / ExpressRoute |
| **Security** | Security controls, Key Vault and related services |
| **Operations** | Azure Monitor, Log Analytics, diagnostics and alerts |
| **Identity** | Microsoft Entra ID, Azure RBAC and Managed Identities |

The exact services depend on the workload and the platform capability.

---

# 10. Connectivity Model

Connectivity follows the enterprise Hub & Spoke architecture.

```text
                       On-Premises
                            │
                     VPN / ExpressRoute
                            │
                            ▼
                     Hub Virtual Network
                            │
                     Azure Firewall
                            │
              ┌─────────────┼─────────────┐
              ▼             ▼             ▼
           Corp Spoke   Online Spoke   Sandbox Spoke
              │             │             │
              ▼             ▼             ▼
           Workloads     Workloads     Workloads
```

Shared connectivity services are provided by the **Connectivity Platform Capability**.

The detailed connectivity reference is defined in **REF-002** and **ADR-002**.

---

# 11. Identity and Security

Identity and security are shared platform capabilities.

The baseline includes:

- Microsoft Entra ID;
- Azure RBAC;
- Managed Identities;
- network security controls;
- Azure Policy;
- Key Vault where appropriate;
- monitoring of relevant security events.

Workload teams remain responsible for workload-specific security requirements.

The detailed identity and security decisions are defined in **ADR-006** and **ADR-008**.

---

# 12. Operations and Monitoring

The **Operations Platform Capability** provides shared monitoring and operational services.

Typical services include:

- Azure Monitor;
- Log Analytics;
- diagnostic settings;
- alerts;
- operational dashboards where required.

Platform monitoring provides shared visibility while workloads remain responsible for workload-specific monitoring requirements.

The monitoring model is defined in **ADR-007**.

---

# 13. Workload Consumption Model

Business workloads consume shared platform capabilities through their Landing Zones.

```text
Business Workload
        │
        ▼
   Landing Zone
        │
        ├── Identity
        ├── Connectivity
        ├── Security
        ├── Operations
        └── Governance
                │
                ▼
       Enterprise Platform
```

The Landing Zone provides the governed boundary; the Platform provides reusable shared capabilities.

---

# 14. Architectural Boundaries

The following concepts must remain distinct:

| Concept | Role |
|---|---|
| **Management Group** | Governance hierarchy and policy scope |
| **Platform Capability** | Shared platform responsibility and ownership |
| **Landing Zone** | Governed workload environment |
| **Subscription** | Administrative, security and cost boundary |
| **Resource Group** | Logical resource organization and lifecycle |
| **Resource** | Azure service instance |

This distinction is fundamental to the architecture.

---

# 15. Design Principles

The reference architecture follows the principles established in ARC-001, including:

- Business Before Technology
- Platform over Projects
- Infrastructure as Code
- Security by Design
- Zero Trust
- Standardization over Customization
- Shared Services First
- Observability by Default

Implementation details should remain subordinate to these architectural boundaries.

---

# 16. Architecture Flow

The overall model can be understood as:

```text
Business Requirements
        │
        ▼
Cloud Strategy
        │
        ▼
Enterprise Architecture
        │
        ▼
Governance
        │
        ▼
Shared Platform
        │
        ▼
Landing Zones
        │
        ▼
Subscriptions
        │
        ▼
Business Workloads
```

Terraform implements the infrastructure defined by these architectural decisions but does not replace the architecture itself.

---

# 17. Benefits

| Area | Benefit |
|---|---|
| Governance | Clear and consistent governance boundaries |
| Security | Shared baseline controls |
| Connectivity | Centralized enterprise connectivity |
| Operations | Common monitoring and operational services |
| Workload Onboarding | Repeatable Landing Zone model |
| Scalability | Consistent structure for additional subscriptions and workloads |
| Maintainability | Clear separation of responsibilities |

---

# 18. Related Documents

### Architecture

- ARC-001 — Architecture Principles
- ARC-002 — High-Level Architecture
- ARC-003 — Enterprise Reference Architecture

### Governance

- GOV-001 — Governance Strategy
- GOV-002 — Management Group Strategy
- GOV-003 — Subscription Strategy
- GOV-009 — Landing Zone Design

### Architecture Decisions

- ADR-001 — Enterprise Landing Zone Architecture
- ADR-002 — Hub & Spoke Network Architecture
- ADR-004 — Enterprise Management Group Hierarchy
- ADR-005 — Private Networking Strategy
- ADR-006 — Enterprise Identity Strategy
- ADR-007 — Enterprise Monitoring and Observability
- ADR-008 — Enterprise Security Baseline
- ADR-009 — Enterprise Naming Convention
- ADR-010 — Enterprise Tagging Strategy

### Reference Architectures

- REF-002 — Enterprise Connectivity Reference Architecture
- REF-003 — Enterprise Platform Services Reference Architecture

---

# 19. References

- Microsoft Cloud Adoption Framework
- Azure Landing Zones
- Azure Architecture Center
- Azure Well-Architected Framework
