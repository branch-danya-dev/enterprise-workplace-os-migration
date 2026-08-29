# Integration Boundary Visual Model

This diagram shows **what crosses each ownership boundary**. It intentionally does not model the internals of adjacent corporate systems.

```mermaid
flowchart LR
    SD[Service Desk] -->|postponement / stop-factor records| P[Planning / Exceptions]
    MT[Automated Migration Tool] -->|attempt evidence| E[Execution]
    NS[Notification Service] <-->|delivery request / result| P

    SS[Software Support] -->|compatibility evidence| R[Readiness]
    IS[Information Security] -->|security/access constraints| R
    IA[Infrastructure Automation] -->|tooling/infrastructure evidence| R
    TS[Telephony / Specialized Support] -->|domain evidence| R

    VD[Vendor / Development] <-->|adaptation request / resolution evidence| X[Exceptions]

    R -->|eligibility decision| P
    E -->|failure evidence| X
```

## Boundary rule

```text
external system owns its own fact/capability
        ↓
fact crosses a contract boundary
        ↓
relevant migration owner interprets it
        ↓
canonical migration meaning changes only through that owner
```

Examples:

- the migration tool owns the technical result it observed, but not `Astra Operational`;
- Service Desk owns ticket/workflow evidence, but not the active migration schedule;
- Software Support owns compatibility evidence for its domain, but not aggregate readiness;
- Notification owns delivery behavior, but not the date being communicated.

See [`boundary-contracts.md`](boundary-contracts.md).
