# ADR-006 — Enterprise Identity Strategy

| Attribute | Value |
|---|---|
| **ADR ID** | ADR-006 |
| **Title** | Enterprise Identity Strategy |
| **Version** | 1.1 |
| **Status** | Accepted |
| **Date** | 2026-09-01 |
| **Authors** | Cloud Architecture Team |
| **Program** | OneCloud 2030 |
| **Organization** | Mandara Global |
| **Category** | Identity & Access Management |

---

# 1. Executive Summary

Mandara Global will use **Microsoft Entra ID as the enterprise identity platform** for the Azure Enterprise Cloud Foundation.

Identity and access will be based on centralized identities, group-based access, Azure RBAC, managed identities and least-privilege principles.

Identity is a shared **Platform Capability** and is not itself a Management Group.

---

# 2. Business Context

The OneCloud 2030 foundation must provide consistent and controlled access to platform services and business workloads.

The identity model must support:

- centralized identity management;
- secure authentication;
- controlled authorization;
- workload-to-service authentication;
- least privilege;
- separation of administrative responsibilities;
- scalable access management.

---

# 3. Problem Statement

Independent identities and direct permissions across subscriptions would make access management difficult to control and review.

The platform therefore requires a common identity model that separates authentication from authorization and minimizes direct user permissions.

---

# 4. Decision

| Area | Decision |
|---|---|
| Enterprise Identity | **Microsoft Entra ID** |
| Human Access | Entra ID users and groups |
| Authorization | Azure RBAC |
| Workload Authentication | Managed Identities where supported |
| Privileged Access | PIM where required |
| Access Model | Least privilege |
| Group Management | Group-based access preferred |
| Administrative Separation | Role and scope based |

Microsoft Entra ID provides the common identity layer across platform capabilities and Landing Zones.

---

# 5. High-Level Identity Model

```text
                         Microsoft Entra ID
                                │
              ┌─────────────────┴─────────────────┐
              │                                   │
              ▼                                   ▼
       Human Identities                    Workload Identities
              │                                   │
        Groups / Roles                       Managed Identity
              │                                   │
              ▼                                   ▼
         Azure RBAC                         Azure Resources
              │
       ┌──────┼────────┐
       ▼      ▼        ▼
 Management Subscription Resource Group
 Groups
       │
       ▼
 Azure Resources
```

The model distinguishes **who or what is requesting access** from **what that identity is allowed to do**.

---

# 6. Human Identity and Access

Human access should use Microsoft Entra ID identities and groups.

Group-based access is preferred over direct user-to-resource assignments.

```text
User
 │
 ▼
Entra ID Group
 │
 ▼
Azure RBAC Role
 │
 ▼
Defined Azure Scope
```

The scope should be the smallest practical scope that supports the responsibility.

Typical scopes include:

- Management Group;
- Subscription;
- Resource Group;
- Resource.

This aligns with GOV-006.

---

# 7. Workload Identities

Workloads should use **Managed Identities** where Azure services support them.

```text
Application / Service
        │
        ▼
Managed Identity
        │
        ▼
Azure Resource
```

Managed identities avoid storing application credentials where the platform can provide an identity-based alternative.

Workload permissions should remain narrowly scoped and follow the same least-privilege principle as human access.

---

# 8. Privileged Access

Privileged access should be controlled separately from normal user access.

Where appropriate, Microsoft Entra Privileged Identity Management (PIM) should be used for controlled elevation of privileged roles.

```text
Eligible Administrator
        │
        ▼
     Approval
        │
        ▼
 Temporary Privileged Access
        │
        ▼
 Azure Resource / Governance Scope
```

Permanent high-privilege assignments should be minimized.

---

# 9. Authorization Model

Authentication and authorization are separate concerns:

| Concern | Responsibility |
|---|---|
| **Authentication** | Establish the identity of the user or workload |
| **Authorization** | Determine what that identity can access or change |
| **Scope** | Determine where the permission applies |
| **Governance** | Define enterprise access rules |

Azure RBAC provides the primary authorization mechanism for Azure resources.

Built-in Azure roles should be preferred when they satisfy the requirement. Custom roles should be introduced only where built-in roles do not provide an appropriate permission model.

---

# 10. Decision Drivers

| Driver | Reason |
|---|---|
| Security | Centralized identity and controlled access |
| Least Privilege | Limit permissions to required actions and scopes |
| Consistency | Common identity model across the platform |
| Automation | Support workload identities without stored credentials |
| Scalability | Support multiple Business Units and Landing Zones |
| Governance | Enable controlled and reviewable access |
| Operations | Simplify identity and access management |

---

# 11. Architectural Principles

| Principle | Application |
|---|---|
| **Central Identity** | Use Microsoft Entra ID as the enterprise identity layer |
| **Least Privilege** | Grant only the permissions required |
| **Group-Based Access** | Prefer groups over direct user assignments |
| **Managed Identity First** | Prefer managed identities for supported Azure workloads |
| **Separation of Duties** | Separate platform, network, security and workload responsibilities |
| **Appropriate Scope** | Assign access at the smallest practical scope |
| **Privileged Access Control** | Use PIM where appropriate |
| **Shared Capability** | Provide identity centrally rather than duplicating it in Landing Zones |

---

# 12. Alternatives Considered

| Option | Decision | Rationale |
|---|---|---|
| **Independent identities per subscription** | Rejected | Fragmented administration |
| **Direct user permissions** | Rejected as default | Difficult to scale and review |
| **Application-managed credentials** | Rejected where Managed Identity is supported | Unnecessary credential management |
| **Microsoft Entra ID + Azure RBAC** | **Selected** | Centralized identity and native Azure authorization |
| **Custom RBAC roles by default** | Rejected | Adds unnecessary administration where built-in roles are sufficient |

---

# 13. Expected Benefits

| Area | Benefit |
|---|---|
| Security | Centralized and controlled access |
| Administration | Consistent identity management |
| Least Privilege | Clear role and scope assignment |
| Workloads | Reduced need for stored credentials |
| Governance | Reviewable access model |
| Scalability | Common model across Landing Zones |
| Operations | Simplified access lifecycle |

---

# 14. Consequences

### Positive

- Centralized enterprise identity
- Consistent authorization model
- Reduced credential management for supported workloads
- Clear separation of administrative responsibilities
- Better alignment with Zero Trust principles
- Reusable identity capability across Landing Zones

### Trade-offs

- Entra ID becomes a critical shared dependency
- Identity and RBAC require ongoing governance
- Poorly designed groups can create unnecessary complexity
- Privileged access controls require operational discipline

---

# 15. Scope and Boundaries

This decision applies to:

- Azure platform capabilities;
- Azure Landing Zones;
- human access to Azure resources;
- workload identities;
- Azure RBAC;
- privileged Azure access.

It does not define application-specific authorization logic or detailed Conditional Access policies.

---

# 16. Relationship to Other Architecture Decisions

| Document | Relationship |
|---|---|
| **ADR-001** | Enterprise Landing Zone architecture |
| **ADR-002** | Hub & Spoke network architecture |
| **ADR-003** | Terraform as the IaC standard |
| **ADR-004** | Management Group governance hierarchy |
| **ADR-005** | Private networking |
| **ADR-007** | Monitoring and observability |
| **ADR-008** | Security baseline |
| **GOV-002** | Management Group governance |
| **GOV-003** | Subscription strategy |
| **GOV-006** | RBAC strategy |
| **GOV-009** | Landing Zone design |
| **ARC-003** | Enterprise reference architecture |

---

# 17. Implementation Alignment

Identity is implemented as a dedicated **Identity platform capability** within the Terraform foundation.

```text
Platform
   │
   └── Identity Capability
           │
           ├── Microsoft Entra ID
           ├── RBAC integration
           └── Managed Identity integration
                         │
                         ▼
                  Landing Zones
                         │
                         ▼
                     Workloads
```

Azure resources and access assignments managed by this project should remain aligned with Terraform and GOV-006.

---

# 18. Review

Review this decision when significant changes occur to:

- Microsoft Entra ID;
- enterprise identity requirements;
- Azure RBAC;
- privileged access requirements;
- Landing Zone architecture;
- security or compliance requirements.

---

# 19. References

- Microsoft Entra ID
- Azure RBAC
- Microsoft Entra Privileged Identity Management
- Azure Managed Identities
- GOV-006 — RBAC Strategy
- ARC-003 — Enterprise Reference Architecture
- ADR-001 — Enterprise Landing Zone Architecture
