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

## Connectivity Implementation Status

The current Terraform implementation establishes the foundational network boundaries for the Platform and Landing Zones.

The Connectivity capability currently provisions the Hub VNet and its foundational subnets. Landing Zone VNets and workload-specific network components are provisioned independently.

The Enterprise Connectivity Reference Architecture defines a broader target pattern for enterprise connectivity. The following capabilities are therefore distinguished explicitly:

| Connectivity Capability | Current Terraform Status | Architectural Status |
|---|:---:|---|
| Hub VNet | Implemented | Core architecture |
| Hub subnets | Implemented | Core architecture |
| Landing Zone VNets | Implemented | Core architecture |
| Network Security Groups | Implemented / available | Core security control |
| Private Endpoint module | Available | Supported pattern |
| Private Endpoint for platform services | Implemented where required | Supported pattern |
| Private DNS | Not currently implemented | Reference pattern |
| VNet Peering | Not currently implemented | Reference pattern |
| Central routing / UDR | Not currently implemented | Reference pattern |
| Azure Firewall | Not currently implemented | Reference pattern |
| WAF | Not currently implemented | Applicable pattern |
| VPN / ExpressRoute | Not currently implemented | Hybrid connectivity pattern |
| Azure Bastion | Not currently implemented | Applicable pattern |

Advanced connectivity capabilities are not deployed merely because they are defined by the reference architecture. They are introduced when required by the target workload, security, compliance, hybrid connectivity or operational scenario.

This distinction prevents the Terraform implementation from becoming over-engineered while keeping the enterprise target architecture explicit.

### Connectivity Model

```text
                    HUB VNet
                       │
             Foundational connectivity
                       │
          ┌────────────┼────────────┐
          │            │            │
       LZ_CORP      LZ_ONLINE   LZ_SANDBOX
          │            │            │
       Workloads    Workloads    Workloads
```

The current Terraform foundation establishes the network boundaries shown above. Advanced connectivity paths such as peering, centralized routing, firewall inspection, private DNS and hybrid connectivity remain governed architectural patterns until a concrete implementation requirement exists.

### Private Endpoint and DNS

Private Endpoint support is implemented through the reusable `private-endpoint` module and is used for applicable platform services.

Private DNS is not currently deployed as a Terraform capability. Where a Private Endpoint requires private name resolution, the complete enterprise pattern is:

```text
Workload / Platform Service
            │
            ▼
    Private Endpoint
            │
            ▼
      Azure PaaS
            ▲
            │
      Private DNS
```

Private DNS should therefore not be interpreted as currently deployed merely because Private Endpoint support exists.

The placement of a Private Endpoint is determined by the service and workload boundary. Platform-owned services may use platform connectivity infrastructure; workload-specific Private Endpoints should remain aligned with the applicable Landing Zone and governance model.

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

## Connectivity Governance

Connectivity is centrally governed while workload-specific connectivity remains delegated to Landing Zone owners within defined platform guardrails.

```text
Workload Team
      │
      │ Connectivity Requirement
      ▼
 Request / IaC
      │
      ▼
Platform Governance
      │
      ▼
 Approved Connectivity
      │
      ▼
 Terraform
      │
      ▼
   Azure
```

The Platform Team owns and governs shared connectivity capabilities, including:

- Hub connectivity infrastructure
- centralized network security capabilities where deployed
- shared DNS capabilities where deployed
- hybrid connectivity capabilities where deployed
- connectivity policies and guardrails

Landing Zone owners remain responsible for their Landing Zones and workloads within those guardrails.

Connectivity changes follow the Infrastructure as Code lifecycle and are subject to the applicable review and approval process.

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
- Connectivity governed centrally and delegated within guardrails
- Least connectivity required
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

The Terraform implementation has also been reviewed against the Enterprise Connectivity Reference Architecture. The review confirms that the implemented foundation does not introduce architectural drift or an additional Landing Zone.


## Current Status

| Capability | Status |
|---|:---:|
| Terraform Foundation | ✅ |
| Management | ✅ |
| Connectivity Foundation | ✅ |
| Advanced connectivity patterns | Reference / requirement-driven |
| Security | ✅ |
| Operations | ✅ |
| Identity | ✅ |
| Landing Zones | ✅ |
| Corp workload infrastructure | ✅ |


## Architecture Alignment

The Terraform implementation remains aligned with the frozen Azure Enterprise Cloud Foundation architecture:

```text
Platform
   │
   ├── Management
   ├── Connectivity
   ├── Security
   ├── Operations
   └── Identity
          │
          ▼
      Guardrails
          │
    ┌─────┼─────┐
    ▼     ▼     ▼
   CORP  ONLINE SANDBOX
    │     │     │
 Workloads / Workload-specific Infrastructure
```

Terraform implements the foundation and reusable capabilities. Enterprise connectivity features that require a concrete workload or hybrid requirement remain architectural patterns until intentionally introduced through the normal governance and IaC lifecycle.

This approach preserves the frozen architecture while avoiding unnecessary infrastructure deployment.
