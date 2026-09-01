# Cloud Strategy

| **Document ID** | STR-001 |
|---|---|
| **Version** | 1.1 |
| **Status** | Approved |
| **Author** | Cloud Center of Excellence (CCoE) |
| **Classification** | Internal Use Only |

---

# 1. Related Business Requirements

- BR-001
- BR-002
- BR-003
- BR-004
- BR-005
- BR-006
- BR-007
- BR-008
- BR-009
- BR-010

---

# 2. Purpose

This document defines Mandara Global's cloud strategy as part of the OneCloud 2030 transformation program.

It establishes the strategic direction for cloud adoption, defines enterprise cloud objectives, and provides the principles that guide the Azure Enterprise Cloud Foundation.

The strategy aligns cloud adoption with business priorities while addressing governance, security, operational efficiency, and long-term scalability.

---

# 3. Executive Summary

Mandara Global treats cloud as a strategic business capability rather than only a technology initiative.

The OneCloud 2030 program establishes Azure as the enterprise cloud platform for new digital services and the modernization of the existing IT landscape where appropriate.

The strategy focuses on a standardized enterprise platform that enables Business Units to deliver services independently while operating within common governance and security boundaries.

---

# 4. Strategic Vision

> **Build a secure, governed, scalable, and AI-ready enterprise cloud platform that accelerates business innovation while reducing operational complexity across all Business Units.**

Cloud is not treated as an end state. It is the operating model supporting the future enterprise.

---

# 5. Strategic Objectives

| ID | Objective | Description |
|---|---|---|
| **SO-001** | Accelerate Business Innovation | Enable Business Units to deliver digital services faster through standardized cloud capabilities. |
| **SO-002** | Standardize Enterprise Governance | Establish a common governance model across Azure subscriptions. |
| **SO-003** | Strengthen Cybersecurity | Establish centralized identity, access control, security monitoring, and security governance. |
| **SO-004** | Increase Operational Excellence | Reduce operational complexity through automation, standardization, and Infrastructure as Code. |
| **SO-005** | Enable AI Innovation | Provide a cloud foundation capable of supporting future AI workloads without requiring fundamental platform redesign. |

---

# 6. Cloud Adoption Principles

Mandara Global adopts the following enterprise principles:

| Principle | Description |
|---|---|
| **Cloud First** | New platforms should be designed for cloud deployment where appropriate. |
| **Platform over Projects** | Shared enterprise capabilities should be preferred over isolated implementations where reuse is practical. |
| **Security by Design** | Security requirements are considered throughout the architecture and delivery lifecycle. |
| **Governance by Default** | Governance controls are incorporated into the platform and workload onboarding process. |
| **Automation First** | Manual provisioning should be minimized through Infrastructure as Code and automation. |
| **Standardization over Customization** | Common standards should be preferred where they reduce operational complexity. |
| **AI Ready** | The platform should support future AI capabilities without requiring fundamental redesign. |

---

# 7. Cloud Operating Model

The Azure Enterprise Cloud Foundation provides shared platform capabilities to Business Units.

```text
                    Business Units
                         │
                         ▼
             Azure Enterprise Cloud Foundation
                         │
          ┌──────────────┼──────────────┐
          │              │              │
       Platform      Governance      Security
     Capabilities      Controls       Controls
          │              │              │
          └──────────────┼──────────────┘
                         ▼
                  Landing Zones
                         │
                         ▼
                    Workloads
```

The platform provides shared capabilities while Landing Zones provide the governed boundaries in which workloads operate.

The core platform capabilities are:

| Capability | Strategic Role |
|---|---|
| **Management** | Shared management and governance services |
| **Connectivity** | Shared network and connectivity services |
| **Security** | Enterprise security controls and services |
| **Operations** | Monitoring and operational capabilities |
| **Identity** | Shared identity and access capabilities |

Business Units consume standardized platform capabilities rather than independently recreating common enterprise services where shared services are appropriate.

---

# 8. Strategic Success Measures

The strategy is considered successful when:

| Area | Success Measure |
|---|---|
| Governance | Enterprise governance is consistently applied across Azure subscriptions. |
| Automation | Infrastructure is provisioned and managed through version-controlled Infrastructure as Code, with Terraform as the enterprise implementation standard. |
| Provisioning | Standard cloud environments can be provisioned within hours rather than days. |
| Security | Enterprise security and access controls are consistently applied across workloads. |
| Cost | Cloud costs are visible, attributable, and governed. |
| Platform | The foundation can support future AI initiatives without fundamental platform redesign. |

---

# 9. Strategic Roadmap

```text
2026
│
├── Enterprise Cloud Foundation
├── Governance
├── Landing Zones
├── Networking
├── Security
├── Platform Engineering
└── Shared Services
        │
        ▼
2027+
│
├── AI Platform
├── Data Platform
├── Enterprise Integration
├── Advanced Automation
└── Multi-Region Expansion
```

The roadmap represents strategic direction rather than a fixed implementation schedule. Individual initiatives are planned and prioritized through the OneCloud 2030 program.

---

# 10. Strategic Alignment

The strategy provides the link between business requirements and the technical foundation:

```text
Business Requirements
        │
        ▼
Cloud Strategy
        │
        ├── Strategic Objectives
        ├── Adoption Principles
        └── Operating Model
                │
                ▼
        Enterprise Architecture
                │
                ▼
        Governance & Decisions
                │
                ▼
        Terraform Implementation
```

The strategy therefore defines direction without prescribing individual Azure resources or Terraform modules.

---

# 11. Key Takeaways

- Cloud is a strategic business capability.
- Azure is the enterprise cloud platform supporting OneCloud 2030.
- Standardization enables consistent delivery across Business Units.
- Governance and security are integrated into the platform and workload model.
- Infrastructure as Code is the standard deployment approach, with Terraform as the enterprise implementation standard.
- The Azure Enterprise Cloud Foundation provides the platform foundation for Mandara Global's digital transformation.
