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



## 1. Executive Summary

Mandara Global adopts a centralized Azure Hub-and-Spoke connectivity model. The Hub provides shared connectivity and network security services, while workload environments are deployed in isolated Spoke VNets.

The architecture supports the enterprise Landing Zone model and controlled connectivity between workloads, shared platform services and on-premises environments.

---

## 2. Purpose

This reference architecture defines the standard connectivity model for Azure Landing Zones.

It covers:

- centralized connectivity
- workload network isolation
- hybrid connectivity
- private access to Azure services
- centralized traffic inspection
- private DNS resolution
- controlled ingress and egress
- controlled network administration

This document defines a reference architecture and target pattern; it is not a detailed workload implementation.

---

## 3. Scope

This reference architecture covers:

- Hub VNet
- Spoke VNets
- Azure Firewall
- VPN Gateway
- ExpressRoute Gateway
- Private DNS
- Private Endpoints
- VNet Peering
- Azure Bastion
- Web Application Firewall (WAF) where applicable
- connectivity between Landing Zones and shared platform services

---

## 4. Architecture Overview

```text
Enterprise Platform
        │
        ▼
Connectivity Capability
        │
        ▼
     Hub VNet
        │
   ┌────┼────┐
   │    │    │
 Corp Online Sandbox
 Spokes Spokes Spokes
   │    │    │
   ▼    ▼    ▼
Workloads
```

A Landing Zone and a Spoke are related but are not synonymous architectural concepts. The Landing Zone defines the governed workload environment; the Spoke provides its network boundary.

---

## 5. High-Level Architecture

```text
                    ON-PREMISES
                         │
                    VPN / ER
                         │
                         ▼
                    ┌─────────┐
                    │   HUB   │
                    │         │
                    │ Firewall│
                    │ DNS     │
                    │ Bastion │
                    └────┬────┘
                         │
              ┌──────────┼──────────┐
              │          │          │
           CORP       ONLINE     SANDBOX
           SPOKE       SPOKE       SPOKE
              │          │          │
              ▼          ▼          ▼
          Workloads   Workloads  Workloads
```

The Hub is the shared connectivity boundary. Spokes provide workload isolation.

Not every workload requires identical connectivity. Network paths should be established according to workload requirements and enterprise security controls.

Internet-facing workloads must use an explicitly approved ingress pattern, with WAF or equivalent application-layer protection where applicable. Internet-bound traffic should use governed egress paths where centralized inspection is required.

---

## 6. Core Components

| Component | Purpose |
|---|---|
| Hub VNet | Central connectivity and shared network services |
| Spoke VNet | Isolated network boundary for a workload environment |
| Azure Firewall | Central traffic inspection and control |
| VPN Gateway | Secure hybrid connectivity |
| ExpressRoute Gateway | Dedicated private enterprise connectivity |
| Private DNS | Private name resolution for supported services |
| Private Endpoint | Private access to supported Azure PaaS services |
| VNet Peering | Connectivity between Hub and Spokes |
| Azure Bastion | Controlled administrative access to supported VMs |
| Web Application Firewall | Application-layer protection for applicable internet-facing workloads |

---

## 7. Network Design Principles

| Principle | Description |
|---|---|
| Hub & Spoke | Centralize shared connectivity services |
| Network Segmentation | Maintain workload boundaries |
| Centralized Security | Inspect/control relevant traffic through shared services |
| Private by Preference | Prefer private connectivity where it provides a meaningful security or architectural benefit |
| Least Connectivity Required | Expose only required network paths |
| Controlled Routing | Define predictable traffic paths |
| Controlled Egress | Govern outbound Internet traffic according to workload requirements and enterprise security controls |
| Shared Services | Reuse common connectivity services |
| Scalability | Support additional Landing Zones and workloads |

---

## 8. Connectivity Flow

### 8.1 Hybrid Connectivity

```text
On-Premises
     │
 VPN / ExpressRoute
     │
     ▼
    Hub
     │
 Azure Firewall
 (where inspection is required)
     │
     ▼
   Spoke
     │
     ▼
  Workload
```

### 8.2 Private PaaS Connectivity

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
Azure PaaS
```

Private DNS provides private name resolution where applicable.

### 8.3 Internet Ingress

```text
Internet
    │
    ▼
Approved Ingress / Edge
    │
    ▼
WAF (where applicable)
    │
    ▼
Online Workload
```

### 8.4 Internet Egress

```text
Workload
    │
    ▼
Spoke
    │
    ▼
Centralized Egress / Inspection
(where required)
    │
    ▼
Internet
```

---

## 9. Landing Zone Connectivity

| Landing Zone | Network Model | Typical Use |
|---|---|---|
| Corp | Spoke-based connectivity through Hub | Internal enterprise workloads |
| Online | Spoke-based connectivity with controlled external access | Internet-facing workloads |
| Sandbox | Isolated Spoke connectivity with controlled access | Experimentation/development |

Landing Zone classification does not determine every network rule; workload requirements may require additional controls.

---

## 10. Workload Isolation

```text
                 HUB
                  │
        ┌─────────┼─────────┐
        │         │         │
      Spoke A   Spoke B   Spoke C
        │         │         │
     Workloads Workloads Workloads
```

Direct spoke-to-spoke communication is not permitted by default. Where required, the path must be explicitly designed and controlled.

---

## 11. Private Connectivity

Private connectivity is preferred for supported Azure services when it provides a meaningful security or architectural benefit.

### Pattern

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
Azure PaaS
```

Private DNS is used for appropriate name resolution.

This approach follows **ADR-005**: private connectivity is a preference, not an absolute requirement for every service or scenario.

---

## 12. Hybrid Connectivity

The architecture supports on-premises connectivity through:

- VPN Gateway
- ExpressRoute Gateway

The Hub is the central connectivity point.

The choice between VPN and ExpressRoute depends on enterprise connectivity requirements and is outside the scope of this reference architecture.

---

## 13. Security and Administration

Network security is supported through:

- Azure Firewall
- NSGs where appropriate
- controlled routing
- private connectivity
- Azure Bastion for supported administrative scenarios
- Web Application Firewall for applicable internet-facing workloads

Network controls complement **ADR-008 Enterprise Security Baseline**.

---

## 14. Ownership and Governance

The **Platform Team** owns and governs shared connectivity capabilities, including:

- the Hub
- centralized network security services
- shared DNS capabilities
- hybrid connectivity

**Landing Zone owners** remain responsible for their Landing Zones and workloads within established platform guardrails.

Connectivity changes are implemented through **Infrastructure as Code** and are subject to the applicable governance and approval process.

Connectivity is governed according to least-privilege and deny-by-default principles. Exceptions require explicit justification and approval.

### Governance Model

```text
Workload Team
      │
      │ Connectivity Requirement
      ▼
 Request / IaC
      │
      ▼
Platform Governance
      │
      ▼
 Approved Connectivity
      │
      ▼
 Terraform
      │
      ▼
   Azure
```

---

## 15. Decision Boundaries

This reference architecture defines the target connectivity pattern but does not prescribe:

- every subnet range
- every NSG rule
- every route
- every workload firewall rule
- application-specific network requirements

These details belong to Landing Zone and workload implementation.

---

## 16. Implementation Alignment

Connectivity is implemented through reusable Terraform capabilities and modules.

Patterns include:

- Virtual Network
- Subnet
- NSG
- Private Endpoint
- Connectivity Resources

Detailed implementation is maintained in the repository's Terraform implementation area.

---

## 17. Benefits

- **Security** — Consistent and controlled network boundaries
- **Connectivity** — Predictable communication paths
- **Hybrid Integration** — Standardized on-premises connectivity patterns
- **Operations** — Centralized inspection and governance
- **Scalability** — Repeatable connectivity for additional Landing Zones and workloads
- **Governance** — Clear ownership and controlled changes
- **Workload Onboarding** — Reusable connectivity patterns

---

## 18. Related Documents

### Architecture

- ARC-002
- ARC-003

### Governance

- GOV-003
- GOV-009

### ADRs

- ADR-002
- ADR-005
- ADR-008

### Reference Architectures

- REF-001
- REF-003

---

## 19. References

- Microsoft Cloud Adoption Framework
- Azure Landing Zones
- Azure Virtual Network
- Azure Firewall
- Azure Private Link
- Azure Architecture Center

---

## Version History

| Version | Date | Change |
|---|---|---|
| 1.2 | 2026-09-08 | S8 Documentation Audit alignment: explicit WAF/ingress, controlled egress, Platform/Landing Zone ownership and governance, and Terraform implementation wording. |
| 1.1 | 2026-09-01 | Approved enterprise connectivity reference architecture. |
