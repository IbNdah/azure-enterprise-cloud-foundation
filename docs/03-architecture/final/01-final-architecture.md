# S10 --- Final Architecture

## 1. Architecture Overview

The Azure Enterprise Cloud Foundation provides the common platform for
Mandara Global workloads.

The architecture is based on a centralized Platform Foundation, three
workload Landing Zones, and a Hub-and-Spoke network model.

``` text
Azure Tenant
│
├── Governance
│
├── Platform Foundation
│   ├── Management
│   ├── Connectivity
│   ├── Security
│   ├── Operations
│   └── Identity
│
└── Landing Zones
    ├── LZ-CORP
    ├── LZ-ONLINE
    └── LZ-SANDBOX
```

The Platform Foundation provides shared capabilities and guardrails.
Workload teams remain responsible for their applications and resources.

## 2. Platform Foundation

The Platform Foundation provides:

-   Management and governance
-   Network connectivity
-   Security controls
-   Monitoring and operations
-   Identity and access management

Platform-owned services are separated from workload-owned resources.

## 3. Landing Zones

  Landing Zone   Purpose
  -------------- ---------------------------------
  LZ-CORP        Corporate workloads
  LZ-ONLINE      Customer-facing workloads
  LZ-SANDBOX     Development and experimentation

Production and Non-Production environments are managed within the respective
Landing Zones. Dev and Test workloads are hosted within th Non-Production boundary.

## 4. Connectivity

The network follows a Hub-and-Spoke model.

The central Hub provides:

-   Azure Firewall
-   Private DNS
-   Azure Bastion
-   VPN Gateway
-   ExpressRoute Gateway

Landing Zone networks connect to the Hub through VNet Peering.
Hybrid connectivity is provided through VPN or ExpressRoute where required.

Private connectivity is preferred where applicable.

## 5. Security & Governance

Security and governance are applied through:

-   Azure Policy
-   RBAC
-   Network security controls
-   Centralized logging
-   Security governance and exception handling

Platform and workload responsibilities are clearly separated.

## 6. Operations & Workload Integration

Operational capabilities are provided through Azure Monitor and Log
Analytics.

Key Vault and Managed Identity provide secure access to secrets and
Azure services.

Terraform provides the Infrastructure-as-Code implementation.

The resulting platform boundary is:

``` text
Platform Foundation
        │
        ▼
Landing Zones
        │
        ▼
Workloads
```

Workloads can be integrated into the Landing Zones without changing the
core platform architecture.
