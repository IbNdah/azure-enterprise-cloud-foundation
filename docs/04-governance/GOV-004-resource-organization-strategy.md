# GOV-004 – Resource Organization Strategy

| **Document ID** | GOV-004 |
|---|---|
| **Version** | 1.1 |
| **Status** | Approved |
| **Owner** | Cloud Platform Team |
| **Audience** | Cloud Architects, Platform Engineers |
| **Classification** | Internal Use Only |

---

# 1. Purpose

This document defines how Azure resources are organized inside subscriptions.

The objective is to provide clear ownership, predictable lifecycle management and a consistent structure without imposing unnecessary Resource Group complexity.

---

# 2. Design Principles

| Principle | Description |
|---|---|
| Workload-oriented | Resources are grouped around a workload or platform function. |
| Lifecycle-aware | Resources with different lifecycles should not be unnecessarily coupled. |
| Single purpose | A Resource Group should have a clear operational purpose. |
| Consistent | Similar workloads should follow a consistent structure. |
| Simple | Resource Groups should not be created solely to reproduce an organizational hierarchy. |

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

Management Groups govern subscriptions. Resource Groups organize resources inside a subscription.

---

# 4. Resource Group Strategy

| Resource Group Type | Purpose |
|---|---|
| Platform | Shared platform services with a common lifecycle. |
| Application | Resources belonging to a specific application or workload. |
| Supporting Service | Supporting resources that have a distinct lifecycle or operational boundary. |

Production, Non-Production and Sandbox are primarily handled through Landing Zone and subscription boundaries; they do not require a separate Resource Group pattern by default.

---

# 5. Naming & Ownership

Resource Groups shall:

- follow the enterprise naming convention;
- have a clear owner;
- contain resources with compatible lifecycles;
- use the required enterprise tags;
- avoid mixing unrelated workloads.

---

# 6. Operational Considerations

Resource Group structure should support:

- RBAC scope;
- deployment lifecycle;
- monitoring;
- cost allocation;
- resource deletion and recovery.

Resource Groups should not be used as a substitute for Management Groups or subscriptions.

---

# 7. Design Decision

## Decision

Use workload- and lifecycle-oriented Resource Groups with a deliberately simple structure.

## Rationale

This provides sufficient operational separation while avoiding unnecessary hierarchy and administrative overhead.

---

# 8. Related Documents & Key Takeaways

| Document | Relationship |
|---|---|
| GOV-002 | Management Groups |
| GOV-003 | Subscription Strategy |
| GOV-005 | Naming Convention |
| GOV-006 | RBAC |
| GOV-008 | Tagging |
| GOV-009 | Landing Zones |

**Key takeaway:** Management Groups govern subscriptions; subscriptions provide major boundaries; Resource Groups organize resources within those subscriptions.
