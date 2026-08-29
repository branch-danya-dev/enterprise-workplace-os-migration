# Migration Planning

This area owns the planned position of a workplace in the migration programme.

## Canonical facts

- planned migration date;
- migration wave / sequencing position;
- active vs superseded schedule;
- postponement state and decision;
- rescheduled date after an approved postponement.

## Core distinction

```text
MigrationSchedule
= planned execution

MigrationAttempt
= actual execution
```

A workplace can be rescheduled many times without creating execution history. Likewise, a failed attempt does not erase the plan that led to it.

## Planning flow

```text
Readiness evidence
      ↓
Workplace selected for wave
      ↓
Migration date assigned
      ↓
User notified
      ↓
Postponement requested?
   ├─ No  → schedule remains active
   └─ Yes → review
               ├─ rejected → original schedule remains
               └─ approved → old date superseded
                              ↓
                           new date
```

## Postponement boundary

A postponement request is evidence that the current plan may be unsafe or impractical. The request itself does not automatically change the schedule.

The decision must be recorded through the approved support/coordination process.

## Ownership boundary

Planning owns **when migration is intended to happen**.

It does not own:

- whether the workplace is technically/operationally ready — [`readiness/`](../readiness/);
- what happened during execution — [`execution/`](../execution/);
- the internal Service Desk process — [`integrations/`](../integrations/);
- blocker remediation — [`exceptions/`](../exceptions/).
