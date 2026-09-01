# TF-004 — Terraform Platform

| Attribute | Value |
|---|---|
| **Document ID** | TF-004 |
| **Title** | Terraform Platform |
| **Version** | 1.1 |
| **Status** | Accepted |
| **Date** | 2026-09-01 |
| **Authors** | Cloud Architecture Team |
| **Program** | OneCloud 2030 |
| **Organization** | Mandara Global |
| **Category** | Terraform / Platform |

---

# 1. Executive Summary

The Terraform `platform/` layer implements the shared services of the Azure Enterprise Cloud Foundation.

It is organized around five Platform Capabilities:

- **Management**
- **Connectivity**
- **Security**
- **Operations**
- **Identity**

Each capability is implemented as an independent Terraform configuration and may consume reusable modules from `modules/`.

The platform layer provides shared infrastructure for Landing Zones and does not represent an additional Management Group hierarchy.

---

# 2. Purpose

TF-004 defines how the five Platform Capabilities are represented and implemented in Terraform.

It establishes:

- capability boundaries;
- resource ownership;
- reusable module usage;
- common metadata and tagging;
- relationship between Platform Capabilities and Landing Zones.

Detailed resource implementation remains in the corresponding capability code and reusable modules.

---

# 3. Platform Architecture

The Terraform platform structure mirrors the enterprise Platform Capability model:

```text
                         Terraform Root
                              │
                              ▼
                     Platform Orchestrator
                              │
          ┌───────────────────┼───────────────────┐
          │                   │                   │
          ▼                   ▼                   ▼
     Management         Connectivity          Security
          │                   │                   │
          └───────────────────┼───────────────────┘
                              │
                    ┌─────────┴─────────┐
                    ▼                   ▼
               Operations            Identity
                    │                   │
                    └─────────┬─────────┘
                              ▼
                       Reusable Modules
                              │
                              ▼
                       Azure Resources
```

The diagram shows Terraform composition, not a dependency hierarchy between capabilities.

---

# 4. Platform Directory

The current Terraform structure is:

```text
platform/
├── management/
├── connectivity/
├── security/
├── operations/
└── identity/
```

| Capability | Terraform Path | Primary Responsibility |
|---|---|---|
| **Management** | `platform/management/` | Management and governance-supporting services |
| **Connectivity** | `platform/connectivity/` | Shared enterprise connectivity |
| **Security** | `platform/security/` | Shared security services and controls |
| **Operations** | `platform/operations/` | Monitoring and operational services |
| **Identity** | `platform/identity/` | Identity and access services |

These names are aligned with the enterprise architecture and governance documentation.

---

# 5. Resource Group Ownership

Platform resources are organized according to capability ownership.

The current model uses a dedicated Resource Group for each capability and environment:

| Capability | Resource Group Pattern |
|---|---|
| Management | `rg-platform-management-<env>-001` |
| Connectivity | `rg-platform-connectivity-<env>-001` |
| Security | `rg-platform-security-<env>-001` |
| Operations | `rg-platform-operations-<env>-001` |
| Identity | `rg-platform-identity-<env>-001` |

This provides a clear ownership and lifecycle boundary for shared platform resources.

The Resource Group naming pattern follows **GOV-005**.

---

# 6. Management Capability

The Management capability provides shared services supporting enterprise resource management and governance.

Typical responsibilities include:

- management-supporting resources;
- governance integration;
- policy-related infrastructure where applicable.

Terraform path:

```text
platform/management/
```

The capability should not become a container for all governance logic. Governance remains defined by the enterprise governance framework.

---

# 7. Connectivity Capability

The Connectivity capability provides shared enterprise network services.

Typical responsibilities include:

- Hub Virtual Network;
- centralized network security services;
- hybrid connectivity;
- private DNS;
- shared connectivity resources.

Terraform path:

```text
platform/connectivity/
```

The detailed connectivity model is defined in **REF-002** and **ADR-002**.

---

# 8. Security Capability

The Security capability provides shared security services and controls.

Typical responsibilities include:

- Key Vault;
- security-related platform resources;
- integration with enterprise security controls.

Terraform path:

```text
platform/security/
```

The capability supports the enterprise security baseline defined in **ADR-008**.

---

# 9. Operations Capability

The Operations capability provides shared monitoring and operational visibility.

Typical responsibilities include:

- Azure Monitor;
- Log Analytics;
- diagnostic settings;
- alerts and operational telemetry.

Terraform path:

```text
platform/operations/
```

The monitoring model is defined in **ADR-007**.

---

# 10. Identity Capability

The Identity capability provides shared identity and access services.

Typical responsibilities include:

- Microsoft Entra ID integration;
- Azure RBAC;
- Managed Identities where required;
- identity-related platform configuration.

Terraform path:

```text
platform/identity/
```

The enterprise identity strategy is defined in **ADR-006**.

---

# 11. Reusable Module Usage

Platform capabilities consume reusable Terraform modules where appropriate.

The preferred relationship is:

```text
Platform Capability
        │
        ▼
Reusable Module
        │
        ▼
Azure Resource
```

For example:

```text
Connectivity
     │
     ▼
virtual-network module
     │
     ▼
Azure Virtual Network
```

A capability should contain orchestration and capability-specific configuration rather than reimplementing common Azure resources.

---

# 12. Metadata and Tagging

Platform resources use centralized enterprise metadata.

Common values are defined through the Terraform root and governance standards.

Capability-specific metadata may identify the owning capability.

Example:

```hcl
tags = merge(
  local.common_tags,
  var.tags,
  {
    Capability = "Connectivity"
  }
)
```

The exact tag set remains governed by **GOV-008** and **ADR-010**.

Terraform should implement the enterprise tagging standard rather than independently redefine it.

---

# 13. Platform-to-Landing-Zone Relationship

The platform provides shared services consumed by Landing Zones.

```text
                   Shared Platform
                         │
        ┌────────────────┼────────────────┐
        │                │                │
        ▼                ▼                ▼
   Management      Connectivity       Security
        │                │                │
        ├────────┬───────┴───────┬────────┤
                 ▼               ▼
             Operations       Identity
                 │               │
                 └───────┬───────┘
                         ▼
                  Landing Zones
               ┌────────┼────────┐
               ▼        ▼        ▼
              Corp    Online   Sandbox
```

Landing Zones consume shared capabilities according to their requirements.

The platform does not own application-specific workload infrastructure.

---

# 14. Separation of Responsibilities

| Platform | Landing Zone / Workload |
|---|---|
| Shared enterprise connectivity | Application-specific networking |
| Shared monitoring services | Application-specific monitoring |
| Enterprise identity integration | Application permissions and workload identities |
| Shared security services | Workload-specific security controls |
| Governance-supporting infrastructure | Workload configuration |
| Platform resource management | Application services |

The exact boundary depends on the service, but the principle remains consistent: shared foundations belong to the platform; application-specific concerns remain with the workload.

---

# 15. Terraform Dependency Model

The preferred dependency direction is:

```text
Terraform Root
      │
      ├── Platform Capability ──► Reusable Module
      │
      └── Landing Zone ─────────► Reusable Module
```

Reusable modules must not depend on a Platform Capability or Landing Zone.

Platform Capabilities should not depend on application workload implementations.

This keeps the reusable infrastructure layer independent.

---

# 16. Platform Lifecycle

Platform infrastructure follows the standard Terraform lifecycle:

```text
Code Change
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
```

Changes to shared Platform Capabilities should be evaluated for their potential impact on all consuming Landing Zones.

---

# 17. Governance and Security

Platform resources are subject to the enterprise governance framework.

Relevant controls include:

- Management Group governance;
- Azure Policy;
- RBAC;
- naming;
- tagging;
- network security;
- monitoring.

The Platform Capability model must not be confused with the Management Group hierarchy.

```text
Management Groups
        │
        │ Governance hierarchy
        ▼
Subscriptions
        │
        ▼
Resources

Platform Capabilities
        │
        │ Shared responsibilities
        ▼
Platform Services
```

The two models describe different architectural concerns.

---

# 18. Design Principles

| Principle | Application |
|---|---|
| **Capability Ownership** | Shared resources have a clear platform capability owner |
| **Reuse** | Common resources are implemented through reusable modules |
| **Separation** | Platform and workload infrastructure remain distinct |
| **Consistency** | Shared services follow common enterprise standards |
| **Security** | Platform resources follow the enterprise security baseline |
| **Traceability** | Infrastructure changes are managed through Terraform |
| **Pragmatism** | No additional abstraction is introduced without a clear need |

---

# 19. Benefits and Trade-offs

| Benefits | Trade-offs |
|---|---|
| Clear ownership of shared services | Requires capability boundaries to remain disciplined |
| Reusable infrastructure | Modules need lifecycle management |
| Consistent platform services | Shared changes can affect multiple workloads |
| Easier operational management | Platform resources require central governance |
| Supports scalable Landing Zones | Additional capabilities may require future structure |

---

# 20. Scope and Boundaries

TF-004 defines the Terraform platform layer.

It does not define:

- detailed resource module interfaces;
- Landing Zone implementation;
- remote state configuration;
- bootstrap procedures;
- application deployment.

These are documented in TF-002, TF-005, TF-006, TF-007 and TF-008.

---

# 21. Related Documents

| Document | Relationship |
|---|---|
| **TF-001** | Terraform Foundation |
| **TF-002** | Remote State |
| **TF-003** | Repository Architecture |
| **TF-005** | Landing Zones |
| **TF-006** | Reusable Modules |
| **TF-007** | Environment Structure & Deployment |
| **TF-008** | Bootstrap |
| **ADR-003** | Terraform as Infrastructure as Code |
| **ADR-004** | Enterprise Management Group Hierarchy |
| **ADR-006** | Enterprise Identity Strategy |
| **ADR-007** | Enterprise Monitoring and Observability |
| **ADR-008** | Enterprise Security Baseline |
| **ADR-010** | Enterprise Tagging Strategy |

---

# 22. References

- ARC-003 — Enterprise Reference Architecture
- REF-003 — Enterprise Platform Services Reference Architecture
- GOV-005 — Naming Convention
- GOV-008 — Tagging Strategy
- GOV-009 — Landing Zone Design
