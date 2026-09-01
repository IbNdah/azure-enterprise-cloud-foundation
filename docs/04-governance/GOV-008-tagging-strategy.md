# GOV-008 – Tagging Strategy

| **Document ID** | GOV-008 |
|---|---|
| **Version** | 1.1 |
| **Status** | Approved |
| **Owner** | Cloud Platform Team |
| **Audience** | Cloud Architects, Platform Engineers, Operations Team |
| **Classification** | Internal Use Only |

---

# 1. Purpose

This document defines the enterprise tagging strategy for Azure resources.

The objective is to provide the minimum metadata required for ownership, environment identification, cost allocation and operational management.

---

# 2. Tagging Principles

| Principle | Description |
|---|---|
| Minimal | Keep mandatory tags limited to useful information. |
| Consistent | Use standardized names and values. |
| Automated | Apply and validate tags through Terraform and Azure Policy where appropriate. |
| Actionable | Every mandatory tag should support an operational or governance need. |

---

# 3. Mandatory Tags

| Tag | Purpose | Example |
|---|---|---|
| **Environment** | Deployment context | Production |
| **Application** | Workload or platform identification | CloudFoundation |
| **Owner** | Responsible team | Platform |
| **CostCenter** | Financial ownership | IT-001 |

These tags are mandatory for applicable managed resources.

---

# 4. Optional Tags

| Tag | Purpose |
|---|---|
| Project | Project identification |
| BusinessUnit | Organizational ownership |
| Criticality | Business importance |
| ManagedBy | Management or automation responsibility |

Optional tags should only be introduced when they have a defined use.

---

# 5. Tag Values

Tag values should be:

- consistent;
- documented;
- meaningful;
- compatible with reporting requirements.

Controlled values should be used where a common enterprise vocabulary is required.

---

# 6. Enforcement

Tags are:

```text
Terraform
   │
   ▼
Resource Deployment
   │
   ▼
Azure Policy Validation
   │
   ▼
Compliance Monitoring
```

Terraform is the primary mechanism for applying standard tags during deployment. Azure Policy provides enforcement or compliance validation where supported.

---

# 7. Design Decision

## Decision

Adopt a small set of mandatory tags and enforce them through Infrastructure as Code and Azure Policy where practical.

## Rationale

A limited tagging model provides useful governance and cost metadata without creating unnecessary operational overhead.

---

# 8. Related Documents & Key Takeaways

| Document | Relationship |
|---|---|
| GOV-001 | Governance Strategy |
| GOV-004 | Resource Organization |
| GOV-005 | Naming Convention |
| GOV-007 | Azure Policy |
| GOV-009 | Landing Zones |
| ADR-010 | Enterprise Tagging Strategy |

**Key takeaway:** tagging provides metadata; it does not replace naming, resource organization or governance boundaries.
