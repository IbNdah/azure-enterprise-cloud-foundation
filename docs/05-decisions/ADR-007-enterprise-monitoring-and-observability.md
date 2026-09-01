# ADR-007 — Enterprise Monitoring and Observability Strategy

| Attribute | Value |
|---|---|
| **ADR ID** | ADR-007 |
| **Title** | Enterprise Monitoring and Observability Strategy |
| **Version** | 1.1 |
| **Status** | Accepted |
| **Date** | 2026-09-01 |
| **Authors** | Cloud Architecture Team |
| **Program** | OneCloud 2030 |
| **Organization** | Mandara Global |
| **Category** | Monitoring / Operations |

---

# 1. Executive Summary

Mandara Global will provide centralized monitoring and observability capabilities as part of the Azure platform foundation.

The approach is based on **Azure Monitor**, **Log Analytics** and diagnostic settings, with shared platform capabilities used where appropriate.

The objective is to provide visibility into platform and workload health while avoiding unnecessary duplication of monitoring services.

Monitoring is a shared **Platform Capability** and is not itself a Management Group.

---

# 2. Business Context

The enterprise cloud foundation requires consistent visibility into the health, performance and operational state of Azure resources.

Monitoring must support:

- platform operations;
- workload operations;
- incident investigation;
- security and governance activities;
- operational troubleshooting;
- service health visibility.

The model must remain scalable across Management Groups, subscriptions and Landing Zones.

---

# 3. Problem Statement

Without a common monitoring approach, each Landing Zone could implement different logging, diagnostic and alerting patterns.

This would make operational visibility inconsistent and increase administration effort.

The platform therefore requires a common monitoring foundation while allowing workloads to define additional monitoring requirements.

---

# 4. Decision

Mandara Global will use the following monitoring model:

| Component | Role |
|---|---|
| **Azure Monitor** | Central monitoring and metrics platform |
| **Log Analytics Workspace** | Central log collection and analysis |
| **Diagnostic Settings** | Route supported resource logs and metrics to monitoring destinations |
| **Alerts** | Detect defined operational conditions |
| **Action Groups** | Route alert notifications where required |
| **Workbooks / Dashboards** | Provide operational views where useful |

Monitoring components should be centralized where this provides operational value, while workload-specific monitoring can remain within the workload boundary when justified.

---

# 5. High-Level Monitoring Model

```text
                    Azure Platform
                          │
             ┌────────────┴────────────┐
             │                         │
             ▼                         ▼
      Platform Resources         Landing Zone
                                      │
                                      ▼
                                  Workloads
             │                         │
             └────────────┬────────────┘
                          │
                   Diagnostic Settings
                          │
                          ▼
                Log Analytics Workspace
                          │
                          ▼
                    Azure Monitor
                     │          │
                     ▼          ▼
                   Alerts   Dashboards
                     │
                     ▼
                Operations Team
```

The diagram represents the monitoring flow conceptually. Not every Azure resource necessarily sends every available signal to the same destination.

---

# 6. Logging and Diagnostics

Supported Azure resources should use diagnostic settings where logging is required.

Logs and metrics should be routed to the appropriate monitoring destination according to the resource and operational requirement.

The platform provides a reusable diagnostic-settings capability to avoid repeated implementation patterns.

The design should avoid collecting data that has no operational, security or governance value.

---

# 7. Monitoring Scope

Monitoring is applied at different levels:

| Scope | Example |
|---|---|
| **Platform** | Connectivity, identity, security and management services |
| **Landing Zone** | Subscription and shared workload infrastructure |
| **Workload** | Application-specific resources and services |

Platform monitoring provides shared visibility.

Landing Zones and workloads remain responsible for monitoring requirements that are specific to their services.

---

# 8. Alerts

Alerts should be created for conditions that require operational attention.

Typical categories include:

- availability;
- resource health;
- capacity;
- performance;
- security-relevant events;
- operational failures.

Alerts should be actionable and avoid unnecessary notification noise.

Not every metric requires an alert.

---

# 9. Security and Monitoring

Monitoring is complementary to the enterprise security baseline.

Security-relevant logs and signals should be retained and integrated with the appropriate security monitoring processes where required.

Monitoring itself does not replace:

- Azure Policy;
- RBAC;
- network controls;
- security controls;
- identity controls.

It provides visibility into their operation and the state of the environment.

---

# 10. Decision Drivers

| Driver | Reason |
|---|---|
| **Visibility** | Understand platform and workload health |
| **Operations** | Support incident investigation and troubleshooting |
| **Consistency** | Establish repeatable monitoring patterns |
| **Scalability** | Support multiple subscriptions and Landing Zones |
| **Cost Control** | Avoid unnecessary log collection and duplicated services |
| **Governance** | Provide evidence and operational visibility |
| **Security** | Support detection and investigation activities |

---

# 11. Architectural Principles

| Principle | Application |
|---|---|
| **Central Monitoring Foundation** | Provide shared monitoring capabilities |
| **Operational Relevance** | Collect data that has a defined purpose |
| **Actionable Alerts** | Alert only when action is required |
| **Appropriate Ownership** | Platform monitors platform services; workloads monitor workload-specific behavior |
| **Reusable Patterns** | Use common Terraform modules |
| **Controlled Retention** | Retain data according to operational and governance requirements |
| **Scalable Design** | Support multiple subscriptions and Landing Zones |

---

# 12. Alternatives Considered

| Option | Decision | Rationale |
|---|---|---|
| **Independent monitoring per subscription** | Rejected as default | Creates duplication and fragmented visibility |
| **Central monitoring only** | Rejected | Does not cover all workload-specific requirements |
| **Central foundation + workload-specific monitoring** | **Selected** | Balances consistency, ownership and flexibility |
| **Collect all available logs** | Rejected | Unnecessary cost and operational noise |

---

# 13. Expected Benefits

| Area | Benefit |
|---|---|
| Operations | Faster troubleshooting and incident analysis |
| Visibility | Common view of platform health |
| Governance | Consistent monitoring expectations |
| Scalability | Reusable pattern across Landing Zones |
| Cost | Controlled data collection |
| Security | Improved visibility into relevant security events |

---

# 14. Consequences

### Positive

- Consistent monitoring foundation
- Shared operational visibility
- Reusable diagnostic configuration
- Clear ownership between platform and workloads
- Reduced monitoring duplication

### Trade-offs

- Central monitoring services become important shared platform dependencies
- Log ingestion and retention create ongoing costs
- Poorly designed alerts can create operational noise
- Monitoring requires ongoing maintenance

These trade-offs are accepted because operational visibility is a core requirement of the enterprise platform.

---

# 15. Scope and Boundaries

This decision applies to:

- Azure platform services;
- Landing Zone infrastructure;
- shared monitoring capabilities;
- Azure Monitor;
- Log Analytics;
- diagnostic settings;
- platform-level alerts.

It does not prescribe:

- application-specific observability frameworks;
- application logging formats;
- a single dashboard for every workload;
- retention periods independent of governance or operational requirements.

---

# 16. Relationship to Other Architecture Decisions

| Document | Relationship |
|---|---|
| **ADR-001** | Enterprise Landing Zone architecture |
| **ADR-002** | Hub & Spoke network architecture |
| **ADR-003** | Terraform as the IaC standard |
| **ADR-004** | Management Group governance hierarchy |
| **ADR-005** | Private networking |
| **ADR-006** | Enterprise identity strategy |
| **ADR-008** | Enterprise security baseline |
| **GOV-001** | Governance strategy |
| **GOV-009** | Landing Zone design |
| **ARC-003** | Enterprise reference architecture |

---

# 17. Implementation Alignment

Monitoring is implemented as a dedicated **Operations platform capability** within the Terraform foundation.

The current Terraform foundation provides reusable modules for:

- Log Analytics;
- diagnostic settings;
- monitoring-related resources.

The implementation should follow:

```text
Platform
   │
   └── Operations Capability
           │
           ├── Log Analytics
           ├── Diagnostics
           └── Monitoring
                    │
                    ▼
              Landing Zones
                    │
                    ▼
                 Workloads
```

Monitoring resources and configuration should be managed through Terraform where they are part of the foundation.

---

# 18. Review

This decision should be reviewed when significant changes occur to:

- Azure Monitor capabilities;
- enterprise operational requirements;
- logging or retention requirements;
- Landing Zone architecture;
- security monitoring requirements;
- platform operating model.

---

# 19. References

- Azure Monitor
- Azure Log Analytics
- Azure Diagnostic Settings
- GOV-009 — Landing Zone Design
- ARC-003 — Enterprise Reference Architecture
- ADR-001 — Enterprise Landing Zone Architecture
