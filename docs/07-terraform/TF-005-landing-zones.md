# TF-005 — Terraform Landing Zones

| Attribute | Value |
|---|---|
| **Document ID** | TF-005 |
| **Title** | Terraform Landing Zones |
| **Version** | 1.1 |
| **Status** | Accepted |
| **Date** | 2026-09-01 |
| **Authors** | Cloud Architecture Team |
| **Program** | OneCloud 2030 |
| **Organization** | Mandara Global |
| **Category** | Terraform / Landing Zones |

---

# 1. Executive Summary

Landing Zones provide the governed infrastructure boundary for Azure workloads.

In the Terraform repository, Landing Zones are represented by three architectural categories:

```text
terraform/landingzones/

├── corp/
├── online/
└── sandbox/
```

The Landing Zone model is aligned with the enterprise architecture and governance framework.

Landing Zones consume shared Platform Capabilities and reusable Terraform modules while retaining ownership of workload-specific infrastructure.

---

# 2. Purpose

TF-005 defines the Terraform structure and implementation principles for Landing Zones.

It establishes:

- Landing Zone boundaries;
- relationship with Platform Capabilities;
- relationship with subscriptions and resource groups;
- environment handling;
- reusable module consumption;
- workload ownership.

It does not define the detailed application architecture of individual workloads.

---

# 3. Landing Zone Model

The enterprise Landing Zone model is:

```text
                    Azure Tenant
                         │
                         ▼
                 Enterprise Governance
                         │
                         ▼
                   Landing Zones
              ┌──────────┼──────────┐
              │          │          │
             Corp       Online     Sandbox
              │          │          │
              ▼          ▼          ▼
        Subscriptions Subscriptions Subscriptions
              │          │          │
              ▼          ▼          ▼
          Workloads   Workloads   Workloads
```

The three Landing Zone categories are architectural boundaries.

They are not Management Groups.

---

# 4. Terraform Structure

The current implementation structure is:

```text
terraform/landingzones/
├── corp/
├── online/
└── sandbox/
```

Each directory represents a Landing Zone category.

The implementation can evolve as additional workload requirements emerge, without changing the enterprise Landing Zone model.

---

# 5. Landing Zone Responsibilities

| Landing Zone | Primary Purpose | Typical Workloads |
|---|---|---|
| **Corp** | Internal enterprise workloads | Business applications, internal services |
| **Online** | Externally accessible workloads | Internet-facing applications and services |
| **Sandbox** | Controlled experimentation | Development, testing and experimentation |

The category describes the intended workload boundary. It does not prescribe every Azure service or network configuration.

---

# 6. Landing Zones and Environments

Environment and Landing Zone are separate concepts.

```text
Landing Zone
     │
     ├── Corp
     ├── Online
     └── Sandbox
            │
            ▼
      Environment Context
      ├── dev
      ├── test
      └── prod
```

An environment identifies the lifecycle stage or operating context of a deployment.

A Landing Zone identifies the type of governed workload environment.

Therefore:

```text
Corp ≠ Production
Online ≠ Non-Production
Sandbox ≠ Environment
```

Production and Non-Production are environment classifications, while Corp, Online and Sandbox are Landing Zone classifications.

The exact combination used by a workload depends on the enterprise deployment model.

---

# 7. Relationship with Platform Capabilities

Landing Zones consume shared services provided by the Platform layer.

```text
                 Shared Platform
                       │
       ┌───────────────┼───────────────┐
       │               │               │
       ▼               ▼               ▼
  Management      Connectivity      Security
       │               │               │
       └───────────────┼───────────────┘
                       │
                ┌──────┴──────┐
                ▼             ▼
           Operations      Identity
                │             │
                └──────┬──────┘
                       ▼
                 Landing Zone
                       │
                       ▼
                    Workload
```

The Landing Zone does not recreate shared platform services unless a specific workload requirement justifies it.

---

# 8. Subscription Boundary

A Landing Zone is deployed into one or more Azure subscriptions according to the enterprise subscription strategy.

```text
Landing Zone
      │
      ▼
Subscription
      │
      ▼
Resource Groups
      │
      ▼
Resources
```

Subscription structure is governed by **GOV-003**.

Terraform should treat subscription boundaries as deployment and governance boundaries rather than simply as another resource type.

---

# 9. Resource Group Organization

Workload resources are organized into Resource Groups according to the enterprise resource organization strategy.

Example:

```text
Corp Landing Zone
       │
       ▼
Subscription
       │
       ├── rg-app-prod-001
       ├── rg-data-prod-001
       └── rg-monitor-prod-001
```

Resource Group naming and organization follow **GOV-004** and **GOV-005**.

The exact grouping should reflect workload ownership and lifecycle rather than creating Resource Groups without a clear boundary.

---

# 10. Terraform Module Usage

Landing Zones consume reusable modules where appropriate.

```text
Landing Zone
     │
     ▼
Reusable Module
     │
     ▼
Azure Resource
```

For example:

```text
Corp
 │
 ├── virtual-network module
 ├── subnet module
 ├── network-security-group module
 └── private-endpoint module
```

Modules provide reusable implementation patterns.

Landing Zone configuration provides the context in which those modules are used.

---

# 11. Workload Boundary

Landing Zones provide the foundation for workload teams.

The responsibility boundary is:

| Platform / Landing Zone Foundation | Workload |
|---|---|
| Shared connectivity | Application-specific connectivity |
| Enterprise identity integration | Application authorization |
| Shared security controls | Application-specific security |
| Central monitoring | Application monitoring |
| Resource organization | Application resources |
| Governance controls | Business/application configuration |

The boundary allows platform standardization without taking ownership of application-specific concerns.

---

# 12. Network Integration

Landing Zones integrate with the shared Connectivity capability.

Typical architecture:

```text
                 Connectivity Capability
                          │
                          ▼
                       Hub VNet
                          │
             ┌────────────┼────────────┐
             ▼            ▼            ▼
          Corp Spoke   Online Spoke  Sandbox Spoke
             │            │            │
             ▼            ▼            ▼
          Workloads    Workloads    Workloads
```

The exact network topology depends on workload requirements and the connectivity architecture defined in **REF-002**.

---

# 13. Security and Governance

Landing Zones inherit enterprise governance controls.

These include, where applicable:

- Management Group policies;
- Azure Policy;
- RBAC;
- naming standards;
- tagging standards;
- network controls;
- monitoring requirements.

Landing Zones must not bypass enterprise governance to achieve workload-specific flexibility.

Exceptions should follow the established governance process.

---

# 14. Environment-Specific Configuration

Environment-specific values are supplied through the Terraform environment configuration.

Current repository examples include:

```text
terraform/environments/
├── dev.tfvars
├── test.tfvars
└── prod.tfvars
```

The Landing Zone structure remains reusable while values can vary between environments.

The exact deployment model is defined in **TF-007**.

---

# 15. Landing Zone Lifecycle

The intended lifecycle is:

```text
Design
  │
  ▼
Landing Zone Configuration
  │
  ▼
Terraform Plan
  │
  ▼
Review
  │
  ▼
Terraform Apply
  │
  ▼
Azure Workload Environment
  │
  ▼
Change / Operate
  │
  ▼
Decommission
```

Lifecycle management should preserve the separation between shared platform infrastructure and workload infrastructure.

---

# 16. Naming and Tagging

Landing Zone resources follow the enterprise naming and tagging standards.

Relevant governance documents include:

- **GOV-005 — Naming Convention**
- **GOV-008 — Tagging Strategy**

Example resource naming:

```text
rg-app-prod-001
vnet-app-prod-001
nsg-app-prod-001
```

Examples are illustrative. Actual resource names must follow the applicable enterprise naming pattern.

Tags should identify required enterprise metadata such as environment, owner and cost allocation where defined by the tagging standard.

---

# 17. Design Principles

| Principle | Application |
|---|---|
| **Governed by Default** | Landing Zones inherit enterprise controls |
| **Clear Boundaries** | Landing Zone, subscription and workload boundaries remain explicit |
| **Shared Platform** | Common services are consumed rather than duplicated |
| **Reusable Infrastructure** | Common resource patterns use modules |
| **Workload Autonomy** | Application teams retain application-specific ownership |
| **Environment Separation** | Environment values remain separate from structural definitions |
| **Pragmatism** | No additional Landing Zone abstraction without a clear requirement |

---

# 18. Benefits and Trade-offs

| Benefits | Trade-offs |
|---|---|
| Consistent workload foundations | Requires adherence to enterprise standards |
| Clear workload boundaries | Additional structure compared with unmanaged subscriptions |
| Reusable Terraform patterns | Modules require maintenance |
| Shared platform integration | Platform changes may affect consumers |
| Controlled experimentation | Sandbox still requires governance |

---

# 19. Scope and Boundaries

TF-005 covers the Terraform Landing Zone layer.

It does not define:

- detailed application architecture;
- detailed network implementation;
- reusable module interfaces;
- remote state configuration;
- bootstrap implementation;
- CI/CD implementation.

These topics are covered by the relevant architecture and Terraform documents.

---

# 20. Related Documents

| Document | Relationship |
|---|---|
| **GOV-003** | Subscription Strategy |
| **GOV-004** | Resource Organization Strategy |
| **GOV-005** | Naming Convention |
| **GOV-008** | Tagging Strategy |
| **GOV-009** | Landing Zone Design |
| **ADR-001** | Enterprise Landing Zone Architecture |
| **ADR-004** | Enterprise Management Group Hierarchy |
| **ADR-005** | Private Networking Strategy |
| **TF-001** | Terraform Foundation |
| **TF-003** | Repository Architecture |
| **TF-004** | Terraform Platform |
| **TF-006** | Reusable Modules |
| **TF-007** | Environment Structure & Deployment |
| **TF-008** | Bootstrap |
| **REF-001** | Enterprise Landing Zone Reference Architecture |
| **REF-002** | Enterprise Connectivity Reference Architecture |

---

# 21. References

- Microsoft Cloud Adoption Framework
- Azure Landing Zones
- Azure Architecture Center
- ARC-002 — High-Level Architecture
- ARC-003 — Enterprise Reference Architecture
