# System Invariants

This document owns the **cross-system properties that must remain true regardless of which migration path a workplace follows**.

These invariants are intentionally separated from individual requirements and implementation artifacts. They are the conditions that local models in `workplace/`, `readiness/`, `planning/`, `execution/` and `exceptions/` must preserve together.

## INV-01 — Operational migration means preserved business capability

A workplace is not fully migrated merely because Astra Linux is installed.

The final migration state requires that the agreed business activity can continue in the target workplace environment with the required software, services and access available.

```text
Astra installed
!=
Operationally migrated
```

Legacy evidence: `BR-014`, `FR-007`, `FR-017`, `NFR-014`, `AC-012`.

## INV-02 — Business continuity is protected during change

Migration must not leave a user without an operational workplace for an uncontrolled period.

The process therefore requires appropriate preservation or recovery mechanisms for:

- user data;
- required access configuration;
- workplace functionality;
- failed automated attempts;
- transitional scenarios where the target environment is not yet sufficient.

Legacy evidence: `NFR-001`, `NFR-002`, `NFR-003`, `NFR-004`, `NFR-005`, `FR-017`, `AC-006`, `AC-008`, `AC-012`.

## INV-03 — Normal execution is gated by current readiness

A planned date does not override a known blocker or an invalid readiness decision.

Before normal automated migration proceeds, the process must have current evidence that the workplace can safely enter the migration path.

```text
planned date reached
+
current readiness acceptable
+
no active blocker
→ normal execution may proceed
```

Legacy evidence: `BR-003`, `BR-012`, `BR-016`, `FR-008`, `FR-013`, `FR-016`, `FR-018`, `AC-003`, `AC-010`.

## INV-04 — Planning and execution history remain distinct

A migration plan records intent. A migration attempt records what actually happened.

Rescheduling must not fabricate execution history, and a failed attempt must not erase the plan that triggered it.

```text
MigrationSchedule
!=
MigrationAttempt
```

This distinction is canonical even if a technical projection stores both concepts near each other.

Legacy evidence: conceptual data model, `FR-019`, `AC-014`.

## INV-05 — Exceptions are isolated to their real impact surface

A blocker affecting one workplace or one limited segment should not automatically stop unrelated migrations.

When evidence shows a systemic issue, the affected segment may be paused deliberately.

```text
local blocker
→ local impact

systemic blocker
→ explicitly widened impact
```

Legacy evidence: `BR-011`, `NFR-008`, `NFR-009`, `AC-009`.

## INV-06 — Automation is preferred; recoverability is mandatory

Standard cases should use automated migration where technically possible.

A failed automated attempt must produce a traceable recovery path rather than an ambiguous terminal state.

Typical recovery may include:

- manual migration;
- backup restoration;
- temporary dual boot;
- workplace reassignment or replacement where necessary.

Legacy evidence: `BR-008`, `BR-009`, `BR-010`, `FR-009`, `FR-010`, `FR-011`, `NFR-002`, `NFR-010`, `NFR-012`, `NFR-013`, `AC-006`, `AC-007`, `AC-008`.

## INV-07 — Dual boot is transitional

Dual boot preserves business capability while a Windows-only dependency remains.

It must stay visible as a transitional condition and must not be interpreted as final migration completion.

Legacy evidence: `BR-013`, `FR-014`, `NFR-015`, `AC-011`.

## INV-08 — Migration history is explainable

For a workplace, responsible teams must be able to reconstruct at least:

- planned dates;
- postponements;
- blockers;
- migration attempts;
- manual recovery where applicable;
- final operational outcome.

This is a system-level requirement because the history crosses multiple responsibility owners.

Legacy evidence: `FR-019`, `FR-020`, `NFR-006`, `NFR-007`, `NFR-017`, `AC-014`, `AC-015`.

## Verification rule

A local design or technical projection is inconsistent with the reconstructed system if it violates any invariant above.

When that happens, either:

1. the local model/projection is wrong; or
2. new evidence has appeared and the invariant itself must be explicitly reopened.
