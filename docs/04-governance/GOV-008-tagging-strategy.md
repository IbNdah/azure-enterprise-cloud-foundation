# GOV-008 – Tagging Strategy

| **Document ID** | GOV-008 |
|-----------------|---------|
| **Version** | 1.0 |
| **Status** | Approved |
| **Owner** | Cloud Platform Team |
| **Audience** | Cloud Architects, Platform Engineers, Operations Team |

---

# 1. Purpose

This document defines the tagging strategy for the Azure Enterprise Cloud Foundation.

The objective is to provide consistent resource classification, improve operational management and support governance, automation and cost reporting.

---

# 2. Tagging Principles

The tagging strategy follows these principles:

- Apply tags consistently across Azure resources.
- Use standardized tag names and values.
- Keep the number of mandatory tags limited.
- Automate tag enforcement through Azure Policy where possible.
- Use tags to support governance and operational visibility.

---

# 3. Mandatory Tags

| Tag | Description | Example |
|-----|-------------|---------|
| **Environment** | Deployment environment | Production |
| **Application** | Business application or platform | Enterprise Cloud Foundation |
| **Owner** | Resource owner or team | Platform Team |
| **CostCenter** | Financial ownership | IT-001 |

---

# 4. Optional Tags

| Tag | Purpose |
|------|---------|
| Project | Project identifier |
| BusinessUnit | Business organization |
| Criticality | Business criticality |
| ManagedBy | Automation or operations team |

---

# 5. Tag Governance

Tags are:

- applied during deployment;
- validated using Azure Policy;
- reviewed regularly for compliance.

---

# 6. Design Benefits

- Improved resource organization
- Better operational visibility
- Enhanced cost allocation
- Simplified automation
- Consistent governance

---

# 7. Design Decision

## Decision

Adopt a standardized tagging strategy with a small set of mandatory tags enforced through Azure Policy.

## Rationale

A minimal tagging model reduces operational overhead while providing the metadata required for governance, automation and reporting.

---

# 8. Related Documents

| Document | Description |
|----------|-------------|
| GOV-004 | Resource Organization Strategy |
| GOV-005 | Naming Convention |
| GOV-007 | Azure Policy Strategy |
| GOV-009 | Landing Zone Design |

---

# Key Takeaways

- Every resource receives a consistent set of tags.
- Mandatory tags provide ownership and cost visibility.
- Azure Policy enforces tag compliance.
- A simple tagging model improves governance without increasing complexity.
