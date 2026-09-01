# Azure Enterprise Cloud Foundation

![Status](https://img.shields.io/badge/Status-Active-blue)
![Platform](https://img.shields.io/badge/Platform-Microsoft%20Azure-0078D4)
![IaC](https://img.shields.io/badge/IaC-Terraform-7B42BC)
![Architecture](https://img.shields.io/badge/Architecture-Enterprise-success)
![License](https://img.shields.io/badge/License-MIT-green)

> **Enterprise Azure Landing Zone & Cloud Foundation Reference Architecture**

A production-inspired Azure Enterprise Cloud Foundation demonstrating enterprise architecture, governance, security, networking, Infrastructure as Code, and platform engineering based on the fictional multinational company **Mandara Global** and its **OneCloud 2030** transformation program.

---

# Executive Summary

The Azure Enterprise Cloud Foundation is a production-inspired reference implementation of an enterprise cloud platform built on Microsoft Azure.

Rather than focusing solely on Azure infrastructure deployment, this project follows an **Architecture-First** approach where business objectives, cloud strategy, governance, and architecture principles drive technical decisions.

The repository demonstrates how an enterprise cloud platform evolves from business vision to Infrastructure as Code while applying consistent principles for governance, security, networking, and platform engineering.

---

# Table of Contents

- Executive Summary
- Project Overview
- Architecture Lifecycle
- High-Level Architecture
- Repository Structure
- Project Status
- Project Roadmap
- Guiding Principles
- Technology Stack
- Architecture Decision Records
- Repository Goals
- What's Next
- Disclaimer

---

# Project Overview

This repository demonstrates how an enterprise organization designs, governs, and implements a modern Azure Cloud Foundation.

Instead of concentrating only on Azure resources, the project emphasizes the complete enterprise architecture lifecycle—from business strategy and governance to Infrastructure as Code and platform capabilities.

The project showcases:

- Enterprise Architecture
- Cloud Strategy
- Cloud Governance
- Security by Design
- Enterprise Networking
- Platform Engineering
- Infrastructure as Code
- Operational Excellence

The implementation is traceable to documented architecture decisions and governance standards.

---

# Architecture Lifecycle

The project follows a structured lifecycle from business intent to implementation:

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
High-Level Architecture
        │
        ▼
Governance
        │
        ▼
Architecture Decisions
        │
        ▼
Reference Architectures
        │
        ▼
Terraform Implementation
        │
        ▼
Azure Platform
```

This structure provides traceability from business objectives through architecture and governance to implementation.

---

# High-Level Architecture

The current enterprise model separates governance, shared platform capabilities, and workload Landing Zones.

```text
                         Tenant Root
                              │
                       Mandara Global
                              │
              ┌───────────────┼───────────────┐
              │               │               │
              ▼               ▼               ▼
          Governance       Platform      Decommissioned
                              │
                    Platform Capabilities
                              │
                              ▼
                       Landing Zones
                              │
                    ┌─────────┼─────────┐
                    │         │         │
                   Corp     Online    Sandbox
                    │         │         │
                    └─────────┼─────────┘
                              │
                        Subscriptions
                              │
                        Resource Groups
                              │
                           Resources
```

The five shared Platform Capabilities are:

- Management
- Connectivity
- Security
- Operations
- Identity

**Management Groups and Platform Capabilities are distinct concepts:** Management Groups provide the Azure governance hierarchy, while Platform Capabilities represent shared platform responsibilities and services.

---

# Repository Structure

The repository is organized according to enterprise architecture domains and implementation concerns.

```text
azure-enterprise-cloud-foundation/

├── docs/
│   ├── 01-business/       Business Discovery & Requirements
│   ├── 02-strategy/       Cloud Strategy
│   ├── 03-architecture/   Architecture Design
│   ├── 04-governance/     Governance Framework
│   ├── 08-decisions/      Architecture Decision Records
│   ├── 09-reference/      Reference Architectures
│   └── 10-terraform/      Terraform Documentation
│
├── terraform/              Infrastructure as Code
├── images/                 Architecture & documentation assets
├── scripts/                Supporting scripts
└── tests/                  Validation & test assets
```

This structure reflects the current repository and separates architecture documentation from implementation.

---

# Project Status

## Current Phase

**Enterprise Cloud Foundation — Platform Foundation & Governance completed**

### Progress Overview

| Sprint | Focus | Status |
|---|---|:---:|
| Sprint 1 | Business & Strategy | ✅ Completed |
| Sprint 2 | Governance | ✅ Completed |
| Sprint 3 | Architecture Decision Records | ✅ Completed |
| Sprint 4 | Enterprise Reference Architectures | ✅ Completed |
| Sprint 5 | Terraform Foundation | ✅ Completed |
| Sprint 6 | Platform Foundation & Governance | ✅ Completed |

### Current Release

**v0.6.0 — Sprint 6 - Platform Foundation & Governance**

### Completed Deliverables

| Domain | Deliverables | Status |
|---|---|:---:|
| Business | Enterprise Profile, Business Requirements | ✅ |
| Strategy | Cloud Strategy | ✅ |
| Architecture | Architecture Principles, High-Level Architecture, Enterprise Reference Architecture | ✅ |
| Governance | Governance Framework, Management Groups, Naming & Tagging Standards, Azure Policy guardrails | ✅ |
| Decisions | ADR-001 → ADR-010 | ✅ |
| Reference | Enterprise Landing Zone, Connectivity, and Platform Services reference architectures | ✅ |
| Terraform | Foundation, remote state, repository architecture, platform, Landing Zones, reusable modules, environment structure, bootstrap | ✅ |
| Platform | Management, Connectivity, Security, Operations, Identity | ✅ |

---

# Project Roadmap

## Sprint 1 — Business & Strategy ✅

- Enterprise Profile
- Business Requirements
- Cloud Strategy
- Architecture Principles
- High-Level Architecture
- Enterprise Reference Architecture

---

## Sprint 2 — Governance ✅

- Governance Framework
- Management Group Hierarchy
- Subscription Strategy
- Naming Convention Standard
- Tagging Strategy
- Governance Documentation

---

## Sprint 3 — Architecture Decision Records ✅

- ADR-001 Enterprise Landing Zone Architecture
- ADR-002 Hub & Spoke Network Architecture
- ADR-003 Terraform as Infrastructure as Code
- ADR-004 Enterprise Management Group Hierarchy
- ADR-005 Private Networking Strategy
- ADR-006 Enterprise Identity Strategy
- ADR-007 Enterprise Monitoring & Observability Strategy
- ADR-008 Enterprise Security Baseline
- ADR-009 Enterprise Naming Convention Standard
- ADR-010 Enterprise Tagging Strategy

---

## Sprint 4 — Enterprise Reference Architectures ✅

- Enterprise Landing Zone Reference Architecture
- Enterprise Connectivity Reference Architecture
- Enterprise Platform Services Reference Architecture

---

## Sprint 5 — Terraform Foundation ✅

- Terraform foundation
- Remote state
- Repository architecture
- Platform structure
- Landing Zone structure
- Reusable modules
- Environment and deployment structure
- Terraform bootstrap

---

## Sprint 6 — Platform Foundation & Governance ✅

- Management capability
- Connectivity capability
- Security capability
- Operations capability
- Identity capability
- Reusable policy module
- Allowed Locations policy
- Required Tags policy
- Subscription-level policy assignments
- Terraform validation and clean plan
- Terraform foundation documentation

### Release

**v0.6.0 — Sprint 6 - Platform Foundation & Governance**

---

# Guiding Principles

The foundation is guided by ten architecture principles:

| ID | Principle |
|---|---|
| AP-001 | Business Before Technology |
| AP-002 | Platform over Projects |
| AP-003 | Infrastructure as Code |
| AP-004 | Security by Design |
| AP-005 | Zero Trust |
| AP-006 | Automation First |
| AP-007 | Standardization over Customization |
| AP-008 | Shared Services First |
| AP-009 | Observability by Default |
| AP-010 | AI Ready |

These principles guide architecture and implementation decisions across the foundation.

---

# Technology Stack

| Domain | Technologies |
|---|---|
| Cloud Platform | Microsoft Azure |
| Infrastructure as Code | Terraform |
| Identity | Microsoft Entra ID |
| Governance | Management Groups, Azure Policy |
| Networking | Hub & Spoke, Private Link, Private DNS, Azure Firewall |
| Security | Microsoft Defender for Cloud, Azure Key Vault |
| Monitoring | Azure Monitor, Log Analytics, Managed Grafana, Microsoft Sentinel |
| DevOps | GitHub, GitHub Actions |

---

# Architecture Decision Records

Architecture decisions are documented as **Architecture Decision Records (ADR)** to provide traceability and a clear rationale for major architectural choices.

The repository contains **10 ADRs** covering the core decisions of the foundation.

| ADR | Decision |
|---|---|
| ADR-001 | Enterprise Landing Zone Architecture |
| ADR-002 | Hub & Spoke Network Architecture |
| ADR-003 | Terraform as Infrastructure as Code |
| ADR-004 | Enterprise Management Group Hierarchy |
| ADR-005 | Private Networking Strategy |
| ADR-006 | Enterprise Identity Strategy |
| ADR-007 | Enterprise Monitoring & Observability Strategy |
| ADR-008 | Enterprise Security Baseline |
| ADR-009 | Enterprise Naming Convention Standard |
| ADR-010 | Enterprise Tagging Strategy |

The ADRs document the context, decision, drivers, alternatives, consequences, and relationships relevant to each major decision.

---

# Repository Goals

The Azure Enterprise Cloud Foundation demonstrates how an enterprise Azure platform can be designed from business strategy through to Infrastructure as Code.

It aims to showcase:

- Enterprise Architecture
- Azure Cloud Governance
- Secure Platform Design
- Enterprise Networking
- Infrastructure as Code
- Platform Engineering
- Operational Excellence
- Architectural traceability

The implementation is intentionally **production-inspired**, not a claim of production deployment. The goal is to demonstrate sound enterprise architecture and engineering practices while keeping the solution understandable and maintainable.

---

# What's Next

The next phase focuses on extending the established platform foundation toward workload-ready Azure Landing Zones.

Upcoming work will build on the completed architecture, Terraform foundation, Platform Capabilities, and governance guardrails while keeping the implementation pragmatic and aligned with the project's architecture principles.

---

# Contributing

This repository is primarily a personal learning and portfolio project.

Suggestions, feedback, and discussions about Azure architecture, governance, Infrastructure as Code, and platform engineering are welcome.

If you have ideas for improvements, feel free to open an issue or submit a pull request.

---

# License

This project is licensed under the MIT License.

See the **LICENSE** file for more information.

---

# Disclaimer

**Mandara Global** and the **OneCloud 2030** transformation program are fictional and have been created exclusively for educational and portfolio purposes.

The architecture presented in this repository is inspired by Microsoft Azure Cloud Adoption Framework, Azure Landing Zone guidance, and enterprise architecture best practices. It does not represent any real organization or production environment.
