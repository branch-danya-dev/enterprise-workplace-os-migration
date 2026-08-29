# Migration Attempt Model

This document owns the canonical meaning of an **actual migration attempt**.

An attempt is an execution fact, not a plan and not the final workplace completion state.

## Attempt identity

A workplace may have zero, one or multiple attempts over its migration history.

An attempt should preserve enough information to answer:

- which workplace was processed;
- when execution started/completed;
- execution method;
- technical result;
- failure evidence where applicable;
- which subsequent transition/recovery path was opened.

## Execution methods

### Automated

Automated migration is the default path for standard eligible workplaces.

This supports programme scale: thousands of standard cases should not require repetitive manual processing.

Legacy anchors: `BR-008`, `FR-008`, `FR-009`, `NFR-012`, `NFR-013`, `AC-006`.

### Manual

Manual activity is used for recovery or exceptional cases where the automated path cannot complete safely.

Manual processing is not merely another status value. It is a different execution/recovery path with explicit support ownership.

Legacy anchors: `BR-010`, `FR-010`, `FR-011`, `AC-008`.

## Normal automated attempt

```text
active plan
+
current readiness allows migration
        ↓
automated attempt starts
        ↓
backup / environment change / restoration activities
        ↓
technical result reported
```

The exact internals of migration tooling remain outside the analyzed boundary unless necessary to explain an outcome.

## Successful technical result

A successful automated attempt should provide enough evidence to continue to operational validation.

Typical expected evidence includes:

- migration procedure completed without blocking technical error;
- Astra Linux installed;
- required user data preserved/restored;
- required access configuration preserved/restored sufficiently for validation.

However:

```text
technical attempt success
!=
final business-operational migration success
```

The workplace enters a target/pending-validation condition until the system can establish operational completion.

Legacy anchors: `FR-009`, `FR-017`, `NFR-003`, `NFR-004`, `AC-006`, `AC-012`.

## Failed automated result

A technical failure must be recorded as an execution fact.

At minimum:

- affected workplace is identifiable;
- attempt is identifiable;
- failure is distinguishable from business/readiness blockers;
- technical error/context is preserved sufficiently for support;
- a recovery/manual path can be opened.

```text
automated attempt
        ↓
technical failure
        ↓
record failure evidence
        ↓
open manual recovery / exception path
```

Legacy anchors: `BR-009`, `FR-009`, `FR-010`, `NFR-002`, `NFR-010`, `AC-007`.

## Handoff to exceptions

Execution owns the failure fact.

[`../exceptions/`](../exceptions/) owns what happens because of that failure:

- manual-recovery coordination;
- blocker/remediation handling;
- return to readiness if needed;
- stable recovery outcome.

This prevents an execution record from also becoming the owner of support workflow.

## Manual completion

When manual migration is performed, the activity should result in its own traceable execution/recovery evidence.

A manual completion may include:

- removal/replacement of the prior Windows environment when appropriate;
- Astra Linux installation;
- restoration of required workplace environment;
- return of the workplace to a condition where operational validation can occur.

The manual activity still does not bypass the final operational-completion invariant.

## Attempt history

Attempts are append-only historical facts conceptually:

```text
Attempt 1 — automated — failed
Attempt 2 — manual — technically completed
```

A later successful attempt does not erase a previous failure.

This supports:

- auditability;
- recovery analysis;
- operational reporting;
- consistency checks;
- understanding repeated attempts.

Legacy anchors: `FR-019`, `NFR-006`, `NFR-007`, `AC-014`.

## Verification conditions

An attempt model is consistent when:

- planning history and attempt history are not conflated;
- failure evidence is preserved;
- automated failure reliably opens an identifiable recovery path;
- technical success does not directly assert full operational migration;
- multiple attempts can coexist in history;
- the execution method is distinguishable.

## Technical projection note

The hypothetical REST API and PostgreSQL schema may expose/store migration attempts, but transport fields and table columns are projections of the meaning defined here.
