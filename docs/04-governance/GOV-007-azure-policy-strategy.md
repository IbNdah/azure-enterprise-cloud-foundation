# GOV-007 – Azure Policy Strategy

| **Document ID**  | GOV-007                                                  |
| ---------------- | -------------------------------------------------------- |
| **Version**      | 1.1                                                      |
| **Status**       | Approved                                                 |
| **Owner**        | Cloud Platform Team                                      |
| **Audience**     | Cloud Architects, Security Engineers, Platform Engineers |
| **Organization** | Mandara Global                                           |
| **Program**      | OneCloud 2030                                            |

---

# 1. Purpose

As part of the **OneCloud 2030** transformation program, **Mandara Global** is implementing Azure Policy as the primary governance enforcement mechanism to ensure that cloud resources comply with enterprise standards from the moment they are deployed.

This document defines the Azure Policy strategy for the Azure Enterprise Cloud Foundation. The objective is to automate governance, reduce configuration drift, strengthen security, and ensure consistent compliance across all Azure subscriptions and workloads.

---

# 2. Design Principles

The Azure Policy strategy follows these principles:

* Enforce governance automatically.
* Prevent non-compliant deployments whenever possible.
* Apply policies at the highest appropriate scope.
* Standardize security and compliance controls.
* Continuously monitor policy compliance.

---

# 3. Policy Assignment Hierarchy

```text id="1crs0o"
Management Group
        │
        ▼
Subscription
        │
        ▼
Resource Group
        │
        ▼
Resource
```

Policy assignments inherit through the Azure resource hierarchy unless explicitly excluded.

---

# 4. Standard Policy Categories

| Category            | Purpose                                            |
| ------------------- | -------------------------------------------------- |
| Security            | Enforce secure configurations                      |
| Networking          | Standardize network configuration                  |
| Resource Governance | Control supported resource types and locations     |
| Tagging             | Enforce mandatory metadata                         |
| Monitoring          | Ensure diagnostic settings are enabled             |
| Compliance          | Support regulatory and organizational requirements |

---

# 5. Policy Effects

| Effect                | Purpose                                                        |
| --------------------- | -------------------------------------------------------------- |
| **Audit**             | Identify non-compliant resources without blocking deployments. |
| **Deny**              | Prevent deployment of non-compliant resources.                 |
| **DeployIfNotExists** | Automatically deploy required configurations when missing.     |
| **Modify**            | Automatically remediate resource properties during deployment. |

---

# 6. Design Benefits

* Automated governance
* Consistent policy enforcement
* Reduced configuration drift
* Improved compliance
* Lower operational effort
* Enhanced platform security

---

# 7. Design Decision

## Decision

Mandara Global has decided to use Azure Policy as the primary governance enforcement mechanism across the Azure Enterprise Cloud Foundation.

## Rationale

Azure Policy enables governance to be enforced automatically rather than relying on manual operational processes. By applying policies consistently across Management Groups and subscriptions, Mandara Global ensures standardized deployments, improved security, regulatory compliance, and operational consistency in support of the **OneCloud 2030** transformation program.

---

# 8. Related Documents

| Document | Description                |
| -------- | -------------------------- |
| GOV-001  | Cloud Governance Strategy  |
| GOV-002  | Management Groups Strategy |
| GOV-006  | RBAC Strategy              |
| GOV-008  | Tagging Strategy           |
| GOV-009  | Landing Zone Design        |

---

# Key Takeaways

* Azure Policy is the primary governance enforcement mechanism for the Azure Enterprise Cloud Foundation.
* Policies are assigned at the highest appropriate scope to maximize consistency and simplify administration.
* Governance controls are applied automatically throughout the resource lifecycle.
* The Azure Policy strategy supports Mandara Global's secure, compliant, and scalable cloud operating model as part of the **OneCloud 2030** transformation program.
