# System Visual Models

This page contains **cross-system synthesis views** for the migration case.

The diagrams do not replace the canonical owner documents. They show how responsibility-owned knowledge connects end to end.

## Responsibility map

```mermaid
flowchart LR
    W[Workplace<br/>environment meaning] --> R[Readiness<br/>may migration proceed?]
    R --> P[Planning<br/>when should it happen?]
    P --> E[Execution<br/>what actually happened?]
    E --> V[Operational validation<br/>is the target workplace usable?]

    E --> X[Exceptions<br/>blockers and recovery]
    X --> R

    I[External domains<br/>evidence and capabilities] --> R
    I --> P
    I --> E
    I --> X

    V --> W
```

The arrows represent **knowledge and decision dependencies**, not one global state machine.

## Independent state dimensions

A single workplace can have several simultaneous states owned by different areas.

```mermaid
flowchart TB
    ID[Workplace 102]

    ID --> WS[Workplace state<br/>Windows Operational]
    ID --> RS[Readiness<br/>RED]
    ID --> PS[Planning<br/>Postponed]
    ID --> ES[Execution<br/>No active attempt]
    ID --> XS[Exception<br/>Missing critical software]
```

These values are not alternatives in one enum. They answer different questions.

## End-to-end migration flow

```mermaid
flowchart TD
    A[Required business capability known] --> B[Readiness evaluation]
    B --> C{GREEN?}
    C -- No --> X[Coordinate / remediate / postpone]
    X --> B
    C -- Yes --> D[Active migration plan]
    D --> E{Postponement or new blocker?}
    E -- Yes --> X
    E -- No --> F[Automated migration attempt]
    F --> G{Technical outcome}
    G -- Failed --> H[Manual recovery / exception]
    H --> I[Astra installed]
    G -- Successful --> I
    I --> J[Operational validation]
    J --> K{Business capability restored?}
    K -- No --> X
    K -- Yes --> L[Astra Operational]
```

The important distinction is:

```text
technical execution success
!=
operational migration completion
```

## Where the details live

- [`../workplace/`](../workplace/) — workplace environment and operational state;
- [`../readiness/`](../readiness/) — evidence and eligibility decision;
- [`../planning/`](../planning/) — schedule and postponement;
- [`../execution/`](../execution/) — attempt facts;
- [`../exceptions/`](../exceptions/) — blockers and recovery;
- [`../integrations/`](../integrations/) — external ownership boundaries;
- [`../technical-projection/`](../technical-projection/) — synthetic implementation projection.
