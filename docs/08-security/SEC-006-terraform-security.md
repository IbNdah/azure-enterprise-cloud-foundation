# SEC-006 — Terraform Security

## Objective
Protect the Terraform Infrastructure as Code lifecycle against configuration errors, insecure IaC patterns, and accidental exposure of sensitive data.

## Controls

| Control | Implementation |
|---|---|
| Formatting | `terraform fmt -check -recursive` |
| Validation | `terraform validate` |
| Initialization | `terraform init -backend=false` in CI |
| IaC security scan | Trivy configuration scan |
| Secret protection | `*.tfvars`, state and plan files excluded from Git |
| Remote state | Azure Storage backend |
| CI permissions | `contents: read` |

## CI Flow

```text
Pull Request / Push
        │
        ├── Terraform fmt
        ├── Terraform init
        ├── Terraform validate
        └── Trivy IaC scan
```

The CI performs validation and security scanning only. It does **not** execute `terraform apply`.

## Status
**Implemented — local validation passed.**
