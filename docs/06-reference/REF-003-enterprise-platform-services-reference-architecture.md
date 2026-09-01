# REF-003 — Enterprise Platform Services Reference Architecture

| Attribute | Value |
|---|---|
| **Reference ID** | REF-003 |
| **Title** | Enterprise Platform Services Reference Architecture |
| **Version** | 1.1 |
| **Status** | Approved |
| **Date** | 2026-09-01 |
| **Authors** | Cloud Architecture Team |
| **Program** | OneCloud 2030 |
| **Organization** | Mandara Global |
| **Category** | Platform Architecture |

---

# 1. Executive Summary

Mandara Global provides a shared Azure platform for enterprise workloads.

The platform is organized into five capabilities:

- **Management**
- **Connectivity**
- **Security**
- **Operations**
- **Identity**

These capabilities provide shared services consumed by Landing Zones and their workloads.

They represent **platform responsibilities and ownership boundaries**, not additional levels in the Management Group hierarchy.

---

# 2. Purpose

This reference architecture describes the main shared services provided by the Azure Enterprise Cloud Foundation.

It establishes a common reference for:

- platform capabilities;
- shared services;
- workload consumption;
- platform ownership;
- security and operational boundaries.

It does not define every Azure service available to workloads.

---

# 3. Scope

This reference architecture covers the shared platform capabilities supporting:

- Corp Landing Zones;
- Online Landing Zones;
- Sandbox Landing Zones;
- enterprise governance;
- workload connectivity;
- security;
- identity;
- monitoring and operations.

Workload-specific services remain the responsibility of the workload team unless explicitly provided as shared platform services.

---

# 4. Platform Architecture

The platform sits between enterprise governance and workload Landing Zones.

```text
                         Enterprise Governance
                                │
                                ▼
                     ┌──────────────────────┐
                     │   Shared Platform    │
                     │                      │
                     │ Management           │
                     │ Connectivity         │
                     │ Security             │
                     │ Operations           │
                     │ Identity             │
                     └──────────┬───────────┘
                                │
                                ▼
                         Landing Zones
                    ┌──────────┼──────────┐
                    │          │          │
                   Corp       Online     Sandbox
                    │          │          │
                    └──────────┼──────────┘
                               │
                         Workload Services
```

The platform provides shared capabilities; Landing Zones provide governed workload environments.

---

# 5. Platform Capabilities

| Capability | Primary Responsibility | Typical Shared Services |
|---|---|---|
| **Management** | Resource governance and management support | Resource organization, policy-related services |
| **Connectivity** | Enterprise network connectivity | Hub VNet, Azure Firewall, VPN / ExpressRoute, Private DNS |
| **Security** | Shared security controls | Key Vault, security controls, policy-related services |
| **Operations** | Monitoring and operational visibility | Azure Monitor, Log Analytics, diagnostics, alerts |
| **Identity** | Enterprise identity and access | Microsoft Entra ID, RBAC, Managed Identities |

The listed services are examples, not an exhaustive catalogue.

A capability may use multiple Azure services to fulfil its responsibility.

---

# 6. Capability Boundaries

The five capabilities are logically distinct but work together.

```text
                  Shared Platform
                         │
       ┌─────────────────┼─────────────────┐
       │                 │                 │
       ▼                 ▼                 ▼
  Management        Connectivity        Security
       │                 │                 │
       └────────────┬────┴────┬────────────┘
                    ▼         ▼
                Operations  Identity
                    │         │
                    └────┬────┘
                         ▼
                  Landing Zones
```

The diagram represents collaboration between capabilities, not a deployment or dependency hierarchy.

---

# 7. Shared Service Examples

## 7.1 Management

Management provides services supporting consistent resource governance and organization.

Examples:

- resource organization;
- governance-supporting resources;
- Azure Policy integration where appropriate.

Example:

```text
Management
    │
    ├── Resource organization
    └── Governance support
```

---

## 7.2 Connectivity

Connectivity provides shared network services.

Examples:

```text
Connectivity
     │
     ├── Hub VNet
     ├── Azure Firewall
     ├── VPN / ExpressRoute
     ├── Private DNS
     └── Shared network controls
```

Landing Zones consume these services according to their connectivity requirements.

The detailed connectivity architecture is defined in **REF-002**.

---

## 7.3 Security

Security provides shared controls and services that establish the enterprise security baseline.

Examples:

```text
Security
    │
    ├── Key Vault
    ├── Security controls
    └── Policy / compliance integration
```

Workloads remain responsible for workload-specific security requirements.

---

## 7.4 Operations

Operations provides common monitoring and operational visibility.

Examples:

```text
Operations
    │
    ├── Azure Monitor
    ├── Log Analytics
    ├── Diagnostic Settings
    └── Alerts
```

Shared monitoring does not remove the responsibility of workload teams to implement workload-specific monitoring.

---

## 7.5 Identity

Identity provides the enterprise identity and access foundation.

Examples:

```text
Identity
    │
    ├── Microsoft Entra ID
    ├── Azure RBAC
    └── Managed Identities
```

Access should follow the enterprise identity and RBAC strategy.

---

# 8. Platform-to-Landing-Zone Consumption

Landing Zones consume shared platform capabilities rather than implementing every foundational service independently.

```text
                       Shared Platform
                              │
       ┌──────────┬───────────┼───────────┬──────────┐
       ▼          ▼           ▼           ▼          ▼
  Management Connectivity Security   Operations  Identity
       │          │           │           │          │
       └──────────┴───────────┴───────────┴──────────┘
                              │
                              ▼
                       Landing Zone
                              │
                              ▼
                          Workload
```

The consumption model reduces duplication while preserving workload autonomy.

---

# 9. Platform vs Workload Responsibilities

| Area | Platform | Workload |
|---|---|---|
| Enterprise identity | Shared | Consumes |
| Core connectivity | Shared | Consumes / configures workload-specific needs |
| Enterprise security baseline | Shared | Adds workload-specific controls |
| Central monitoring | Shared | Adds workload-specific monitoring |
| Resource governance | Shared | Complies |
| Application services | Not normally shared | Workload-owned |
| Application configuration | Not shared | Workload-owned |
| Business logic | Not shared | Workload-owned |

The boundary is intentional: the platform provides reusable foundations while workloads retain ownership of application-specific concerns.

---

# 10. Security and Governance

Platform services operate within the enterprise governance framework.

Relevant controls include:

- Management Group governance;
- Azure Policy;
- RBAC;
- network security controls;
- resource naming;
- tagging;
- monitoring.

The platform does not replace governance; it provides services that enable governance to be applied consistently.

---

# 11. Operational Model

Shared platform services should be:

- centrally governed;
- consistently configured;
- monitored;
- managed through Infrastructure as Code where appropriate;
- reusable across Landing Zones.

Workload teams remain responsible for the operation of workload-specific services.

---

# 12. Implementation Alignment

The platform architecture is implemented through Terraform using reusable modules and platform capability configurations.

```text
Terraform Root
      │
      ├── Platform
      │    ├── Management
      │    ├── Connectivity
      │    ├── Security
      │    ├── Operations
      │    └── Identity
      │
      ├── Reusable Modules
      │
      └── Landing Zones
           ├── Corp
           ├── Online
           └── Sandbox
```

This is an implementation alignment view. The detailed Terraform structure and deployment process are documented under `07-terraform`.

---

# 13. Design Principles

The platform follows these principles:

| Principle | Application |
|---|---|
| **Shared Services First** | Reuse common foundational services |
| **Security by Design** | Integrate security into the platform baseline |
| **Infrastructure as Code** | Provision infrastructure consistently |
| **Standardization** | Prefer common patterns over individual implementations |
| **Least Privilege** | Limit access to required scope |
| **Observability** | Provide common operational visibility |
| **Workload Autonomy** | Keep workload-specific concerns with workload teams |

---

# 14. Benefits

| Area | Benefit |
|---|---|
| Consistency | Common platform patterns |
| Security | Shared enterprise baseline |
| Operations | Central monitoring and operational services |
| Connectivity | Reusable enterprise network services |
| Identity | Common access model |
| Scalability | Repeatable support for additional Landing Zones |
| Cost | Reduced duplication of foundational services |

---

# 15. Related Documents

### Architecture

- ARC-001 — Architecture Principles
- ARC-002 — High-Level Architecture
- ARC-003 — Enterprise Reference Architecture

### Governance

- GOV-002 — Management Group Strategy
- GOV-006 — RBAC Strategy
- GOV-007 — Azure Policy Strategy
- GOV-009 — Landing Zone Design

### Architecture Decisions

- ADR-001 — Enterprise Landing Zone Architecture
- ADR-004 — Enterprise Management Group Hierarchy
- ADR-006 — Enterprise Identity Strategy
- ADR-007 — Enterprise Monitoring and Observability
- ADR-008 — Enterprise Security Baseline
- ADR-010 — Enterprise Tagging Strategy

### Reference Architectures

- REF-001 — Enterprise Landing Zone Reference Architecture
- REF-002 — Enterprise Connectivity Reference Architecture

---

# 16. References

- Microsoft Cloud Adoption Framework
- Azure Landing Zones
- Azure Architecture Center
- Azure Well-Architected Framework
