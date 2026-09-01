# ARC-003 — Enterprise Reference Architecture

| Attribute | Value |
|---|---|
| Document ID | ARC-003 |
| Title | Enterprise Reference Architecture |
| Version | 1.1 |
| Status | Approved |
| Date | 2026-09-01 |
| Author | Cloud Center of Excellence (CCoE) |
| Program | OneCloud 2030 |
| Organization | Mandara Global |

## 1. Purpose

This document defines the enterprise reference architecture for the Azure Enterprise Cloud Foundation. It connects governance, shared Platform Capabilities, Landing Zones, subscriptions, resource groups, and workloads.

It complements ARC-002, which provides the high-level architectural view.

## 2. Architectural Model

| Element | Role |
|---|---|
| Governance | Enterprise controls and hierarchy |
| Platform | Shared enterprise capabilities |
| Landing Zones | Governed workload boundaries |
| Subscription | Azure administrative, security, cost, and operational boundary |
| Resource Group | Logical and lifecycle grouping |
| Resource | Azure service or workload component |

These elements are related but are not interchangeable.

## 3. High-Level Enterprise Structure

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

This is a conceptual structure. Governance, Platform, and Landing Zones are architectural constructs, not Azure resource types.

## 4. Enterprise Governance

Governance establishes the controls under which Azure operates.

Key elements:
- Management Groups
- Azure Policy
- RBAC
- Subscription strategy
- Resource organization
- Naming standards
- Tagging standards
- Cost and compliance controls

Management Groups provide the Azure governance hierarchy and are not synonymous with Platform Capabilities.

## 5. Platform Capabilities

The shared Platform is organized into five capabilities:

| Capability | Primary Responsibility |
|---|---|
| Management | Central management and governance-supporting services |
| Connectivity | Shared network and hybrid connectivity services |
| Security | Shared security controls and services |
| Operations | Monitoring, logging, diagnostics, and operational services |
| Identity | Enterprise identity and access services |

A Platform Capability represents a responsibility and service boundary, not a Management Group. A capability may use multiple Azure resources and scopes where required.

```text
                    Platform
                       │
       ┌───────────────┼───────────────┐
       ▼               ▼               ▼
  Management      Connectivity      Security
       │               │               │
       └───────────────┼───────────────┘
                       ▼
                Operations / Identity
```

The diagram is conceptual and does not prescribe deployment dependency between capabilities.

## 6. Landing Zones

Landing Zones provide governed boundaries for business workloads.

| Landing Zone | Intended Use |
|---|---|
| Corp | Internal and enterprise workloads |
| Online | Internet-facing or externally accessible workloads |
| Sandbox | Controlled experimentation and development |

Landing Zones consume shared Platform Capabilities rather than unnecessarily recreating common enterprise services.

## 7. Environment Context

Environment and Landing Zone are separate concepts.

```text
Landing Zone
├── Corp
├── Online
└── Sandbox

Environment
├── dev
├── test
└── prod
```

The Landing Zone identifies the workload boundary; the environment identifies the deployment context.

```text
Corp     ≠ Production
Online   ≠ Non-Production
Sandbox  ≠ Environment
```

The exact combination depends on workload requirements and the enterprise deployment model.

## 8. Subscription and Resource Organization

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

Subscriptions provide administration, security, cost, and operational boundaries. Resource Groups provide logical grouping and lifecycle boundaries.

## 9. Connectivity Reference

```text
                    Enterprise Connectivity
                             │
                             ▼
                         Hub VNet
                             │
              ┌──────────────┼──────────────┐
              ▼              ▼              ▼
          Corp Spoke     Online Spoke    Sandbox Spoke
              │              │              │
              ▼              ▼              ▼
          Workloads       Workloads       Workloads
```

Hybrid connectivity may use VPN or ExpressRoute where required. Private connectivity follows the approved Private Link and Private DNS architecture.

## 10. Security and Identity

Security and identity are cross-cutting concerns.

The reference architecture supports:
- Microsoft Entra ID
- RBAC
- Managed Identities
- Conditional Access
- Microsoft Defender for Cloud
- Key Vault
- Azure Policy
- network segmentation
- private connectivity where appropriate

Controls are applied at the appropriate governance, platform, subscription, or workload boundary.

## 11. Operations and Observability

Operations provides shared capabilities for platform and workload visibility.

Examples:
- Azure Monitor
- Log Analytics
- Diagnostic Settings
- Alerts
- Dashboards
- Microsoft Sentinel
- Managed Grafana where required

The Operations capability provides the shared operational foundation. Workloads remain responsible for workload-specific monitoring.

## 12. Business Workloads

Business workloads are deployed within approved Landing Zones.

Examples include manufacturing, finance, HR, AI and analytics, customer applications, and internal platforms.

Workload teams consume shared platform services while retaining responsibility for application-specific architecture and configuration.

## 13. End-to-End View

```text
                         Azure Tenant
                              │
                         Governance
                              │
              ┌───────────────┴───────────────┐
              ▼                               ▼
          Platform                      Landing Zones
              │                               │
      ┌───────┼───────┐              ┌───────┼───────┐
      ▼       ▼       ▼              ▼       ▼       ▼
 Management Connectivity Security   Corp    Online  Sandbox
      │       │       │               │       │       │
      └───────┼───────┘               └───────┼───────┘
              ▼                               ▼
       Operations / Identity            Subscriptions
                                              │
                                        Resource Groups
                                              │
                                           Resources
                                              │
                                          Workloads
```

This view separates shared platform responsibilities from workload boundaries.

## 14. Architecture Decision Flow

```text
Business Requirements
        ↓
Cloud Strategy
        ↓
Architecture Principles
        ↓
Enterprise Reference Architecture
        ↓
Architecture Decisions
        ↓
Terraform Implementation
        ↓
Azure Resources
```

## 15. Design Principles

- Business requirements drive architectural decisions.
- Governance is applied at the appropriate scope.
- Shared Platform Capabilities are preferred where reuse is beneficial.
- Landing Zones provide clear workload boundaries.
- Subscriptions provide clear Azure administrative boundaries.
- Security and identity are integrated across the architecture.
- Infrastructure is managed through Infrastructure as Code.
- The architecture remains as simple as practical.

## 16. Scope and Evolution

This document defines the stable logical reference model. Detailed implementation may evolve as Azure services, organizational requirements, and workload patterns change.

A fundamental change to an architectural boundary should trigger review of the relevant architecture and ADR documents.

## 17. Related Documents

| Document | Relationship |
|---|---|
| ARC-001 | Architecture Principles |
| ARC-002 | High-Level Architecture |
| GOV-002 | Management Group Strategy |
| GOV-003 | Subscription Strategy |
| GOV-004 | Resource Organization Strategy |
| GOV-009 | Landing Zone Design |
| ADR-001 | Enterprise Landing Zone Architecture |
| ADR-002 | Hub & Spoke Network Architecture |
| ADR-004 | Enterprise Management Group Hierarchy |
| ADR-005 | Private Networking Strategy |
| TF-004 | Terraform Platform |
| TF-005 | Terraform Landing Zones |
| REF-001 | Enterprise Landing Zone Reference Architecture |
| REF-002 | Enterprise Connectivity Reference Architecture |
