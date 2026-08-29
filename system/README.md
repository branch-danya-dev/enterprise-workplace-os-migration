# System View

This directory owns the **cross-system view** of the enterprise workplace migration.

The case is not modeled as an operating-system installer. It is modeled as a controlled change to an employee workplace whose business usefulness depends on software, access, infrastructure, support processes and operational continuity.

## System boundary

Inside the analyzed system:

- workplace migration/operational meaning;
- migration readiness decision;
- migration planning and postponement;
- migration execution outcome;
- blockers, exception handling and recovery;
- interpretation of evidence received from adjacent support and infrastructure domains;
- cross-system invariants and final synthesis.

Outside the analyzed system but relevant through boundaries:

- application internals;
- information-security systems;
- corporate access-control internals;
- telephony internals;
- vendor development processes;
- automated migration tooling internals;
- Service Desk internals.

These external domains provide evidence, capabilities or constraints. Their internals are not re-modeled unless required to explain the migration boundary.

## Responsibility map

```text
WORKPLACE
what environment exists and is it operational?
        ↓
READINESS
can this workplace be migrated safely now?
        ↓
PLANNING
when and in which wave should migration happen?
        ↓
EXECUTION
what actually happened during the migration attempt?
        ↓
EXCEPTIONS
what blocks normal progress and how is recovery handled?
        ↓
SYSTEM SYNTHESIS
are cross-system invariants satisfied?
```

`integrations/` describes cross-boundary interactions that provide evidence, capabilities or notifications across these responsibilities.

## Canonical system documents

- [`invariants.md`](invariants.md) — properties that every local model and migration path must preserve;
- [`data-ownership.md`](data-ownership.md) — which responsibility owns each significant fact and why one global `migration_status` is insufficient;
- [`legacy-knowledge-map.md`](legacy-knowledge-map.md) — temporary migration map from artifact-oriented legacy files to canonical SSAD owners.

## Core distinctions

```text
Astra installed
!= operationally migrated

MigrationSchedule
!= MigrationAttempt

Evidence provider
!= final migration authority

Blocker record
!= ownership of underlying technical problem

Technical projection
!= historical production architecture
```

The detailed definitions and verification conditions live in the canonical documents above and in the local responsibility areas.

## Evidence status

This repository is a sanitized reconstruction of a real enterprise migration case.

Knowledge is separated into two categories:

```text
RECONSTRUCTED SYSTEM KNOWLEDGE
→ process, constraints, responsibilities, states and operational rules derived from the real case

TECHNICAL PROJECTION
→ hypothetical API and database representations created to demonstrate how the domain could be implemented
```

Technical projections must not become canonical owners of business meaning.

## Related areas

- [`workplace/`](../workplace/) — workplace environment meaning and operational state;
- [`readiness/`](../readiness/) — readiness evaluation and dependency evidence;
- [`planning/`](../planning/) — schedule, migration waves and postponement;
- [`execution/`](../execution/) — automated/manual migration attempts;
- [`exceptions/`](../exceptions/) — blockers and recovery;
- [`integrations/`](../integrations/) — cross-boundary contracts and evidence;
- [`technical-projection/`](../technical-projection/) — portfolio API/database projection.
