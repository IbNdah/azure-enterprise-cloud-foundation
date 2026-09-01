# ADR-010 — Enterprise Tagging Strategy

| Attribute | Value |
|---|---|
| **ADR ID** | ADR-010 |
| **Title** | Enterprise Tagging Strategy |
| **Version** | 1.1 |
| **Status** | Accepted |
| **Date** | 2026-09-01 |
| **Authors** | Cloud Architecture Team |
| **Program** | OneCloud 2030 |
| **Organization** | Mandara Global |
| **Category** | Governance / Resource Management |

---

# 1. Executive Summary

Mandara Global will use Azure resource tags as a standard mechanism for **governance, ownership, cost allocation and operational identification**.

Tags complement the enterprise naming convention but do not replace it.

The strategy provides a common minimum tagging model across Platform Capabilities and Landing Zones while avoiding unnecessary metadata.

---

# 2. Business Context

As the Azure environment grows across Platform Capabilities, Landing Zones and subscriptions, resources need consistent metadata for management and governance.

Tags provide information that should not be encoded into resource names, such as ownership, business context and cost allocation.

---

# 3. Problem Statement

Without a common tagging strategy, resources may lack information needed for:

- ownership;
- cost management;
- business identification;
- operational management;
- governance reporting.

At the same time, requiring too many tags creates administrative overhead and reduces consistency.

The platform therefore requires a small, meaningful and repeatable tagging standard.

---

# 4. Decision

Mandara Global will use a **standardized set of tags** for Azure resources where the Azure resource type supports tagging.

Tags should contain stable governance and operational metadata.

The tagging strategy will be applied consistently across the platform and Landing Zones, with additional workload-specific tags permitted where there is a clear requirement.

---

# 5. Standard Tags

The enterprise baseline uses the following categories:

| Tag | Purpose | Example |
|---|---|---|
| `environment` | Identifies the deployment environment | `prod` |
| `owner` | Identifies the responsible team or owner | `platform-team` |
| `business-unit` | Identifies the responsible Business Unit | `finance` |
| `cost-center` | Supports cost allocation | `CC1001` |
| `application` | Identifies the related application or workload | `erp` |
| `managed-by` | Identifies the management mechanism | `terraform` |

The exact values should follow the organization's controlled vocabulary where one exists.

Not every tag must necessarily be applicable to every resource. Applicability depends on the resource, ownership model and governance requirement.

### Tagging Examples by Use Case

**Platform resource**

```text
environment = prod
owner       = platform-team
business-unit = global-platform
cost-center = CC1001
application = platform
managed-by  = terraform
```

**Landing Zone workload**

```text
environment = prod
owner       = finance-it
business-unit = finance
cost-center = CC2100
application = erp
managed-by  = terraform
```

**Non-production workload**

```text
environment = nonprod
owner       = finance-it
business-unit = finance
cost-center = CC2100
application = erp
managed-by  = terraform
```

**Sandbox resource**

```text
environment = sbx
owner       = cloud-engineering
business-unit = engineering
cost-center = CC3000
application = experimentation
managed-by  = terraform
```

These examples illustrate the intended use of the standard tags. Actual values remain subject to the enterprise-controlled vocabulary and the ownership model of the resource.

---

# 6. Naming and Tagging

Naming and tagging have distinct purposes.

```text
Azure Resource
      │
      ├── Name
      │     └── Technical identification
      │
      └── Tags
            ├── Owner
            ├── Business Unit
            ├── Cost Center
            ├── Application
            └── Management metadata
```

The naming convention should remain short and predictable.

Governance metadata should generally be represented through tags rather than encoded into resource names.

This aligns with ADR-009.

---

# 7. Tagging Scope

The strategy applies across the enterprise hierarchy:

```text
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
        │
        ▼
     Standard Tags
```

Where supported, tags should be applied consistently to resources and resource groups.

### Scope Examples

| Scope | Example |
|---|---|
| Platform Resource Group | `rg-platform-prod` → `environment=prod`, `owner=platform-team`, `application=platform` |
| Landing Zone Resource Group | `rg-erp-prod` → `environment=prod`, `owner=finance-it`, `application=erp` |
| Workload Resource | `kv-erp-prod` → `environment=prod`, `owner=finance-it`, `application=erp`, `managed-by=terraform` |
| Sandbox Resource | `st-experiment-sbx` → `environment=sbx`, `owner=cloud-engineering`, `application=experimentation` |

Subscription-level governance should establish tagging expectations, while resource and resource-group tags provide the detailed metadata.

---

# 8. Tag Governance

Azure Policy should be used where tagging requirements need to be consistently enforced or monitored.

| Control | Purpose | Example |
|---|---|---|
| **Require Tag** | Prevent or identify resources without required metadata | Require `environment` |
| **Append / Inherit Tag** | Apply defined metadata where appropriate | Inherit `business-unit` from the resource group |
| **Allowed Values** | Prevent uncontrolled tag values | `environment ∈ {prod, nonprod, sbx}` |
| **Audit** | Identify non-compliant resources | Audit resources missing `owner` |

### Governance Examples

```text
Resource
   │
   ├── environment = prod      ✓
   ├── owner = platform-team   ✓
   ├── application = platform  ✓
   └── managed-by = terraform  ✓
```

A resource with `environment=production` would be non-compliant if the controlled vocabulary only permits `prod`.

Not every tag should automatically be enforced. Enforcement should be based on its governance value and the practical impact on deployments.

---

# 9. Tagging Principles

| Principle | Application |
|---|---|
| **Meaningful Metadata** | Tags must have a defined purpose |
| **Consistency** | Use standardized tag names and values |
| **Minimum Necessary Set** | Avoid unnecessary tags |
| **Controlled Values** | Use agreed values where appropriate |
| **Automation** | Apply tags through Terraform and policy where practical |
| **Separation from Naming** | Keep governance metadata out of resource names |
| **Ownership** | Make responsibility identifiable |
| **Cost Visibility** | Support cost allocation where required |

---

# 10. Decision Drivers

| Driver | Reason |
|---|---|
| **Governance** | Identify ownership and resource context |
| **Cost Management** | Support cost allocation and reporting |
| **Operations** | Improve resource identification |
| **Consistency** | Establish common metadata |
| **Automation** | Enable repeatable application through Terraform and Policy |
| **Practicality** | Avoid excessive tagging requirements |

---

# 11. Alternatives Considered

| Option | Decision | Rationale |
|---|---|---|
| **No tagging standard** | Rejected | Insufficient governance and cost visibility |
| **Encode metadata in resource names** | Rejected | Produces long and inflexible names |
| **Large mandatory tag catalogue** | Rejected | Creates unnecessary operational overhead |
| **Small enterprise baseline + workload-specific tags** | **Selected** | Balances governance and practicality |
| **Manual tagging only** | Rejected | Inconsistent and difficult to maintain at scale |

---

# 12. Expected Benefits

| Area | Benefit |
|---|---|
| Governance | Clear ownership and resource context |
| Cost | Improved allocation and reporting |
| Operations | Easier filtering and identification |
| Automation | Consistent metadata through IaC |
| Compliance | Easier identification of non-compliant resources |
| Scalability | Repeatable model across Landing Zones |

---

# 13. Consequences

### Positive

- Consistent governance metadata
- Better cost and ownership visibility
- Clear separation between technical naming and metadata
- Easier automation and reporting
- Reusable tagging model across Landing Zones

### Trade-offs

- Tags require controlled vocabularies and maintenance
- Policy enforcement can affect deployments
- Some Azure resources have tagging limitations
- Incorrect or outdated tag values reduce their usefulness

The strategy therefore favors a small, meaningful baseline over exhaustive metadata.

---

# 14. Scope and Boundaries

This decision applies to:

- Azure Platform Capabilities;
- Azure Landing Zones;
- subscriptions;
- resource groups;
- taggable Azure resources managed by the enterprise foundation.

It does not define:

- application-internal metadata;
- business data classification schemes;
- CMDB schemas;
- all workload-specific metadata.

Those concerns remain within the appropriate governance or workload processes.

---

# 15. Relationship to Other Architecture Decisions

| Document | Relationship |
|---|---|
| **ADR-001** | Enterprise Landing Zone architecture |
| **ADR-003** | Terraform as the IaC standard |
| **ADR-004** | Management Group governance hierarchy |
| **ADR-009** | Enterprise naming convention |
| **GOV-005** | Naming Convention |
| **GOV-008** | Tagging Strategy |
| **GOV-009** | Landing Zone Design |
| **ARC-003** | Enterprise Reference Architecture |

---

# 16. Implementation Alignment

Tagging is implemented through the Terraform foundation and Azure Policy where appropriate.

```text
Terraform
    │
    ▼
Standard Tags
    │
    ├── environment
    ├── owner
    ├── business-unit
    ├── cost-center
    ├── application
    └── managed-by
    │
    ▼
Azure Resources
    │
    ▼
Azure Policy
    └── Audit / Enforce where required
```

### Terraform Example

A platform resource can therefore receive:

```hcl
tags = {
  environment   = "prod"
  owner         = "platform-team"
  business-unit = "global-platform"
  cost-center   = "CC1001"
  application   = "platform"
  managed-by    = "terraform"
}
```

A Landing Zone workload can use the same structure with workload-specific values:

```hcl
tags = {
  environment   = "prod"
  owner         = "finance-it"
  business-unit = "finance"
  cost-center   = "CC2100"
  application   = "erp"
  managed-by    = "terraform"
}
```

The implementation should centralize common tag logic rather than requiring each Terraform module to independently define the enterprise baseline.

---

# 17. Review

This decision should be reviewed when significant changes occur to:

- enterprise governance requirements;
- cost allocation requirements;
- Landing Zone architecture;
- naming standards;
- Azure Policy strategy;
- Terraform repository architecture.

---

# 18. References

- GOV-005 — Naming Convention
- GOV-008 — Tagging Strategy
- GOV-009 — Landing Zone Design
- ADR-004 — Enterprise Management Group Hierarchy
- ADR-009 — Enterprise Naming Convention Standard
- ARC-003 — Enterprise Reference Architecture
