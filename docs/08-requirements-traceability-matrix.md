# Requirements Traceability Matrix

## Purpose

This document provides traceability between business rules, functional
requirements, non-functional requirements and acceptance criteria for the
enterprise workplace migration process.

The matrix helps verify that migration requirements are supported by
appropriate business logic and have defined acceptance conditions.

---

| Business Rule | Functional Requirement | Non-Functional Requirement | Acceptance Criteria | Description |
|---|---|---|---|---|
| BR-001 | FR-001, FR-002 | NFR-006, NFR-011 | AC-001 | Each workplace must be included in the migration schedule and assigned a migration date. |
| BR-002 | FR-003 | NFR-017 | AC-002 | Users must be notified about the planned migration date. |
| BR-003 | FR-008 | NFR-011 | AC-003 | If no postponement request exists, the workplace remains eligible for migration. |
| BR-004 | FR-004 | NFR-006, NFR-007 | AC-004 | Postponement requests must be registered through the corporate Service Desk. |
| BR-005 | FR-005 | NFR-007 | AC-004, AC-005 | The postponement reason must be reviewed and recorded. |
| BR-006 | FR-006 | NFR-006, NFR-011 | AC-005 | Approved postponement requires rescheduling and user notification. |
| BR-007 | FR-005, FR-008 | NFR-011 | AC-003 | Rejected postponement does not change the original migration schedule. |
| BR-008 | FR-008, FR-009 | NFR-012, NFR-013 | AC-006 | Automated migration is the default execution method. |
| BR-009 | FR-009, FR-010 | NFR-002, NFR-010 | AC-007 | Technical migration failure transfers the workplace to manual processing. |
| BR-010 | FR-010, FR-011 | NFR-001, NFR-002, NFR-010 | AC-008 | Manual migration is performed by Workplace Support. |
| BR-011 | FR-012 | NFR-006, NFR-007, NFR-009 | AC-009 | Confirmed migration blockers must be registered and tracked. |
| BR-012 | FR-013, FR-016 | NFR-014 | AC-010 | Software compatibility affects migration priority and readiness. |
| BR-013 | FR-014 | NFR-015 | AC-011 | Dual boot is a temporary migration state. |
| BR-014 | FR-007, FR-017 | NFR-001, NFR-014 | AC-012 | Astra installation alone is not sufficient for operational migration completion. |
| BR-015 | FR-015 | NFR-016 | AC-010 | Missing Astra functionality may require vendor development or adaptation. |
| BR-016 | FR-018 | NFR-016 | AC-009, AC-012 | Migration readiness may depend on multiple support domains. |
| — | FR-019 | NFR-006, NFR-007 | AC-014 | Migration history must remain traceable. |
| — | FR-020 | NFR-017 | AC-015 | Responsible teams require operational reporting across migration statuses. |
| — | FR-017 | NFR-003, NFR-004, NFR-005 | AC-006, AC-012 | User data, access and security controls must remain operational after migration. |

---

## Traceability Principles

The following traceability logic is used:

Business Rule
→ defines operational decision logic

Functional Requirement
→ defines required process or system behaviour

Non-Functional Requirement
→ defines required quality or operational constraint

Acceptance Criteria
→ defines how successful implementation or process execution can be verified

Example:

BR-009
Technical failure triggers manual migration

↓

FR-010
The process shall transfer a failed automated migration to manual processing

↓

NFR-002
The migration process shall provide a recovery path

↓

AC-007
The failure is recorded and the workplace becomes identifiable for manual
intervention

---

## Coverage Review

The matrix should be reviewed when:

- a new migration rule is introduced;
- migration status logic changes;
- a new blocker type appears;
- a new support team becomes part of the process;
- the migration tooling changes;
- acceptance conditions are updated.

Any requirement without an acceptance criterion should be reviewed for
testability.

Any acceptance criterion without a corresponding requirement should be
reviewed for scope consistency.