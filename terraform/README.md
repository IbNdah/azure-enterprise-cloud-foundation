# Azure Enterprise Cloud Foundation

![Platform](https://img.shields.io/badge/Platform-Microsoft%20Azure-0078D4)
![IaC](https://img.shields.io/badge/IaC-Terraform-7B42BC)
![Architecture](https://img.shields.io/badge/Architecture-Enterprise-success)
![Status](https://img.shields.io/badge/Status-In%20Progress-blue)
![License](https://img.shields.io/badge/License-MIT-green)

> **Designing a production-inspired Azure Enterprise Cloud Foundation from business strategy to Infrastructure as Code.**

This repository demonstrates how an enterprise cloud platform can be designed, governed and implemented using Microsoft Azure and Terraform.

Unlike most Azure Landing Zone projects, this repository starts with **business objectives, enterprise architecture and governance** before implementing the platform itself.

---

# Why this project?

Most Infrastructure as Code projects begin by deploying Azure resources.

This project intentionally begins much earlier.

It demonstrates how enterprise cloud platforms evolve through a structured lifecycle where architecture decisions, governance standards and platform design guide every technical implementation.

The objective is not only to deploy Azure resources, but to demonstrate the reasoning behind an enterprise cloud platform.

---

# Enterprise Capabilities

The project covers the major capabilities expected from an Enterprise Cloud Foundation:

- Enterprise Architecture
- Cloud Strategy
- Cloud Governance
- Azure Landing Zones
- Infrastructure as Code
- Platform Engineering
- Enterprise Networking
- Security by Design
- Architecture Decision Records (ADR)

---

# Architecture Lifecycle

```text
Business Strategy
        │
        ▼
Enterprise Architecture
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
Terraform Foundation
        │
        ▼
Azure Platform Services
        │
        ▼
Landing Zones
```

Every implementation within this repository can be traced back to documented architectural decisions.

---

# Repository Structure

```text
azure-enterprise-cloud-foundation/

docs/
terraform/
scripts/
images/
tests/
```

Terraform follows a modular enterprise structure.

```text
terraform/

├── backend/
├── environments/
├── landingzones/
├── modules/
├── platform/
├── locals.tf
├── main.tf
├── providers.tf
├── variables.tf
└── versions.tf
```

---

# Current Status

| Area | Status |
|------|:------:|
| Enterprise Architecture | ✅ |
| Governance | ✅ |
| Architecture Decision Records | ✅ |
| Enterprise Reference Architectures | ✅ |
| Terraform Foundation | ✅ |
| Azure Platform Services | 🚧 |

Current focus:

**Sprint 6 – Azure Platform Services**

---

# Technology Stack

| Domain | Technologies |
|---------|--------------|
| Cloud Platform | Microsoft Azure |
| Infrastructure as Code | Terraform |
| Identity | Microsoft Entra ID |
| Governance | Azure Policy · Management Groups |
| Networking | Hub & Spoke · Private Link · Azure Firewall |
| Security | Defender for Cloud · Key Vault |
| Monitoring | Azure Monitor · Log Analytics · Microsoft Sentinel |
| DevOps | GitHub · GitHub Actions |

---

# Roadmap

## Completed

- Enterprise Architecture
- Governance Framework
- Architecture Decision Records
- Enterprise Reference Architectures
- Terraform Foundation

## In Progress

- Management Platform
- Connectivity Platform
- Identity Platform
- Landing Zones

## Planned

- Enterprise Policies
- Platform Automation
- CI/CD Pipelines
- Monitoring & Observability

---

# Documentation

The repository contains detailed technical documentation, including:

- Architecture Decision Records (ADR)
- Governance Standards
- Terraform Design Documents
- Enterprise Reference Architectures

Each completed sprint is summarized through a dedicated **GitHub Release**, providing an architectural overview of the delivered capabilities.

---

# Design Principles

Every architectural decision follows the same guiding principle:

> **Introduce complexity only when justified by a real business or technical requirement.**

The project favors pragmatic, maintainable and production-inspired solutions over unnecessary complexity.

---

# License

This project is licensed under the MIT License.

---

# Disclaimer

**Mandara Global** and the **OneCloud 2030** transformation program are fictional and exist solely for educational and portfolio purposes.

The project is inspired by Microsoft Cloud Adoption Framework, Azure Landing Zone guidance and enterprise architecture best practices.git status
