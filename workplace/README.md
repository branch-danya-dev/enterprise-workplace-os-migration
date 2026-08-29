# Workplace

This area owns the canonical meaning of the **workplace as the object being changed by the migration programme**.

A workplace is not only an operating-system installation. It is the user's usable working environment: device, operating system, required software, access, peripherals and the capability to perform agreed business activity.

## Canonical questions

- What is a workplace in this case?
- Which facts describe the workplace environment itself?
- Which operational states are stable or transitional?
- What does operational migration completion mean?
- Which apparent “statuses” actually belong to readiness, planning, execution or exceptions?

## Canonical document

→ [`states.md`](states.md) defines workplace state semantics and decomposes the legacy one-dimensional `migration_status` into separate responsibility dimensions.

## Core idea

The workplace state answers:

> **What environment exists now, and can it support the required business activity?**

It does not answer every migration-process question.

```text
Workplace state
!= Readiness state
!= Planning state
!= Execution state
!= Exception state
```

For example, a workplace may simultaneously be:

```text
Environment = Windows Operational
Readiness = RED
Planning = Postponed
Exception = Missing critical software
```

This is more precise than forcing those facts into one global status value.

## Final target meaning

The stable target is not “Astra installed.”

It is an **Astra Operational** workplace where the agreed business activity can continue with required software, services and access.

The cross-system conditions for that claim are owned by [`../system/invariants.md`](../system/invariants.md).

## Ownership boundary

This area owns workplace-environment and operational-state meaning.

It does **not** own:

- whether dependencies are sufficient for migration — [`readiness/`](../readiness/);
- migration date or postponement — [`planning/`](../planning/);
- execution-attempt details — [`execution/`](../execution/);
- blocker resolution/recovery workflow — [`exceptions/`](../exceptions/).

This separation prevents a status field in a hypothetical API or database from becoming the accidental definition of the domain state.
