# Readiness Visual Model

Readiness answers one question:

> **May this workplace proceed through the normal migration path now?**

It is a time-sensitive decision over current evidence, not a permanent workplace attribute.

```mermaid
flowchart TD
    BA[Required business activity] --> EV[Collect current evidence]
    SW[Software / functionality] --> EV
    AC[Access / security] --> EV
    IN[Infrastructure / tooling] --> EV
    HW[Hardware / peripherals] --> EV
    EX[Open blockers / exceptions] --> EV

    EV --> Q1{Required evidence sufficient?}
    Q1 -- No / unresolved --> Y[YELLOW<br/>coordination required]
    Q1 -- Yes --> Q2{Confirmed blocking condition?}
    Q2 -- Yes --> R[RED<br/>normal migration must not proceed]
    Q2 -- No --> G[GREEN<br/>eligible for normal migration]

    Y --> CH[New evidence / coordination result]
    R --> RM[Remediation / exception outcome]
    CH --> EV
    RM --> EV
```

## Evidence and authority

```mermaid
flowchart LR
    SS[Software Support] -->|compatibility evidence| RE[Readiness evaluation]
    IS[Information Security] -->|security/access evidence| RE
    IA[Infrastructure Automation] -->|tooling evidence| RE
    WS[Workplace Support] -->|workplace evidence| RE

    RE --> D[GREEN / YELLOW / RED]
```

Each external or adjacent domain can be authoritative about its own evidence without owning the aggregate readiness decision.

## Re-evaluation

A previous `GREEN` result may be reopened when material evidence changes. A resolved blocker does not mechanically set readiness to `GREEN`; it removes or changes one input and triggers re-evaluation.

See [`evidence-model.md`](evidence-model.md) and [`decision-model.md`](decision-model.md).
