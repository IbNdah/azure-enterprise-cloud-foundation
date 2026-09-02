# Terraform Foundation

This directory contains the Infrastructure as Code (IaC) implementation of the Azure Enterprise Cloud Foundation.
The Terraform codebase follows a layered architecture that separates enterprise orchestration, shared platform capabilities, reusable infrastructure modules, and business Landing Zones.

## Architecture

```text
                         terraform/main.tf
                      (Platform Orchestrator)
                               │
        ┌──────────────────────┼──────────────────────┐
        ▼                      ▼                      ▼
   Platform               Reusable              Landing
  Capabilities              Modules               Zones
        │                      │                      │
        ▼                      ▼                      ▼
 Shared Enterprise        Azure Resource          Workload
    Services              Building Blocks       Infrastructure
```

Landing Zones are separate workload boundaries from the shared Platform layer.

```text
Azure Tenant
│
├── Platform
│   ├── Management
│   ├── Connectivity
│   ├── Security
│   ├── Operations
│   └── Identity
│
└── Landing Zones
    ├── Corp
    ├── Online
    └── Sandbox
```

**Landing Zone ≠ Environment.**

`dev`, `test`, and `prod` remain workload and environment concerns within the appropriate Landing Zone.

## Repository Structure

```text
terraform/

├── backend/                 # Remote state configuration
├── environments/            # Environment-specific configuration
├── landingzones/             # Business workload deployments
│   ├── corp/
│   ├── online/
│   └── sandbox/
│
├── modules/                 # Reusable Azure resource modules
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
├── platform/                # Enterprise platform capabilities
│   ├── management/
│   ├── connectivity/
│   ├── security/
│   ├── operations/
│   └── identity/
│
├── locals.tf                # Enterprise metadata and common tags
├── main.tf                  # Platform capability orchestrator
├── providers.tf             # Terraform providers
├── variables.tf             # Global deployment variables
└── versions.tf              # Terraform version constraints
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

Platform capabilities provide shared enterprise services and are not duplicated inside individual Landing Zones.

## Landing Zones

The foundation implements three independent Landing Zone Terraform roots:

| Landing Zone | Resource Group | Status |
|---|---|:---:|
| Corp | `rg-corp-workloads-001` | ✅ |
| Online | `rg-online-workloads-001` | ✅ |
| Sandbox | `rg-sandbox-workloads-001` | ✅ |

Each Landing Zone:

- Targets an existing Azure subscription
- Uses an independent Terraform state
- Creates a dedicated workload Resource Group
- Applies enterprise governance tags
- Provides the boundary for workload-specific infrastructure

The current lab uses the same Azure subscription for all three Landing Zones. In a production implementation, Corp, Online, and Sandbox would target their respective workload subscriptions.

## Corp Workload Example

The Corp Landing Zone has been enriched with a representative workload infrastructure stack.

```text
Corp Landing Zone
│
└── rg-corp-workloads-001
    │
    ├── vnet-corp-workload-001
    │   └── 10.10.0.0/16
    │       │
    │       └── snet-workload
    │           └── 10.10.1.0/24
    │
    ├── nsg-corp-workload-001
    │
    ├── nic-corp-workload-001
    │
    └── vm-corp-workload-001
        └── Private IP: 10.10.1.4
```

The workload VNet uses a `/16` address space, providing room for additional workload subnets as the Landing Zone evolves.
The current `/24` workload subnet provides 256 addresses, with Azure reserving 5 addresses per subnet.

The VM is:

- Linux / Ubuntu 24.04
- `Standard_B2s`
- Private IP only
- SSH key authentication
- No password authentication
- No Public IP

The Corp example demonstrates that Landing Zones are intended to host actual workload infrastructure while shared platform services remain centralized.
Online and Sandbox currently remain foundation-only and can be enriched with workloads when required.

## Governance

Governance controls are implemented within the Management capability using the reusable `policies` Terraform module.
The foundation currently enforces:
- Allowed resource locations
- Required resource tags

Landing Zone resources apply the enterprise tagging model and add a Landing Zone-specific tag.
Required tags currently applied to Landing Zone Resource Groups and workload resources:

```text
Organization
Project
BusinessUnit
Department
ManagedBy
LandingZone
```

Policy definitions and subscription-level assignments are managed exclusively through Terraform.

## Terraform State

Each Landing Zone uses an independent remote Terraform state:

| Scope | State Key |
|---|---|
| Platform / Dev | `dev.terraform.tfstate` |
| Corp | `lz-corp.terraform.tfstate` |
| Online | `lz-online.terraform.tfstate` |
| Sandbox | `lz-sandbox.terraform.tfstate` |

This keeps Landing Zone lifecycle management isolated from the shared Platform state.

## Initialization

Initialize each Landing Zone using its dedicated backend configuration.

Corp:

```bash
terraform init -reconfigure --backend-config=../../backend/lz-corp.hcl
```

Online:

```bash
terraform init -reconfigure --backend-config=../../backend/lz-online.hcl
```

Sandbox:

```bash
terraform init -reconfigure --backend-config=../../backend/lz-sandbox.hcl
```

Common validation workflow:

```bash
terraform fmt
terraform validate
terraform plan
terraform apply
```

For the Corp Linux workload, the SSH public key is supplied at deployment time:

```powershell
terraform apply -var="admin_ssh_public_key=$(Get-Content $HOME\.ssh\id_ed25519.pub -Raw)"
```

The private SSH key remains local and is never stored in the repository.

## Layer Responsibilities

| Layer | Responsibility |
|---|---|
| **Root** | Enterprise metadata and platform capability orchestration |
| **Platform** | Shared enterprise capabilities and Resource Group ownership |
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
- Independent Landing Zone state
- Clear separation of platform and workload responsibilities
- No unnecessary infrastructure duplication

## Validation

Landing Zones have been validated through the complete Terraform lifecycle:

```text
Terraform Configuration
        │
        ▼
terraform validate
        │
        ▼
terraform plan
        │
        ▼
terraform apply
        │
        ▼
Azure Resources
        │
        ▼
terraform plan
        │
        ▼
No changes
```

The three Landing Zone Resource Groups are deployed successfully.
The Corp Landing Zone has additionally been validated with its VNet, subnet, NSG, NIC, and Linux VM workload.

## Current Status

| Capability | Status |
|---|:---:|
| Terraform Foundation | ✅ |
| Management | ✅ |
| Connectivity | ✅ |
| Security | ✅ |
| Operations | ✅ |
| Identity | ✅ |
| Landing Zones | ✅ |
| Corp workload infrastructure | ✅ |
