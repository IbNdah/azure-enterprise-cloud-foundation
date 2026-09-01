# TF-003 — Terraform Repository Architecture

| Attribute | Value |
|---|---|
| **Document ID** | TF-003 |
| **Title** | Terraform Repository Architecture |
| **Version** | 1.1 |
| **Status** | Accepted |
| **Date** | 2026-09-01 |
| **Authors** | Cloud Architecture Team |
| **Program** | OneCloud 2030 |
| **Organization** | Mandara Global |
| **Category** | Terraform |

---

# 1. Executive Summary

The Terraform repository is organized by **architectural responsibility** rather than by Azure resource type.

The structure separates:

- shared platform capabilities;
- reusable infrastructure modules;
- Landing Zones;
- environment configuration;
- remote state configuration;
- Terraform root orchestration.

This separation keeps the implementation understandable and allows each layer to evolve without unnecessarily coupling it to the others.

---

# 2. Purpose

TF-003 defines the repository structure and the responsibility of each major directory.

It complements **TF-001**, which defines the overall Terraform foundation.

The objective is to provide a clear mapping between the enterprise architecture and the Terraform implementation.

---

# 3. Repository Architecture

The current repository follows this structure:

```text
terraform/
│
├── backend/
│
├── environments/
│
├── landingzones/
│   ├── corp/
│   ├── online/
│   └── sandbox/
│
├── modules/
│
├── platform/
│   ├── management/
│   ├── connectivity/
│   ├── security/
│   ├── operations/
│   └── identity/
│
├── locals.tf
├── main.tf
├── providers.tf
├── variables.tf
├── versions.tf
└── README.md
```

The repository therefore reflects the main implementation boundaries of the Enterprise Cloud Foundation.

---

# 4. Directory Responsibilities

| Directory / File | Responsibility |
|---|---|
| `backend/` | Remote Terraform state configuration |
| `environments/` | Environment-specific input values |
| `landingzones/` | Workload Landing Zone infrastructure |
| `modules/` | Reusable Azure resource implementations |
| `platform/` | Five shared Platform Capabilities |
| `locals.tf` | Common enterprise values and metadata |
| `main.tf` | Terraform root orchestration |
| `providers.tf` | Azure provider configuration |
| `variables.tf` | Root input variables |
| `versions.tf` | Terraform and provider version constraints |
| `README.md` | Terraform implementation documentation |

Each area has a defined responsibility and should not duplicate another layer.

---

# 5. Architectural Relationship

The repository structure maps to the enterprise architecture as follows:

```text
Enterprise Architecture
        │
        ▼
Terraform Root
        │
        ├───────────────┬────────────────┐
        ▼               ▼                ▼
    Platform         Modules        Landing Zones
        │               │                │
        │               └──────┐         │
        │                      ▼         │
        └────────────────► Azure Resources
```

The **Platform** layer represents the five shared Platform Capabilities.

The **Modules** layer provides reusable implementation building blocks.

The **Landing Zones** layer represents governed workload environments.

These are implementation layers, not additional Management Group levels.

---

# 6. Platform Directory

The `platform/` directory contains the five shared Platform Capabilities:

```text
platform/
├── management/
├── connectivity/
├── security/
├── operations/
└── identity/
```

| Capability | Role |
|---|---|
| **Management** | Shared management and governance-supporting services |
| **Connectivity** | Shared enterprise connectivity |
| **Security** | Shared security controls and services |
| **Operations** | Monitoring and operational services |
| **Identity** | Identity and access services |

The capabilities are architecturally distinct from Management Groups and Landing Zones.

They are implemented through Terraform configurations that may consume reusable modules.

---

# 7. Modules Directory

The `modules/` directory contains reusable Azure resource implementations.

The current repository includes:

```text
modules/
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

A module normally contains:

```text
module/
├── main.tf
├── variables.tf
└── outputs.tf
```

Modules should focus on **how a reusable Azure resource or resource pattern is implemented**.

They should not contain enterprise workload decisions or duplicate platform orchestration.

---

# 8. Landing Zones Directory

Landing Zones are organized by the enterprise Landing Zone model:

```text
landingzones/
├── corp/
├── online/
└── sandbox/
```

| Landing Zone | Purpose |
|---|---|
| **Corp** | Internal and enterprise workloads |
| **Online** | Internet-facing or externally accessible workloads |
| **Sandbox** | Controlled experimentation |

A Landing Zone is an architectural and governance boundary. Its Terraform directory is the implementation boundary for the corresponding workload infrastructure.

Detailed Landing Zone implementation is defined in **TF-005**.

---

# 9. Environment Directory

Environment-specific configuration is kept under:

```text
environments/
├── dev.tfvars
├── test.tfvars
└── prod.tfvars
```

These files provide values that vary between environments without requiring duplicated infrastructure definitions.

Environment configuration does not represent a separate Terraform architecture layer.

It is an input mechanism used by the Terraform deployment model.

---

# 10. Backend Directory

The `backend/` directory contains the configuration used to initialize the remote Terraform backend.

```text
backend/
├── backend.hcl
└── README.md
```

The backend stores Terraform state outside the Git repository.

The detailed remote state model is defined in **TF-002**.

---

# 11. Root Terraform Configuration

The root Terraform files provide common configuration and orchestration.

| File | Responsibility |
|---|---|
| `main.tf` | Root Terraform orchestration |
| `providers.tf` | Azure provider configuration |
| `variables.tf` | Root-level inputs |
| `locals.tf` | Common values and enterprise metadata |
| `versions.tf` | Terraform and provider constraints |

The root should remain focused on orchestration and shared configuration rather than becoming a collection of unrelated resource definitions.

---

# 12. Dependency Direction

The preferred dependency direction is:

```text
Root
 │
 ├── Platform ───────► Modules
 │
 └── Landing Zones ──► Modules
```

Platform and Landing Zone implementations may consume reusable modules.

Reusable modules should not depend on Platform or Landing Zone implementations.

This keeps the reusable layer independent and limits coupling.

---

# 13. Naming and Organization

Repository directories use clear, purpose-based names.

The structure should remain aligned with enterprise terminology:

```text
Management
Connectivity
Security
Operations
Identity

Corp
Online
Sandbox
```

Terraform directory names do not replace the enterprise naming convention for Azure resources.

Resource naming is governed by **GOV-005** and **ADR-009**.

---

# 14. Separation of Concerns

The repository maintains the following separation:

| Concern | Location |
|---|---|
| Enterprise orchestration | Terraform root |
| Platform responsibilities | `platform/` |
| Reusable infrastructure | `modules/` |
| Workload environments | `landingzones/` |
| Environment inputs | `environments/` |
| Terraform state configuration | `backend/` |

This separation avoids placing unrelated responsibilities into the same Terraform layer.

---

# 15. Change Management

Repository changes should follow the normal Terraform lifecycle:

```text
Code Change
    │
    ▼
Format
    │
    ▼
Validate
    │
    ▼
Plan
    │
    ▼
Review
    │
    ▼
Apply
```

Changes affecting shared modules or Platform Capabilities should be reviewed for their potential impact on Landing Zones.

---

# 16. Repository Hygiene

The repository must not contain:

- Terraform state files;
- local `.terraform/` directories;
- provider binaries;
- backend credentials;
- generated secrets;
- unnecessary local artifacts.

The repository should contain source configuration and documentation required to reproduce the managed infrastructure.

The `.gitignore` configuration is responsible for excluding local Terraform artifacts.

---

# 17. Design Principles

| Principle | Application |
|---|---|
| **Single Responsibility** | Each directory has a clear purpose |
| **Reusability** | Common infrastructure is implemented once and reused |
| **Low Coupling** | Modules remain independent from platform and workloads |
| **Consistency** | Enterprise architecture terminology is reflected in the repository |
| **Reviewability** | Changes are visible through version control |
| **Pragmatism** | Structure is introduced only where it provides value |
| **Evolution** | New capabilities can be added without restructuring the whole repository |

---

# 18. Benefits and Trade-offs

| Benefits | Trade-offs |
|---|---|
| Clear repository navigation | More structured than a flat Terraform project |
| Reusable infrastructure | Modules require maintenance |
| Clear platform/workload boundary | Contributors must understand the architecture |
| Easier review and troubleshooting | Some changes span multiple layers |
| Supports future Landing Zones | Additional structure may be required as scope grows |

The repository deliberately avoids introducing additional layers such as separate framework abstractions or complex orchestration engines unless a real requirement emerges.

---

# 19. Relationship to Other Terraform Documents

| Document | Relationship |
|---|---|
| **TF-001** | Defines the Terraform foundation |
| **TF-002** | Defines remote state |
| **TF-004** | Defines Platform implementation |
| **TF-005** | Defines Landing Zone implementation |
| **TF-006** | Defines reusable modules |
| **TF-007** | Defines environment structure and deployment |
| **TF-008** | Defines bootstrap |

---

# 20. References

- ADR-003 — Terraform as Infrastructure as Code
- ARC-003 — Enterprise Reference Architecture
- GOV-005 — Naming Convention
- GOV-009 — Landing Zone Design
- TF-001 — Terraform Foundation
- TF-002 — Remote State
