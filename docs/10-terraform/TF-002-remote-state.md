# TF-002 – Terraform Remote State

| **Attribute**    | **Value**                     |
| ---------------- | ----------------------------- |
| **Document ID**  | TF-002                        |
| **Title**        | Terraform Remote State        |
| **Status**       | Accepted                      |
| **Date**         | 2026-08-04                    |
| **Authors**      | Cloud Architecture Team       |
| **Program**      | OneCloud 2030                 |
| **Organization** | Mandara Global                |
| **Category**     | Terraform                     |

---

# Executive Summary

Terraform state is a critical component of Infrastructure as Code. Rather than storing the state file locally, this project uses an Azure Storage Account as a remote backend to provide secure, centralized and consistent infrastructure management.

The remote backend establishes a single source of truth for Terraform deployments while supporting collaboration and future CI/CD integration.

---

# Architecture Overview

```text
Terraform

↓

backend.hcl

↓

Azure Storage Account

↓

Blob Container

↓

dev.terraform.tfstate
```

The Terraform state is stored in Azure Blob Storage, ensuring that infrastructure state remains centralized, persistent and independent of local developer workstations.

### Backend Resources

| **Resource** | **Name** |
|--------------|----------|
| Resource Group | `rg-mandara-tfstate-01` |
| Storage Account | `stmandaratfstate01` |
| Blob Container | `tfstate` |
| State File | `dev.terraform.tfstate` |

---

# Design Decisions

| **Decision** | **Rationale** |
|--------------|---------------|
| Azure Storage Account | Native Azure backend for Terraform |
| Blob Container | Centralized storage for Terraform state |
| Remote Backend | Eliminates dependency on local state files |
| One state file per environment | Each environment maintains its own Terraform state (`dev.terraform.tfstate`, `test.terraform.tfstate`, `prod.terraform.tfstate`) |
| Single backend configuration file | Current project scope does not justify multiple backend configuration files |

---

# Benefits & Trade-offs

| **Benefits** | **Trade-offs** |
|--------------|----------------|
| Centralized state management | Backend infrastructure must exist before the first deployment |
| Better collaboration | Initial backend configuration is required |
| Reduced risk of state inconsistency | |
| Ready for future CI/CD integration | |

---

# Architecture Decision

The project intentionally uses a single backend configuration file.

```text
terraform/

backend/
└── backend.hcl
```

Although large enterprise platforms often maintain dedicated backend configuration files for Development, Test and Production, this project intentionally adopts a simpler approach.

### Rationale

- The platform currently manages a single Azure subscription.
- A single Azure Storage Account hosts the Terraform backend.
- Additional backend configuration files were evaluated but intentionally deferred.
- Introducing multiple backend configuration files at this stage would increase complexity without providing additional architectural value.

The project follows the guiding architecture principle:

> **Introduce complexity only when justified by a real business or technical requirement.**

If the platform evolves towards multiple Azure subscriptions, multiple backend infrastructures or independent platform teams, dedicated backend configuration files can be introduced without redesigning the Terraform architecture.

---

# Bootstrap Consideration

The Terraform backend is created during an initial bootstrap phase and is intentionally managed outside of the platform deployment.

This avoids a circular dependency where Terraform would need an existing backend in order to create the backend itself.

The bootstrap process is performed only once before the first platform deployment.

---

# Key Takeaways

- Terraform state is stored centrally in Azure Blob Storage.
- Local state files are intentionally avoided.
- Each environment uses an independent Terraform state file.
- A single backend configuration file is sufficient for the current project scope.
- The backend architecture is designed to evolve without impacting the Terraform modules.

---

## References

- Terraform AzureRM Backend
- Microsoft Cloud Adoption Framework (CAF)

---

## Next Step

**TF-003 – Terraform Repository Architecture**
