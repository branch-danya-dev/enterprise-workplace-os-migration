# Technical Projection

This area contains **portfolio-oriented implementation projections** of the migration domain.

They demonstrate how reconstructed system knowledge could be represented through APIs, relational data and machine-readable contracts.

They are not evidence that these exact interfaces, schemas or services existed in the real banking environment.

## Why this separation matters

The legacy repository mixes real reconstructed process knowledge with hypothetical implementation artifacts:

```text
real migration experience
+
reconstructed rules and states
+
hypothetical REST API
+
hypothetical PostgreSQL schema
```

Without an explicit boundary, readers may mistake an educational projection for historical production architecture.

SSAD separates them:

```text
CANONICAL SYSTEM KNOWLEDGE
system / workplace / readiness / planning / execution / exceptions / integrations

            ↓ projected into

TECHNICAL PROJECTION
API / data schema / OpenAPI / SQL examples
```

## Rules for technical projections

1. A technical projection must link back to the canonical domain meaning it represents.
2. Field names and HTTP operations do not define business semantics.
3. Database storage does not automatically own the stored fact.
4. An API provider does not automatically own every state it exposes.
5. Projection-specific decisions must be clearly marked as synthetic or illustrative.
6. If a projection contradicts the canonical system model, the projection is wrong unless new evidence requires reopening the model.

## Legacy material

During restructuring, the existing [`api/`](../api/) and [`sql/`](../sql/) directories remain available as migration sources.

Their useful content should be moved or linked into this area only after the domain ownership model is stable.
