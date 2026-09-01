# GOV-002 — Management Group Strategy

| Attribute | Value |
|---|---|
| **Document ID** | GOV-002 |
| **Title** | Management Group Strategy |
| **Version** | 1.1 |
| **Status** | Approved |
| **Date** | 2026-08-31 |
| **Program** | OneCloud 2030 |
| **Organization** | Mandara Global |

---

# 1. Purpose

This document defines how Azure Management Groups are used to organize subscriptions and apply enterprise governance.

Management Groups provide governance scope above subscriptions and support policy and access inheritance.

They are a governance construct and are distinct from platform capabilities and Landing Zones.

---

# 2. Strategy

Mandara Global will use a simple Management Group structure that supports:

- enterprise governance;
- shared platform subscriptions;
- Landing Zone governance;
- environment separation where required;
- scalable subscription onboarding.

The hierarchy should remain stable and should not model every team, application or temporary organizational structure.

---

# 3. Conceptual Model

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

Management Groups provide governance scope. They do not represent platform capabilities by definition.

---

# 4. High-Level Organization

The enterprise model is represented conceptually as:

```text
                         Tenant Root
                              │
                       Mandara Global
                              │
              ┌───────────────┼───────────────┐
              │               │               │
              ▼               ▼               ▼
          Governance       Platform      Decommissioned
                              │
                    Platform Capabilities
                              │
                              ▼
                       Landing Zones
                    ┌─────────┼─────────┐
                    │         │         │
                   Corp     Online    Sandbox
```

This is a high-level architectural representation from ARC-002. It should not be interpreted as a requirement to create a Management Group for every capability or every box shown.

The actual Management Group hierarchy must reflect **governance boundaries**, not merely organizational labels.

---

# 5. Platform Capabilities vs Management Groups

| Concept | Meaning |
|---|---|
| **Platform Capability** | Shared service responsibility such as Management, Connectivity, Security, Operations or Identity |
| **Management Group** | Azure governance scope used to organize subscriptions and apply inherited controls |
| **Landing Zone** | Governed workload environment |
| **Subscription** | Administrative, security, cost and operational boundary |

A platform capability can therefore span resources or subscriptions without requiring a corresponding Management Group.

---

# 6. Governance Application

Management Groups are used for controls that should apply to multiple subscriptions.

Typical controls include:

| Control | Typical Scope |
|---|---|
| Azure Policy | Management Group where common inheritance is required |
| RBAC | Management Group only where a broad administrative scope is justified |
| Compliance controls | Appropriate parent governance scope |
| Subscription placement | Management Group aligned with governance requirements |

Governance should be assigned at the highest practical scope for common controls while avoiding unnecessary inheritance.

---

# 7. Design Rules

1. Keep the hierarchy as simple as practical.
2. Create a Management Group only when a distinct governance boundary is required.
3. Do not create Management Groups solely to represent teams or platform capabilities.
4. Keep Production and Non-Production governance distinguishable where requirements differ.
5. Use subscriptions as the primary administrative and cost boundary.
6. Avoid deep nesting without a clear governance reason.
7. Treat changes to the hierarchy as governance changes because inherited controls may be affected.

---

# 8. Consequences

### Benefits

- Centralized governance
- Policy inheritance
- Clear subscription organization
- Scalable onboarding
- Consistent governance boundaries

### Trade-offs

- Hierarchy changes can affect inherited Policy and RBAC
- Poorly designed nesting increases complexity
- Governance ownership must be clearly defined

The strategy therefore favors **the minimum hierarchy required to meet governance needs**.

---

# 9. Relationship to Other Documents

| Document | Relationship |
|---|---|
| **ARC-002** | High-level architectural organization |
| **ARC-003** | Enterprise reference architecture |
| **GOV-001** | Overall governance strategy |
| **GOV-003** | Subscription strategy |
| **GOV-009** | Landing Zone design |
| **ADR-001** | Enterprise Landing Zone architecture |
| **ADR-004** | Management Group hierarchy |

---

# 10. Review

Review this strategy when there are significant changes to the operating model, subscription strategy, governance requirements, security/compliance requirements or Landing Zone model.
