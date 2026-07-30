# GOV-003 – Subscription Strategy

| **Document ID** | GOV-003 |
|-----------------|---------|
| **Version** | 1.0 |
| **Status** | Approved |
| **Owner** | Cloud Platform Team |
| **Audience** | Cloud Architects, Platform Engineers |

---

# 1. Purpose

This document defines the Azure subscription strategy for the Azure Enterprise Cloud Foundation.

The objective is to organize workloads using dedicated subscriptions to improve governance, security, cost management and operational isolation.

---

# 2. Design Principles

The subscription strategy follows these principles:

- Separate platform services from application workloads.
- Isolate production from non-production environments.
- Enable independent governance and cost management.
- Support future business growth without restructuring.

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

| Subscription | Purpose |
|--------------|---------|
| **Identity** | Microsoft Entra ID and identity-related services. |
| **Connectivity** | Shared networking resources and connectivity services. |
| **Management** | Monitoring, logging, backup and platform operations. |
| **Production** | Production business workloads. |
| **Non-Production** | Development and testing workloads. |
| **Sandbox** | Learning, experimentation and proof-of-concept deployments. |

---

# 5. Design Benefits

- Clear workload isolation
- Independent cost management
- Simplified access control
- Reduced operational risk
- Scalable subscription model

---

# 6. Design Decision

## Decision

Adopt dedicated subscriptions for platform services and application environments.

## Rationale

This approach improves governance, security and operational management while remaining simple and scalable. New subscriptions can be added as business requirements evolve without impacting the existing platform.

---

# 7. Related Documents

| Document | Description |
|----------|-------------|
| GOV-001 | Cloud Governance Strategy |
| GOV-002 | Management Groups Strategy |
| GOV-005 | Tagging Strategy |
| GOV-006 | RBAC Strategy |
| GOV-007 | Azure Policy |
| GOV-009 | Landing Zone Design |

---

# Key Takeaways

- Platform services are isolated from application workloads.
- Production and non-production environments are separated.
- Each subscription has a clear operational responsibility.
- The subscription model supports secure and scalable cloud adoption.
