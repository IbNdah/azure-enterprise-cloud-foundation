# GOV-004 – Resource Organization Strategy

| **Document ID** | GOV-004 |
|-----------------|---------|
| **Version** | 1.0 |
| **Status** | Approved |
| **Owner** | Cloud Platform Team |
| **Audience** | Cloud Architects, Platform Engineers |

---

# 1. Purpose

This document defines how Azure resources are organized within the Azure Enterprise Cloud Foundation.

The objective is to provide a consistent and scalable resource organization that simplifies deployment, operations and governance.

---

# 2. Design Principles

The resource organization follows these principles:

- Organize resources by workload and lifecycle.
- Keep Resource Groups focused on a single purpose.
- Separate platform resources from application resources.
- Maintain a consistent structure across all subscriptions.

---

# 3. Resource Hierarchy

```text
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

| Resource Group | Purpose |
|----------------|---------|
| **Platform Resource Groups** | Shared platform services such as networking, monitoring and management. |
| **Application Resource Groups** | Business applications and supporting services. |
| **Environment Resource Groups** | Separate production, non-production and sandbox workloads. |

---

# 5. Organization Benefits

- Clear ownership
- Simplified operations
- Easier access management
- Improved governance
- Better scalability

---

# 6. Design Decision

## Decision

Organize Azure resources using dedicated Resource Groups based on workload and lifecycle.

## Rationale

A workload-oriented structure improves maintainability, simplifies operations and aligns with Azure Well-Architected Framework recommendations.

---

# 7. Related Documents

| Document | Description |
|----------|-------------|
| GOV-002 | Management Groups Strategy |
| GOV-003 | Subscription Strategy |
| GOV-005 | Tagging Strategy |
| GOV-006 | RBAC Strategy |

---

# Key Takeaways

- Resource Groups are organized by workload.
- Platform and application resources are separated.
- Each Resource Group has a single responsibility.
- A consistent structure improves governance and operations.
