# API Projection

This directory contains a **synthetic REST/OpenAPI projection** of the reconstructed migration domain.

It is not evidence of a production banking API. Its purpose is to demonstrate how the canonical SSAD model can be represented without letting transport-level resources redefine domain meaning.

## Projection rule

```text
Canonical system knowledge
        ↓
API representation
        ↓
consumer-facing resources and operations
```

If the API contradicts the canonical model, the API projection is wrong unless new evidence reopens the domain model.

## Ownership-aware resources

The API intentionally separates the responsibility dimensions discovered during the SSAD migration:

| Resource / operation | Canonical owner represented |
|---|---|
| `workplaces` | [`workplace/`](../../workplace/) |
| `readiness-evaluations` | [`readiness/`](../../readiness/) |
| `migration-schedules` | [`planning/`](../../planning/) |
| `postponement-requests` | [`planning/`](../../planning/) + Service Desk boundary |
| `migration-attempts` | [`execution/`](../../execution/) |
| `migration-blockers` | [`exceptions/`](../../exceptions/) |
| `compatibility-assessments` | readiness evidence from external/specialized domains |
| `operational-validations` | workplace/system completion verification |
| `operational-report` | derived read model across owners |

## Important corrections from the legacy API

### No generic `migrationStatus`

The previous API exposed one `migrationStatus` field with values such as:

```text
scheduled
ready
blocked
migration_in_progress
manual_migration_required
dual_boot
migrated
```

Those values belong to different responsibility dimensions. The new projection exposes them separately rather than rebuilding the old one-dimensional state model.

### Schedule does not own readiness

A migration schedule contains planning facts:

```text
plannedDate
migrationWave
scheduleStatus
```

It does **not** accept or own `readinessStatus`.

Scheduling may require a current GREEN readiness decision as a precondition, but the decision remains owned by readiness.

### Explicit business transitions instead of generic status PATCH

The projection favors operations that preserve business meaning:

```http
POST /migration-schedules/{id}/reschedule
POST /postponement-requests/{id}/approve
POST /postponement-requests/{id}/reject
POST /migration-blockers/{id}/resolve
POST /workplaces/{id}/operational-validations
```

This prevents arbitrary clients from setting state fields without performing the corresponding domain operation.

### Technical success is not operational completion

A successful migration attempt means that the technical attempt succeeded.

It does not by itself mean:

```text
workplace = operationally migrated
```

Operational completion requires a separate validation against required business capability, access and unresolved blockers.

## Core routes

### Workplace

```http
GET /api/v1/workplaces
GET /api/v1/workplaces/{workplaceId}
GET /api/v1/workplaces/{workplaceId}/operational-view
POST /api/v1/workplaces/{workplaceId}/operational-validations
```

`operational-view` is a derived read model. It may combine current environment, readiness, active schedule, latest attempt and open blockers for convenience without becoming their canonical owner.

### Readiness

```http
GET  /api/v1/workplaces/{workplaceId}/readiness
POST /api/v1/readiness-evaluations
```

A readiness evaluation is an immutable decision snapshot:

```json
{
  "evaluationId": 3001,
  "workplaceId": 102,
  "decision": "red",
  "evaluatedAt": "2026-02-20T13:10:00Z",
  "reasonSummary": "Critical spreadsheet workflow has no acceptable replacement"
}
```

New evidence creates a new evaluation; it does not rewrite the historical decision.

### Planning

```http
POST /api/v1/migration-schedules
GET  /api/v1/migration-schedules/{scheduleId}
POST /api/v1/migration-schedules/{scheduleId}/reschedule
```

Creating a schedule does not include a readiness field. The service verifies the current readiness decision as a precondition.

### Postponement

```http
POST /api/v1/postponement-requests
GET  /api/v1/postponement-requests/{requestId}
POST /api/v1/postponement-requests/{requestId}/approve
POST /api/v1/postponement-requests/{requestId}/reject
```

An approved postponement supersedes the active schedule and creates a new planned schedule; it does not mutate the original date as if history never existed.

### Execution

```http
POST /api/v1/migration-attempts
GET  /api/v1/migration-attempts/{attemptId}
```

Example request:

```json
{
  "externalAttemptId": "mig-20260408-106-001",
  "sourceSystem": "automated-migration-tool",
  "workplaceId": 106,
  "executionType": "automated",
  "startedAt": "2026-04-08T09:00:00Z",
  "completedAt": "2026-04-08T09:42:00Z",
  "result": "failed",
  "technicalError": "OS deployment failed"
}
```

The `(sourceSystem, externalAttemptId)` pair is idempotent.

### Exceptions

```http
POST /api/v1/migration-blockers
GET  /api/v1/migration-blockers/{blockerId}
POST /api/v1/migration-blockers/{blockerId}/resolve
```

Resolving a blocker does not automatically make readiness GREEN. It makes new readiness evaluation possible.

### Compatibility evidence

```http
POST /api/v1/compatibility-assessments
GET  /api/v1/software/{softwareId}/compatibility-assessments
```

Compatibility is evidence with a timestamp and source/responsible domain, not a permanent boolean property of software.

## Derived operational view

Operational teams often need one screen containing multiple dimensions. The API may therefore expose a derived representation such as:

```json
{
  "workplaceId": 102,
  "environmentState": "windows_operational",
  "latestReadiness": "red",
  "activeSchedule": null,
  "latestAttempt": null,
  "openBlockerCount": 1,
  "operationallyMigrated": false
}
```

This is explicitly a **read model**.

```text
convenient aggregation
!=
canonical ownership
```

## Integration semantics

- external systems report evidence or execution facts;
- idempotent event reporting uses stable external identifiers;
- timeouts mean outcome unknown, not automatically failed;
- stale or conflicting evidence must not silently overwrite newer confirmed facts;
- caller permissions follow responsibility boundaries;
- correlation identifiers should be propagated where possible.

See [`openapi.yaml`](openapi.yaml) for the machine-readable projection.
