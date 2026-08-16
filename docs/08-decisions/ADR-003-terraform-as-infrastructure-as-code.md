# ADR-003 — Terraform as Infrastructure as Code

| **Attribute** | **Value** |
|---|---|
| **ADR ID** | ADR-003 |
| **Title** | Terraform as Infrastructure as Code |
| **Status** | Accepted |
| **Date** | 2026-08-16 |
| **Authors** | Cloud Architecture Team |
| **Program** | OneCloud 2030 |
| **Organization** | Mandara Global |
| **Category** | Platform Engineering |

---

## 1. Context

The Azure Enterprise Cloud Foundation requires a standardized, repeatable, and auditable approach to infrastructure provisioning.

Terraform is selected to reduce configuration drift, improve reusability, and provide consistent infrastructure lifecycle management across environments.

---

## 2. Decision

Terraform is adopted as the standard Infrastructure as Code (IaC) and orchestration tool for the Azure Enterprise Cloud Foundation.

The implementation follows four logical layers:

| Layer | Responsibility |
|---|---|
| **Root** | Enterprise metadata, variables, providers, and orchestration |
| **Platform Capability** | Capability orchestration and Resource Group ownership |
| **Reusable Module** | Implementation of individual Azure resources |
| **Landing Zone** | Business workload infrastructure |

Platform capabilities are organized as independent domains:

```text
Management
Connectivity
Security
Operations
Identity
```

Each capability owns a dedicated Resource Group and its associated platform resources.

---

## 3. Architecture

```text
                         Terraform Root
                              │
                    Metadata & Orchestration
                              │
        ┌─────────────────────┼─────────────────────┐
        ▼                     ▼                     ▼
   Management           Connectivity            Security
        │                     │                     │
        ▼                     ▼                     ▼
   Dedicated RG          Dedicated RG          Dedicated RG
        │                     │                     │
        └─────────────────────┼─────────────────────┘
                              ▼
                       Reusable Modules
                              │
                              ▼
                       Azure Platform
                              │
                              ▼
                        Landing Zones
```

Resource Group ownership follows the capability boundary:

| Capability | Resource Group |
|---|---|
| Management | `rg-platform-management-<env>-001` |
| Connectivity | `rg-platform-connectivity-<env>-001` |
| Security | `rg-platform-security-<env>-001` |
| Operations | `rg-platform-operations-<env>-001` |
| Identity | `rg-platform-identity-<env>-001` |

---

## 4. Metadata and Tagging

Enterprise metadata is centralized in `terraform/locals.tf`.

Capability-specific metadata is added during root orchestration:

```hcl
tags = merge(
  local.common_tags,
  var.tags,
  {
    Capability = "Connectivity"
  }
)
```

Reusable modules consume the resulting configuration and remain capability-agnostic.

---

## 5. Architectural Principles

| Principle | Application |
|---|---|
| **Infrastructure as Code** | Azure infrastructure is managed through Terraform |
| **Modularity** | Azure resources are implemented through reusable modules |
| **Capability Ownership** | Each capability owns its Resource Group and platform resources |
| **Centralized Metadata** | Enterprise-wide metadata is maintained at root level |
| **Separation of Concerns** | Root, capabilities, and modules have distinct responsibilities |
| **Idempotency** | Terraform maintains the declared desired state |

---

## 6. Alternatives Considered

| Option | Decision | Rationale |
|---|---|---|
| Azure Portal | ❌ Rejected | Manual provisioning does not provide the required consistency and automation |
| Bicep | ❌ Rejected | Terraform provides the selected module and orchestration model |
| Terraform | ✅ Selected | Mature ecosystem, Azure support, modularity, reusability, and CI/CD integration |

---

## 7. Consequences

### Benefits

- Consistent infrastructure provisioning
- Clear capability ownership
- Reusable Terraform modules
- Centralized enterprise metadata
- Reduced configuration drift
- Repeatable environment deployment

### Trade-offs

- Terraform state requires controlled management
- Contributors must follow the defined repository structure
- Platform orchestration introduces an additional abstraction layer

---

## 8. Validation

The implementation is validated through:

```text
terraform fmt
terraform validate
terraform plan
terraform apply
terraform plan
```

Expected steady-state result:

```text
No changes.
Your infrastructure matches the configuration.
```

---

## 9. Related ADRs

| ADR | Decision |
|---|---|
| ADR-001 | Enterprise Landing Zone Architecture |
| ADR-002 | Hub & Spoke Network Architecture |
| ADR-008 | Security Baseline |
| ADR-009 | Naming Convention |
| ADR-010 | Tagging Strategy |

---

## 10. Review

This decision should be reviewed when significant changes occur to the Terraform architecture, Azure platform strategy, or enterprise cloud operating model.

---

## 11. References

- Terraform Documentation
- Azure Provider for Terraform
- Microsoft Cloud Adoption Framework
- Azure Well-Architected Framework
- Azure Architecture Center
