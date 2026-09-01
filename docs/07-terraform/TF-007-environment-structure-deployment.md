# TF-007 — Terraform Environment Structure & Deployment

| Attribute | Value |
|---|---|
| **Document ID** | TF-007 |
| **Title** | Terraform Environment Structure & Deployment |
| **Version** | 1.1 |
| **Status** | Accepted |
| **Date** | 2026-09-01 |
| **Authors** | Cloud Architecture Team |
| **Program** | OneCloud 2030 |
| **Organization** | Mandara Global |
| **Category** | Terraform / Deployment |

---

# 1. Executive Summary

Environment configuration provides the values required to deploy the Terraform infrastructure for different operating environments.

The current repository contains:

```text
terraform/environments/
├── dev.tfvars
├── test.tfvars
└── prod.tfvars
```

The environment files provide configuration values without duplicating the underlying Terraform structure.

Deployment follows the standard Terraform lifecycle:

```text
Environment Values
        │
        ▼
Terraform Configuration
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

---

# 2. Purpose

TF-007 defines how environments are represented and used during Terraform deployment.

It covers:

- environment configuration;
- separation of environment values from infrastructure code;
- deployment workflow;
- validation;
- plan and apply;
- relationship between environments, Platform Capabilities and Landing Zones.

It does not define the detailed architecture of the Platform or Landing Zones.

---

# 3. Environment Model

The project currently distinguishes:

| Environment | Code | Purpose |
|---|---|---|
| Development | `dev` | Development and integration |
| Test | `test` | Testing and validation |
| Production | `prod` | Production workloads |

These environment codes are used as Terraform configuration inputs.

They must not be confused with Landing Zone categories:

| Concept | Examples |
|---|---|
| **Environment** | `dev`, `test`, `prod` |
| **Landing Zone** | `corp`, `online`, `sandbox` |
| **Platform Capability** | Management, Connectivity, Security, Operations, Identity |

The three concepts serve different purposes.

---

# 4. Environment Configuration

Environment-specific values are stored under:

```text
terraform/environments/
```

Current files:

```text
dev.tfvars
test.tfvars
prod.tfvars
```

The files contain values that may differ between environments while the Terraform resource structure remains reusable.

Conceptually:

```text
                   Terraform Code
                         │
             ┌───────────┼───────────┐
             ▼           ▼           ▼
          dev.tfvars  test.tfvars  prod.tfvars
             │           │           │
             ▼           ▼           ▼
          Dev Deploy   Test Deploy  Prod Deploy
```

---

# 5. Environment Separation

Environment separation is achieved through configuration rather than by maintaining separate copies of the Terraform code.

Preferred model:

```text
                    Shared Terraform Code
                           │
          ┌────────────────┼────────────────┐
          ▼                ▼                ▼
        Dev Values      Test Values      Prod Values
          │                │                │
          ▼                ▼                ▼
        Dev State        Test State       Prod State
```

This reduces duplication and keeps infrastructure changes consistent across environments.

State separation remains subject to the deployment boundaries defined in **TF-002**.

---

# 6. Deployment Boundary

The Terraform root provides the deployment entry point.

The general relationship is:

```text
Terraform Root
      │
      ├── Platform
      │     ├── Management
      │     ├── Connectivity
      │     ├── Security
      │     ├── Operations
      │     └── Identity
      │
      └── Landing Zones
            ├── Corp
            ├── Online
            └── Sandbox
```

Environment values are supplied to this configuration at deployment time.

The environment does not create a separate architecture layer.

---

# 7. Standard Deployment Workflow

The standard workflow is:

```text
1. Select Environment
        │
        ▼
2. Initialize Terraform
        │
        ▼
3. Format Configuration
        │
        ▼
4. Validate Configuration
        │
        ▼
5. Generate Plan
        │
        ▼
6. Review Plan
        │
        ▼
7. Apply Approved Changes
```

Typical commands:

```bash
terraform init

terraform fmt -check

terraform validate

terraform plan -var-file="environments/dev.tfvars"

terraform apply -var-file="environments/dev.tfvars"
```

The environment file changes for the target environment.

For example:

```bash
terraform plan -var-file="environments/test.tfvars"
terraform plan -var-file="environments/prod.tfvars"
```

---

# 8. Initialization

Terraform must be initialized before planning or applying infrastructure.

```bash
terraform init
```

Initialization configures:

- the Terraform backend;
- required providers;
- required modules.

The remote backend is defined in **TF-002**.

---

# 9. Formatting and Validation

Before creating a plan, the configuration should be formatted and validated.

```bash
terraform fmt -check
terraform validate
```

Formatting ensures consistent Terraform source code.

Validation checks the Terraform configuration before infrastructure changes are planned.

Validation does not replace review of the generated plan.

---

# 10. Terraform Plan

A plan should be generated for the target environment.

Example:

```bash
terraform plan -var-file="environments/dev.tfvars"
```

The plan should be reviewed before applying changes.

The review should pay particular attention to:

- unexpected resource creation;
- unexpected resource destruction;
- changes to shared Platform Capabilities;
- changes affecting Landing Zones;
- naming and tagging;
- security-related changes.

---

# 11. Terraform Apply

Approved plans can be applied using:

```bash
terraform apply -var-file="environments/dev.tfvars"
```

Production changes should follow the same review discipline as development and test changes.

The environment file identifies the configuration context; Terraform state records the deployed infrastructure.

---

# 12. Platform and Landing Zone Deployment

The same environment configuration mechanism supports both Platform and Landing Zone infrastructure.

```text
Environment
     │
     ▼
Terraform Root
     │
     ├──────────────► Platform Capabilities
     │
     └──────────────► Landing Zones
```

Shared Platform changes should be evaluated for their effect on Landing Zone consumers.

Landing Zone changes should not modify shared Platform resources unless explicitly part of the intended configuration.

---

# 13. Environment-Specific Values

Values that commonly vary by environment include:

- resource names;
- Azure locations where applicable;
- address spaces;
- resource identifiers;
- feature configuration;
- environment-specific tags or metadata.

Enterprise standards such as naming and tagging remain governed centrally.

The environment file should provide values, not redefine enterprise policy.

---

# 14. Secrets and Sensitive Values

Secrets should not be stored directly in environment files committed to Git.

The environment configuration must not contain:

- passwords;
- access keys;
- client secrets;
- certificates;
- other sensitive credentials.

Sensitive information should use appropriate Azure identity and secret-management mechanisms.

Terraform state must also be treated as sensitive infrastructure data, as defined in **TF-002**.

---

# 15. Production Deployment

Production deployment follows the same technical workflow:

```text
prod.tfvars
     │
     ▼
terraform plan
     │
     ▼
Review / Approval
     │
     ▼
terraform apply
```

The project does not require a separate Terraform implementation for production.

Additional approval or CI/CD controls may be introduced by the operating model where required.

---

# 16. Change Management

Changes should be made to the shared Terraform configuration rather than by copying and modifying environment-specific infrastructure code.

Preferred:

```text
Shared Code
    │
    ├── dev
    ├── test
    └── prod
```

Avoid:

```text
dev/
test/
prod/
    └── duplicated Terraform code
```

This keeps the environments structurally consistent while allowing controlled differences in configuration.

---

# 17. Deployment Safety

Before applying a change:

| Check | Objective |
|---|---|
| `terraform fmt` | Consistent source formatting |
| `terraform validate` | Valid Terraform configuration |
| `terraform plan` | Understand infrastructure changes |
| Plan review | Detect unintended changes |
| State lock | Prevent concurrent state modification |
| Correct `.tfvars` | Ensure the intended environment is targeted |

The correct environment must always be explicitly identified before applying infrastructure changes.

---

# 18. Environment Lifecycle

The environment lifecycle is:

```text
Configuration
     │
     ▼
Validation
     │
     ▼
Plan
     │
     ▼
Approval / Review
     │
     ▼
Apply
     │
     ▼
Operate
     │
     ▼
Change / Update
     │
     ▼
Retire
```

Environment retirement must be handled as an intentional infrastructure change and must consider the associated Terraform state and Azure resources.

---

# 19. Design Principles

| Principle | Application |
|---|---|
| **Shared Code** | Avoid duplicated Terraform implementations |
| **Explicit Environment** | Target environments explicitly through configuration |
| **Repeatability** | Use the same workflow across environments |
| **Reviewability** | Review plans before applying changes |
| **Isolation** | Maintain appropriate state and deployment boundaries |
| **Security** | Keep secrets out of configuration and source control |
| **Pragmatism** | Avoid additional environment abstractions without a real need |

---

# 20. Benefits and Trade-offs

| Benefits | Trade-offs |
|---|---|
| Consistent infrastructure across environments | Environment-specific differences must be controlled |
| Reduced code duplication | Shared code changes can affect several environments |
| Repeatable deployments | Terraform state must be managed correctly |
| Clear deployment workflow | Production changes require disciplined review |
| Easy environment selection | Incorrect `.tfvars` selection can target the wrong environment |

---

# 21. Scope and Boundaries

TF-007 defines environment configuration and the Terraform deployment workflow.

It does not define:

- remote state architecture;
- Platform Capability implementation;
- Landing Zone architecture;
- reusable module design;
- bootstrap implementation;
- application deployment pipelines.

These are covered by TF-002, TF-004, TF-005, TF-006 and TF-008.

---

# 22. Related Documents

| Document | Relationship |
|---|---|
| **TF-001** | Terraform Foundation |
| **TF-002** | Remote State |
| **TF-003** | Repository Architecture |
| **TF-004** | Terraform Platform |
| **TF-005** | Terraform Landing Zones |
| **TF-006** | Reusable Modules |
| **TF-008** | Bootstrap |
| **GOV-003** | Subscription Strategy |
| **GOV-005** | Naming Convention |
| **GOV-008** | Tagging Strategy |
| **ADR-003** | Terraform as Infrastructure as Code |

---

# 23. References

- Terraform documentation
- AzureRM provider documentation
- ARC-002 — High-Level Architecture
- ARC-003 — Enterprise Reference Architecture
- TF-001 — Terraform Foundation
- TF-002 — Remote State
