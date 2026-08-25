# Workplace Migration State Model

## Purpose

This document defines the allowed migration states of a workplace and the
transitions between them.

---

| Current State | Trigger | Next State |
|---|---|---|
| Scheduled | Readiness confirmed | Ready |
| Scheduled | Postponement approved | Postponed |
| Scheduled | Blocker identified | Blocked |
| Ready | Migration started | Migration In Progress |
| Ready | Postponement approved | Postponed |
| Ready | Blocker identified | Blocked |
| Postponed | New date assigned | Scheduled |
| Blocked | Blocker resolved and readiness confirmed | Ready |
| Migration In Progress | Automated migration successful | Migrated |
| Migration In Progress | Automated migration failed | Manual Migration Required |
| Migration In Progress | Windows dependency remains | Dual Boot |
| Manual Migration Required | Manual migration successful | Migrated |
| Manual Migration Required | Manual migration cannot proceed | Blocked |
| Dual Boot | Windows dependency removed | Migrated |
| Migrated | Operational validation completed | Fully Operational |

---

## Invalid Transitions

Transitions not explicitly defined by the state model are rejected unless
supported by a separate business operation.

Example:

`Scheduled -> Migrated`

is not valid because migration execution has not been registered.

Example:

`Blocked -> Migrated`

is not valid while an active blocker exists.

Such operations should return:

`409 Conflict`

with:

`INVALID_MIGRATION_STATE_TRANSITION`