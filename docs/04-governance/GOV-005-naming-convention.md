# GOV-005 – Naming Convention

| **Document ID** | GOV-005 |
|---|---|
| **Version** | 1.1 |
| **Status** | Approved |
| **Owner** | Cloud Platform Team |
| **Audience** | Cloud Architects, Platform Engineers |
| **Classification** | Internal Use Only |

---

# 1. Purpose

This document defines the enterprise naming convention for Azure resources.

The objective is to make resources identifiable, searchable and manageable while keeping names predictable and practical.

---

# 2. Naming Principles

| Principle | Description |
|---|---|
| Consistent | Use common patterns across the platform. |
| Readable | Names should be understandable to operators. |
| Unique where required | Respect Azure uniqueness requirements. |
| Stable | Avoid embedding values that are likely to change. |
| Automation-friendly | Naming must work reliably with Terraform and automation. |

---

# 3. Naming Components

Where supported by the Azure resource type, names may use:

```text
<organization>-<workload>-<environment>-<region>-<instance>
```

Not every component is required for every resource. Azure naming limits and uniqueness requirements take precedence.

---

# 4. Standard Abbreviations

| Resource | Prefix |
|---|---|
| Resource Group | `rg` |
| Virtual Network | `vnet` |
| Network Security Group | `nsg` |
| Route Table | `rt` |
| Key Vault | `kv` |
| Storage Account | `st` |
| Log Analytics Workspace | `law` |
| Recovery Services Vault | `rsv` |
| Application Gateway | `agw` |
| Azure Firewall | `afw` |
| Public IP | `pip` |

These prefixes provide a consistent short form for commonly used Azure resources.

---

# 5. Environment Codes

| Environment | Code |
|---|---|
| Production | `prod` |
| Non-Production | `nonprod` |
| Sandbox | `sbx` |

Environment codes shall be used consistently across resource names where the resource naming rules permit them.

---

# 6. Naming Examples

| Resource | Example |
|---|---|
| Resource Group | `rg-platform-prod` |
| Virtual Network | `vnet-platform-prod` |
| Key Vault | `kv-platform-prod` |
| Log Analytics Workspace | `law-platform-prod` |
| Azure Firewall | `afw-platform-prod` |

The examples illustrate the standard naming logic. Actual names must also comply with the Azure-specific constraints of the resource type.

---

# 7. Resource-Specific Rules

Naming shall follow Azure resource-specific constraints for:

- length;
- allowed characters;
- case sensitivity;
- global uniqueness;
- immutable naming requirements.

Where Azure imposes a service-specific pattern, that constraint takes precedence over the generic enterprise pattern.

---

# 8. Enforcement

Naming standards are enforced through:

- Terraform modules and variables;
- code review;
- Azure Policy where technically appropriate.

Azure Policy is not expected to validate every naming convention when the service does not expose a practical policy condition.

---

# 9. Design Decision

## Decision

Adopt a consistent enterprise naming convention with resource-specific patterns where required by Azure.

## Rationale

A practical naming standard improves resource identification and automation without creating brittle rules.

---

# 10. Related Documents & Key Takeaways

| Document | Relationship |
|---|---|
| GOV-004 | Resource organization |
| GOV-006 | RBAC |
| GOV-007 | Azure Policy |
| GOV-008 | Tagging |
| GOV-009 | Landing Zones |

**Key takeaway:** use a common naming logic, but do not force one literal pattern onto every Azure resource type.
