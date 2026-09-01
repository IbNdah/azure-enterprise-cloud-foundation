# REF-002 — Enterprise Connectivity Reference Architecture

| Attribute | Value |
|---|---|
| **Reference ID** | REF-002 |
| **Title** | Enterprise Connectivity Reference Architecture |
| **Version** | 1.1 |
| **Status** | Approved |
| **Date** | 2026-09-01 |
| **Authors** | Cloud Architecture Team |
| **Program** | OneCloud 2030 |
| **Organization** | Mandara Global |
| **Category** | Networking |

---

# 1. Executive Summary

Mandara Global uses a centralized enterprise networking model based on **Azure Hub & Spoke architecture**.

The Hub provides shared connectivity and network security services, while workload environments are deployed into isolated Spoke Virtual Networks.

The connectivity architecture supports the enterprise Landing Zone model and provides controlled connectivity between workloads, shared platform services and on-premises environments.

---

# 2. Purpose

This reference architecture provides the standard connectivity model for Azure Landing Zones.

It establishes a common pattern for:

- centralized connectivity;
- workload network isolation;
- hybrid connectivity;
- private access to Azure services;
- centralized traffic inspection;
- private DNS resolution;
- controlled network administration.

It is a reference architecture rather than a detailed implementation specification.

---

# 3. Scope

This architecture covers:

- Hub Virtual Network;
- Spoke Virtual Networks;
- Azure Firewall;
- VPN Gateway;
- ExpressRoute Gateway;
- Private DNS;
- Private Endpoints;
- Virtual Network Peering;
- Azure Bastion;
- connectivity between Landing Zones and shared platform services.

---

# 4. Architecture Overview

The network architecture separates shared connectivity services from workload networks.

The **Hub Virtual Network** provides centralized connectivity and security services.

**Spoke Virtual Networks** provide network boundaries for workloads deployed through Landing Zones.

The connectivity model is aligned with the Landing Zone structure:

```text
Enterprise Platform
        │
        ▼
 Connectivity Capability
        │
        ▼
     Hub VNet
        │
        ├───────────────┬───────────────┐
        ▼               ▼               ▼
     Corp Spokes     Online Spokes   Sandbox Spokes
        │               │               │
        ▼               ▼               ▼
    Workloads        Workloads       Workloads
```

A Landing Zone and a Spoke are related but are not synonymous architectural concepts. The Landing Zone defines the governed workload environment; the Spoke provides its network boundary.

---

# 5. High-Level Architecture

```text
                         On-Premises
                              │
                     VPN / ExpressRoute
                              │
                              ▼
                    ┌──────────────────┐
                    │    Hub VNet      │
                    │                  │
                    │ Azure Firewall   │
                    │ Private DNS      │
                    │ Bastion          │
                    └────────┬─────────┘
                             │
                ┌────────────┼────────────┐
                │            │            │
                ▼            ▼            ▼
           Corp Spokes   Online Spokes  Sandbox Spokes
                │            │            │
                ▼            ▼            ▼
            Workloads     Workloads     Workloads
```

The Hub is the shared connectivity boundary. Spokes provide workload isolation.

Not every workload requires identical connectivity. Network paths should be established according to workload requirements and enterprise security controls.

---

# 6. Core Components

| Component | Purpose |
|---|---|
| **Hub VNet** | Central connectivity and shared network services |
| **Spoke VNet** | Isolated network boundary for a workload environment |
| **Azure Firewall** | Central traffic inspection and control |
| **VPN Gateway** | Secure hybrid connectivity |
| **ExpressRoute Gateway** | Dedicated private enterprise connectivity |
| **Private DNS** | Private name resolution for supported services |
| **Private Endpoint** | Private access to supported Azure PaaS services |
| **VNet Peering** | Connectivity between Hub and Spokes |
| **Azure Bastion** | Controlled administrative access to supported virtual machines |

---

# 7. Network Design Principles

| Principle | Application |
|---|---|
| **Hub & Spoke** | Centralize shared connectivity services |
| **Network Segmentation** | Maintain workload boundaries |
| **Centralized Security** | Inspect and control relevant traffic through shared services |
| **Private by Preference** | Prefer private connectivity where it provides a meaningful benefit |
| **Least Connectivity Required** | Expose only required network paths |
| **Shared Services** | Reuse common connectivity services |
| **Controlled Routing** | Define predictable traffic paths |
| **Scalability** | Support additional Landing Zones and workloads |

---

# 8. Connectivity Flow

A typical hybrid connectivity flow is:

```text
On-Premises
     │
     ▼
VPN / ExpressRoute
     │
     ▼
Hub Virtual Network
     │
     ▼
Azure Firewall
     │
     ▼
Spoke Virtual Network
     │
     ▼
Application Workload
```

A typical private PaaS access flow is:

```text
Workload
   │
   ▼
Spoke VNet
   │
   ▼
Private Endpoint
   │
   ▼
Azure PaaS Service
```

Private DNS provides the required private name resolution where applicable.

---

# 9. Landing Zone Connectivity

Connectivity is provided according to the Landing Zone type and workload requirements.

| Landing Zone | Network Model | Typical Use |
|---|---|---|
| **Corp** | Spoke-based connectivity through the Hub | Internal enterprise workloads |
| **Online** | Spoke-based connectivity with controlled external access | Internet-facing workloads |
| **Sandbox** | Isolated Spoke connectivity with controlled access | Experimentation and development |

The Landing Zone classification does not determine every network rule. Specific workload requirements may require additional controls.

---

# 10. Workload Isolation

Each workload environment should have an appropriate network boundary.

The default model is:

```text
                    Hub VNet
                       │
          ┌────────────┼────────────┐
          │            │            │
          ▼            ▼            ▼
       Spoke A      Spoke B      Spoke C
          │            │            │
       Workload A   Workload B   Workload C
```

Direct spoke-to-spoke communication is not permitted by default.

Where communication is required, the path must be explicitly designed and controlled.

---

# 11. Private Connectivity

Private connectivity is preferred for supported Azure services when it provides a meaningful security or architectural benefit.

The standard pattern is:

```text
Spoke VNet
    │
    ▼
Private Endpoint
    │
    ▼
Private Link
    │
    ▼
Azure PaaS Service
```

Private DNS is used to provide appropriate name resolution for private endpoints.

This follows the principle established in **ADR-005**: private connectivity is a preference, not an absolute requirement for every service or scenario.

---

# 12. Hybrid Connectivity

The architecture supports enterprise connectivity to on-premises environments through:

- VPN Gateway;
- ExpressRoute Gateway.

The Hub acts as the central connectivity point.

The choice between VPN and ExpressRoute depends on enterprise connectivity requirements and is outside the scope of this reference architecture.

---

# 13. Security and Administration

Network security is supported through:

- Azure Firewall;
- Network Security Groups where appropriate;
- controlled routing;
- private connectivity;
- Azure Bastion for supported administrative scenarios.

Network controls complement the enterprise security baseline defined in **ADR-008**.

---

# 14. Decision Boundaries

This reference architecture defines the target connectivity pattern but does not prescribe:

- every subnet address range;
- every NSG rule;
- every route;
- every workload firewall rule;
- application-specific network requirements.

Those details belong to the relevant Landing Zone or workload implementation.

---

# 15. Implementation Alignment

The connectivity architecture is implemented through reusable Terraform capabilities and modules.

Relevant infrastructure patterns include:

```text
Terraform
    │
    ├── Virtual Network
    ├── Subnet
    ├── Network Security Group
    ├── Private Endpoint
    └── Connectivity Resources
```

The detailed implementation is maintained under `10-terraform`.

---

# 16. Benefits

| Area | Benefit |
|---|---|
| Security | Centralized traffic controls and workload isolation |
| Connectivity | Consistent enterprise network model |
| Hybrid Integration | Standard private connectivity pattern |
| Operations | Shared network services |
| Scalability | Repeatable pattern for additional workloads |
| Governance | Clear network ownership and boundaries |
| Workload Onboarding | Reusable connectivity model |

---

# 17. Related Documents

### Architecture

- ARC-002 — High-Level Architecture
- ARC-003 — Enterprise Reference Architecture

### Governance

- GOV-003 — Subscription Strategy
- GOV-009 — Landing Zone Design

### Architecture Decisions

- ADR-002 — Hub & Spoke Network Architecture
- ADR-005 — Private Networking Strategy
- ADR-008 — Enterprise Security Baseline

### Reference Architectures

- REF-001 — Enterprise Landing Zone Reference Architecture
- REF-003 — Enterprise Platform Services Reference Architecture

---

# 18. References

- Microsoft Cloud Adoption Framework
- Azure Landing Zones
- Azure Virtual Network
- Azure Firewall
- Azure Private Link
- Azure Architecture Center
