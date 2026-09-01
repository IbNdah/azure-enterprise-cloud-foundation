# ADR-003 — Terraform as Infrastructure as Code

| **Attribute** | **Value** |
|---|---|
| **ADR ID** | ADR-003 |
| **Title** | Terraform as Infrastructure as Code |
| **Version** | 1.1 |
| **Status** | Accepted |
| **Date** | 2026-08-31 |
| **Authors** | Cloud Architecture Team |
| **Program** | OneCloud 2030 |
| **Organization** | Mandara Global |
| **Category** | Infrastructure as Code |

---

# 1. Executive Summary

Mandara Global will use **Terraform as the standard Infrastructure as Code (IaC) tool** for the Azure Enterprise Cloud Foundation.

Terraform will be used to define, provision and manage the foundation infrastructure in a repeatable and version-controlled manner.

This decision supports the Landing Zone architecture established by ADR-001 and applies across shared platform capabilities and managed Landing Zone infrastructure.

---

# 2. Business Context

The OneCloud 2030 program requires a cloud foundation that can be deployed consistently across environments and evolved through controlled changes.

Manual Azure provisioning creates risks including:

- configuration drift;
- inconsistent environments;
- limited change traceability;
- difficult repeatability;
- increased operational effort.

Infrastructure as Code provides a controlled mechanism for managing the platform and its lifecycle.

---

# 3. Problem Statement

The platform requires a single, repeatable approach for infrastructure provisioning and change management.

Without an IaC standard, teams may use different tools or manual processes, resulting in:

| Risk | Consequence |
|---|---|
| Configuration drift | Environments become inconsistent |
| Manual changes | Reduced traceability |
| Tool fragmentation | Increased operational complexity |
| Non-repeatable deployments | Slower onboarding and recovery |
| Undocumented infrastructure | Difficult maintenance |

A common IaC standard is therefore required.

---

# 4. Decision

Mandara Global will use **Terraform** as the standard IaC technology for the Azure Enterprise Cloud Foundation.

Terraform will manage:

- Azure platform capabilities;
- Landing Zone infrastructure;
- reusable infrastructure modules;
- networking components;
- governance resources;
- security resources;
- monitoring and operational resources;
- environment-specific configuration.

The repository will treat Terraform configuration as the authoritative definition of infrastructure managed by the project.

---

# 5. Implementation Model

The repository follows a layered Terraform structure:

```text
Terraform
│
├── Platform
│   ├── Management
│   ├── Connectivity
│   ├── Security
│   ├── Operations
│   └── Identity
│
├── Landing Zones
│   ├── Corp
│   ├── Online
│   └── Sandbox
│
├── Reusable Modules
│   ├── Networking
│   ├── Security
│   ├── Monitoring
│   └── Supporting Services
│
└── Environments
    ├── dev
    ├── test
    └── prod
```

The structure separates reusable implementation from platform capabilities, Landing Zones and environment configuration.

---

# 6. Terraform Principles

| Principle | Application |
|---|---|
| Version Control | Terraform configuration is stored in Git |
| Reproducibility | Infrastructure can be recreated from code |
| Reusability | Common resources are implemented as modules |
| Reviewability | Changes are reviewed before deployment |
| State Management | Terraform state is stored in the configured remote backend |
| Least Manual Change | Infrastructure changes should be made through Terraform |
| Separation of Configuration | Environment-specific values are separated from reusable code |

---

# 7. State Management

Terraform state is managed through the project's remote backend.

The state represents the relationship between Terraform configuration and deployed Azure resources.

The remote-state design provides:

- centralized state storage;
- controlled access;
- state locking where supported;
- separation of state from the source repository.

State files and sensitive state data are not committed to Git.

The remote-state approach is documented in TF-002.

---

# 8. Change Lifecycle

Infrastructure changes follow the general lifecycle:

```text
Change
  ↓
Terraform Code
  ↓
Validation
  ↓
Plan
  ↓
Review
  ↓
Apply
  ↓
Azure
  ↓
State
```

Terraform validation and planning should be performed before applying infrastructure changes.

Changes should be traceable through version control and code review.

---

# 9. Alternatives Considered

| Option | Decision | Rationale |
|---|---|---|
| **Manual Azure Portal** | Rejected | Not sufficiently repeatable or traceable |
| **Azure CLI / Scripts only** | Rejected as primary IaC | Useful for operational tasks but less suitable as the authoritative infrastructure model |
| **ARM / Bicep** | Not selected | Valid Azure-native alternatives, but Terraform better fits the project's multi-layer IaC and module model |
| **Terraform** | **Selected** | Mature declarative model, reusable modules and strong automation support |

The decision is specific to this project; it does not imply that Terraform is universally superior to Bicep or other IaC technologies.

---

# 10. Expected Benefits

| Area | Benefit |
|---|---|
| Consistency | Repeatable infrastructure |
| Governance | Infrastructure changes are controlled and reviewable |
| Automation | Reduced manual provisioning |
| Scalability | Reusable patterns for new environments and workloads |
| Recovery | Infrastructure can be recreated from code |
| Collaboration | Infrastructure changes are visible in version control |
| Operations | Reduced configuration drift |

---

# 11. Consequences

### Positive

- Infrastructure becomes version-controlled
- Deployments are repeatable
- Changes are reviewable
- Reusable modules reduce duplication
- Platform and Landing Zone infrastructure can follow the same lifecycle model
- Infrastructure can be validated before deployment

### Trade-offs

- Terraform requires state management
- Engineers need Terraform knowledge
- Provider and module versions require lifecycle management
- Some Azure operations may remain outside Terraform when they are not part of the managed infrastructure scope

The last point is intentional: Terraform is the authoritative tool for **managed infrastructure**, not a requirement to automate every possible Azure operation.

---

# 12. Scope and Boundaries

Terraform is responsible for infrastructure declared within this project.

It does not replace:

- Azure operational procedures;
- application deployment pipelines;
- incident management;
- identity governance processes;
- manual emergency procedures where explicitly required.

Any infrastructure created outside Terraform should have a documented reason and should be reconciled with the IaC model where appropriate.

---

# 13. Relationship to Other Decisions

| Document | Relationship |
|---|---|
| ADR-001 | Defines the Enterprise Landing Zone architecture |
| ADR-002 | Defines the network architecture implemented through Terraform |
| ADR-004 | Defines the Management Group hierarchy |
| ADR-005 | Defines private networking |
| ADR-006 | Defines enterprise identity |
| ADR-007 | Defines monitoring and observability |
| ADR-008 | Defines the security baseline |
| ADR-009 | Defines naming standards |
| ADR-010 | Defines tagging standards |

---

# 14. Review

This decision should be reviewed when significant changes occur to:

- the enterprise IaC strategy;
- Azure infrastructure management requirements;
- Terraform or provider capabilities;
- the cloud operating model;
- platform automation requirements.

---

# 15. References

- Terraform documentation
- Microsoft Azure documentation
- Microsoft Cloud Adoption Framework
- TF-001 — Terraform Foundation
- TF-002 — Remote State
- TF-003 — Repository Architecture
- TF-004 — Platform
- TF-005 — Landing Zones
- TF-006 — Reusable Modules
- TF-007 — Environment Structure & Deployment
- ADR-001 — Enterprise Landing Zone Architecture
