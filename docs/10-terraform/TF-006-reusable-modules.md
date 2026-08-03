# TF-006 – Reusable Terraform Modules

| **Attribute**    | **Value**                  |
| ---------------- | -------------------------- |
| **Document ID**  | TF-006                     |
| **Title**        | Reusable Terraform Modules |
| **Status**       | Accepted                   |
| **Date**         | 2026-08-03                 |
| **Authors**      | Cloud Architecture Team    |
| **Program**      | OneCloud 2030              |
| **Organization** | Mandara Global             |
| **Category**     | Terraform                  |

---

# Executive Summary

Reusable Terraform modules improve consistency, reduce duplication, and simplify infrastructure maintenance. Instead of defining Azure resources multiple times, common infrastructure components are encapsulated into reusable modules.

The Azure Enterprise Cloud Foundation begins with a Resource Group module, which serves as the foundation for all subsequent deployments.

---

# Module Overview

```text
Modules
│
└── resource_group
```

Each module has a single responsibility and can be reused across multiple environments.

---

# Design Decisions

| **Decision** | **Rationale** |
|--------------|---------------|
| Single-purpose modules | Easier maintenance |
| Reusable building blocks | Reduce code duplication |
| Standard inputs and outputs | Consistent deployments |
| Incremental module development | Avoid unnecessary complexity |

---

# Key Takeaways

- Modules improve maintainability.
- Infrastructure becomes reusable.
- Modules evolve incrementally.
- Simplicity remains the primary design principle.

---

## Next Step

**TF-007 – Multi-Environment Configuration**
