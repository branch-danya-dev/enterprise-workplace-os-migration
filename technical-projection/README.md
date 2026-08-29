# Technical Projection

This area contains **portfolio-oriented implementation projections** of the migration domain.

They demonstrate how reconstructed system knowledge could be represented through APIs, relational data and machine-readable contracts.

They are not evidence that these exact interfaces, schemas or services existed in the real banking environment.

## Projection boundary

The canonical reconstructed domain now lives in:

```text
system/
workplace/
readiness/
planning/
execution/
exceptions/
integrations/
```

Technical artifacts are downstream projections:

```text
CANONICAL SYSTEM KNOWLEDGE
        ↓
TECHNICAL PROJECTION
        ↓
REST / OpenAPI / relational schema / SQL queries
```

If a projection contradicts canonical migration meaning, the projection should be corrected unless new evidence explicitly reopens the domain model.

## Why this separation matters

The original portfolio repository mixed real reconstructed process knowledge with hypothetical implementation artifacts.

Without an explicit boundary, a reader could incorrectly infer that:

- one Migration Management API existed in production;
- one PostgreSQL database owned the migration domain;
- API status fields defined the real workplace lifecycle;
- endpoint operations represented historical corporate integrations.

The repository makes none of those claims.

## Rules for technical projections

1. A technical projection must link back to the canonical domain meaning it represents.
2. Field names and HTTP operations do not define business semantics.
3. Database storage does not automatically own the stored fact.
4. An API provider does not automatically own every state it exposes.
5. Projection-specific decisions must be clearly marked as synthetic or illustrative.
6. A flattened reporting/API status may summarize multiple canonical dimensions but must not replace them.
7. Technical error handling must preserve the domain distinction between execution failure, blocker, readiness and workplace state.

## Data projection

Before mapping entities to tables, use [`../system/data-ownership.md`](../system/data-ownership.md).

For example:

```text
planned_migration_date
→ Planning fact

migration attempt result
→ Execution fact

blocker
→ Exceptions fact

workplace environment state
→ Workplace fact
```

These facts may coexist in one database for implementation convenience without gaining one semantic owner.

## API projection

Before defining REST operations, follow the relevant canonical behavior:

- planning changes → [`../planning/`](../planning/);
- attempt registration/results → [`../execution/`](../execution/);
- blocker/recovery behavior → [`../exceptions/`](../exceptions/);
- readiness views → [`../readiness/`](../readiness/);
- workplace state → [`../workplace/`](../workplace/).

A command such as `PATCH status` should be treated suspiciously when it bypasses the owner-specific operation that actually changes domain meaning.

## Remaining migration sources

The old `docs/` tree has been fully decomposed into canonical SSAD owners and removed.

The remaining artifact-oriented sources are:

- [`../api/`](../api/) — hypothetical REST/OpenAPI projection;
- [`../sql/`](../sql/) — hypothetical PostgreSQL projection;
- [`../diagrams/`](../diagrams/) — PlantUML/rendered presentation artifacts.

These areas remain active only as migration/projection sources for the next restructuring pass.

The next goal is to reorganize API/data examples around the canonical owners above and remove any endpoint/schema design that accidentally reintroduces one global migration state model.
