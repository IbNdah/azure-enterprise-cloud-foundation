# ADR-008 — Enterprise Security Baseline

| Attribute | Value |
|---|---|
| **ADR ID** | ADR-008 |
| **Title** | Enterprise Security Baseline |
| **Version** | 1.1 |
| **Status** | Accepted |
| **Date** | 2026-09-01 |
| **Authors** | Cloud Architecture Team |
| **Program** | OneCloud 2030 |
| **Organization** | Mandara Global |
| **Category** | Security |

---

# 1. Executive Summary

Mandara Global will establish a common **security baseline** for the Azure Enterprise Cloud Foundation.

The baseline combines identity, network security, Azure Policy, monitoring, resource configuration and governance controls.

The objective is to establish a minimum security standard across Platform Capabilities and Landing Zones while allowing workload-specific controls where required.

Security is a shared **Platform Capability** and is not itself a Management Group.

---

# 2. Business Context

The enterprise cloud foundation must provide a consistent minimum level of security across Azure environments.

Without a common baseline, individual subscriptions and workloads could implement significantly different security controls.

The security baseline therefore establishes common controls that can be applied consistently while keeping workload-specific security responsibilities within the appropriate boundary.

---

# 3. Problem Statement

Azure resources can be deployed with different levels of security depending on the workload team, subscription or implementation approach.

The platform needs a common baseline covering the main security domains without attempting to define every possible workload security requirement.

---

# 4. Decision

Mandara Global will establish the following enterprise security baseline:

| Security Domain | Baseline Approach |
|---|---|
| **Identity** | Microsoft Entra ID, Azure RBAC and least privilege |
| **Privileged Access** | Controlled privileged access and PIM where appropriate |
| **Network** | Segmentation, NSGs, private connectivity and centralized controls where required |
| **Policy** | Azure Policy for enforceable governance requirements |
| **Resource Configuration** | Secure configuration of supported Azure resources |
| **Monitoring** | Azure Monitor and relevant security logging |
| **Data Protection** | Encryption and appropriate access controls |
| **Secrets** | Azure Key Vault where secrets require centralized management |
| **Governance** | Tags, naming, ownership and resource organization |

The baseline represents the **minimum enterprise expectation**. Workloads may implement stronger controls where their requirements justify them.

---

# 5. High-Level Security Model

```text
                         Enterprise Security
                                │
          ┌─────────────────────┼─────────────────────┐
          │                     │                     │
          ▼                     ▼                     ▼
       Identity              Network              Governance
          │                     │                     │
      Entra ID             NSG / Private         Azure Policy
      Azure RBAC            Connectivity         Tags / Naming
          │                     │                     │
          └─────────────────────┼─────────────────────┘
                                │
                                ▼
                           Monitoring
                                │
                                ▼
                       Platform & Landing Zones
                                │
                                ▼
                            Workloads
```

Security is implemented through multiple complementary controls rather than through one security service.

---

# 6. Identity and Access Security

Identity is a primary security control.

The platform uses:

- Microsoft Entra ID for enterprise identity;
- Azure RBAC for authorization;
- group-based access where practical;
- least-privilege assignments;
- managed identities for supported workloads;
- controlled privileged access.

These controls are defined in greater detail in ADR-006 and GOV-006.

---

# 7. Network Security

Network security follows the enterprise Hub & Spoke architecture.

The baseline includes:

- network segmentation;
- Network Security Groups where appropriate;
- private connectivity for supported services where justified;
- centralized network controls where required;
- controlled hybrid connectivity.

Private networking is defined in ADR-005 and the Hub & Spoke architecture in ADR-002.

The baseline does not require every workload to use identical network controls. Controls must be appropriate to the workload and its connectivity requirements.

---

# 8. Governance and Policy

Azure Policy is used to enforce or audit enterprise requirements where appropriate.

Typical policy areas include:

- allowed resource types or locations;
- security configuration;
- required tags;
- resource naming or organization requirements;
- public exposure controls;
- monitoring configuration.

Policy should be applied at an appropriate governance scope and should distinguish between requirements that must be **enforced** and requirements that should initially be **audited**.

---

# 9. Data and Secrets Protection

Sensitive data should use the security controls appropriate to its classification and service.

The baseline includes:

- encryption at rest where supported;
- encryption in transit where supported;
- controlled access to sensitive data;
- Azure Key Vault for centralized secret management where appropriate;
- avoidance of credentials embedded in code or configuration.

Workload-specific data protection requirements remain the responsibility of the workload owner.

---

# 10. Monitoring and Security Visibility

Security-relevant events should be monitored through the enterprise monitoring foundation.

Azure Monitor, Log Analytics and diagnostic settings provide the underlying monitoring capabilities.

Monitoring supports:

- security investigation;
- operational troubleshooting;
- detection of configuration issues;
- governance verification;
- incident response.

Monitoring does not replace preventive controls such as RBAC, Azure Policy or network security.

---

# 11. Decision Drivers

| Driver | Reason |
|---|---|
| **Security** | Establish a consistent minimum protection level |
| **Consistency** | Apply common controls across environments |
| **Governance** | Make key requirements enforceable or auditable |
| **Least Privilege** | Limit access to required permissions |
| **Visibility** | Detect and investigate relevant events |
| **Scalability** | Support multiple subscriptions and Landing Zones |
| **Practicality** | Avoid controls that provide little additional value |

---

# 12. Architectural Principles

| Principle | Application |
|---|---|
| **Secure by Default** | Prefer secure configurations where practical |
| **Least Privilege** | Grant only required access |
| **Defense in Depth** | Use complementary security controls |
| **Policy Where Appropriate** | Automate enforceable governance requirements |
| **Private by Preference** | Prefer private connectivity where justified |
| **Centralized Shared Controls** | Provide common platform security capabilities |
| **Workload Responsibility** | Workload teams remain responsible for workload-specific security |
| **Continuous Visibility** | Monitor relevant security and operational signals |

---

# 13. Alternatives Considered

| Option | Decision | Rationale |
|---|---|---|
| **Security defined independently by each workload** | Rejected | Creates inconsistent protection levels |
| **One centralized security control for everything** | Rejected | Does not address all security domains |
| **Common baseline + workload-specific controls** | **Selected** | Provides consistency without unnecessary restriction |
| **Enforce every requirement immediately** | Rejected | Can create deployment disruption where audit-first is more appropriate |

---

# 14. Expected Benefits

| Area | Benefit |
|---|---|
| Security | Consistent minimum protection |
| Governance | Clear enterprise requirements |
| Operations | Better visibility and troubleshooting |
| Access | Controlled permissions |
| Networking | Reduced unnecessary exposure |
| Scalability | Repeatable controls across Landing Zones |
| Compliance | Easier evidence and control verification |

---

# 15. Consequences

### Positive

- Consistent enterprise security baseline
- Clear security responsibilities
- Better integration between identity, networking, governance and monitoring
- Reusable platform security controls
- Reduced risk of inconsistent subscription configurations

### Trade-offs

- Security controls require ongoing maintenance
- Policy changes can affect existing workloads
- Central security capabilities require operational ownership
- Stronger controls can increase implementation effort or cost

The baseline therefore focuses on controls that provide clear enterprise value.

---

# 16. Scope and Boundaries

This decision applies to:

- Azure platform capabilities;
- Azure Landing Zones;
- shared enterprise security controls;
- identity and access;
- network security;
- Azure Policy;
- monitoring and security visibility;
- baseline resource security configuration.

It does not define:

- detailed application security architecture;
- application-level authorization;
- workload-specific threat models;
- detailed incident response procedures;
- every security control required by a regulated workload.

Those concerns remain within the appropriate workload or enterprise security processes.

---

# 17. Relationship to Other Architecture Decisions

| Document | Relationship |
|---|---|
| **ADR-001** | Enterprise Landing Zone architecture |
| **ADR-002** | Hub & Spoke network architecture |
| **ADR-003** | Terraform as the IaC standard |
| **ADR-004** | Management Group governance hierarchy |
| **ADR-005** | Private networking |
| **ADR-006** | Enterprise identity strategy |
| **ADR-007** | Monitoring and observability |
| **GOV-006** | RBAC strategy |
| **GOV-007** | Azure Policy strategy |
| **GOV-008** | Tagging strategy |
| **GOV-009** | Landing Zone design |
| **ARC-003** | Enterprise reference architecture |

---

# 18. Implementation Alignment

Security is implemented across several platform capabilities rather than as a single Terraform stack.

```text
Platform
   │
   ├── Identity Capability
   │      └── Access / RBAC
   │
   ├── Connectivity Capability
   │      └── Network Security
   │
   ├── Security Capability
   │      └── Policies / Security Controls
   │
   └── Operations Capability
          └── Monitoring / Diagnostics
```

Terraform provides the implementation mechanism for the security-related infrastructure and configuration managed by this project.

---

# 19. Review

This decision should be reviewed when significant changes occur to:

- Azure security capabilities;
- enterprise security requirements;
- identity architecture;
- networking architecture;
- Azure Policy strategy;
- monitoring requirements;
- Landing Zone architecture.

---

# 20. References

- Microsoft Azure Security documentation
- Microsoft Entra ID
- Azure RBAC
- Azure Policy
- Azure Monitor
- Azure Key Vault
- ADR-005 — Enterprise Private Networking Strategy
- ADR-006 — Enterprise Identity Strategy
- ADR-007 — Enterprise Monitoring and Observability Strategy
- GOV-006 — RBAC Strategy
- GOV-007 — Azure Policy Strategy
- GOV-009 — Landing Zone Design
- ARC-003 — Enterprise Reference Architecture
