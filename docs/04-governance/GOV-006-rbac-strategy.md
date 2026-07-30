# GOV-006 – RBAC Strategy

| **Document ID**  | GOV-006                                                  |
| ---------------- | -------------------------------------------------------- |
| **Version**      | 1.1                                                      |
| **Status**       | Approved                                                 |
| **Owner**        | Cloud Platform Team                                      |
| **Audience**     | Cloud Architects, Security Engineers, Platform Engineers |
| **Organization** | Mandara Global                                           |
| **Program**      | OneCloud 2030                                            |

---

# 1. Purpose

As part of the **OneCloud 2030** transformation program, **Mandara Global** is implementing a standardized Role-Based Access Control (RBAC) model to secure access to Azure resources while enabling efficient collaboration across platform and application teams.

This document defines the RBAC strategy for the Azure Enterprise Cloud Foundation. The objective is to establish consistent authorization practices based on the Principle of Least Privilege, ensuring that users receive only the permissions required to perform their responsibilities.

---

# 2. Design Principles

The RBAC strategy follows these principles:

* Apply the Principle of Least Privilege.
* Assign permissions using Azure Entra ID groups whenever possible.
* Grant permissions at the highest appropriate scope.
* Avoid assigning permissions directly to individual users.
* Separate operational responsibilities through role delegation.

---

# 3. RBAC Hierarchy

```text id="b1h72d"
Management Group
        │
        ▼
Subscription
        │
        ▼
Resource Group
        │
        ▼
Resource
```

Permissions are inherited through the Azure resource hierarchy unless explicitly overridden.

---

# 4. Standard Roles

| Role                          | Responsibility                                               |
| ----------------------------- | ------------------------------------------------------------ |
| **Owner**                     | Full administrative control, including access management.    |
| **Contributor**               | Manage Azure resources without modifying access permissions. |
| **Reader**                    | Read-only access to Azure resources.                         |
| **User Access Administrator** | Manage RBAC assignments without modifying resources.         |

---

# 5. RBAC Assignment Strategy

| Scope            | Typical Assignment               |
| ---------------- | -------------------------------- |
| Management Group | Platform Administrators          |
| Subscription     | Platform Operations Team         |
| Resource Group   | Application or Service Owners    |
| Resource         | Exception-based assignments only |

---

# 6. Design Benefits

* Improved security
* Simplified administration
* Centralized identity management
* Reduced operational risk
* Scalable authorization model
* Consistent access governance

---

# 7. Design Decision

## Decision

Mandara Global has decided to implement Azure Role-Based Access Control (RBAC) using Microsoft Entra ID groups and the Principle of Least Privilege across the Azure Enterprise Cloud Foundation.

## Rationale

A centralized RBAC model strengthens security, simplifies access administration, and ensures consistent authorization across all Azure environments. Group-based role assignments reduce administrative overhead, improve auditability, and support Mandara Global's enterprise governance objectives under the **OneCloud 2030** transformation program.

---

# 8. Related Documents

| Document | Description                |
| -------- | -------------------------- |
| GOV-001  | Cloud Governance Strategy  |
| GOV-002  | Management Groups Strategy |
| GOV-005  | Naming Convention          |
| GOV-007  | Azure Policy Strategy      |
| GOV-008  | Tagging Strategy           |

---

# Key Takeaways

* Access to Azure resources is governed through Azure RBAC.
* Permissions are assigned to Microsoft Entra ID groups rather than individual users whenever possible.
* The Principle of Least Privilege is applied consistently across all scopes.
* The RBAC strategy supports Mandara Global's secure and scalable cloud operating model as part of the **OneCloud 2030** transformation program.
