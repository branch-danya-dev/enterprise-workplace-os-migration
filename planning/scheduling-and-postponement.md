# Scheduling and Postponement

This document owns the canonical behavior for **migration planning**: when a workplace is intended to migrate and how that plan changes.

Planning is downstream from readiness and upstream from execution.

```text
Readiness
→ Planning
→ Execution
```

## Migration schedule

A migration schedule represents an intention to execute migration for a workplace at a planned point in time.

Canonical planning facts include:

- workplace included in the migration programme;
- migration wave or sequencing position;
- planned migration date;
- whether the plan is active, postponed or superseded;
- user notification associated with the active plan.

A schedule does not prove that migration occurred.

## Scheduling rule

A workplace selected for a normal migration wave should have a planned date and enough readiness evidence to justify inclusion.

```text
readiness acceptable
        ↓
workplace selected for wave
        ↓
planned date assigned
        ↓
user notified
```

Legacy anchors: `BR-001`, `BR-002`, `FR-001`, `FR-002`, `FR-003`, `AC-001`, `AC-002`.

## User notification

The user must be informed about the planned migration date.

Notification delivery is an integration concern, but the date communicated to the user must correspond to the canonical active plan.

```text
Planning owns planned date
→ Notification delivers it
```

A notification service must not become the owner of schedule truth simply because it sent the message.

## Postponement request

A postponement request is a formal claim that the active plan should be reconsidered.

The approved channel in the reconstructed process is the corporate Service Desk.

A valid request should identify, directly or through context:

- affected user/workplace;
- current planned migration date;
- reason for postponement;
- request/decision state.

The request itself does not alter the canonical plan.

```text
request submitted
!=
schedule changed
```

Legacy anchors: `BR-004`, `FR-004`, `AC-004`.

## Postponement review

The reason is reviewed by the responsible support/coordination path.

Possible outcomes:

### Approved

- current active date becomes superseded;
- workplace is treated as postponed for planning purposes;
- a new migration date is assigned;
- user is informed about the new active date.

### Rejected

- original migration date remains active;
- no rescheduling occurs solely because a request was submitted.

### Additional coordination required

- the planning decision remains unresolved;
- the reason may generate new readiness evidence or an exception investigation.

Legacy anchors: `BR-005`, `BR-006`, `BR-007`, `FR-005`, `FR-006`, `AC-003`, `AC-005`.

## Reason classification matters

Not every postponement reason is purely a planning issue.

```text
User unavailable on date
→ planning constraint

Critical application missing on Astra
→ planning request
+
readiness evidence
+
possibly exception/blocker
```

Planning records the resulting schedule decision, while the underlying technical/business cause belongs to its canonical owner.

## Multiple schedules

A workplace may have multiple historical planned dates.

Only one should be treated as the current active plan for normal execution at a time.

```text
Schedule A — superseded
Schedule B — superseded
Schedule C — active
```

Keeping schedule history supports traceability without overwriting earlier decisions.

## Execution gate

Reaching the planned date is not sufficient to start normal migration if current evidence shows:

- an approved postponement;
- an active blocker;
- readiness no longer acceptable.

```text
planned date reached
+
active plan
+
current readiness allows migration
+
no blocking exception
→ execution may start
```

Legacy anchors: `BR-003`, `FR-008`, `AC-003`.

## Verification conditions

Planning is consistent when:

- a workplace selected for migration has an identifiable active plan;
- approved postponement supersedes the old date rather than silently rewriting history;
- rejected postponement does not change the plan;
- notifications reflect the current active date;
- planning does not override current readiness/blocker evidence;
- execution history remains separate from plan history.

## Legacy traceability

Primary old artifacts absorbed here:

- `BR-001` through `BR-007`;
- `FR-001` through `FR-006`, plus the planning side of `FR-008` and `FR-019`;
- `NFR-006`, `NFR-007`, `NFR-008`, `NFR-011` where they constrain planning history/control;
- `AC-001` through `AC-005`, plus the planning part of `AC-014`;
- conceptual entities `MigrationSchedule` and `PostponementRequest`.
