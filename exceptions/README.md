# Exceptions and Recovery

This area owns deviations from the normal migration path that require explicit coordination, remediation or recovery.

## Canonical documents

- [`blockers-and-recovery.md`](blockers-and-recovery.md) — blocker semantics, impact scope, remediation strategies, vendor adaptation, manual recovery, dual-boot transition and closure rules;
- [`visual-model.md`](visual-model.md) — manual-recovery sequence, blocker lifecycle and return-to-readiness loop.

## Core principle

A blocker is not merely an error message or ticket.

> **It is evidence that the normal migration path must not continue until the condition is resolved, accepted or transformed into an explicit transition strategy.**

```text
blocker / failed normal path
        ↓
identify affected scope
        ↓
coordinate responsible domain
        ↓
remediate / recover / transition
        ↓
update evidence
        ↓
revalidate readiness
```

## Two ownership levels

The migration case may own the **blocker record and migration impact** without owning the underlying problem.

```text
underlying software/security/infrastructure problem
→ specialized domain

migration blocker and its effect on the programme
→ Exceptions
```

## Failure boundary

A failed migration attempt is first an [`execution/`](../execution/) fact.

This area owns the consequence:

- manual-recovery case;
- remediation coordination;
- exception state;
- return to readiness or another accepted path.

## Ownership boundary

Exceptions owns migration-impact/recovery semantics.

It does not absorb the internals of software, security, infrastructure, vendor or Service Desk domains.

Cross-boundary interactions are described in [`integrations/`](../integrations/).
