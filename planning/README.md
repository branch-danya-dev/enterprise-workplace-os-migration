# Migration Planning

This area owns the planned position of a workplace in the migration programme.

Planning answers:

> **When is migration intended to happen, and how does that intention change?**

## Canonical documents

- [`scheduling-and-postponement.md`](scheduling-and-postponement.md) — migration-wave/date semantics, user notification, postponement review and rescheduling rules;
- [`visual-model.md`](visual-model.md) — postponement sequence and active/superseded schedule lifecycle.

## Core distinction

```text
MigrationSchedule
= planned execution

MigrationAttempt
= actual execution
```

A workplace can be rescheduled multiple times without creating execution history. Likewise, a failed attempt does not erase the plan that led to it.

## Planning consumes readiness

Planning does not manufacture migration eligibility.

```text
Readiness decision
      ↓
Planning / migration wave
      ↓
active date
      ↓
Execution gate
```

If readiness becomes invalid or a blocker appears, an existing date does not override that evidence.

## Postponement boundary

A postponement request is a formal claim that the current plan should be reconsidered.

The request itself does not change the canonical schedule. An approved planning decision does.

The reason may also reveal evidence belonging to `readiness/` or `exceptions/`.

## Ownership boundary

Planning owns:

- migration wave/sequence;
- planned date;
- active vs superseded plan;
- postponement decision as it affects the plan;
- rescheduled date.

It does not own:

- technical/operational readiness — [`readiness/`](../readiness/);
- what happened during execution — [`execution/`](../execution/);
- Service Desk internals — [`integrations/`](../integrations/);
- blocker remediation — [`exceptions/`](../exceptions/).
