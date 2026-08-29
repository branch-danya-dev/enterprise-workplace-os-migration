# Migration Execution

This area owns the fact of **what actually happened when migration was attempted**.

Execution is intentionally separate from planning and workplace state.

## Canonical facts

- execution method: automated or manual;
- attempt start and completion;
- technical outcome;
- failure evidence;
- recovery handoff when automation cannot complete the migration;
- link from an attempt to the resulting workplace-state transition.

## Default path

```text
Active schedule
      ↓
Readiness confirmed
      ↓
Automated migration attempt
      ↓
Success?
   ├─ Yes → workplace moves toward migrated / operational validation
   └─ No  → failure recorded
             ↓
          manual recovery required
```

Automated migration is the default path. Manual migration is an exception/recovery mechanism rather than an equivalent planning mode.

## Execution does not own business completion

A technical tool can report:

```text
installation completed
backup restored
script failed
migration attempt failed
```

But the tool does not own the final statement:

```text
workplace is operationally migrated
```

That meaning depends on workplace state, readiness evidence and operational validation.

## Ownership boundary

Execution owns **attempt facts**.

It does not own:

- the plan that caused the attempt — [`planning/`](../planning/);
- readiness eligibility — [`readiness/`](../readiness/);
- workplace-state semantics — [`workplace/`](../workplace/);
- recovery/blocker coordination after failure — [`exceptions/`](../exceptions/).
