# Enterprise Workplace OS Migration

> Sanitized reconstruction of a large-scale enterprise workplace migration from Microsoft Windows to Astra Linux in a banking environment.

[![Case Study](https://img.shields.io/badge/type-system%20analysis-222222)](#)
[![Status](https://img.shields.io/badge/status-complete-2ea44f)](#)
[![Documentation](https://img.shields.io/badge/docs-structured-blue)](#)
[![OpenAPI](https://img.shields.io/badge/API-OpenAPI%203.0-orange)](#)
[![SQL](https://img.shields.io/badge/data-PostgreSQL-336791)](#)

---

## Overview

This repository presents a structured system-analysis reconstruction of a real enterprise migration initiative involving workplace transition from Microsoft Windows to Astra Linux.

The original initiative covered a large number of employee workplaces and required coordination across workplace support, infrastructure automation, information security, software support, and other adjacent teams.

The repository focuses on the analytical side of the migration:

- scope and system boundaries;
- current-state workplace environment;
- migration dependencies;
- business rules;
- functional and non-functional requirements;
- acceptance criteria;
- requirements traceability;
- conceptual and relational data models;
- SQL examples;
- REST API design;
- JSON contracts;
- OpenAPI specification;
- integration rules;
- process, sequence, dependency, ERD and state-machine diagrams.

The purpose of this repository is to demonstrate how a complex enterprise operational process can be converted into a consistent set of system-analysis artifacts.

---

## Case Context

The migration programme was part of a broader transition of enterprise workplace infrastructure to a domestic Linux-based operating environment.

The operational scope included:

- standard office workplaces;
- remote workplaces;
- protected or restricted workplaces;
- developer workplaces;
- specialized workplaces with non-standard software requirements.

The migration itself was highly automated.

A typical flow was:

1. A workplace was assigned a migration date.
2. The user received a notification.
3. If the user had a valid reason to postpone migration, they created a Service Desk request.
4. If no postponement request was received, migration proceeded as scheduled.
5. Automated migration tooling executed the migration.
6. If the automated process failed technically, Workplace Support performed a manual migration.
7. Migration blockers, compatibility issues and transitional states were tracked separately.

---

## Analytical Goals

This case is designed to answer several system-analysis questions:

- What is the migration target: user, workplace, operating system or business capability?
- What dependencies determine migration readiness?
- How should migration blockers be modeled?
- How do postponement and rescheduling affect lifecycle state?
- What is the difference between migration planning and actual migration execution?
- How should migration attempts be stored and traced?
- How should software compatibility affect migration decisions?
- How can automated and manual migration paths coexist?
- How should external systems report migration results safely?
- How should duplicate requests, retries, timeouts and stale events be handled?
- What should be represented as business rules, requirements, states, events and data entities?

---

## Repository Structure

```text
enterprise-workplace-os-migration/
│
├── docs/
│   ├── 01-context-and-scope.md
│   ├── 02-as-is.md
│   ├── 03-dependency-model.md
│   ├── 04-business-rules.md
│   ├── 05-functional-requirements.md
│   ├── 06-non-functional-requirements.md
│   ├── 07-acceptance-criteria.md
│   ├── 08-requirements-traceability-matrix.md
│   ├── 09-migration-data-model.md
│   └── 10-workplace-state-model.md
│
├── diagrams/
│   ├── dependency-model.puml
│   ├── migration-process.puml
│   ├── migration-data-model.puml
│   ├── postponement-sequence.puml
│   ├── manual-migration-sequence.puml
│   └── workplace-state-machine.puml
│
├── api/
│   ├── 01-api-overview.md
│   ├── 02-endpoints.md
│   ├── 03-json-contracts.md
│   ├── 04-integration-rules.md
│   └── openapi.yaml
│
├── sql/
│   ├── 01-schema.sql
│   ├── 02-sample-data.sql
│   └── 03-analysis-queries.sql
│
└── README.md
```

---

## Key Artifacts

### Context and Scope

`docs/01-context-and-scope.md`

Defines:

- programme context;
- migration scope;
- system boundaries;
- operational success criteria;
- key constraints.

### AS-IS Model

`docs/02-as-is.md`

Describes the current workplace environment before migration, including:

- workplace types;
- standard and specialized software;
- corporate services;
- access dependencies;
- security constraints;
- support responsibility boundaries.

### Dependency Model

`docs/03-dependency-model.md`  
`diagrams/dependency-model.puml`

Shows how migration readiness depends on:

- user business activity;
- workplace;
- operating system;
- software;
- software compatibility;
- access rights;
- corporate services;
- security controls;
- hardware;
- support teams.

A simplified dependency chain:

```text
User
  ↓
Business Activity
  ↓
Required Software / Corporate Services
  ↓
Operating System Compatibility
  ↓
Migration Readiness
```

### Business Rules

`docs/04-business-rules.md`

Examples:

```text
BR-003
If no postponement request is received before the planned migration date,
the workplace remains eligible for migration.
```

```text
BR-009
A technical automated-migration failure triggers manual migration handling.
```

```text
BR-014
Installation of Astra Linux alone does not guarantee operational migration success.
```

### Functional Requirements

`docs/05-functional-requirements.md`

Covers:

- workplace scheduling;
- user notification;
- postponement registration;
- rescheduling;
- migration status tracking;
- blocker management;
- migration-attempt recording;
- compatibility tracking;
- dual-boot support;
- operational reporting.

### Non-Functional Requirements

`docs/06-non-functional-requirements.md`

Focuses on:

- business continuity;
- recoverability;
- data preservation;
- access preservation;
- security compliance;
- traceability;
- auditability;
- controlled rollout;
- supportability;
- operational transparency.

### Acceptance Criteria

`docs/07-acceptance-criteria.md`

Defines how requirements can be verified.

Example trace:

```text
BR-009
Technical failure triggers manual migration
        ↓
FR-010
Failed automated migration is transferred to manual processing
        ↓
AC-007
The failure is recorded and the workplace becomes visible for manual intervention
```

### Requirements Traceability

`docs/08-requirements-traceability-matrix.md`

Links:

```text
Business Rules
      ↓
Functional Requirements
      ↓
Non-Functional Requirements
      ↓
Acceptance Criteria
```

The matrix helps identify:

- requirements without validation;
- acceptance criteria without requirements;
- business rules not represented in system behavior;
- gaps between process logic and implementation expectations.

---

## Data Model

`docs/09-migration-data-model.md`  
`diagrams/migration-data-model.puml`

The conceptual model includes:

- User
- Workplace
- WorkplaceProfile
- Software
- WorkplaceSoftware
- CompatibilityAssessment
- MigrationSchedule
- PostponementRequest
- MigrationAttempt
- MigrationBlocker
- AccessDependency
- SupportTeam

A key modeling decision is separating planning from execution:

```text
MigrationSchedule
    = planned migration

MigrationAttempt
    = actual execution attempt
```

This allows the model to represent:

- repeated rescheduling;
- failed automated attempts;
- subsequent manual migration;
- historical migration analysis.

---

## SQL

The `sql/` directory contains a simplified PostgreSQL implementation of the conceptual model.

### Schema

`sql/01-schema.sql`

Includes primary keys, foreign keys, many-to-many relations, indexes and migration-history entities.

### Synthetic Data

`sql/02-sample-data.sql`

Contains fictional scenarios such as:

- successful automated migration;
- software compatibility blocker;
- dual-boot transition;
- approved postponement;
- remote workplace;
- automated failure followed by successful manual migration.

### Analysis Queries

`sql/03-analysis-queries.sql`

Demonstrates:

- `SELECT`
- `WHERE`
- `JOIN`
- `LEFT JOIN`
- `DISTINCT`
- `GROUP BY`
- `HAVING`
- `COUNT`
- `MAX`
- `EXISTS`
- subqueries
- consistency checks

Examples include blocked workplaces, incompatible software dependencies, users with multiple workplaces, failed automated migrations, manual recovery cases, open blockers and data-consistency issues.

---

## REST API

The `api/` directory contains a simplified Migration Management API design.

### API Overview

`api/01-api-overview.md`

Main resources:

```text
/users
/workplaces
/software
/migration-schedules
/migration-attempts
/migration-blockers
/postponement-requests
/compatibility-assessments
```

### Endpoints

`api/02-endpoints.md`

Examples:

```http
GET /api/v1/workplaces
GET /api/v1/workplaces/{workplaceId}
GET /api/v1/workplaces/{workplaceId}/software
GET /api/v1/workplaces/{workplaceId}/migration-attempts

POST /api/v1/migration-schedules
PATCH /api/v1/migration-schedules/{scheduleId}

POST /api/v1/postponement-requests
PATCH /api/v1/postponement-requests/{requestId}

POST /api/v1/migration-attempts

POST /api/v1/migration-blockers
PATCH /api/v1/migration-blockers/{blockerId}
```

### JSON Contracts

`api/03-json-contracts.md`

Defines field types, required and optional fields, nullable fields, enums, validation rules and a common error model.

Example:

```json
{
  "workplaceId": 106,
  "executionType": "automated",
  "result": "failed",
  "migrationDate": "2026-04-08T09:00:00Z",
  "technicalError": "OS deployment failed"
}
```

### OpenAPI

`api/openapi.yaml`

Contains a machine-readable OpenAPI 3.0 contract for the Migration Management API, including endpoints, request bodies, responses, reusable schemas, error models, path parameters, enums and validation constraints.

---

## Integration Rules

`api/04-integration-rules.md`

The integration model covers production-oriented concerns such as:

- idempotency;
- duplicate request handling;
- conflicting duplicates;
- retries;
- exponential backoff;
- timeout semantics;
- concurrency;
- stale events;
- event ordering;
- transaction consistency;
- correlation identifiers;
- authentication and authorization boundaries.

Example idempotency rule:

```text
The combination of sourceSystem + externalAttemptId
must identify exactly one migration attempt.
```

Repeated delivery must not create duplicate business effects.

---

## Diagrams

The repository uses PlantUML for version-controlled diagrams.

### Dependency Diagram

`diagrams/dependency-model.puml`

Shows structural dependencies affecting migration readiness.

### Migration Process

`diagrams/migration-process.puml`

Shows:

```text
Schedule
  ↓
User Notification
  ↓
Postponement?
  ↓
Automated Migration
  ↓
Success / Manual Recovery
```

### ERD

`diagrams/migration-data-model.puml`

Shows relationships between migration entities.

### Postponement Sequence

`diagrams/postponement-sequence.puml`

Shows interaction between User, Service Desk, Migration Management API, Migration Database, Support Team and Notification Service.

### Manual Migration Sequence

`diagrams/manual-migration-sequence.puml`

Shows the transition from automated failure to Workplace Support intervention.

### Workplace State Machine

`diagrams/workplace-state-machine.puml`

Defines allowed migration-state transitions.

Example:

```text
Scheduled
    ↓
Ready
    ↓
Migration In Progress
   ↙                  ↘
Migrated       Manual Migration Required
                       ↓
                    Migrated
```

---

## Architecture Perspective

The portfolio reconstruction assumes the following simplified system boundary:

```text
                   ┌──────────────────────┐
                   │     Service Desk     │
                   └──────────┬───────────┘
                              │
                              v
┌────────────────┐   ┌──────────────────────┐
│ Support / Admin│──>│ Migration Management │
│      UI        │   │         API          │
└────────────────┘   └──────────┬───────────┘
                                │
                                v
                     ┌──────────────────────┐
                     │  Migration Database  │
                     └──────────┬───────────┘
                                ^
                                │
                     ┌──────────┴───────────┐
                     │ Automated Migration  │
                     │        Tooling       │
                     └──────────┬───────────┘
                                │
                                v
                     ┌──────────────────────┐
                     │      Workplace       │
                     └──────────────────────┘
```

The Migration Management Service does not directly install operating systems.

Its responsibility is to manage migration state, schedules, blockers, attempts, compatibility information and integration data.

---

## Key Analytical Decisions

### Workplace is not the same as User

Migration is performed on a workplace, while business impact belongs to the user.

```text
User 1 ─── N Workplace
```

### Migration planning is not migration execution

```text
MigrationSchedule ≠ MigrationAttempt
```

A workplace may be scheduled multiple times but migrated once. It may also have multiple execution attempts.

### Compatibility is not binary

A replacement can exist and still be insufficient for the required business workflow.

Therefore compatibility includes states such as:

```text
compatible
partial
under_development
no_replacement
unknown
```

### Dual boot is transitional

Dual boot indicates that Astra Linux has been introduced, but Windows is still required for unresolved business dependencies.

It is not treated as the final operational target.

### External systems report facts

External systems should report events such as:

```text
automated migration failed
```

The Migration Management Service decides the resulting business state:

```text
manual_migration_required
```

This prevents external tools from directly controlling internal lifecycle state.

---

## Technologies and Notations

This repository uses:

- Markdown — documentation;
- PlantUML — diagrams;
- PostgreSQL-style SQL — relational data model;
- REST — API design;
- JSON — data exchange contracts;
- OpenAPI 3.0 — machine-readable API specification;
- UML-style sequence and state diagrams;
- conceptual ER modeling;
- requirements traceability.

---

## What This Repository Demonstrates

### Business and Process Analysis

- scope clarification;
- current-state analysis;
- dependency identification;
- business-rule extraction;
- exception handling.

### Requirements Engineering

- functional requirements;
- non-functional requirements;
- acceptance criteria;
- traceability.

### System Modeling

- dependency modeling;
- lifecycle modeling;
- data modeling;
- sequence modeling;
- responsibility boundaries.

### Data

- relational decomposition;
- many-to-many relationships;
- SQL joins and analytical queries;
- data-quality checks.

### Integration

- REST API design;
- JSON contracts;
- OpenAPI;
- error handling;
- idempotency;
- retries;
- timeouts;
- concurrency;
- state consistency.

---

## Disclaimer

This repository is a sanitized reconstruction of a real enterprise migration case.

Internal system names, organization-specific processes, employee data, technical identifiers, infrastructure details and confidential information have been removed, generalized or replaced with synthetic examples.

The repository does not contain:

- original internal documentation;
- real production data;
- employee personal data;
- internal credentials;
- confidential infrastructure information;
- proprietary source code.

The API, database schema and diagrams are analytical reconstructions created for educational and portfolio purposes.

---

## Author

**Daniil Moore**  
System Analyst / Enterprise IT

Focus areas:

- enterprise systems;
- system analysis;
- integrations;
- infrastructure transformation;
- requirements engineering;
- technical process decomposition.
