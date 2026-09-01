# TF-001 — Terraform Foundation

| Attribute | Value |
|---|---|
| **Document ID** | TF-001 |
| **Title** | Terraform Foundation |
| **Version** | 1.1 |
| **Status** | Accepted |
| **Date** | 2026-09-01 |
| **Authors** | Cloud Architecture Team |
| **Program** | OneCloud 2030 |
| **Organization** | Mandara Global |
| **Category** | Terraform |

---

# 1. Executive Summary

Terraform is the Infrastructure as Code (IaC) standard for the Azure Enterprise Cloud Foundation.

The Terraform repository provides a layered structure that separates:

- enterprise orchestration;
- Platform Capabilities;
- reusable Azure resource modules;
- Landing Zones;
- environment-specific configuration;
- remote state configuration.

The implementation follows a pragmatic approach: infrastructure is modular and reusable, while unnecessary complexity is avoided.

---

# 2. Purpose

TF-001 defines the foundation and structure of the Terraform implementation.

It establishes the responsibilities of the main Terraform layers and their relationship to the enterprise architecture.

It does not define the detailed implementation of individual Platform Capabilities, Landing Zones, modules or deployment procedures. Those concerns are documented in the subsequent TF documents.

---

# 3. Terraform Architecture

The Terraform repository follows this logical structure:

```text
                         terraform/main.tf
                      Platform Orchestrator
                               │
          ┌────────────────────┼────────────────────┐
          ▼                    ▼                    ▼
      Platform             Reusable            Landing
     Capabilities            Modules             Zones
          │                                        │
          └────────────────────┬───────────────────┘
                               ▼
                         Azure Resources
```

The layers have different responsibilities:

| Layer | Responsibility |
|---|---|
| **Root** | Orchestrates the Terraform configuration and shared enterprise metadata |
| **Platform** | Implements the five shared Platform Capabilities |
| **Modules** | Provides reusable Azure resource implementations |
| **Landing Zones** | Provides workload-specific infrastructure boundaries |
| **Environments** | Provides environment-specific values and configuration |
| **Backend** | Provides Terraform remote state configuration |

Platform Capabilities are a logical architecture concept implemented by the `platform/` layer. They are not Terraform modules and are not Management Groups.

---

# 4. Repository Structure

```text
terraform/

├── backend/                # Remote state configuration
│
├── environments/           # Environment-specific configuration
│   ├── dev.tfvars
│   ├── test.tfvars
│   └── prod.tfvars
│
├── landingzones/           # Business workload deployments
│   ├── corp/
│   ├── online/
│   └── sandbox/
│
├── modules/                # Reusable Azure resource modules
│   ├── diagnostic-settings/
│   ├── key-vault/
│   ├── logs-analytics/
│   ├── monitor/
│   ├── network-security-group/
│   ├── policies/
│   ├── private-endpoint/
│   ├── recovery-services/
│   ├── resource-group/
│   ├── role-assignement/
│   ├── storage-account/
│   ├── subnet/
│   └── virtual-network/
│
├── platform/               # Enterprise Platform Capabilities
│   ├── management/
│   ├── connectivity/
│   ├── security/
│   ├── operations/
│   └── identity/
│
├── locals.tf               # Enterprise metadata and common values
├── main.tf                 # Terraform root / orchestrator
├── providers.tf            # Provider configuration
├── variables.tf            # Root variables
└── versions.tf             # Terraform and provider constraints
```

The structure reflects the current repository organization. Landing Zone directories provide the architectural boundaries for Corp, Online and Sandbox workloads.

---

# 5. Platform Capabilities

The Terraform platform layer reflects the five enterprise Platform Capabilities:

| Capability | Terraform Path | Responsibility |
|---|---|---|
| **Management** | `platform/management/` | Management and governance-supporting services |
| **Connectivity** | `platform/connectivity/` | Shared network and connectivity services |
| **Security** | `platform/security/` | Shared security services and controls |
| **Operations** | `platform/operations/` | Monitoring and operational services |
| **Identity** | `platform/identity/` | Identity and access services |

These capabilities are composed from reusable modules where appropriate.

The Terraform structure therefore mirrors the enterprise architecture without creating an additional architectural hierarchy.

---

# 6. Reusable Modules

The `modules/` layer contains reusable implementations of individual Azure resources or resource patterns.

Examples include:

| Module | Purpose |
|---|---|
| `resource-group` | Resource Group creation |
| `virtual-network` | Virtual Network creation |
| `subnet` | Subnet configuration |
| `network-security-group` | Network security controls |
| `private-endpoint` | Private Endpoint configuration |
| `key-vault` | Key Vault resources |
| `storage-account` | Storage resources |
| `logs-analytics` | Log Analytics resources |
| `diagnostic-settings` | Diagnostic configuration |
| `policies` | Azure Policy resources |
| `role-assignement` | Role assignment resources |
| `recovery-services` | Recovery Services resources |

Modules should remain focused on reusable infrastructure implementation.

They should not contain workload-specific architecture or duplicate enterprise orchestration logic.

---

# 7. Landing Zones

Landing Zones are represented under:

```text
terraform/landingzones/

├── corp/
├── online/
└── sandbox/
```

They provide the Terraform boundary for business workload infrastructure.

The Landing Zone model is aligned with the enterprise architecture:

| Landing Zone | Purpose |
|---|---|
| **Corp** | Internal and enterprise workloads |
| **Online** | Internet-facing or externally accessible workloads |
| **Sandbox** | Controlled experimentation |

Landing Zones consume shared Platform Capabilities where required.

Detailed Landing Zone implementation is documented in **TF-005**.

---

# 8. Environment Configuration

Environment-specific values are separated from the reusable Terraform structure.

Current configuration files include:

```text
environments/
├── dev.tfvars
├── test.tfvars
└── prod.tfvars
```

The environment configuration provides deployment-specific values without duplicating the underlying infrastructure structure.

Environment configuration and deployment procedures are documented further in **TF-007**.

---

# 9. Remote State

Terraform state is stored outside the source repository using the configured Azure Storage backend.

The foundation therefore separates:

```text
Terraform Configuration
        │
        ├── Source Repository
        │
        └── Remote State
              │
              ▼
       Azure Storage Backend
```

State management is documented in **TF-002**.

State files and sensitive state data must not be committed to Git.

---

# 10. Common Enterprise Metadata

Enterprise metadata and common values are centralized where practical.

This includes values used for:

- naming;
- tagging;
- environment identification;
- common platform metadata.

Naming and tagging standards remain defined by the governance documentation and are implemented through Terraform.

The Terraform implementation should not redefine those standards independently.

---

# 11. Change and Validation Workflow

The basic Terraform lifecycle is:

```text
Change
  │
  ▼
Terraform Code
  │
  ▼
terraform fmt
  │
  ▼
terraform validate
  │
  ▼
terraform plan
  │
  ▼
Review
  │
  ▼
terraform apply
  │
  ▼
Azure + Terraform State
```

Changes should be reviewed before applying infrastructure modifications.

The exact deployment model is documented in **TF-007**.

---

# 12. Design Principles

| Principle | Application |
|---|---|
| **Infrastructure as Code** | Infrastructure is defined through Terraform |
| **Layered Structure** | Platform, modules and Landing Zones have clear responsibilities |
| **Reusability** | Common Azure resources are implemented through reusable modules |
| **Separation of Concerns** | Architecture, orchestration and resource implementation remain distinct |
| **Centralized Metadata** | Common naming and tagging inputs are managed consistently |
| **Pragmatism** | Complexity is introduced only where it provides clear value |
| **Reviewability** | Infrastructure changes are visible and reviewable in version control |

---

# 13. Scope and Boundaries

TF-001 covers the Terraform foundation and repository structure.

It does not define:

- detailed remote state design;
- individual Platform Capability implementations;
- detailed Landing Zone implementation;
- module interface specifications;
- complete deployment procedures;
- application deployment pipelines.

These topics are covered by the other documents in `07-terraform`.

---

# 14. Benefits and Trade-offs

| Benefits | Trade-offs |
|---|---|
| Consistent infrastructure provisioning | Terraform state requires management |
| Reusable infrastructure components | Modules require lifecycle management |
| Clear separation of responsibilities | Engineers need Terraform knowledge |
| Reviewable infrastructure changes | Provider changes require validation |
| Repeatable Platform and Landing Zone deployments | Some Azure operations may remain outside Terraform scope |

The architecture intentionally avoids reproducing the full complexity of an Azure Enterprise-Scale implementation where it is not required by the project scope.

---

# 15. Related Documents

| Document | Relationship |
|---|---|
| **ADR-003** | Establishes Terraform as the IaC standard |
| **TF-002** | Defines remote state |
| **TF-003** | Defines repository architecture |
| **TF-004** | Defines Platform implementation |
| **TF-005** | Defines Landing Zone implementation |
| **TF-006** | Defines reusable modules |
| **TF-007** | Defines environment structure and deployment |
| **TF-008** | Defines bootstrap |

---

# 16. References

- Microsoft Cloud Adoption Framework
- Azure Landing Zones
- Terraform documentation
- ADR-003 — Terraform as Infrastructure as Code
- ARC-003 — Enterprise Reference Architecture
