# S10 — Traceability Matrix

## Architecture Traceability

The matrix links the main requirements and architectural concerns to the relevant principles, decisions, architecture, and implementation.

| Requirement / Concern | Reference / Decision | Architecture | Implementation |
|---|---|---|---|
| Centralized governance | AP-007 · GOV-002 · GOV-003 | Azure Policy / RBAC | Terraform policy and RBAC modules |
| Workload isolation | ADR-001 · GOV-009 | Landing Zone model | LZ-CORP / LZ-ONLINE / LZ-SANDBOX |
| Centralized connectivity | ADR-002 · REF-002 | Hub-and-Spoke | Hub VNet / Hub Subnets / NSG; Advanced connectivity capability introduced when required / Gateways |
| Private connectivity | ADR-005 | Private networking | Key Vault Private Endpoints + Private DNS;reusable Private Endpoint module |
| Infrastructure consistency | AP-003 | Infrastructure as Code | Terraform modules and environments |
| Security by design | AP-004 · AP-005 | Security and identity controls | RBAC / Managed Identity / Policy |
| Centralized observability | AP-009 | Operations capability | Azure Monitor / Log Analytics / Diagnostics |
| Secure secrets | AP-004 | Key management | Key Vault / Managed Identity |
| Shared enterprise services | AP-002 · AP-008 | Platform Foundation | Management / Connectivity / Security / Operations / Identity |
| Workload integration | ARC-003 | Landing Zones as workload boundary | Workloads deployed within approved LZs |

## End-to-End Traceability

```text
Business Requirements
        │
        ▼
Architecture Principles
        │
        ▼
Architecture Decisions
        │
        ▼
Reference Architecture
        │
        ▼
Terraform Implementation
        │
        ▼
Azure Foundation
        │
        ▼
Workloads
