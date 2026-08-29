# Exceptions and Recovery

This area owns deviations from the normal migration path that require explicit coordination, remediation or recovery.

## Exception classes

Typical exceptions include:

- incompatible or missing software;
- unacceptable replacement functionality;
- unresolved access/security constraint;
- infrastructure dependency;
- automation failure requiring manual migration;
- peripheral/driver incompatibility;
- business-critical postponement reason;
- unresolved cross-team dependency.

## Blocker semantics

A blocker is not merely an error message.

It means:

> **The normal migration path must not continue until the blocking condition is resolved, accepted or moved into an explicit transition strategy.**

```text
Blocker discovered
      ↓
Register evidence
      ↓
Identify responsible domain
      ↓
Choose response
   ├─ remediation
   ├─ postpone / later wave
   ├─ dual boot transition
   ├─ vendor adaptation
   └─ manual recovery
      ↓
Revalidate readiness
      ↓
Return to migration path
```

## Manual recovery

A failed automated attempt can produce a manual-recovery requirement.

The failure itself belongs to [`execution/`](../execution/). This area owns the exception path that follows: handoff, coordination, recovery and return to a valid workplace state.

## Blockers and ownership

The migration process may own the blocker record without owning the underlying technical problem.

Examples:

```text
missing office-software capability
→ owned for remediation by software/vendor domain

migration blocker record
→ owned by migration exception process
```

This distinction allows the migration model to track impact without pretending to own every adjacent system.

## Completion

An exception is closed only when its impact on migration is resolved or explicitly transformed into another accepted path and readiness is re-evaluated.
