# Blockers, Remediation and Recovery

This document owns the canonical behavior for **conditions that interrupt the normal migration path** and the controlled return from those conditions.

An exception is not just an error label. It changes what the migration system is allowed to do next.

## Blocker meaning

A migration blocker means:

> **Current evidence is sufficient to conclude that the workplace must not continue through the normal migration path until the condition is resolved, accepted or transformed into an explicit transition strategy.**

A blocker may affect:

- one workplace;
- a workplace group;
- a department/user segment;
- every workplace depending on a particular software capability;
- a broader migration wave when evidence shows systemic impact.

## Blocker record vs underlying problem

The migration case owns the blocker **record and impact on migration**.

It does not necessarily own the underlying technical problem.

Examples:

```text
Missing critical office-software capability
→ underlying remediation: software/vendor domain
→ migration impact record: Exceptions

Security requirement not satisfied
→ underlying authority: Information Security
→ migration impact record: Exceptions
```

This is another `evidence != ownership` boundary.

## Blocker lifecycle

```text
IDENTIFIED
   ↓
REGISTERED
   ↓
ASSIGNED / COORDINATING
   ↓
REMEDIATION OR TRANSITION STRATEGY
   ↓
RESOLVED FOR MIGRATION PURPOSES
   ↓
READINESS REVALIDATION
```

A blocker should preserve, where known:

- affected scope;
- category/reason;
- responsible remediation/support domain;
- current blocker state;
- evidence/notes needed for coordination;
- resolution evidence.

Legacy anchors: `BR-011`, `FR-012`, `NFR-006`, `NFR-007`, `NFR-009`, `AC-009`.

## Common blocker classes

### Software compatibility

Examples:

- no Linux-compatible version;
- replacement lacks required functionality;
- replacement is unstable/immature;
- macros/extensions/integration scenarios fail;
- vendor adaptation required.

### Access / security

Required access or security condition cannot currently be preserved in the target environment.

### Infrastructure

A required infrastructure dependency is unavailable or unsuitable for the planned transition.

### Hardware / peripheral

A specific driver/device is incompatible. Usually local and remediable rather than systemic.

### Business dependency

A required workflow cannot safely continue in the proposed target environment.

### Technical execution failure

The automated attempt failed and a recovery path is required.

The failure fact belongs to `execution/`; the recovery case belongs here.

## Response strategies

A blocker does not imply one universal response.

Possible strategies include:

```text
remediate dependency
postpone / move to later wave
replace component/device
vendor development or adaptation
dual-boot transition
manual recovery
explicitly widen pause when issue is systemic
```

The chosen response must preserve system invariants, especially business continuity and operational-completion meaning.

## Vendor development / adaptation

When required functionality has no acceptable Astra Linux solution, a request may be prepared for the responsible vendor/development team.

Typical flow:

```text
missing capability identified
        ↓
required functionality described
        ↓
impact on migration recorded
        ↓
approval / coordination
        ↓
request to vendor/development domain
        ↓
development / adaptation
        ↓
compatibility validation
        ↓
readiness re-evaluation
```

The migration repository owns why this work blocks migration, not the vendor's internal development process.

Legacy anchors: `BR-015`, `FR-015`, `NFR-016`, `AC-010`.

## Manual recovery after automation failure

A failed automated attempt creates a recovery need.

Typical reconstructed path:

```text
automated attempt fails
        ↓
execution failure recorded
        ↓
manual recovery required
        ↓
Workplace Support takes over
        ↓
manual environment recovery / migration
        ↓
technical completion
        ↓
operational validation
```

Manual recovery may include backup restoration, manual Astra installation, restoration of required environment or another controlled recovery action.

Legacy anchors: `BR-009`, `BR-010`, `FR-010`, `FR-011`, `NFR-001`, `NFR-002`, `NFR-010`, `AC-007`, `AC-008`.

## Dual boot as a transition strategy

Dual boot may be chosen when Astra Linux can be introduced but selected required functionality still depends on Windows.

It resolves immediate continuity pressure without pretending the blocker has disappeared.

```text
unresolved Windows-only dependency
+
Astra can otherwise be introduced
→ Dual Boot
→ dependency remains traceable
→ final completion waits for dependency removal
```

The workplace state is defined in `workplace/states.md`; this area owns the exception strategy that led to it.

Legacy anchors: `BR-013`, `FR-014`, `NFR-015`, `AC-011`.

## Exception isolation

A local blocker should have local impact unless evidence justifies a wider scope.

This is critical in a programme spanning thousands of workplaces.

```text
one incompatible peripheral
→ do not stop unrelated workplaces

common critical application defect
→ pause affected dependency segment
```

Legacy anchors: `NFR-008`, `NFR-009`.

## Closure rule

A blocker/recovery case is not closed merely because a support ticket is closed.

For migration purposes, closure requires that:

1. the blocking impact is removed or transformed into an explicitly accepted path;
2. relevant evidence is updated;
3. readiness is re-evaluated when the normal path may resume;
4. the workplace state/plan is updated by its respective owner if needed.

## Verification conditions

Exception handling is consistent when:

- blocker scope is explicit;
- underlying technical ownership is not falsely absorbed by the migration process;
- remediation/recovery path is traceable;
- local issues do not silently become global pauses;
- manual recovery follows recorded technical failure;
- dual boot remains transitional;
- readiness is revalidated before return to normal migration.
