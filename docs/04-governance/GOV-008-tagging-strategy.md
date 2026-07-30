# GOV-008 – Tagging Strategy

| **Document ID**  | GOV-008                                                |
| ---------------- | ------------------------------------------------------ |
| **Version**      | 1.1                                                    |
| **Status**       | Approved                                               |
| **Owner**        | Cloud Platform Team                                    |
| **Audience**     | Cloud Architects, Platform Engineers, Operations Teams |
| **Organization** | Mandara Global                                         |
| **Program**      | OneCloud 2030                                          |

---

# 1. Purpose

As part of the **OneCloud 2030** transformation program, **Mandara Global** is implementing a standardized resource tagging strategy to improve governance, operational visibility, cost management, and automation across the Azure Enterprise Cloud Foundation.

This document defines the mandatory tagging standard applied to Azure resources. The objective is to ensure that every deployed resource contains consistent business and operational metadata throughout its lifecycle.

---

# 2. Design Principles

The tagging strategy follows these principles:

* Apply mandatory tags to all supported Azure resources.
* Use standardized tag names and values.
* Automate tag enforcement using Azure Policy where possible.
* Support governance, reporting, and cost allocation.
* Maintain consistency across all subscriptions and environments.

---

# 3. Mandatory Tags

| Tag              | Description                                 |
| ---------------- | ------------------------------------------- |
| **Application**  | Business application or workload name.      |
| **Environment**  | Production, Non-Production, or Sandbox.     |
| **BusinessUnit** | Owning business department or organization. |
| **Owner**        | Service or application owner.               |
| **CostCenter**   | Financial cost allocation identifier.       |
| **ManagedBy**    | Managing team or automation platform.       |

---

# 4. Example Tags

| Tag          | Value               |
| ------------ | ------------------- |
| Application  | EnterprisePortal    |
| Environment  | prod                |
| BusinessUnit | DigitalServices     |
| Owner        | Cloud Platform Team |
| CostCenter   | CC-1001             |
| ManagedBy    | Terraform           |

---

# 5. Governance Enforcement

Resource tags are enforced using Azure Policy whenever supported. Resources that do not comply with the mandatory tagging standard may be denied during deployment or automatically remediated using Azure Policy.

---

# 6. Design Benefits

* Improved resource visibility
* Accurate cost allocation
* Simplified operational management
* Enhanced automation
* Better compliance reporting
* Consistent enterprise metadata

---

# 7. Design Decision

## Decision

Mandara Global has decided to implement a mandatory enterprise tagging standard for all supported Azure resources deployed within the Azure Enterprise Cloud Foundation.

## Rationale

Standardized resource tags provide essential business and operational metadata that supports governance, automation, financial management, and compliance reporting. Automated enforcement through Azure Policy ensures consistent adoption while reducing manual effort and operational inconsistencies across the **OneCloud 2030** cloud platform.

---

# 8. Related Documents

| Document | Description           |
| -------- | --------------------- |
| GOV-005  | Naming Convention     |
| GOV-006  | RBAC Strategy         |
| GOV-007  | Azure Policy Strategy |
| GOV-009  | Landing Zone Design   |

---

# Key Takeaways

* All supported Azure resources must include the mandatory enterprise tags.
* Resource tags enable governance, automation, reporting, and cost management.
* Azure Policy is used to enforce tagging standards consistently across the platform.
* The tagging strategy supports Mandara Global's enterprise governance model and the long-term objectives of the **OneCloud 2030** transformation program.
