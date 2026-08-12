# Terraform Foundation

This directory contains the Infrastructure as Code (IaC) implementation of the Azure Enterprise Cloud Foundation.

The Terraform codebase is organized around enterprise platform capabilities rather than individual Azure resources.

## Structure

```text
terraform/

├── backend/          # Remote state configuration
├── environments/     # Environment-specific configuration
├── modules/          # Reusable Terraform modules
├── platform/         # Enterprise platform capabilities
│   ├── management/
│   ├── connectivity/
│   ├── identity/
│   ├── security/
│   └── operations/
├── landingzones/     # Business workload landing zones
│   ├── corp/
│   ├── online/
│   └── sandbox/
│
├── locals.tf
├── main.tf
├── providers.tf
├── variables.tf
└── versions.tf
```

## Design Principles

- Modular and reusable Terraform modules
- Platform capabilities before workloads
- Infrastructure as Code by default
- Incremental implementation aligned with the enterprise architecture

## Status

| Capability | Status |
|------------|:------:|
| Terraform Foundation | ✅ |
| Platform Services | 🚧 |
| Identity | ⏳ |
| Operations | ⏳ |
