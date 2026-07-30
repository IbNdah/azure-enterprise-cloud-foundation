# GOV-005 – Naming Convention

| **Document ID** | GOV-005 |
|-----------------|---------|
| **Version** | 1.0 |
| **Status** | Approved |
| **Owner** | Cloud Platform Team |
| **Audience** | Cloud Architects, Platform Engineers |

---

# 1. Purpose

This document defines the naming convention used within the Azure Enterprise Cloud Foundation.

The objective is to ensure that Azure resources are named consistently, making them easy to identify, manage and operate throughout their lifecycle.

---

# 2. Naming Principles

The naming convention follows these principles:

- Use meaningful and consistent names.
- Follow Azure naming restrictions.
- Keep resource names short and readable.
- Include environment information where applicable.
- Use standard abbreviations.

---

# 3. Naming Pattern

The standard naming format is:

```text
<resource>-<workload>-<environment>
```

Example:

```text
vnet-platform-prod
kv-platform-prod
law-platform-prod
stapp-prod
```

---

# 4. Standard Abbreviations

| Resource | Prefix |
|----------|--------|
| Resource Group | rg |
| Virtual Network | vnet |
| Network Security Group | nsg |
| Route Table | rt |
| Key Vault | kv |
| Storage Account | st |
| Log Analytics Workspace | law |
| Recovery Services Vault | rsv |
| Application Gateway | agw |
| Azure Firewall | afw |
| Public IP | pip |

---

# 5. Environment Codes

| Environment | Code |
|-------------|------|
| Production | prod |
| Non-Production | nonprod |
| Sandbox | sbx |

---

# 6. Examples

| Resource | Example |
|----------|---------|
| Resource Group | rg-platform-prod |
| Virtual Network | vnet-platform-prod |
| Key Vault | kv-platform-prod |
| Log Analytics Workspace | law-platform-prod |
| Azure Firewall | afw-platform-prod |

---

# 7. Design Decision

## Decision

Use a simple and consistent naming convention across all Azure resources.

## Rationale

A standardized naming convention improves readability, simplifies administration and supports automation while remaining easy to maintain.

---

# 8. Related Documents

| Document | Description |
|----------|-------------|
| GOV-003 | Subscription Strategy |
| GOV-004 | Resource Organization Strategy |
| GOV-006 | Tagging Strategy |

---

# Key Takeaways

- Resource names follow a consistent structure.
- Standard prefixes improve readability.
- Environment codes identify deployment stages.
- Consistent naming simplifies governance and operations.
