# TF-006 — Terraform Reusable Modules

| Attribute | Value |
|---|---|
| **Document ID** | TF-006 |
| **Title** | Terraform Reusable Modules |
| **Version** | 1.1 |
| **Status** | Accepted |
| **Date** | 2026-09-01 |
| **Authors** | Cloud Architecture Team |
| **Program** | OneCloud 2030 |
| **Organization** | Mandara Global |
| **Category** | Terraform / Modules |

---

# 1. Executive Summary

Reusable Terraform modules provide the common infrastructure building blocks used by the Platform and Landing Zone layers.

The current repository contains focused modules for common Azure resources and resource patterns.

The module strategy is intentionally pragmatic: modules should improve reuse and consistency without introducing unnecessary abstraction.

---

# 2. Purpose

TF-006 defines the role, structure and usage principles of reusable Terraform modules.

It covers:

- module responsibilities;
- current module inventory;
- module structure;
- inputs and outputs;
- reuse between Platform and Landing Zones;
- module design principles.

It does not define the architecture of Platform Capabilities or Landing Zones themselves.

---

# 3. Module Architecture

The intended relationship is:

```text
                 Terraform Root
                      │
          ┌───────────┴───────────┐
          ▼                       ▼
      Platform               Landing Zones
          │                       │
          └───────────┬───────────┘
                      ▼
               Reusable Modules
                      │
                      ▼
                Azure Resources
```

Modules are implementation building blocks.

They do not define the enterprise architecture hierarchy.

---

# 4. Current Module Inventory

The current repository contains:

```text
terraform/modules/
├── diagnostic-settings/
├── key-vault/
├── logs-analytics/
├── monitor/
├── network-security-group/
├── policies/
├── private-endpoint/
├── recovery-services/
├── resource-group/
├── role-assignement/
├── storage-account/
├── subnet/
└── virtual-network/
```

| Module | Primary Purpose |
|---|---|
| `diagnostic-settings` | Configure Azure diagnostic settings |
| `key-vault` | Deploy Key Vault resources |
| `logs-analytics` | Deploy Log Analytics resources |
| `monitor` | Configure monitoring resources |
| `network-security-group` | Deploy Network Security Groups |
| `policies` | Configure Azure Policy resources |
| `private-endpoint` | Deploy Private Endpoints |
| `recovery-services` | Deploy Recovery Services resources |
| `resource-group` | Deploy Resource Groups |
| `role-assignement` | Configure Azure role assignments |
| `storage-account` | Deploy Storage Accounts |
| `subnet` | Configure subnets |
| `virtual-network` | Deploy Virtual Networks |

The inventory reflects the current repository structure.

---

# 5. Module Structure

A standard module follows the repository pattern:

```text
module-name/
├── main.tf
├── variables.tf
└── outputs.tf
```

| File | Responsibility |
|---|---|
| `main.tf` | Resource implementation |
| `variables.tf` | Module inputs |
| `outputs.tf` | Values exposed to callers |

Additional files may be introduced where required, but the module should remain focused.

---

# 6. Module Responsibilities

A reusable module should answer:

> How is this infrastructure component created and configured?

It should not answer:

> Which enterprise workload should use it?

For example:

```text
virtual-network module
        │
        ▼
Creates/configures a VNet
```

Whereas:

```text
Landing Zone
        │
        ▼
Decides which VNet is required
        │
        ▼
Calls virtual-network module
```

This keeps infrastructure implementation separate from architecture and workload decisions.

---

# 7. Inputs

Modules receive configuration through variables.

Inputs should represent values that genuinely vary between module consumers.

Typical examples include:

- resource name;
- location;
- resource group;
- address spaces;
- tags;
- configuration parameters.

Inputs should remain explicit and understandable.

A module should not require callers to understand unnecessary internal implementation details.

---

# 8. Outputs

Modules expose values required by their consumers.

Typical outputs may include:

- resource ID;
- resource name;
- subnet ID;
- workspace ID;
- Key Vault ID;
- other identifiers required by dependent resources.

Outputs should be limited to values that have a useful consumer.

Avoid exposing internal implementation details without a clear need.

---

# 9. Platform Module Usage

Platform Capabilities use reusable modules to implement common Azure resources.

Example:

```text
Connectivity Capability
        │
        ▼
virtual-network
        │
        ▼
Hub Virtual Network
```

Another example:

```text
Operations Capability
        │
        ├── logs-analytics
        └── diagnostic-settings
                │
                ▼
        Monitoring Infrastructure
```

The Platform Capability remains responsible for the capability-level composition.

The module remains responsible for reusable resource implementation.

---

# 10. Landing Zone Module Usage

Landing Zones also consume reusable modules.

Example:

```text
Corp Landing Zone
        │
        ├── resource-group
        ├── virtual-network
        ├── subnet
        ├── network-security-group
        └── private-endpoint
```

The same modules may be reused by Online or Sandbox where appropriate.

This avoids creating separate copies of equivalent Azure resource implementations.

---

# 11. Module Independence

The dependency direction is:

```text
Platform ───────► Modules
Landing Zones ──► Modules
```

The reverse direction is not permitted:

```text
Modules ──X──► Platform
Modules ──X──► Landing Zones
```

Modules must remain independent of workload-specific or capability-specific configurations.

This is the main mechanism that keeps the module layer reusable.

---

# 12. Naming and Tagging

Modules receive enterprise naming and tagging values from their callers or shared Terraform configuration.

They should implement the enterprise standards rather than define alternative standards.

Relevant governance documents include:

- **GOV-005 — Naming Convention**
- **GOV-008 — Tagging Strategy**
- **ADR-009 — Enterprise Naming Convention Standard**
- **ADR-010 — Enterprise Tagging Strategy**

Example:

```text
Caller
  │
  ├── name = "vnet-platform-prod-001"
  └── tags = enterprise tags
          │
          ▼
    virtual-network module
```

The module should not silently replace the supplied enterprise metadata.

---

# 13. Module Scope

A module should generally represent one coherent reusable resource or resource pattern.

Good examples:

```text
virtual-network
network-security-group
key-vault
private-endpoint
```

A module should not become a complete Platform Capability or Landing Zone.

For example, the following would be an inappropriate abstraction:

```text
enterprise-everything-module
```

Such an abstraction would hide architectural decisions and reduce reuse.

---

# 14. Module Composition

Modules may be composed by higher-level Terraform configurations when there is a clear benefit.

Example:

```text
Landing Zone
     │
     ├── virtual-network
     │      └── subnet
     │
     ├── network-security-group
     │
     └── private-endpoint
```

Composition belongs to the Platform or Landing Zone layer.

The reusable module itself should remain focused on its defined responsibility.

---

# 15. Validation and Quality

Modules should be validated before being consumed by shared Platform or Landing Zone configurations.

Basic validation includes:

```text
terraform fmt
      │
      ▼
terraform validate
      │
      ▼
terraform plan
```

Changes to commonly used modules should be reviewed for their potential impact on all consumers.

---

# 16. Versioning and Change Management

Module changes are managed through Git version control together with the Terraform repository.

A module change should be treated as a shared infrastructure change when multiple capabilities or Landing Zones consume it.

Breaking changes should be avoided where practical.

When a breaking change is required, affected consumers should be updated deliberately rather than relying on implicit behavior.

---

# 17. Security

Modules must not embed secrets or credentials.

Sensitive values should be passed through appropriate Terraform and Azure mechanisms.

Security-related modules, such as:

- `key-vault`;
- `private-endpoint`;
- `network-security-group`;
- `policies`;

must follow the enterprise security and governance standards.

---

# 18. Design Principles

| Principle | Application |
|---|---|
| **Focused** | One coherent responsibility per module |
| **Reusable** | Usable by multiple Platform or Landing Zone consumers |
| **Independent** | No dependency on Platform or workload code |
| **Explicit** | Clear inputs and outputs |
| **Consistent** | Common enterprise standards are respected |
| **Maintainable** | Avoid unnecessary abstraction |
| **Pragmatic** | Create modules when reuse or consistency justifies them |

---

# 19. Benefits and Trade-offs

| Benefits | Trade-offs |
|---|---|
| Reduces duplicated Terraform code | Modules require maintenance |
| Promotes consistent resource configuration | Poor abstractions can hide important details |
| Supports Platform and Landing Zone reuse | Shared changes can affect multiple consumers |
| Simplifies common resource deployment | Module interfaces need careful design |
| Improves maintainability | Too many small modules can increase complexity |

The project therefore favors **useful reuse**, not maximum modularization.

---

# 20. Scope and Boundaries

TF-006 covers reusable Terraform modules.

It does not define:

- Platform Capability architecture;
- Landing Zone architecture;
- remote state;
- environment deployment;
- bootstrap;
- application architecture.

Those topics are defined in the corresponding Terraform and architecture documents.

---

# 21. Related Documents

| Document | Relationship |
|---|---|
| **TF-001** | Terraform Foundation |
| **TF-003** | Repository Architecture |
| **TF-004** | Terraform Platform |
| **TF-005** | Terraform Landing Zones |
| **TF-007** | Environment Structure & Deployment |
| **TF-008** | Bootstrap |
| **GOV-005** | Naming Convention |
| **GOV-008** | Tagging Strategy |
| **ADR-009** | Enterprise Naming Convention Standard |
| **ADR-010** | Enterprise Tagging Strategy |

---

# 22. References

- Terraform documentation
- AzureRM provider documentation
- ARC-003 — Enterprise Reference Architecture
- GOV-005 — Naming Convention
- GOV-008 — Tagging Strategy
