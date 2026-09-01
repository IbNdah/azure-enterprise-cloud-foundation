# ADR-005 — Enterprise Private Networking Strategy

| Attribute | Value |
|---|---|
| **ADR ID** | ADR-005 |
| **Title** | Enterprise Private Networking Strategy |
| **Version** | 1.2 |
| **Status** | Accepted |
| **Date** | 2026-09-01 |
| **Authors** | Cloud Architecture Team |
| **Program** | OneCloud 2030 |
| **Organization** | Mandara Global |
| **Category** | Enterprise Networking / Security |

---

# 1. Executive Summary

Mandara Global will use **private networking as the preferred connectivity model** for Azure platform services and workloads where supported and justified by the workload requirements.

The strategy combines:

- Azure Private Link and Private Endpoints;
- Private DNS;
- the enterprise Hub & Spoke network architecture;
- centralized network security where required;
- private hybrid connectivity through VPN or ExpressRoute.

Public endpoints are not prohibited in every scenario. They may remain in use where private connectivity is not supported or where a justified workload requirement exists.

---

# 2. Business Context

The enterprise cloud foundation must reduce unnecessary exposure to the public internet and provide controlled connectivity between workloads, Azure services and enterprise networks.

The networking strategy therefore needs to provide:

- private access to supported Azure services;
- workload network isolation;
- predictable name resolution;
- controlled connectivity between Azure and on-premises networks;
- consistent networking patterns across Landing Zones;
- appropriate network security controls.

This decision complements ADR-002:

> **ADR-002 defines the Hub & Spoke topology. ADR-005 defines the preferred private connectivity model within that topology.**

---

# 3. Problem Statement

Using public endpoints for all Azure services can increase exposure and make network controls more difficult to standardize.

However, requiring private connectivity for every service and every traffic path can introduce unnecessary cost and complexity.

The architecture therefore needs a balanced approach:

> **Use private connectivity where it provides a meaningful security, isolation or control benefit, while allowing controlled exceptions where appropriate.**

---

# 4. Decision

Mandara Global will use the following private networking components:

| Component | Role |
|---|---|
| **Private Endpoint** | Provides a private IP address for access to supported Azure services |
| **Azure Private Link** | Provides private connectivity to supported Azure PaaS services |
| **Private DNS** | Resolves service names to the appropriate Private Endpoint address |
| **Hub & Spoke** | Provides the enterprise network topology |
| **Azure Firewall** | Provides centralized inspection and traffic control where required |
| **VNet Peering** | Connects Spoke networks to shared Hub services |
| **VPN / ExpressRoute** | Provides private connectivity between Azure and enterprise networks |

The exact placement of networking components depends on the workload, service and required governance boundary.

---

# 5. Private Connectivity Patterns

The architecture distinguishes **two different private connectivity scenarios**.

## 5.1 Azure Workload → Azure PaaS

A workload located in a Spoke VNet can access a supported Azure PaaS service through a Private Endpoint.

```text
                    Azure Workload
                           │
                           ▼
                    Spoke VNet
                           │
                           ▼
                  Private Endpoint
                    (Private Link)
                           │
                           ▼
                    Azure PaaS
              ┌────────┬────────┬─────────┐
              │        │        │         │
          Key Vault  Storage  Cosmos DB  SQL
```

The traffic uses the private connectivity provided by the Private Endpoint rather than a public endpoint.

**Private DNS is used for name resolution and is not a traffic hop:**

```text
                 Private DNS
                      │
                      │ resolves
                      ▼
       PaaS service name → Private Endpoint IP
```

---

## 5.2 On-Premises → Azure PaaS

An on-premises workload can reach an Azure PaaS service privately through the enterprise connectivity path.

```text
                    On-Premises
                         │
                 VPN / ExpressRoute
                         │
                         ▼
                    Hub VNet
                         │
                Azure Firewall*
                         │
                         ▼
                 Spoke VNet
                         │
                         ▼
                Private Endpoint
                  (Private Link)
                         │
                         ▼
                  Azure PaaS
             ┌────────┬────────┬─────────┐
             │        │        │         │
         Key Vault  Storage  Cosmos DB  SQL
```

`* Azure Firewall is used where the enterprise routing and security design requires centralized inspection. It is **not an inherent requirement of Private Link**.

The important distinction is therefore:

| Scenario | Primary private mechanism | Hub required? |
|---|---|---|
| **Azure Workload → Azure PaaS** | Private Endpoint / Private Link | Not necessarily |
| **On-Premises → Azure PaaS** | VPN/ExpressRoute + enterprise routing + Private Endpoint | Yes, for the enterprise connectivity path |

This distinction prevents Private Link, Hub connectivity and firewall inspection from being treated as the same network function.

---

# 6. Private DNS

Private DNS supports the Private Endpoint model by resolving Azure service names to the private address associated with the Private Endpoint.

Conceptually:

```text
Application
    │
    │ DNS query
    ▼
Private DNS
    │
    │ private address
    ▼
Private Endpoint
    │
    ▼
Azure PaaS
```

Private DNS therefore supports the connectivity path but does not carry the application traffic itself.

The enterprise approach favors centralized DNS services where practical while allowing workload-specific DNS configuration where a separate boundary is required.

---

# 7. Public Access

Private networking is the preferred model, but public access is not categorically prohibited.

A public endpoint may be used when:

- private connectivity is not supported;
- the workload has a valid external access requirement;
- private connectivity would introduce disproportionate complexity;
- applicable security controls provide an acceptable risk level.

Where public access remains enabled, the workload must comply with the applicable security, network and monitoring requirements.

The objective is therefore **appropriate private connectivity**, not private connectivity as an end in itself.

---

# 8. Decision Drivers

| Driver | Reason |
|---|---|
| **Security** | Reduce unnecessary public exposure |
| **Isolation** | Keep supported service traffic within private boundaries |
| **Control** | Provide predictable and controlled network paths |
| **Hybrid Connectivity** | Support private enterprise connectivity |
| **Consistency** | Establish repeatable networking patterns |
| **Operations** | Reuse common DNS and connectivity services where practical |
| **Cost** | Avoid unnecessary private networking components |

---

# 9. Architectural Principles

| Principle | Application |
|---|---|
| **Private by Preference** | Prefer private connectivity for supported services |
| **Least Connectivity Required** | Expose only what is required |
| **Network Segmentation** | Maintain workload boundaries |
| **Centralized Services** | Reuse shared DNS and connectivity services where appropriate |
| **Controlled Inspection** | Use centralized firewall inspection where required by the routing/security model |
| **Infrastructure as Code** | Manage networking through Terraform |
| **Practicality** | Avoid private connectivity where it adds complexity without meaningful benefit |

---

# 10. Alternatives Considered

| Option | Decision | Rationale |
|---|---|---|
| **Public Endpoints by Default** | Rejected | Greater public exposure and weaker network isolation |
| **Private Connectivity Everywhere** | Rejected | Can introduce unnecessary cost and complexity |
| **Private by Preference with Controlled Exceptions** | **Selected** | Balances security, control, operational effort and workload requirements |

---

# 11. Expected Benefits

| Area | Benefit |
|---|---|
| **Security** | Reduced unnecessary public exposure |
| **Network Control** | More predictable traffic paths |
| **Workload Isolation** | Private access to supported services |
| **Hybrid Integration** | Consistent private connectivity model |
| **Governance** | Standard enterprise networking approach |
| **Operations** | Reusable connectivity and DNS services |

---

# 12. Consequences

### Positive

- Reduced reliance on public endpoints
- Stronger network isolation
- Consistent Private Endpoint and DNS patterns
- Clear integration with Hub & Spoke
- Defined approach for hybrid private connectivity
- Clear separation between DNS resolution and traffic routing

### Trade-offs

- Private Endpoints and DNS require additional configuration
- Centralized DNS requires operational ownership
- Private connectivity can increase infrastructure cost
- Firewall inspection can introduce additional routing and operational complexity
- Some Azure services or scenarios may still require public endpoints

These trade-offs are accepted because private networking is applied where it provides a meaningful architectural benefit.

---

# 13. Scope and Boundaries

This decision applies to:

- Azure Landing Zones;
- shared platform services;
- supported Azure PaaS services;
- Private Endpoint deployment;
- Private DNS integration;
- private hybrid connectivity.

It does **not** prescribe:

- one mandatory subnet design;
- one mandatory DNS topology for every workload;
- mandatory firewall traversal for every Private Endpoint connection;
- private access for every Azure service.

---

# 14. Relationship to Other Decisions

| Document | Relationship |
|---|---|
| **ADR-001** | Enterprise Landing Zone architecture |
| **ADR-002** | Hub & Spoke network topology |
| **ADR-003** | Terraform as Infrastructure as Code |
| **ADR-004** | Management Group governance hierarchy |
| **ADR-006** | Enterprise identity strategy |
| **ADR-007** | Monitoring and observability |
| **ADR-008** | Enterprise security baseline |
| **GOV-009** | Landing Zone design |
| **ARC-002** | High-level architecture |
| **ARC-003** | Enterprise reference architecture |

---

# 15. Implementation Alignment

The Terraform foundation provides reusable modules for:

- Virtual Networks;
- Subnets;
- Private Endpoints;
- Network Security Groups;
- related networking resources.

Private networking should therefore be implemented through the established Terraform modules and platform/workload boundaries rather than through unmanaged manual configuration.

The implementation must preserve the distinction between:

```text
Private Endpoint
      │
      └── Private access to Azure services

Hub / Firewall
      │
      └── Enterprise connectivity and traffic control

Private DNS
      │
      └── Name resolution
```

---

# 16. Review

This decision should be reviewed when significant changes occur to:

- Azure Private Link capabilities;
- Azure networking services;
- hybrid connectivity requirements;
- enterprise security requirements;
- Landing Zone architecture;
- cloud operating model.

---

# 17. References

- Microsoft Cloud Adoption Framework
- Azure Architecture Center
- Azure Private Link documentation
- Azure Private Endpoint documentation
- Azure Private DNS documentation
- ADR-002 — Hub & Spoke Network Architecture
- GOV-009 — Landing Zone Design
- ARC-003 — Enterprise Reference Architecture
