# TF-008 — Terraform Bootstrap

| Attribute | Value |
|---|---|
| **Document ID** | TF-008 |
| **Title** | Terraform Bootstrap |
| **Version** | 1.1 |
| **Status** | Accepted |
| **Date** | 2026-09-01 |
| **Authors** | Cloud Architecture Team |
| **Program** | OneCloud 2030 |
| **Organization** | Mandara Global |
| **Category** | Terraform / Bootstrap |

---

# 1. Executive Summary

Terraform Bootstrap establishes the minimum Azure infrastructure required before the main Terraform configuration can operate.

The primary bootstrap dependency is the **remote Terraform state backend**.

The bootstrap boundary is intentionally small:

```text
Bootstrap
    │
    ├── State Resource Group
    ├── State Storage Account
    └── State Container
             │
             ▼
       Terraform Remote State
             │
             ▼
       Main Terraform Configuration
```

Bootstrap is therefore a prerequisite to the normal Terraform lifecycle rather than a second implementation of the platform.

---

# 2. Purpose

TF-008 defines the bootstrap boundary and the sequence required to establish the Terraform operating foundation.

It covers:

- remote state prerequisites;
- bootstrap resources;
- initialization order;
- bootstrap responsibilities;
- transition to normal Terraform management.

It does not define the complete Platform, Landing Zone or reusable module architecture.

---

# 3. Bootstrap Problem

Terraform cannot use a remote backend before the backend infrastructure exists.

This creates an initial dependency:

```text
             Terraform
                 │
                 ▼
        Needs Remote Backend
                 │
                 ▼
        Backend must already exist
                 │
                 ▼
              Bootstrap
```

Bootstrap resolves this initial dependency.

Once the backend is available, the normal Terraform configuration can be initialized against it.

---

# 4. Bootstrap Scope

The bootstrap scope is deliberately limited to the resources required to establish Terraform's operating foundation.

| Resource | Purpose |
|---|---|
| **Resource Group** | Hosts Terraform state storage |
| **Storage Account** | Provides durable state storage |
| **Blob Container** | Stores Terraform state |

The exact resource names, location and configuration are implementation details and must follow the enterprise naming, tagging and security standards.

---

# 5. Bootstrap Architecture

```text
                         Azure
                           │
                           ▼
                 Bootstrap Resources
                           │
                ┌──────────┴──────────┐
                ▼                     ▼
        Resource Group          Storage Account
                                      │
                                      ▼
                                Blob Container
                                      │
                                      ▼
                              Terraform State
                                      │
                                      ▼
                              Main Terraform
```

Bootstrap resources form the minimal dependency required for remote state.

---

# 6. Initialization Sequence

The overall sequence is:

```text
1. Bootstrap backend infrastructure
              │
              ▼
2. Configure backend
              │
              ▼
3. terraform init
              │
              ▼
4. terraform validate
              │
              ▼
5. terraform plan
              │
              ▼
6. Review
              │
              ▼
7. terraform apply
```

The main Terraform configuration should not attempt to use a remote backend that has not yet been established.

---

# 7. Bootstrap and Remote State

Bootstrap is directly related to **TF-002 — Remote State**.

```text
TF-008 Bootstrap
       │
       ▼
Azure Storage Backend
       │
       ▼
TF-002 Remote State
       │
       ▼
Terraform Operations
```

Bootstrap creates the infrastructure.

TF-002 defines how that infrastructure is used as the Terraform backend.

---

# 8. Bootstrap and Main Terraform Configuration

Bootstrap and the main Terraform configuration have different responsibilities.

| Bootstrap | Main Terraform |
|---|---|
| Creates the initial state backend | Uses the remote backend |
| Establishes Terraform prerequisites | Manages Platform and Landing Zones |
| Runs before normal initialization | Runs the normal Terraform lifecycle |
| Minimal infrastructure scope | Full enterprise infrastructure scope |

The bootstrap layer should not become a parallel implementation of resources already managed by the main Terraform configuration.

---

# 9. State Backend Security

The bootstrap storage account contains Terraform state and must therefore be treated as sensitive infrastructure.

The implementation should apply the relevant enterprise controls, including:

- controlled identity access;
- RBAC;
- encryption;
- appropriate storage security settings;
- auditing where required.

Credentials should not be embedded in the repository.

The detailed state security model is defined in **TF-002**.

---

# 10. Naming and Tagging

Bootstrap resources follow the enterprise naming and tagging standards.

Relevant standards include:

- **GOV-005 — Naming Convention**
- **GOV-008 — Tagging Strategy**
- **ADR-009 — Enterprise Naming Convention Standard**
- **ADR-010 — Enterprise Tagging Strategy**

Example:

```text
rg-tfstate-prod-001
sttfstateprod001
```

These are illustrative examples only. The actual implementation must use the approved naming pattern and valid Azure naming constraints.

Required enterprise tags should be applied consistently to supported resources.

---

# 11. Access and Ownership

Access to bootstrap resources should be restricted to the identities responsible for managing Terraform infrastructure.

Conceptually:

```text
Terraform Operators
        │
        ▼
Identity / RBAC
        │
        ▼
Terraform State Storage
```

The bootstrap backend should not be treated as general-purpose application storage.

---

# 12. Bootstrap Lifecycle

Bootstrap infrastructure has a different lifecycle from normal workload infrastructure.

```text
Bootstrap
    │
    ▼
Backend Available
    │
    ▼
Platform / Landing Zones
    │
    ▼
Normal Terraform Operations
```

The backend should normally remain available for as long as the associated Terraform state is required.

Destroying the backend without first handling the dependent Terraform state can prevent normal Terraform operations.

---

# 13. Operational Considerations

Before changing or removing bootstrap resources:

1. Identify all Terraform states using the backend.
2. Confirm that the backend is no longer required or prepare an appropriate migration.
3. Preserve required state data.
4. Validate access and recovery options.
5. Apply the change through a controlled process.

The project does not prescribe a separate backup platform. Appropriate Azure Storage protection should be configured according to the operational requirements.

---

# 14. Design Principles

| Principle | Application |
|---|---|
| **Minimal Scope** | Bootstrap only what Terraform needs to operate |
| **Clear Boundary** | Separate backend prerequisites from normal infrastructure |
| **Security** | Protect state storage and access |
| **Repeatability** | Keep bootstrap configuration reproducible |
| **No Duplication** | Do not recreate main Terraform resources unnecessarily |
| **Recoverability** | Protect state according to operational requirements |
| **Pragmatism** | Avoid a complex bootstrap framework without a clear need |

---

# 15. Benefits and Trade-offs

| Benefits | Trade-offs |
|---|---|
| Resolves the remote-state bootstrap dependency | Requires an initial bootstrap step |
| Keeps the main Terraform configuration clean | Bootstrap has a separate lifecycle |
| Provides durable state storage | Backend availability becomes an operational dependency |
| Clear security boundary | State storage requires controlled access |
| Simple to understand and operate | Backend migration requires planning |

---

# 16. Scope and Boundaries

TF-008 covers the bootstrap prerequisites for Terraform remote state.

It does not define:

- Platform Capability implementation;
- Landing Zone implementation;
- reusable modules;
- environment configuration;
- application deployment;
- complete CI/CD architecture.

Those concerns are covered by the corresponding Terraform and architecture documents.

---

# 17. Related Documents

| Document | Relationship |
|---|---|
| **TF-001** | Terraform Foundation |
| **TF-002** | Remote State |
| **TF-003** | Repository Architecture |
| **TF-004** | Terraform Platform |
| **TF-005** | Terraform Landing Zones |
| **TF-006** | Reusable Modules |
| **TF-007** | Environment Structure & Deployment |
| **GOV-005** | Naming Convention |
| **GOV-008** | Tagging Strategy |
| **ADR-003** | Terraform as Infrastructure as Code |

---

# 18. References

- Terraform documentation
- Azure Storage documentation
- AzureRM backend documentation
- ARC-003 — Enterprise Reference Architecture
- TF-002 — Remote State
