# Exceptions and Recovery Visual Model

This view shows how technical failure becomes an explicit recovery path without collapsing execution, exception and workplace state into one status.

```mermaid
sequenceDiagram
    participant Tool as Migration Tool
    participant E as Execution
    participant X as Exceptions
    participant S as Workplace Support
    participant W as Workplace
    participant R as Readiness

    Tool->>E: Report automated attempt result

    alt technical success
        E->>W: Evidence: Astra installation completed
        W->>W: Astra Installed — Pending Validation
    else technical failure
        E->>E: Record failed attempt
        E->>X: Open recovery requirement
        X->>S: Manual intervention required
        S->>S: Diagnose / recover / migrate manually

        alt manual migration succeeds
            S->>E: Record manual attempt result
            E->>W: Evidence: Astra installation completed
            W->>W: Astra Installed — Pending Validation
        else recovery cannot proceed
            S->>X: Register unresolved blocking condition
            X->>R: Re-evaluation required
        end
    end
```

## Blocker lifecycle

```mermaid
stateDiagram-v2
    [*] --> Open
    Open --> InProgress: owner / remediation path identified
    InProgress --> Resolved: impact removed or accepted transition established
    Open --> Resolved: immediate resolution
    Resolved --> [*]
```

`Resolved` means the exception no longer blocks the same path. It does **not** imply that the workplace is now ready or operational. Readiness and operational validation must evaluate their own conditions.

## Recovery loop

```mermaid
flowchart LR
    F[Failure / blocker] --> X[Exception owned]
    X --> O[Responsible domain / support]
    O --> M[Remediation or transition strategy]
    M --> R[Re-evaluate readiness]
    R --> P[Return to normal migration path when allowed]
```

See [`blockers-and-recovery.md`](blockers-and-recovery.md).
