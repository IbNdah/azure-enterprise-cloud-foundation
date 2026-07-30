# GOV-004 – Resource Organization Strategy

| **Document ID**  | GOV-004                              |
| ---------------- | ------------------------------------ |
| **Version**      | 1.1                                  |
| **Status**       | Approved                             |
| **Owner**        | Cloud Platform Team                  |
| **Audience**     | Cloud Architects, Platform Engineers |
| **Organization** | Mandara Global                       |
| **Program**      | OneCloud 2030                        |

---

# 1. Purpose

As part of the **OneCloud 2030** transformation program, **Mandara Global** is implementing a standardized resource organization model to ensure that Azure resources are deployed consistently across all subscriptions, business units, and environments.

This document defines how Azure resources are organized within the Azure Enterprise Cloud Foundation. The objective is to establish a scalable and maintainable resource hierarchy that simplifies governance, operations, automation, and lifecycle management while supporting enterprise-wide cloud adoption.

---

# 2. Design Principles

The resource organization follows these principles:

* Organize resources by workload and lifecycle.
* Keep Resource Groups focused on a single purpose.
* Separate platform resources from application resources.
* Maintain a consistent structure across all subscriptions.

---

# 3. Resource Hierarchy

```text id="l6omqi"
Management Group
        │
        ▼
Subscription
        │
        ▼
Resource Group
        │
        ▼
Azure Resources
```

---

# 4. Resource Group Strategy

| Resource Group                  | Purpose                                                                                |
| ------------------------------- | -------------------------------------------------------------------------------------- |
| **Platform Resource Groups**    | Shared platform services such as networking, monitoring, identity, and management.     |
| **Application Resource Groups** | Business applications and their supporting services.                                   |
| **Environment Resource Groups** | Separate production, non-production, and sandbox workloads throughout their lifecycle. |

---

# 5. Organization Benefits

* Clear ownership
* Simplified operations
* Easier access management
* Improved governance
* Better scalability
* Consistent workload lifecycle management

---

# 6. Design Decision

## Decision

Mandara Global has decided to organize Azure resources using dedicated Resource Groups based on workload ownership and lifecycle as part of the Azure Enterprise Cloud Foundation.

## Rationale

A workload-oriented Resource Group strategy provides clear ownership, simplifies day-to-day operations, improves governance, and aligns with Microsoft Azure Well-Architected Framework recommendations. It also supports the long-term objectives of the **OneCloud 2030** program by enabling standardized deployments and predictable operational management across the enterprise.

---

# 7. Related Documents

| Document | Description                |
| -------- | -------------------------- |
| GOV-002  | Management Groups Strategy |
| GOV-003  | Subscription Strategy      |
| GOV-005  | Naming Convention          |
| GOV-006  | RBAC Strategy              |

---

# Key Takeaways

* Azure resources are organized consistently across all subscriptions.
* Platform and application resources are separated to improve governance and operational efficiency.
* Each Resource Group has a single responsibility and a clearly defined lifecycle.
* The resource organization strategy supports Mandara Global's standardized cloud operating model established through the **OneCloud 2030** transformation program.
