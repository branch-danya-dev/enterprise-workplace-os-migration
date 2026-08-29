# System View

This directory owns the **cross-system view** of the enterprise workplace migration.

The case is not modeled as an operating-system installer. It is modeled as a controlled change to an employee workplace whose business usefulness depends on software, access, infrastructure, support processes and operational continuity.

## System boundary

Inside the analyzed system:

- workplace migration state;
- migration readiness decision;
- migration planning and postponement;
- migration execution outcome;
- blockers, exception handling and recovery;
- evidence received from adjacent support and infrastructure domains.

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
what operational state is the workplace in?
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
is the workplace operationally migrated?
```

`integrations/` describes cross-boundary interactions that provide evidence or trigger operations across these responsibilities.

## Core invariants

1. Installing Astra Linux does not by itself mean that a workplace is operationally migrated.
2. Migration readiness depends on the workplace's required business capability, not only operating-system compatibility.
3. A planned migration and an actual migration attempt are different facts.
4. External systems may report evidence, but they do not arbitrarily mutate internal migration meaning.
5. A blocker delays or changes the migration path; it does not erase the workplace from the migration programme.
6. Dual boot is a transitional state, not equivalent to final operational migration.
7. A migration is complete only when the agreed business workflow can continue in the target workplace environment.

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

- [`workplace/`](../workplace/) — workplace meaning and operational state;
- [`readiness/`](../readiness/) — readiness evaluation and dependency evidence;
- [`planning/`](../planning/) — schedule, migration waves and postponement;
- [`execution/`](../execution/) — automated/manual migration attempts;
- [`exceptions/`](../exceptions/) — blockers and recovery;
- [`integrations/`](../integrations/) — cross-boundary contracts and evidence;
- [`technical-projection/`](../technical-projection/) — portfolio API/database projection.
