# TF-002 – Terraform Remote State

| **Attribute**    | **Value**                     |
| ---------------- | ----------------------------- |
| **Document ID**  | TF-002                        |
| **Title**        | Terraform Remote State        |
| **Status**       | Accepted                      |
| **Date**         | 2026-08-02                    |
| **Authors**      | Cloud Architecture Team       |
| **Program**      | OneCloud 2030                 |
| **Organization** | Mandara Global                |
| **Category**     | Terraform                     |

---

# Executive Summary

Terraform state is a critical component of Infrastructure as Code. Rather than storing the state file locally, this project uses an Azure Storage Account as a remote backend to enable secure, consistent, and collaborative infrastructure management.

The remote state configuration ensures that infrastructure changes are tracked centrally while supporting future CI/CD integration.

---

# Architecture Overview

```text
Terraform
     │
     ▼
Azure Storage Account
     │
     └── Blob Container
             │
             └── terraform.tfstate
```

The remote backend stores the Terraform state file in Azure Blob Storage, providing a single source of truth for infrastructure deployments.

---

# Design Decisions

| **Decision** | **Rationale** |
|--------------|---------------|
| Azure Storage Account | Native Azure backend for Terraform |
| Blob Container | Centralized storage for state files |
| Remote Backend | Eliminates dependency on local state files |
| One state per environment | Keeps Dev, Test and Production isolated |
| Backend configuration separated | Simplifies maintenance and future automation |

---

# Benefits & Trade-offs

| **Benefits** | **Trade-offs** |
|--------------|----------------|
| Centralized state management | Requires backend initialization before deployment |
| Better collaboration | Azure resources must exist before first Terraform run |
| Reduced risk of state inconsistency | Slightly more initial configuration |
| Ready for CI/CD pipelines | |

---

# Key Takeaways

- Terraform state is stored centrally in Azure Blob Storage.
- Remote state improves consistency and collaboration.
- Each environment maintains an independent state file.
- The backend design supports future automation pipelines.
- Local state files are intentionally avoided.

---

## References

- Terraform AzureRM Backend
- Microsoft Cloud Adoption Framework (CAF)

## Next Step

**TF-003 – Terraform Repository Architecture**


