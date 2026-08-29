# Planning Visual Model

Planning owns the **intended migration date/wave and postponement decision**, not readiness or execution outcome.

## Postponement flow

```mermaid
sequenceDiagram
    actor User
    participant SD as Service Desk
    participant P as Planning
    participant R as Readiness
    participant N as Notification

    User->>SD: Submit postponement request + reason
    SD->>P: Register request / coordination evidence
    P->>P: Review current active plan
    P->>R: Read current readiness context if relevant

    alt postponement approved
        P->>P: Resolve request = approved
        P->>P: Supersede active schedule
        P->>P: Create new active schedule/date
        P->>N: Request notification of new date
        N-->>User: New migration date
    else postponement rejected
        P->>P: Resolve request = rejected
        P->>N: Request notification that plan remains active
        N-->>User: Original date remains active
    else more coordination required
        P->>P: Keep decision unresolved
        P-->>SD: Additional evidence required
    end
```

The Service Desk is the formal request/coordination boundary. It does not own the canonical migration schedule.

## Schedule lifecycle

```mermaid
stateDiagram-v2
    [*] --> Active
    Active --> Superseded: approved reschedule
    Active --> Cancelled: explicit cancellation
    Active --> Consumed: execution started for this plan
    Superseded --> [*]
    Cancelled --> [*]
    Consumed --> [*]
```

A new planned date should create or identify a new active plan rather than rewriting historical intent without traceability.

See [`scheduling-and-postponement.md`](scheduling-and-postponement.md).
