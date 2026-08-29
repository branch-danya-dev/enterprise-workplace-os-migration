# Workplace State Semantics

This document owns the **canonical state semantics of the workplace itself**.

The legacy repository used one convenient `migration_status` vocabulary containing values such as `scheduled`, `ready`, `blocked`, `migration in progress`, `manual migration required`, `dual boot` and `migrated`.

That vocabulary is useful for reporting, but SSAD shows that these values do not all describe the same thing.

## Why one global state machine is misleading

Consider:

```text
Scheduled
→ says something about Planning

Ready / Blocked
→ says something about Readiness

Migration In Progress
→ says something about Execution

Manual Migration Required
→ says something about an Exception path

Dual Boot
→ says something about the actual workplace environment
```

Putting all of them into one field hides ownership and creates artificial transition rules between unrelated dimensions.

## Canonical workplace environment states

For the reconstructed case, the workplace itself is best understood through the environment that currently exists and whether required business capability is available.

### Windows Operational

The workplace still operates in the original Windows environment and supports the current business activity.

This can coexist with:

- a future migration schedule;
- `GREEN`, `YELLOW` or `RED` readiness;
- postponement;
- an unresolved blocker.

Those facts are owned elsewhere.

### Transitioning

A migration attempt is actively changing the workplace environment.

Execution owns the attempt itself; this state only communicates that the workplace environment is not currently in a stable final condition.

### Recovery Required

The attempted change did not leave the workplace in the intended stable target condition and explicit recovery is required.

The recovery workflow is owned by [`../exceptions/`](../exceptions/).

### Dual Boot

Both Windows and Astra Linux are available because one or more required business scenarios still depend on Windows.

```text
Astra available
+
Windows dependency remains
→ Dual Boot
```

Dual boot preserves continuity but is not final migration completion.

### Astra Installed — Pending Operational Validation

Astra Linux has been installed and the technical migration has completed sufficiently to start validation, but full business capability has not yet been confirmed.

This prevents a technical success from being mistaken for business completion.

### Astra Operational

The target workplace environment is operational and the user can perform the agreed business activity with required software, services and access.

This is the stable target state for the migration case.

## State progression

A simplified normal path is:

```text
Windows Operational
        ↓
Transitioning
        ↓
Astra Installed — Pending Operational Validation
        ↓
Astra Operational
```

Alternative paths include:

```text
Transitioning
    ↓
Recovery Required
    ↓
Transitioning / restored stable workplace
```

and:

```text
Transitioning
    ↓
Dual Boot
    ↓
Astra Operational
```

## Orthogonal migration dimensions

The current workplace state must be read together with other canonical dimensions:

| Dimension | Example values | Owner |
|---|---|---|
| workplace environment | Windows Operational, Dual Boot, Astra Operational | `workplace/` |
| readiness | GREEN, YELLOW, RED | `readiness/` |
| planning | scheduled, postponed, superseded | `planning/` |
| execution | not started, in progress, successful, failed | `execution/` |
| exception | open blocker, remediation, manual recovery | `exceptions/` |

Example:

```text
Workplace environment = Windows Operational
Readiness = RED
Planning = Postponed
Exception = Missing critical software
```

This combination is meaningful without inventing one global status value for it.

## Legacy state-model compatibility

The original state model contained transitions such as:

```text
Scheduled → Ready
Ready → Migration In Progress
Migration In Progress → Manual Migration Required
Migration In Progress → Dual Boot
Migrated → Fully Operational
```

In the SSAD model these are reinterpreted as **cross-responsibility flow changes**, not necessarily transitions of one workplace-owned state machine.

For example:

```text
Readiness becomes READY
→ Planning permits execution
→ Execution starts
→ Workplace becomes Transitioning
```

and:

```text
Execution succeeds technically
→ Workplace becomes Astra Installed — Pending Operational Validation
→ operational verification succeeds
→ Workplace becomes Astra Operational
```

## Verification conditions

A workplace may be treated as `Astra Operational` only when:

- Astra Linux is the target operating environment;
- required business-critical software or acceptable alternatives are available;
- required corporate services are accessible;
- required user access works;
- no active blocker prevents the agreed business activity.

Installation alone is insufficient.

Legacy traceability: `BR-013`, `BR-014`, `FR-007`, `FR-014`, `FR-017`, `NFR-001`, `NFR-014`, `NFR-015`, `AC-011`, `AC-012`, plus the legacy workplace state model.
