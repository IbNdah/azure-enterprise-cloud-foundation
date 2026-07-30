# GOV-002 – Management Groups Strategy

| **Document ID**  | GOV-002                              |
| ---------------- | ------------------------------------ |
| **Version**      | 1.1                                  |
| **Status**       | Approved                             |
| **Owner**        | Cloud Platform Team                  |
| **Audience**     | Cloud Architects, Platform Engineers |
| **Organization** | Mandara Global                       |
| **Program**      | OneCloud 2030                        |

---

# 1. Purpose

As part of the **OneCloud 2030** transformation program, **Mandara Global** is establishing a standardized Azure governance hierarchy to support consistent cloud operations across multiple business units, environments, and future workloads.

This document defines the Management Group strategy used within the Azure Enterprise Cloud Foundation. The objective is to organize Azure subscriptions consistently while enabling centralized governance, policy inheritance, and scalable access management across the enterprise.

---

# 2. Design Principles

The Management Group hierarchy follows these principles:

* Keep the hierarchy simple and easy to understand.
* Separate platform resources from application workloads.
* Apply governance at the highest appropriate level.
* Allow future expansion without restructuring.

---

# 3. Management Group Hierarchy

```text
Tenant Root
│
├── Platform
│     └── Platform Subscriptions
│
└── Landing Zones
      ├── Production
      ├── Non-Production
      └── Sandbox
```

---

# 4. Management Groups

| Management Group   | Purpose                                                                                      |
| ------------------ | -------------------------------------------------------------------------------------------- |
| **Platform**       | Contains shared platform subscriptions such as Identity, Connectivity and Management.        |
| **Landing Zones**  | Contains application workload subscriptions.                                                 |
| **Production**     | Hosts production workload subscriptions.                                                     |
| **Non-Production** | Hosts development and testing subscriptions.                                                 |
| **Sandbox**        | Hosts experimental, innovation, and learning subscriptions with limited governance controls. |

---

# 5. Governance Model

Governance is inherited from the top of the hierarchy.

```text
Tenant Root
      │
      ▼
Management Groups
      │
      ▼
Subscriptions
      │
      ▼
Resource Groups
      │
      ▼
Resources
```

Policies and RBAC assignments should be applied at the highest appropriate level to minimize administrative effort while ensuring consistent governance across all Azure environments.

---

# 6. Benefits

* Centralized governance
* Consistent policy inheritance
* Simplified access management
* Scalable subscription organization
* Clear separation between platform services and business workloads

---

# 7. Design Decision

## Decision

Mandara Global has decided to implement a lightweight Management Group hierarchy based on **Platform** and **Landing Zones** as the governance backbone of the **OneCloud 2030** cloud platform.

## Rationale

This hierarchy provides a clear, scalable, and easily maintainable governance structure that aligns with Microsoft Azure Landing Zone principles while supporting Mandara Global's long-term cloud growth. It enables centralized policy enforcement, delegated administration, and seamless onboarding of future business units and subscriptions without requiring structural redesign.

---

# 8. Related Documents

| Document | Description               |
| -------- | ------------------------- |
| GOV-001  | Cloud Governance Strategy |
| GOV-003  | Subscription Strategy     |
| GOV-006  | RBAC Strategy             |
| GOV-007  | Azure Policy Strategy     |
| GOV-009  | Landing Zone Design       |

---

# Key Takeaways

* Management Groups provide the governance backbone of Mandara Global's Azure platform.
* Platform services are isolated from application workloads.
* Policies and RBAC assignments are inherited through the Management Group hierarchy.
* The hierarchy is intentionally simple, scalable, and designed to support the long-term objectives of the **OneCloud 2030** transformation program.
