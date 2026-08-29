# Workplace

This area owns the canonical meaning of the **workplace as the object being changed by the migration programme**.

A workplace is not only an operating-system installation. It is the user's usable working environment: device, operating system, required software, access, peripherals and the capability to perform agreed business activity.

## Canonical questions

- What is a workplace in this case?
- Which migration state is it currently in?
- Which states are transitional and which are stable?
- What does `migrated` mean compared with `fully operational`?
- Which facts describe the workplace itself and which belong to readiness, planning or execution?

## State semantics

The reconstructed lifecycle is:

```text
Scheduled
   ├─> Postponed
   ├─> Blocked
   └─> Ready
          ↓
   Migration In Progress
      ├─> Manual Migration Required
      ├─> Dual Boot
      └─> Migrated
               ↓
        Fully Operational
```

The exact transition rules remain derived from the existing state model during migration of the legacy documentation.

## Important distinctions

```text
planned date
!= workplace state

migration attempt
!= workplace state

Astra installed
!= fully operational workplace

dual boot
!= completed migration
```

## Ownership boundary

This area owns workplace-state meaning.

It does **not** own:

- whether dependencies are sufficient for migration — see [`readiness/`](../readiness/);
- migration date or postponement — see [`planning/`](../planning/);
- execution-attempt details — see [`execution/`](../execution/);
- blocker resolution workflow — see [`exceptions/`](../exceptions/).

This separation prevents a status field in a hypothetical API or database from becoming the accidental definition of the domain state.
