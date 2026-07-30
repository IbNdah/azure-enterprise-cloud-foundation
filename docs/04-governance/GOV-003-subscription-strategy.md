# GOV-003 – Subscription Strategy

| **Document ID**  | GOV-003                              |
| ---------------- | ------------------------------------ |
| **Version**      | 1.1                                  |
| **Status**       | Approved                             |
| **Owner**        | Cloud Platform Team                  |
| **Audience**     | Cloud Architects, Platform Engineers |
| **Organization** | Mandara Global                       |
| **Program**      | OneCloud 2030                        |

---

# 1. Purpose

As part of the **OneCloud 2030** transformation program, **Mandara Global** is adopting a subscription model that establishes clear operational boundaries between shared platform services and business workloads.

This document defines the Azure subscription strategy for the Azure Enterprise Cloud Foundation. The objective is to organize Azure workloads using dedicated subscriptions to improve governance, security, cost management, and operational isolation while providing a scalable foundation for future business growth.

---

# 2. Design Principles

The subscription strategy follows these principles:

* Separate platform services from application workloads.
* Isolate production from non-production environments.
* Enable independent governance and cost management.
* Support future business growth without restructuring.

---

# 3. Subscription Organization

```text
Platform
│
├── Identity Subscription
├── Connectivity Subscription
└── Management Subscription

Landing Zones
│
├── Production Subscription
├── Non-Production Subscription
└── Sandbox Subscription
```

---

# 4. Subscription Overview

| Subscription       | Purpose                                                                  |
| ------------------ | ------------------------------------------------------------------------ |
| **Identity**       | Microsoft Entra ID and identity-related services.                        |
| **Connectivity**   | Shared networking resources and connectivity services.                   |
| **Management**     | Monitoring, logging, backup, governance, and platform operations.        |
| **Production**     | Production business workloads.                                           |
| **Non-Production** | Development, testing, and quality assurance workloads.                   |
| **Sandbox**        | Innovation, experimentation, learning, and proof-of-concept deployments. |

---

# 5. Design Benefits

* Clear workload isolation
* Independent cost management
* Simplified access control
* Reduced operational risk
* Scalable subscription model
* Improved governance and compliance

---

# 6. Design Decision

## Decision

Mandara Global has decided to implement dedicated Azure subscriptions for shared platform services and application environments as part of the **OneCloud 2030** cloud operating model.

## Rationale

Separating platform capabilities from business workloads improves governance, strengthens security boundaries, simplifies operational management, and enables independent lifecycle management of production and non-production environments. The subscription model is designed to scale as Mandara Global expands into new business units, regions, and cloud services.

---

# 7. Related Documents

| Document | Description                |
| -------- | -------------------------- |
| GOV-001  | Cloud Governance Strategy  |
| GOV-002  | Management Groups Strategy |
| GOV-005  | Naming Convention          |
| GOV-006  | RBAC Strategy              |
| GOV-007  | Azure Policy Strategy      |
| GOV-009  | Landing Zone Design        |

---

# Key Takeaways

* Dedicated subscriptions provide clear operational and governance boundaries.
* Platform services are isolated from application workloads.
* Production, non-production, and sandbox environments follow independent lifecycle management.
* The subscription strategy supports Mandara Global's long-term cloud adoption objectives under the **OneCloud 2030** transformation program.
