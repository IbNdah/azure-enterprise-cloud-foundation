# ADR-002 — Hub & Spoke Network Architecture

| **Attribute** | **Value** |
|---|---|
| **ADR ID** | ADR-002 |
| **Title** | Hub & Spoke Network Architecture |
| **Version** | 1.1 |
| **Status** | Accepted |
| **Date** | 2026-08-31 |
| **Authors** | Cloud Architecture Team |
| **Program** | OneCloud 2030 |
| **Organization** | Mandara Global |
| **Category** | Enterprise Networking |

---

# 1. Executive Summary

Mandara Global will use a **Hub & Spoke network architecture** as the standard connectivity model for the Azure Enterprise Cloud Foundation.

The architecture centralizes shared connectivity and security services in the Hub while workloads remain isolated in dedicated Spoke Virtual Networks.

This decision supports the Enterprise Landing Zone Architecture established by ADR-001 and the Connectivity platform capability defined in the reference architecture.

---

# 2. Business Context

Mandara Global operates multiple Business Units with different security, operational and compliance requirements.

Historically, network components were deployed independently, resulting in:

| Challenge | Impact |
|---|---|
| Duplicated network infrastructure | Higher cost |
| Inconsistent security controls | Increased risk |
| Independent routing designs | Operational complexity |
| Multiple connectivity gateways | Difficult management |
| Fragmented DNS | Inconsistent name resolution |
| Limited scalability | More effort for new workloads |

The cloud platform therefore requires a standardized connectivity model that provides shared enterprise services while preserving workload isolation.

---

# 3. Problem Statement

A model based only on independent workload networks would require each workload or subscription to manage its own connectivity services.

This can lead to duplicated:

- firewalls;
- VPN or ExpressRoute gateways;
- DNS services;
- routing components;
- security controls.

A centralized network architecture is therefore required to provide common connectivity and security services without removing workload-level isolation.

---

# 4. Decision

Mandara Global will implement **Hub & Spoke** as the standard network topology for Azure Landing Zones.

The **Hub** provides shared enterprise connectivity services. **Spokes** provide isolated networks for workloads.

| Component | Responsibility |
|---|---|
| Hub VNet | Shared connectivity and network security services |
| Spoke VNet | Workload network isolation |
| VNet Peering | Connectivity between Hub and Spokes |
| Azure Firewall | Central traffic inspection and control |
| VPN Gateway | Hybrid connectivity |
| ExpressRoute Gateway | Future dedicated private connectivity |
| Private DNS | Centralized private name resolution |
| Azure Bastion | Controlled administrative access |
| Routing | Controlled traffic paths between network segments |

Direct spoke-to-spoke communication is not permitted by default. Required exceptions must be explicitly designed and approved.

---

# 5. High-Level Architecture

```text
                         On-Premises
                              │
                       VPN / ExpressRoute
                              │
                              ▼
                 ┌─────────────────────────┐
                 │       Hub Network       │
                 │                         │
                 │  Azure Firewall         │
                 │  VPN Gateway            │
                 │  ExpressRoute (future) │
                 │  Private DNS             │
                 │  Azure Bastion           │
                 │  Shared Services         │
                 └────────────┬────────────┘
                              │
                    VNet Peering / Routing
                    ┌─────────┼─────────┐
                    ▼         ▼         ▼
                ┌───────┐ ┌───────┐ ┌───────┐
                │Spoke A│ │Spoke B│ │Spoke C│
                │ Corp  │ │Online │ │Sandbox│
                └───────┘ └───────┘ └───────┘
                    │         │         │
                    ▼         ▼         ▼
                 Workloads Workloads Workloads
```

The Hub belongs to the shared **Connectivity** platform capability. Spokes belong to the respective Landing Zone and workload architecture.

---

# 6. Decision Scope

This decision applies to:

- Azure virtual networks used by the foundation;
- Landing Zone networking;
- shared connectivity services;
- hybrid connectivity;
- network security and traffic inspection;
- future regional Azure network expansion.

The design is a standard architecture, not a requirement that every future workload use identical network sizing or subnet layouts.

Exceptions require documented architectural justification and approval through the established governance process.

---

# 7. Decision Drivers

| Driver | Reason |
|---|---|
| Security | Central traffic inspection and controlled connectivity |
| Isolation | Workloads remain separated in dedicated Spokes |
| Reuse | Shared network services avoid unnecessary duplication |
| Scalability | Additional Spokes and regions can be added |
| Hybrid Connectivity | Central point for VPN and future ExpressRoute |
| Operations | Centralized network management |
| Governance | Consistent enterprise network controls |
| Cost | Reduced duplication of common network services |

---

# 8. Architectural Principles

The decision follows these principles:

| Principle | Application |
|---|---|
| Centralized Connectivity | Shared network services are provided through the Hub |
| Network Segmentation | Workloads are isolated in Spokes |
| Security by Design | Traffic inspection and controlled paths are built into the topology |
| Least Connectivity Required | Connectivity is provided only where required |
| Shared Services First | Common network services are centralized |
| Infrastructure as Code | Network infrastructure is managed through Terraform |
| Scalability | The topology supports additional workloads and regions |
| Operational Simplicity | Common services are managed centrally |

---

# 9. Expected Benefits

| Area | Benefit |
|---|---|
| Security | Centralized inspection and consistent controls |
| Workload isolation | Dedicated Spoke networks |
| Cost | Reduced duplication of shared services |
| Operations | Centralized network services |
| Connectivity | Standard hybrid connectivity model |
| Scalability | Repeatable network pattern for new workloads |
| Governance | Consistent network architecture |

---

# 10. Alternatives Considered

| Option | Decision | Rationale |
|---|---|---|
| **Flat Network** | Rejected | Weak isolation and limited scalability |
| **Independent VNets** | Rejected as enterprise default | Duplicated gateways and network services |
| **Hub & Spoke** | **Selected** | Centralized services with workload isolation and scalable connectivity |

The selected model provides a balance between centralized enterprise services and workload autonomy.

---

# 11. Consequences

### Positive

- Standardized enterprise networking
- Centralized security controls
- Reusable connectivity services
- Workload network isolation
- Simplified hybrid connectivity
- Repeatable onboarding pattern
- Support for future regional expansion

### Trade-offs

- Initial network architecture is more complex than a flat network
- Workloads depend on shared Hub services for defined connectivity paths
- Centralized network services require clear ownership and operational controls
- Routing requires deliberate design as the environment grows

These trade-offs are accepted because the platform is designed for long-term enterprise use.

---

# 12. Relationship to Architecture and Governance

| Document | Relationship |
|---|---|
| ADR-001 | Establishes the Enterprise Landing Zone architecture |
| ADR-003 | Defines Terraform as the IaC standard |
| ADR-004 | Defines the Management Group hierarchy |
| ADR-005 | Defines the private networking strategy |
| ADR-006 | Defines enterprise identity |
| ADR-007 | Defines monitoring and observability |
| ADR-008 | Defines the security baseline |
| GOV-009 | Defines Landing Zone design |
| ARC-002 | Defines the high-level connectivity architecture |
| ARC-003 | Defines the enterprise reference architecture |

The Hub & Spoke decision is therefore a specific networking decision within the broader Landing Zone architecture.

---

# 13. Implementation Alignment

The current Terraform platform includes a dedicated **Connectivity capability** for shared connectivity services.

The implementation is intentionally separated from workload Landing Zones:

```text
Terraform
   │
   ├── Connectivity Capability
   │       └── Shared Hub Services
   │
   └── Landing Zones
           └── Workload Spokes
```

This preserves the distinction between shared platform ownership and workload infrastructure.

---

# 14. Review

This decision should be reviewed when significant changes occur to:

- Azure networking capabilities;
- enterprise connectivity requirements;
- hybrid connectivity strategy;
- security architecture;
- regional expansion;
- the cloud operating model.

---

# 15. References

- Microsoft Cloud Adoption Framework
- Azure Architecture Center
- Azure Well-Architected Framework
- GOV-009 — Landing Zone Design
- ARC-002 — High-Level Architecture
- ARC-003 — Enterprise Reference Architecture
- ADR-001 — Enterprise Landing Zone Architecture
