# Terraform Foundation

This directory contains the Infrastructure as Code (IaC) implementation of the Azure Enterprise Cloud Foundation.

The Terraform codebase follows a layered architecture that separates enterprise orchestration, platform capabilities, reusable infrastructure modules, and business landing zones.

## Architecture

```text
                         terraform/main.tf
                      (Platform Orchestrator)
                               │
        ┌──────────────────────┼──────────────────────┐
        ▼                      ▼                      ▼
   Platform               Reusable              Landing
  Capabilities              Modules               Zones
        │
        ▼
 Dedicated Resource
 Groups per Capability
```

## Repository Structure

```text
terraform/

├── backend/                # Remote state configuration
├── environments/           # Environment-specific configuration
├── landingzones/           # Business workload deployments
│   ├── corp/
│   ├── online/
│   └── sandbox/
│
├── modules/                # Reusable Azure resource modules
│   ├── diagnostic-settings/
│   ├── key-vault/
│   ├── logs-analytics/
│   ├── monitor/
│   ├── network-security-group/
│   ├── policies/
│   ├── private-endpoint/
│   ├── recovery-services/
│   ├── resource-group/
│   ├── role-assignment/
│   ├── storage-account/
│   ├── subnet/
│   └── virtual-network/
│
├── platform/               # Enterprise platform capabilities
│   ├── management/
│   ├── connectivity/
│   ├── security/
│   ├── operations/
│   └── identity/
│
├── locals.tf               # Enterprise metadata and common tags
├── main.tf                 # Platform capability orchestrator
├── providers.tf            # Terraform providers
├── variables.tf            # Global deployment variables
└── versions.tf             # Terraform version constraints
```

## Platform Capabilities

Each platform capability owns a dedicated Resource Group and its associated resources.

| Capability | Resource Group |
|---|---|
| Management | `rg-platform-management-<env>-001` |
| Connectivity | `rg-platform-connectivity-<env>-001` |
| Security | `rg-platform-security-<env>-001` |
| Operations | `rg-platform-operations-<env>-001` |
| Identity | `rg-platform-identity-<env>-001` |

## Governance

Governance controls are implemented within the Management capability using the reusable `policies` Terraform module.

The foundation currently enforces:

- Allowed resource locations
- Required resource tags (`Project`, `ManagedBy`)

Policy definitions and subscription-level assignments are managed exclusively through Terraform.

## Initialization

Initialize Terraform using the remote Azure Storage backend:

```bash
terraform init --backend-config=./backend/backend.hcl
```

Common validation workflow:

```bash
terraform fmt -recursive
terraform validate
terraform plan
```

## Layer Responsibilities

| Layer | Responsibility |
|---|---|
| **Root** | Enterprise metadata and platform capability orchestration |
| **Platform** | Capability orchestration and Resource Group ownership |
| **Modules** | Reusable Azure resource implementation |
| **Landing Zones** | Business workload infrastructure |

## Design Principles

- Infrastructure as Code by default
- Layered Terraform architecture
- Reusable resource modules
- Platform capability ownership
- Centralized enterprise metadata
- Consistent resource tagging
- Governance through policy-as-code
- Clear separation of responsibilities

## Current Status

| Capability | Status |
|---|:---:|
| Terraform Foundation | ✅ |
| Management | ✅ |
| Connectivity | ✅ |
| Security | ✅ |
| Operations | ✅ |
| Identity | ✅ |
| Landing Zones | ⏳ |
