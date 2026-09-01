# GOV-003 – Subscription Strategy

| **Document ID** | GOV-003                              |
| --------------- | ------------------------------------ |
| **Version**     | 1.1                                  |
| **Status**      | Approved                             |
| **Owner**       | Cloud Platform Team                  |
| **Audience**    | Cloud Architects, Platform Engineers |

---

# 1. Purpose

This document defines the Azure subscription strategy for Mandara Global.

Subscriptions provide administrative, security, cost and operational boundaries for Azure resources.

The strategy defines how subscriptions relate to Management Groups, Landing Zones, environments and platform services.

---

# 2. Context

The Azure Enterprise Cloud Foundation separates shared platform services from business workloads.

The Management Group hierarchy defined in **GOV-002** provides the governance structure, while subscriptions provide the operational and administrative boundaries within that structure.

The subscription model must support:

* shared enterprise platform services;
* business workloads;
* production and non-production environments;
* sandbox workloads;
* independent access and cost management;
* future growth without unnecessary restructuring.

---

# 3. Subscription Model

Subscriptions are organized within the Management Group hierarchy.

```text
Tenant Root
│
└── Mandara Global
    │
    ├── Platform
    │   └── Platform Subscriptions
    │
    ├── Landing Zones
    │   │
    │   ├── Corp
    │   │   ├── Production Subscriptions
    │   │   └── Non-Production Subscriptions
    │   │
    │   ├── Online
    │   │   ├── Production Subscriptions
    │   │   └── Non-Production Subscriptions
    │   │
    │   └── Sandbox
    │       └── Sandbox Subscriptions
    │
    └── Decommissioned
```

The following concepts must remain distinct:

| Concept              | Purpose                                                          |
| -------------------- | ---------------------------------------------------------------- |
| **Management Group** | Governance boundary for subscriptions                            |
| **Landing Zone**     | Workload governance and architecture boundary                    |
| **Environment**      | Workload lifecycle context, such as Production or Non-Production |
| **Subscription**     | Administrative, security, cost and operational boundary          |
| **Resource Group**   | Logical grouping of resources within a subscription              |

---

# 4. Platform Subscriptions

Platform subscriptions host shared services used by the enterprise platform and Landing Zones.

The platform is organized around five capabilities established in the platform foundation:

| Capability       | Scope                                        |
| ---------------- | -------------------------------------------- |
| **Management**   | Shared management and governance services    |
| **Connectivity** | Shared networking and connectivity services  |
| **Security**     | Enterprise security services and controls    |
| **Operations**   | Operational and supporting platform services |
| **Identity**     | Shared identity and access capabilities      |

These capabilities are architectural responsibilities and are not required to map one-to-one to Management Groups or subscriptions.

The final subscription allocation may depend on operational ownership and the scale of the platform.

---

# 5. Landing Zone Subscriptions

Landing Zone subscriptions host business workloads and are placed under the appropriate Landing Zone Management Group.

## Corp

Corp is intended for workloads requiring private enterprise connectivity and internal integration.

Typical separation:

```text
Corp
│
├── Production
└── Non-Production
```

Production and non-production workloads should normally be separated into different subscriptions where they require different administrative, security or operational boundaries.

## Online

Online is intended for workloads requiring Internet-facing or externally accessible architectures.

Typical separation:

```text
Online
│
├── Production
└── Non-Production
```

Online workloads remain subject to enterprise governance while allowing workload-specific network and security requirements.

## Sandbox

Sandbox provides an isolated environment for experimentation, learning and proof-of-concept workloads.

```text
Sandbox
│
└── Sandbox Subscriptions
```

Sandbox subscriptions must remain separated from production workloads and should operate with appropriate governance restrictions.

---

# 6. Subscription Governance and Lifecycle

Subscriptions inherit applicable governance from their Management Group.

```text
Management Group
        │
        ▼
   Subscription
        │
        ▼
 Resource Groups
        │
        ▼
    Resources
```

Governance may include:

* Azure Policy;
* RBAC;
* security controls;
* naming and tagging requirements;
* monitoring and diagnostic requirements.

Subscription lifecycle:

```text
Request
   │
   ▼
Review
   │
   ▼
Provision
   │
   ▼
Place in Management Group
   │
   ▼
Apply inherited governance
   │
   ▼
Deploy workloads
   │
   ▼
Operate
   │
   ▼
Decommission
```

Subscriptions should be provisioned and managed through Infrastructure as Code where applicable.

---

# 7. Subscription Design Rules

| Rule          | Requirement                                                                                                 |
| ------------- | ----------------------------------------------------------------------------------------------------------- |
| Governance    | Every subscription must belong to an approved Management Group.                                             |
| Landing Zone  | Every workload subscription must belong to an approved Landing Zone.                                        |
| Isolation     | Production and non-production should be separated when their governance or operational requirements differ. |
| Platform      | Shared platform services must remain separate from business workloads.                                      |
| Creation      | A new subscription should have a clear administrative, security, cost or operational reason.                |
| Fragmentation | Avoid creating subscriptions without a meaningful boundary.                                                 |
| Lifecycle     | Subscription creation, placement and decommissioning must follow the defined lifecycle.                     |
| Governance    | Subscriptions inherit enterprise controls from their Management Group.                                      |

---

# 8. Decision and Related Documents

## Decision

Mandara Global will use Azure subscriptions as the primary administrative, security, cost and operational boundary for Azure workloads.

Subscriptions will be organized under the Management Group hierarchy and Landing Zone model defined by GOV-002 and GOV-009.

The model allows multiple subscriptions within a Landing Zone where a clear boundary requires them.

The strategy intentionally avoids a fixed one-subscription-per-environment model.

## Related Documents

* GOV-001 — Cloud Governance Strategy
* GOV-002 — Management Groups Strategy
* GOV-005 — Naming Convention
* GOV-006 — RBAC Strategy
* GOV-007 — Azure Policy Strategy
* GOV-009 — Landing Zone Design
* ADR-001 — Enterprise Landing Zone Architecture
* ADR-004 — Enterprise Management Group Hierarchy
* TF-005 — Landing Zones
