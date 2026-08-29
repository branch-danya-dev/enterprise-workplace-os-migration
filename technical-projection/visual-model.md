# Technical Projection Visual Model

This page shows how independently owned domain facts may be stored and exposed together without turning the technical layer into the semantic owner.

## Projection from canonical owners

```mermaid
flowchart TB
    W[Workplace owner] --> DB[(Synthetic relational storage)]
    R[Readiness owner] --> DB
    P[Planning owner] --> DB
    E[Execution owner] --> DB
    X[Exceptions owner] --> DB
    V[Operational validation] --> DB

    DB --> API[REST / OpenAPI projection]
    DB --> RM[Operational read model]

    RM --> UI[Reporting / support consumers]
    API --> C[API consumers]
```

Storage locality does not merge semantic ownership.

## Operational read model

```mermaid
flowchart LR
    WS[environmentState] --> OV[workplace_operational_view]
    RE[latest readiness evaluation] --> OV
    PL[active schedule] --> OV
    AT[latest attempt] --> OV
    BL[open blocker count] --> OV
    VA[latest operational validation] --> OV

    OV --> D[Dashboard / filtering / reporting]
```

The read model is deliberately denormalized for operational questions. It is **derived knowledge** and must not be used as the authoritative write model for all dimensions.

## API command rule

Prefer owner-specific operations:

```text
reschedule
approve postponement
register attempt
resolve blocker
record operational validation
```

over generic commands such as:

```text
PATCH migrationStatus
```

See [`api/README.md`](api/README.md) and [`data/README.md`](data/README.md).
