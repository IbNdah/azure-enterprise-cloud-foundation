# TF-002 — Terraform Remote State

| Attribute | Value |
|---|---|
| **Document ID** | TF-002 |
| **Title** | Terraform Remote State |
| **Version** | 1.1 |
| **Status** | Accepted |
| **Date** | 2026-09-01 |
| **Authors** | Cloud Architecture Team |
| **Program** | OneCloud 2030 |
| **Organization** | Mandara Global |
| **Category** | Terraform / State Management |

---

# 1. Executive Summary

Terraform state is stored remotely in **Azure Storage** rather than in the source repository.

Remote state provides a shared and durable state location for Terraform operations and prevents state files from being managed as source-code artifacts.

The current foundation uses an Azure Storage backend and keeps backend configuration separate from the Terraform resource definitions.

---

# 2. Purpose

This document defines the remote state model used by the Azure Enterprise Cloud Foundation.

It covers:

- state storage;
- backend configuration;
- state security;
- state separation;
- operational handling of Terraform state.

It does not define the complete Terraform repository structure or Landing Zone deployment model.

---

# 3. Remote State Architecture

The Terraform configuration is stored in Git, while Terraform state is stored remotely.

```text
                    Git Repository
                          │
                          │ Terraform Configuration
                          ▼
                   Terraform Root
                          │
                          │ State
                          ▼
                Azure Storage Backend
                          │
                          ▼
                 Terraform State File
```

The state is therefore separated from the source repository.

---

# 4. Azure Storage Backend

The project uses the AzureRM backend for remote state.

The backend configuration is maintained under:

```text
terraform/backend/
└── backend.hcl
```

The backend configuration is consumed during Terraform initialization.

A simplified configuration follows this model:

```hcl
resource_group_name  = "<state-resource-group>"
storage_account_name = "<state-storage-account>"
container_name       = "<state-container>"
key                  = "<state-key>"
```

Actual environment-specific values must not be hard-coded into this reference document.

---

# 5. State Separation

Terraform state should be separated according to the infrastructure boundary it represents.

For the current project, the state model should remain simple and aligned with the actual Terraform root and deployment structure.

```text
Terraform Root
      │
      ▼
Remote Backend
      │
      ├── Foundation / Platform State
      │
      └── Landing Zone State
           ├── Corp
           ├── Online
           └── Sandbox
```

The exact number of state files and keys depends on the implemented deployment boundaries.

State separation should be introduced when it provides a clear operational or ownership benefit rather than simply increasing the number of state files.

---

# 6. State Key Convention

State keys should be:

- unique within the backend container;
- predictable;
- associated with the Terraform deployment boundary;
- independent from local workstation paths.

Examples:

```text
platform.tfstate
landingzones/corp.tfstate
landingzones/online.tfstate
landingzones/sandbox.tfstate
```

These are reference examples. The actual keys must match the implemented deployment configuration.

---

# 7. State Security

Terraform state can contain sensitive infrastructure information.

The state storage therefore requires appropriate access controls.

Minimum controls include:

| Control | Purpose |
|---|---|
| **Private / controlled access** | Limit access to the state storage |
| **RBAC** | Control who can read or modify state |
| **Encryption at rest** | Protect stored state |
| **No Git storage** | Prevent state files entering source control |
| **Access auditing** | Support operational accountability |

State access should follow the enterprise identity and RBAC model.

---

# 8. State Locking and Concurrency

Terraform operations should avoid concurrent modification of the same state.

The AzureRM backend provides state locking through Azure Storage mechanisms.

The operational principle is:

```text
Engineer A ──┐
             ├──► Terraform Backend ──► State
Engineer B ──┘
                    │
                    ▼
              Lock / Coordination
```

Only one operation should modify a given state at a time.

---

# 9. Backend Bootstrap Boundary

The resources required to host Terraform state are a special bootstrap concern.

The bootstrap process may need to establish:

```text
Bootstrap
    │
    ├── Resource Group
    ├── Storage Account
    └── Blob Container
             │
             ▼
        Terraform State
```

The state backend must exist before the Terraform configuration that depends on it can use it.

Bootstrap details are documented separately in **TF-008**.

---

# 10. Environment and State

Environment configuration and Terraform state are separate concepts.

```text
Environment
    │
    └── dev / test / prod
            │
            ▼
       Terraform Values
            │
            ▼
       Terraform Deployment
            │
            ▼
       Remote State
```

An environment variable file does not itself define or contain Terraform state.

The deployment model and environment structure are documented in **TF-007**.

---

# 11. State Lifecycle

The intended lifecycle is:

```text
terraform init
       │
       ▼
Backend Connection
       │
       ▼
terraform plan
       │
       ▼
terraform apply
       │
       ▼
State Updated
       │
       ▼
Remote Azure Storage
```

State should not be manually edited.

If state recovery or migration is required, it should be handled using Terraform-supported state operations and a controlled change process.

---

# 12. Backup and Recovery

The state backend should use appropriate Azure Storage protection according to the platform's operational requirements.

State recovery procedures should be tested before they are required in production.

The exact backup and retention configuration belongs to the implementation of the state storage and is not prescribed by this reference document.

---

# 13. Design Principles

| Principle | Application |
|---|---|
| **Remote State** | Keep state outside source control |
| **Controlled Access** | Restrict state access through identity and RBAC |
| **Predictability** | Use clear backend and state key conventions |
| **Separation** | Separate state where deployment boundaries justify it |
| **Simplicity** | Avoid unnecessary state fragmentation |
| **Recoverability** | Maintain appropriate storage protection |
| **Automation** | Initialize and operate state through standard Terraform workflows |

---

# 14. Common Operational Rules

The following rules apply to the repository:

1. Do not commit `.tfstate` files to Git.
2. Do not commit sensitive backend credentials.
3. Do not manually modify remote state.
4. Do not share state access more broadly than required.
5. Do not create separate state files without a clear boundary.
6. Review backend changes as infrastructure changes.

---

# 15. Implementation Alignment

The repository currently contains:

```text
terraform/
├── backend/
│   ├── backend.hcl
│   └── README.md
│
├── main.tf
├── providers.tf
├── variables.tf
└── versions.tf
```

The backend is therefore separated from the main Terraform resource configuration.

Detailed repository structure is described in **TF-003**.

---

# 16. Relationship to Architecture

Remote state is an implementation concern supporting the Infrastructure as Code architecture.

```text
Enterprise Architecture
        │
        ▼
Infrastructure as Code
        │
        ▼
Terraform
        │
        ├── Configuration → Git
        │
        └── State → Azure Storage
```

Remote state does not change the enterprise architecture hierarchy or the distinction between Platform Capabilities, Landing Zones, subscriptions and resources.

---

# 17. Benefits and Trade-offs

| Benefits | Trade-offs |
|---|---|
| Shared state access | Requires backend availability |
| Durable state storage | State access must be secured |
| Separation from Git | Backend requires bootstrap |
| State locking | Operational access must be controlled |
| Supports collaborative Terraform operations | State structure requires lifecycle management |

The model intentionally avoids introducing additional state-management infrastructure unless required by the project.

---

# 18. Related Documents

| Document | Relationship |
|---|---|
| **ADR-003** | Terraform as Infrastructure as Code |
| **TF-001** | Terraform Foundation |
| **TF-003** | Repository Architecture |
| **TF-007** | Environment Structure & Deployment |
| **TF-008** | Bootstrap |

---

# 19. References

- Terraform documentation
- Azure Storage documentation
- AzureRM Terraform Backend
- Microsoft Azure security and RBAC guidance
