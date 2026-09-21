# S10 --- Final Architecture Diagram

## Final Architecture

``` text
                              Azure Tenant
                                   │
                    ┌──────────────┴──────────────┐
                    │                             │
              Governance                  Platform Foundation
              Azure Policy                    │
              RBAC                            ├── Management
                                              ├── Connectivity
                                              ├── Security
                                              ├── Operations
                                              └── Identity
                                                     │
                                              ┌──────▼──────┐
                                              │  Hub VNet   │
                                              │             │
                                              │ Firewall    │
                                              │ Private DNS │
                                              │ Bastion     │
                                              │ VPN / ER    │
                                              └──────┬──────┘
                                                     │
                              ┌──────────────────────┼──────────────────────┐
                              │                      │                      │
                       ┌──────▼──────┐       ┌──────▼──────┐       ┌──────▼──────┐
                       │  LZ-CORP    │       │ LZ-ONLINE   │       │ LZ-SANDBOX  │
                       │             │       │             │       │             │
                       │ Workloads   │       │ Workloads   │       │ Dev / Test  │
                       │ Dev/Test/   │       │ Dev/Test/   │       │ / Experiment │
                       │ Prod        │       │ Prod        │       │             │
                       └─────────────┘       └─────────────┘       └─────────────┘

                              Hub-and-Spoke Connectivity
                              Private Connectivity Preferred
```

## Architecture Boundary

``` text
Platform Foundation
        │
        ▼
Landing Zones
        │
        ▼
Workloads
```

The diagram represents the final logical architecture. Detailed
implementation remains documented in the relevant architecture decisions
and Terraform structure.
