# ADR-003 — Terraform as Infrastructure as Code

| **Attribute** | **Value** |
|----------------|-----------|
| ADR ID | ADR-003 |
| Status | Accepted |
| Date | 2026-07-31 |
| Authors | Cloud Architecture Team |
| Program | OneCloud 2030 |
| Organization | Mandara Global |
| Category | Platform Engineering |

---

# 1. Executive Summary

Mandara Global adopts **Terraform** as the enterprise Infrastructure as Code (IaC) standard for provisioning, managing, and operating the Azure Enterprise Cloud Foundation.

Terraform provides a consistent, automated, version-controlled and reusable deployment model aligned with the OneCloud 2030 strategy.

---

# 2. Context

| Current Challenges | Expected Outcomes |
|--------------------|-------------------|
| Manual deployments | Automated provisioning |
| Configuration drift | Consistent environments |
| Limited governance | Standardized platform |
| Difficult auditing | Full traceability |
| Slow provisioning | Faster delivery |

---

# 3. Decision

Terraform is the standard technology for provisioning and managing:

| Scope |
|-------|
| Management Groups |
| Resource Groups |
| Networking |
| Identity Integration |
| Security Services |
| Monitoring |
| Shared Platform Services |
| Landing Zones |

Infrastructure is maintained in Git repositories and deployed through automated CI/CD pipelines.

---

# 4. Terraform Architecture

```text
Reusable Modules
        │
        ▼
Platform Capabilities
        │
        ▼
Landing Zones
```

| Layer | Purpose | Location |
|--------|---------|----------|
| Reusable Modules | Azure resource building blocks | `terraform/modules/` |
| Platform Capabilities | Compose enterprise services | `terraform/platform/` |
| Landing Zones | Deploy business workloads | `terraform/landingzones/` |

---

## Standard Module Structure

```text
module/

main.tf
variables.tf
outputs.tf
```

---

## Global Configuration

```text
terraform/

locals.tf
providers.tf
variables.tf
versions.tf
```

`locals.tf` is the single source of truth for enterprise metadata and common resource tags.

Platform capabilities extend common tags using Terraform `merge()`.

---

# 5. Design Principles

| Principle |
|-----------|
| Infrastructure as Code |
| Modular Design |
| Single Responsibility |
| Reusability |
| Platform Composition |
| Version Control |
| Idempotent Deployments |
| Security by Design |
| Operational Excellence |

---

# 6. Benefits

| Business | Technical |
|----------|-----------|
| Faster delivery | Reusable modules |
| Improved governance | Standardized architecture |
| Lower operational risk | Reduced code duplication |
| Consistent deployments | Scalable platform |
| Better change management | Easier maintenance |

---

# 7. Alternatives

| Option | Decision | Reason |
|--------|----------|--------|
| Azure Portal | Rejected | Manual, error-prone, not scalable |
| Azure Bicep | Rejected | Azure-specific, reduced flexibility |
| Terraform | Accepted | Mature ecosystem, reusable modules, CI/CD ready |

---

# 8. Consequences

| Positive | Trade-offs |
|-----------|------------|
| Enterprise-standard IaC | Terraform state management |
| Layered architecture | Learning curve |
| Clear separation of concerns | Additional abstraction |
| Reusable platform components | Platform composition required |

The benefits outweigh the additional complexity by providing a scalable and maintainable enterprise platform.

---

# 9. Related ADRs

| ADR |
|-----|
| ADR-001 — Enterprise Landing Zone Architecture |
| ADR-002 — Hub & Spoke Network Architecture |
| ADR-004 — Enterprise Management Group Hierarchy |
| ADR-005 — Private Networking Strategy |
| ADR-006 — Enterprise Identity Strategy |
| ADR-007 — Enterprise Monitoring and Observability |
| ADR-008 — Enterprise Security Baseline |
| ADR-009 — Enterprise Naming Convention |
| ADR-010 — Enterprise Tagging Strategy |

---

# 10. References

- Terraform Documentation
- Azure Provider for Terraform
- Microsoft Cloud Adoption Framework (CAF)
- Azure Well-Architected Framework (WAF)
- Azure Architecture Center
