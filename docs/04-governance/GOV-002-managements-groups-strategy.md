# GOV-002 – Management Groups Strategy

| **Document ID** | GOV-002 |
|-----------------|---------|
| **Version** | 1.0 |
| **Status** | Approved |
| **Owner** | Cloud Platform Team |
| **Audience** | Cloud Architects, Platform Engineers |

---

# 1. Purpose

This document defines the Management Group hierarchy used within the Azure Enterprise Cloud Foundation.

The objective is to organize Azure subscriptions consistently while providing centralized governance, policy inheritance and access management.

---

# 2. Design Principles

The Management Group hierarchy follows these principles:

- Keep the hierarchy simple and easy to understand.
- Separate platform resources from application workloads.
- Apply governance at the highest appropriate level.
- Allow future expansion without restructuring.

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

| Management Group | Purpose |
|------------------|---------|
| **Platform** | Contains shared platform subscriptions such as Identity, Connectivity and Management. |
| **Landing Zones** | Contains application workload subscriptions. |
| **Production** | Hosts production workload subscriptions. |
| **Non-Production** | Hosts development and testing subscriptions. |
| **Sandbox** | Hosts experimental and learning subscriptions with limited governance. |

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

Policies and RBAC assignments should be applied at the highest level possible to minimize administrative effort.

---

# 6. Benefits

- Centralized governance
- Consistent policy inheritance
- Simplified access management
- Scalable subscription organization
- Clear separation between platform and workloads

---

# 7. Design Decision

## Decision

Use a lightweight Management Group hierarchy based on Platform and Landing Zones.

## Rationale

The selected hierarchy provides a clean and scalable foundation while avoiding unnecessary complexity. It aligns with Azure Landing Zone principles and can easily grow as additional subscriptions or business units are introduced.

---

# 8. Related Documents

| Document | Description |
|----------|-------------|
| GOV-001 | Cloud Governance Strategy |
| GOV-003 | Subscription Strategy |
| GOV-006 | RBAC Strategy |
| GOV-007 | Azure Policy |
| GOV-009 | Landing Zone Design |

---

# Key Takeaways

- A simple hierarchy is easier to govern and maintain.
- Platform services are separated from application workloads.
- Policies and permissions are inherited through Management Groups.
- The design supports future growth without requiring structural changes.
