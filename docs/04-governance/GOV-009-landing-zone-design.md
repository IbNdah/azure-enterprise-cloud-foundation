# GOV-009 — Landing Zone Design

| Attribute | Value |
|---|---|
| **Document ID** | GOV-009 |
| **Title** | Landing Zone Design |
| **Version** | 1.1 |
| **Status** | Approved |
| **Date** | 2026-08-31 |
| **Program** | OneCloud 2030 |
| **Organization** | Mandara Global |

---

# 1. Purpose

This document defines the standard Landing Zone model for the Azure Enterprise Cloud Foundation.

Landing Zones provide governed boundaries in which business workloads can be deployed while shared enterprise platform capabilities provide common services.

---

# 2. Landing Zone Model

The current model contains three Landing Zone types:

| Landing Zone | Purpose |
|---|---|
| **Corp** | Internal and enterprise workloads |
| **Online** | Internet-facing or externally accessible workloads |
| **Sandbox** | Controlled experimentation and development |

Corp and Online are organized by Production and Non-Production. Sandbox is maintained as a separate Landing Zone.

```text
Landing Zones
│
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

---

# 3. Relationship to the Platform

Landing Zones consume shared services provided by the platform.

```text
                    Shared Platform
                          │
          ┌───────────────┼───────────────┐
          │               │               │
      Identity       Connectivity      Security
          │               │               │
          └───────────────┼───────────────┘
                          │
                          ▼
                    Landing Zones
                          │
                          ▼
                      Workloads
```

The platform capabilities are:

- Management
- Connectivity
- Security
- Operations
- Identity

These are shared service and ownership boundaries, not automatically Management Groups.

---

# 4. Landing Zone Boundaries

A Landing Zone establishes a governed workload boundary.

| Boundary | Primary Purpose |
|---|---|
| Management Group | Governance and inherited controls |
| Landing Zone | Workload environment and architectural boundary |
| Subscription | Administrative, cost, security and operational boundary |
| Resource Group | Resource organization and lifecycle grouping |

A Landing Zone may contain one or more subscriptions when separate boundaries are justified.

---

# 5. Subscription Model

Subscriptions are used where isolation or separate ownership is required.

Typical reasons include:

- production isolation;
- non-production isolation;
- cost management;
- security boundaries;
- operational ownership;
- workload scale.

Subscription placement follows GOV-003 and the Management Group strategy defined in GOV-002.

---

# 6. Standard Landing Zone Capabilities

Each Landing Zone should integrate with the shared platform for:

| Capability | Expected Integration |
|---|---|
| Identity | Enterprise authentication and authorization |
| Connectivity | Approved network connectivity |
| Security | Enterprise security controls and policy |
| Operations | Monitoring, logging and operational visibility |
| Management | Governance and management services |

Landing Zones should not independently duplicate shared enterprise services unless a documented requirement justifies it.

---

# 7. Network Model

The Landing Zone network model follows the enterprise Hub & Spoke architecture.

```text
                 Shared Connectivity Hub
                          │
             ┌────────────┼────────────┐
             ▼            ▼            ▼
          Corp Spoke   Online Spoke  Sandbox Spoke
             │            │            │
             ▼            ▼            ▼
          Workloads     Workloads    Workloads
```

Shared connectivity services are provided through the Connectivity platform capability.

Detailed network architecture is defined in ADR-002 and the related architecture documents.

---

# 8. Governance Controls

Landing Zones inherit enterprise governance through the Management Group and subscription structure.

Controls include:

- Azure Policy;
- RBAC;
- naming conventions;
- tagging requirements;
- security baseline;
- monitoring requirements.

The specific controls are defined in the respective governance strategies and ADRs.

---

# 9. Design Principles

| Principle | Application |
|---|---|
| Standardization | Use common Landing Zone patterns |
| Isolation | Keep workloads within defined boundaries |
| Shared Services | Reuse enterprise platform capabilities |
| Governance | Apply controls consistently |
| Automation | Provision infrastructure through Terraform |
| Scalability | Support additional subscriptions and workloads |
| Simplicity | Avoid unnecessary Landing Zone variants |

---

# 10. Consequences

### Benefits

- Consistent workload onboarding
- Clear workload boundaries
- Shared enterprise services
- Reusable governance controls
- Scalable Azure adoption
- Reduced infrastructure duplication

### Trade-offs

- Landing Zones require platform dependencies
- Subscription placement requires governance
- Shared services need clear ownership
- Exceptions require additional governance effort

---

# 11. Relationship to Other Documents

| Document | Relationship |
|---|---|
| **ARC-002** | High-level architecture |
| **ARC-003** | Enterprise reference architecture |
| **GOV-002** | Management Group strategy |
| **GOV-003** | Subscription strategy |
| **GOV-004** | Resource organization |
| **GOV-005** | Naming convention |
| **GOV-006** | RBAC strategy |
| **GOV-007** | Azure Policy strategy |
| **GOV-008** | Tagging strategy |
| **ADR-001** | Enterprise Landing Zone architecture |
| **ADR-002** | Hub & Spoke network architecture |

---

# 12. Review

Review the Landing Zone design when significant changes occur to the cloud strategy, organizational model, subscription strategy, security requirements, connectivity architecture or Azure Landing Zone guidance.
