# Data Ownership and Domain Facts

This document maps important migration concepts to their **canonical responsibility owner**.

It replaces the old assumption that one conceptual entity list or one database schema should define the meaning of the whole migration domain.

## Why this is needed

The legacy conceptual model was useful for demonstrating relationships, but several fields combined facts owned by different responsibility areas.

Examples:

```text
Workplace.planned_migration_date
→ actually belongs to Planning

Workplace.migration_status
→ compressed several independent state dimensions

User.current_migration_status
→ migration target is the workplace, not the user

Software.compatibility_status
→ compatibility is an assessment that can change over time
```

SSAD separates these facts before choosing storage.

## Canonical fact map

| Concept / fact | Canonical owner | Notes |
|---|---|---|
| employee identity / business role | external business / identity context | consumed by migration analysis; not re-owned by the migration model |
| workplace identity and operational environment | [`workplace/`](../workplace/) | device/environment being changed |
| workplace operational state | [`workplace/`](../workplace/) | must not be collapsed with schedule/readiness/attempt state |
| workplace profile | [`workplace/`](../workplace/) | useful classification of environment characteristics |
| required business capability | business context consumed by [`readiness/`](../readiness/) | defines what must remain possible after migration |
| required workplace software | readiness evidence / specialized software domain | migration consumes the dependency; software internals remain external |
| compatibility assessment | [`readiness/`](../readiness/) as consumed evidence | assessment has time, source and maturity; not a permanent boolean on `Software` |
| access/security dependency | readiness evidence / specialized domain | migration tracks impact without owning access-system internals |
| readiness decision | [`readiness/`](../readiness/) | aggregate eligibility decision |
| planned migration date | [`planning/`](../planning/) | intention, not workplace intrinsic state |
| migration wave | [`planning/`](../planning/) | sequencing decision |
| postponement request | [`planning/`](../planning/) + Service Desk evidence | request is evidence; approved planning decision changes the schedule |
| migration attempt | [`execution/`](../execution/) | actual execution fact |
| technical attempt result | [`execution/`](../execution/) | reported by tooling/manual process |
| migration blocker record | [`exceptions/`](../exceptions/) | tracks impact and remediation state |
| underlying blocker cause | responsible external/support domain | e.g. software, security or infrastructure problem |
| manual recovery case | [`exceptions/`](../exceptions/) | recovery coordination after failure |
| final operational migration meaning | [`workplace/`](../workplace/) + [`system/`](../system/) synthesis | must satisfy cross-system invariants |
| support-team identity | [`integrations/`](../integrations/) context | identifies authority/evidence source; migration does not own team internals |

## State is multidimensional

The old model used convenient global status values such as:

```text
scheduled
ready
blocked
migration in progress
manual migration required
dual boot
migrated
```

These values do not all belong to the same state machine.

The SSAD model separates them into independent dimensions:

```text
WORKPLACE STATE
→ what environment exists and whether it is operational

READINESS STATE
→ may normal migration proceed?

PLANNING STATE
→ when is migration intended to occur?

EXECUTION STATE
→ what is happening / what happened in an attempt?

EXCEPTION STATE
→ what unresolved condition changes the normal path?
```

A dashboard or API may project these dimensions into one convenient status, but that projection does not become the canonical domain model.

## Conceptual relationships

```text
User / Business Context
        ↓
Workplace
   ├─ required capability
   ├─ dependency evidence ───────→ Readiness
   ├─ readiness decision ───────→ Planning
   ├─ plans / postponements ────→ Execution
   ├─ execution attempts ───────→ Exceptions when needed
   └─ operational validation ───→ Final workplace state
```

## Storage rule

The reconstructed case does **not** claim that all of these facts were stored in one production database.

The legacy PostgreSQL schema is a portfolio-oriented technical projection. It may represent these facts, but storage placement must follow the ownership model above rather than redefine it.

See [`../technical-projection/`](../technical-projection/) for implementation-oriented representations.
