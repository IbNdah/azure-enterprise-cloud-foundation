# ADR-009 — Enterprise Naming Convention Standard

| Attribute | Value |
|---|---|
| **ADR ID** | ADR-009 |
| **Title** | Enterprise Naming Convention Standard |
| **Version** | 1.1 |
| **Status** | Accepted |
| **Date** | 2026-09-01 |
| **Authors** | Cloud Architecture Team |
| **Program** | OneCloud 2030 |
| **Organization** | Mandara Global |
| **Category** | Governance / Resource Management |

---

# 1. Executive Summary

Mandara Global will use a standardized naming convention for Azure resources managed by the enterprise cloud foundation.

Names should be:

- predictable;
- consistent;
- readable;
- identifiable by resource type and environment;
- aligned with the enterprise governance model.

The standard is defined in **GOV-005 — Naming Convention**. This ADR records the architectural decision to adopt and enforce that standard across the platform and Landing Zones.

---

# 2. Business Context

A common naming convention is required to make Azure resources easier to identify, operate and govern across multiple subscriptions and Landing Zones.

Without a common standard, resources can be named inconsistently, making ownership, environment identification and operational management more difficult.

---

# 3. Problem Statement

The enterprise platform needs a repeatable naming pattern that allows teams to identify the main characteristics of an Azure resource from its name without introducing unnecessary complexity.

The convention must work across:

- Platform Capabilities;
- Landing Zones;
- subscriptions;
- resource groups;
- Azure resources.

---

# 4. Decision

Mandara Global will use the naming convention defined in GOV-005.

The general naming model is:

```text
<resource-prefix>-<workload-or-purpose>-<environment>
```

Where applicable, additional elements may be included when they provide useful identification.

The convention must remain compatible with Azure naming restrictions for each resource type.

---

# 5. Standard Abbreviations

The following resource prefixes are part of the enterprise standard:

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

The complete resource-specific naming rules remain maintained in GOV-005.

---

# 6. Environment Codes

The enterprise standard uses the following environment identifiers:

| Environment | Code |
|---|---|
| Production | `prod` |
| Non-Production | `nonprod` |
| Sandbox | `sbx` |

These codes provide a consistent way to distinguish resource environments.

---

# 7. Examples

| Resource | Example |
|---|---|
| Resource Group | `rg-platform-prod` |
| Virtual Network | `vnet-platform-prod` |
| Key Vault | `kv-platform-prod` |
| Log Analytics Workspace | `law-platform-prod` |
| Azure Firewall | `afw-platform-prod` |

Examples are illustrative and must also respect the naming restrictions of the individual Azure resource type.

---

# 8. Naming Principles

| Principle | Application |
|---|---|
| **Consistency** | Use the same structure across comparable resources |
| **Readability** | Names should be understandable without external decoding |
| **Resource Identification** | Include the resource type prefix where applicable |
| **Environment Identification** | Include the standard environment code where applicable |
| **Purpose Identification** | Include the workload, platform capability or purpose where useful |
| **Azure Compatibility** | Respect resource-specific naming restrictions |
| **Practicality** | Avoid unnecessary identifiers and overly long names |

Naming is an identification mechanism. It should not be used to encode information that belongs in tags or governance metadata.

---

# 9. Relationship Between Naming and Tags

Naming and tagging serve different purposes.

| Mechanism | Purpose |
|---|---|
| **Name** | Stable technical identification |
| **Tag** | Operational, ownership and governance metadata |

Information such as owner, cost center or business unit should generally be managed through tags rather than being embedded into every resource name.

This keeps names stable and avoids unnecessarily complex naming patterns.

---

# 10. Decision Drivers

| Driver | Reason |
|---|---|
| **Consistency** | Provide a common enterprise standard |
| **Operations** | Make resources easier to identify |
| **Governance** | Support resource organization and policy |
| **Scalability** | Work across subscriptions and Landing Zones |
| **Readability** | Allow quick identification by engineers and operators |
| **Practicality** | Avoid excessive naming complexity |

---

# 11. Alternatives Considered

| Option | Decision | Rationale |
|---|---|---|
| **No enterprise naming standard** | Rejected | Creates inconsistent resource identification |
| **Highly detailed encoded names** | Rejected | Creates unnecessary complexity and length |
| **Resource prefix + purpose + environment** | **Selected** | Provides useful identification with limited complexity |
| **Use names for all governance metadata** | Rejected | Tags are more appropriate for dynamic metadata |

---

# 12. Expected Benefits

| Area | Benefit |
|---|---|
| Operations | Faster resource identification |
| Governance | Consistent resource organization |
| Automation | Predictable resource naming |
| Troubleshooting | Easier identification of resource purpose and environment |
| Scalability | Common approach across Landing Zones |
| Documentation | Clearer architecture and operational documentation |

---

# 13. Consequences

### Positive

- Consistent resource naming across the enterprise
- Easier operational identification
- Better alignment between Terraform and governance
- Simpler resource inventories
- Reduced naming ambiguity

### Trade-offs

- Teams must follow resource-specific Azure naming restrictions
- Existing resources may require exceptions during migration
- Some Azure services impose naming limitations that prevent a completely uniform pattern

These exceptions should be documented where necessary rather than creating a separate naming convention for each team.

---

# 14. Scope and Boundaries

This decision applies to Azure resources managed by the enterprise cloud foundation, including:

- Platform Capabilities;
- Landing Zones;
- subscriptions;
- resource groups;
- infrastructure resources managed through Terraform.

It does not define:

- application-internal naming conventions;
- source-code naming;
- DNS naming outside the Azure resource convention;
- business data naming standards.

---

# 15. Relationship to Other Architecture Decisions

| Document | Relationship |
|---|---|
| **ADR-001** | Enterprise Landing Zone architecture |
| **ADR-003** | Terraform as the IaC standard |
| **ADR-004** | Management Group governance hierarchy |
| **ADR-008** | Enterprise security baseline |
| **GOV-005** | Detailed naming convention standard |
| **GOV-008** | Tagging strategy |
| **GOV-009** | Landing Zone design |
| **ARC-003** | Enterprise reference architecture |

---

# 16. Implementation Alignment

Naming conventions are implemented through the Terraform configuration and reusable modules.

The preferred pattern is:

```text
Terraform
   │
   ▼
Naming Convention
   │
   ├── Resource Prefix
   ├── Purpose / Capability
   └── Environment
           │
           ▼
      Azure Resource
```

The implementation should use the centralized naming logic already established in the Terraform foundation rather than allowing individual modules to invent their own conventions.

---

# 17. Review

This decision should be reviewed when significant changes occur to:

- Azure resource naming restrictions;
- enterprise governance requirements;
- Landing Zone architecture;
- Terraform repository architecture;
- resource types introduced into the platform.

---

# 18. References

- GOV-005 — Naming Convention
- GOV-008 — Tagging Strategy
- GOV-009 — Landing Zone Design
- ADR-001 — Enterprise Landing Zone Architecture
- ADR-003 — Terraform as Infrastructure as Code
- ADR-004 — Enterprise Management Group Hierarchy
- ARC-003 — Enterprise Reference Architecture
