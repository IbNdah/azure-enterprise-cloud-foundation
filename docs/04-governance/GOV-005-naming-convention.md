# GOV-005 – Naming Convention

| **Document ID**  | GOV-005                              |
| ---------------- | ------------------------------------ |
| **Version**      | 1.1                                  |
| **Status**       | Approved                             |
| **Owner**        | Cloud Platform Team                  |
| **Audience**     | Cloud Architects, Platform Engineers |
| **Organization** | Mandara Global                       |
| **Program**      | OneCloud 2030                        |

---

# 1. Purpose

As part of the **OneCloud 2030** transformation program, **Mandara Global** is adopting a standardized naming convention to ensure that Azure resources are consistently identified across all subscriptions, environments, and business units.

This document defines the naming convention used within the Azure Enterprise Cloud Foundation. The objective is to improve resource discoverability, simplify operations, support automation, and establish a common language for platform administration throughout the resource lifecycle.

---

# 2. Naming Principles

The naming convention follows these principles:

* Use meaningful and consistent names.
* Follow Azure naming restrictions.
* Keep resource names short and readable.
* Include environment information where applicable.
* Use standard abbreviations.

---

# 3. Naming Pattern

The standard naming format is:

```text id="0rjlwm"
<resource>-<workload>-<environment>
```

Examples:

```text id="8g7w78"
vnet-platform-prod
kv-platform-prod
law-platform-prod
stapp-prod
```

---

# 4. Standard Abbreviations

| Resource                | Prefix |
| ----------------------- | ------ |
| Resource Group          | rg     |
| Virtual Network         | vnet   |
| Network Security Group  | nsg    |
| Route Table             | rt     |
| Key Vault               | kv     |
| Storage Account         | st     |
| Log Analytics Workspace | law    |
| Recovery Services Vault | rsv    |
| Application Gateway     | agw    |
| Azure Firewall          | afw    |
| Public IP               | pip    |

---

# 5. Environment Codes

| Environment    | Code    |
| -------------- | ------- |
| Production     | prod    |
| Non-Production | nonprod |
| Sandbox        | sbx     |

---

# 6. Examples

| Resource                | Example            |
| ----------------------- | ------------------ |
| Resource Group          | rg-platform-prod   |
| Virtual Network         | vnet-platform-prod |
| Key Vault               | kv-platform-prod   |
| Log Analytics Workspace | law-platform-prod  |
| Azure Firewall          | afw-platform-prod  |

---

# 7. Design Decision

## Decision

Mandara Global has decided to adopt a standardized naming convention for all Azure resources deployed within the Azure Enterprise Cloud Foundation.

## Rationale

A consistent naming convention improves readability, simplifies administration, enables automation, and reduces operational errors. It establishes a common resource identification standard across the organization and supports the governance objectives of the **OneCloud 2030** transformation program while remaining compliant with Azure naming requirements.

---

# 8. Related Documents

| Document | Description                    |
| -------- | ------------------------------ |
| GOV-003  | Subscription Strategy          |
| GOV-004  | Resource Organization Strategy |
| GOV-006  | RBAC Strategy                  |
| GOV-008  | Tagging Strategy               |

---

# Key Takeaways

* Azure resources follow a standardized enterprise naming convention.
* Consistent naming improves governance, automation, and operational efficiency.
* Standard abbreviations and environment codes provide predictable resource identification.
* The naming convention supports Mandara Global's enterprise cloud operating model under the **OneCloud 2030** transformation program.
