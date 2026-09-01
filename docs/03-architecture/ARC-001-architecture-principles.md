# ARC-001 — Architecture Principles

| Attribute | Value |
|---|---|
| **Document ID** | ARC-001 |
| **Title** | Architecture Principles |
| **Version** | 1.2 |
| **Status** | Approved |
| **Date** | 2026-09-01 |
| **Author** | Cloud Center of Excellence (CCoE) |
| **Program** | OneCloud 2030 |
| **Organization** | Mandara Global |
| **Classification** | Internal Use Only |

---

# 1. Purpose

This document defines the principles governing the design, implementation, and operation of the Azure Enterprise Cloud Foundation.

The principles provide a consistent basis for architecture, governance, platform engineering, security, operations, and workload decisions.

Architecture decisions, reference architectures, Terraform implementation, and Azure resources should align with these principles. Approved exceptions are documented through Architecture Decision Records (ADR).

---

# 2. Related Business Requirements

| Principle | Related Business Requirements |
|---|---|
| AP-001 | BR-001, BR-010 |
| AP-002 | BR-001, BR-005 |
| AP-003 | BR-002, BR-006 |
| AP-004 | BR-003 |
| AP-005 | BR-003 |
| AP-006 | BR-002, BR-006 |
| AP-007 | BR-001, BR-005 |
| AP-008 | BR-001, BR-005 |
| AP-009 | BR-009 |
| AP-010 | BR-008 |

---

# 3. Architecture Principles

| ID | Principle | Statement | Rationale | Key Architectural Implications |
|---|---|---|---|---|
| **AP-001** | **Business Before Technology** | Technology decisions shall support a documented business requirement. | Keeps architecture focused on defined enterprise outcomes. | Business traceability · ADR references · justified technology choices |
| **AP-002** | **Platform over Projects** | Shared enterprise services should be preferred over project-specific infrastructure where reuse provides a clear benefit. | Reduces duplication and promotes consistent governance and operations. | Shared connectivity · identity · monitoring · security · governance |
| **AP-003** | **Infrastructure as Code** | Cloud infrastructure shall be provisioned, changed, and retired through IaC. | Makes infrastructure reproducible, version-controlled, and auditable. | Terraform · version control · controlled changes |
| **AP-004** | **Security by Design** | Security shall be considered from the beginning of architecture decisions. | Prevents security from becoming an afterthought. | Secure defaults · encryption · private connectivity · managed identities · policy |
| **AP-005** | **Zero Trust** | Users, workloads, and network locations shall not be implicitly trusted. | Supports explicit verification and least-privilege access. | RBAC · Conditional Access · segmentation · identity-driven security |
| **AP-006** | **Automation First** | Repeatable activities should be automated where practical. | Improves consistency and reduces operational error. | Validation · testing · infrastructure deployment · CI/CD where appropriate |
| **AP-007** | **Standardization over Customization** | Enterprise standards should be preferred where they meet the requirement. | Reduces operational complexity and improves supportability. | Naming · tagging · subscriptions · Landing Zones |
| **AP-008** | **Shared Services First** | Common enterprise capabilities should be provided as shared platform services where centralization is appropriate. | Improves consistency, security, and operational efficiency. | Identity · logging · monitoring · networking · policy |
| **AP-009** | **Observability by Default** | Platform components shall provide appropriate monitoring, logging, and diagnostics. | Provides visibility required for reliability, security, and operations. | Azure Monitor · Log Analytics · alerts · dashboards · diagnostics |
| **AP-010** | **AI Ready** | The cloud foundation should support future AI capabilities without requiring a fundamental platform redesign. | Keeps the foundation adaptable to future workload requirements. | Scalable Landing Zones · secure data integration · identity · governance |

---

# 4. Principle Compliance

The architectural decision flow is:

```text
Business Requirements
        │
        ▼
Cloud Strategy
        │
        ▼
Architecture Principles
        │
        ▼
Architecture Decision Records
        │
        ▼
Reference Architecture
        │
        ▼
Terraform Implementation
        │
        ▼
Azure Resources
```

Architecture decisions should be evaluated against the principles.

An exception should be justified and documented through an ADR where appropriate.

---

# 5. Relationship to the Architecture

The principles apply across the foundation:

```text
                 Architecture Principles
                          │
          ┌───────────────┼───────────────┐
          ▼               ▼               ▼
      Governance       Platform       Landing Zones
          │               │               │
          └───────────────┼───────────────┘
                          ▼
                       Workloads
```

The principles guide the architecture but do not replace the detailed governance, architecture, or Terraform documents.

---

# 6. Key Takeaways

- Business requirements guide technology decisions.
- Shared Platform Capabilities are preferred where reuse provides value.
- Terraform provides the standard Infrastructure as Code approach.
- Security, identity, governance, and observability are considered from the beginning.
- Enterprise standards are preferred where appropriate.
- Exceptions are documented through ADRs.
- The architecture should remain as simple as practical while meeting enterprise requirements.
