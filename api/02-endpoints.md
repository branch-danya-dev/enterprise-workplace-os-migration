# API Endpoints

## Purpose

This document defines the REST API endpoints for the simplified Migration
Management Service.

The API supports workplace migration planning, postponement handling,
migration execution tracking, blocker management and software compatibility
analysis.

Base path:

`/api/v1`

---

# 1. Workplaces

## GET /workplaces

Returns a list of workplaces.

### Query Parameters

Optional:

- `migrationStatus`
- `userId`
- `readinessStatus`
- `location`
- `page`
- `pageSize`

Example:

`GET /api/v1/workplaces?migrationStatus=blocked`

### Response

`200 OK`

```json
{
  "items": [
    {
      "workplaceId": 102,
      "userId": 15,
      "currentOs": "Windows 10",
      "targetOs": "Astra Linux",
      "migrationStatus": "blocked",
      "location": "Office A"
    }
  ],
  "page": 1,
  "pageSize": 50,
  "total": 1
}

Errors
400 Bad Request — invalid filter or pagination parameter;
500 Internal Server Error — unexpected server failure.
Related Requirements
FR-007
FR-020
NFR-017
GET /workplaces/{workplaceId}

Returns detailed information about one workplace.

Path Parameters
workplaceId — unique workplace identifier.
Response

200 OK

{
  "workplaceId": 102,
  "userId": 15,
  "profileId": 1,
  "currentOs": "Windows 10",
  "targetOs": "Astra Linux",
  "location": "Office A",
  "workplaceType": "Desktop",
  "migrationStatus": "blocked"
}
Errors

404 Not Found

{
  "code": "WORKPLACE_NOT_FOUND",
  "message": "Workplace with id 102 was not found",
  "details": null
}
Related Requirements
FR-007
FR-019
GET /workplaces/{workplaceId}/software

Returns software dependencies associated with the workplace.

Response

200 OK

{
  "workplaceId": 102,
  "software": [
    {
      "softwareId": 1,
      "softwareName": "Yandex Browser",
      "required": true,
      "businessCritical": true,
      "currentStatus": "available"
    },
    {
      "softwareId": 2,
      "softwareName": "Microsoft Excel",
      "required": true,
      "businessCritical": true,
      "currentStatus": "blocked"
    }
  ]
}
Errors
404 WORKPLACE_NOT_FOUND
Related Requirements
FR-013
BR-012
AC-010
GET /workplaces/{workplaceId}/migration-attempts

Returns migration execution history for the workplace.

Response

200 OK

{
  "workplaceId": 106,
  "attempts": [
    {
      "attemptId": 4001,
      "migrationDate": "2026-04-08T09:00:00Z",
      "executionType": "automated",
      "result": "failed",
      "technicalError": "Automated installation process terminated during OS deployment"
    },
    {
      "attemptId": 4002,
      "migrationDate": "2026-04-08T12:30:00Z",
      "executionType": "manual",
      "result": "successful",
      "technicalError": null
    }
  ]
}
Related Requirements
FR-009
FR-010
FR-011
FR-019
AC-007
AC-008
GET /workplaces/{workplaceId}/blockers

Returns migration blockers associated with the workplace.

Response

200 OK

{
  "workplaceId": 102,
  "blockers": [
    {
      "blockerId": 7001,
      "blockerType": "software_compatibility",
      "description": "Required spreadsheet workflows are not fully supported",
      "status": "open",
      "responsibleTeamId": 4
    }
  ]
}
Related Requirements
FR-012
BR-011
AC-009
2. Migration Schedule
POST /migration-schedules

Creates a migration schedule record.

Request
{
  "workplaceId": 102,
  "plannedDate": "2026-09-15",
  "readinessStatus": "green",
  "migrationWave": "Wave 9"
}
Required Fields
workplaceId
plannedDate
readinessStatus
Response

201 Created

{
  "scheduleId": 9001,
  "workplaceId": 102,
  "plannedDate": "2026-09-15",
  "readinessStatus": "green",
  "scheduleStatus": "scheduled",
  "migrationWave": "Wave 9"
}
Errors

404 Not Found

{
  "code": "WORKPLACE_NOT_FOUND",
  "message": "Specified workplace does not exist",
  "details": null
}

409 Conflict

{
  "code": "ACTIVE_SCHEDULE_ALREADY_EXISTS",
  "message": "The workplace already has an active migration schedule",
  "details": null
}
Related Requirements
FR-001
FR-002
BR-001
GET /migration-schedules/{scheduleId}

Returns a migration schedule record.

Response

200 OK

{
  "scheduleId": 9001,
  "workplaceId": 102,
  "plannedDate": "2026-09-15",
  "readinessStatus": "green",
  "scheduleStatus": "scheduled",
  "migrationWave": "Wave 9"
}
Errors
404 SCHEDULE_NOT_FOUND
PATCH /migration-schedules/{scheduleId}

Updates selected migration schedule fields.

Typical use cases:

rescheduling;
readiness status update;
schedule status change.
Request
{
  "plannedDate": "2026-09-29",
  "scheduleStatus": "scheduled"
}

Only fields included in the request are changed.

Response

200 OK

{
  "scheduleId": 9001,
  "workplaceId": 102,
  "plannedDate": "2026-09-29",
  "readinessStatus": "green",
  "scheduleStatus": "scheduled",
  "migrationWave": "Wave 9"
}
Errors
400 INVALID_SCHEDULE_STATE
404 SCHEDULE_NOT_FOUND
409 SCHEDULE_CONFLICT
Related Requirements
FR-006
FR-016
BR-006
BR-007
3. Postponement Requests
POST /postponement-requests

Registers a workplace migration postponement request.

This endpoint may be called by a Service Desk integration or an authorized
support interface.

Request
{
  "workplaceId": 104,
  "serviceDeskTicketId": "SD-2026-00421",
  "reason": "Required development tooling is not ready for the migration date"
}
Required Fields
workplaceId
serviceDeskTicketId
reason
Response

201 Created

{
  "requestId": 5001,
  "workplaceId": 104,
  "serviceDeskTicketId": "SD-2026-00421",
  "reason": "Required development tooling is not ready for the migration date",
  "approvalStatus": "pending",
  "newMigrationDate": null
}
Errors

404 WORKPLACE_NOT_FOUND

409 ACTIVE_POSTPONEMENT_REQUEST_EXISTS

Related Requirements
FR-004
BR-004
BR-005
AC-004
GET /postponement-requests/{requestId}

Returns a postponement request.

Response

200 OK

{
  "requestId": 5001,
  "workplaceId": 104,
  "serviceDeskTicketId": "SD-2026-00421",
  "reason": "Required development tooling is not ready for the migration date",
  "approvalStatus": "pending",
  "newMigrationDate": null
}
Errors
404 POSTPONEMENT_REQUEST_NOT_FOUND
PATCH /postponement-requests/{requestId}

Updates the postponement decision.

Approve Example
{
  "approvalStatus": "approved",
  "newMigrationDate": "2026-06-17"
}
Reject Example
{
  "approvalStatus": "rejected"
}
Response

200 OK

{
  "requestId": 5001,
  "workplaceId": 104,
  "approvalStatus": "approved",
  "newMigrationDate": "2026-06-17"
}
Business Validation

If:

approvalStatus = approved

then:

newMigrationDate

is required.

Errors

400 INVALID_POSTPONEMENT_DECISION

404 POSTPONEMENT_REQUEST_NOT_FOUND

409 POSTPONEMENT_ALREADY_RESOLVED

Related Requirements
FR-005
FR-006
BR-005
BR-006
BR-007
AC-005
4. Migration Attempts
POST /migration-attempts

Registers the result of a migration attempt.

This endpoint may be called by automated migration tooling or by Workplace
Support after manual migration.

Request — Successful Automated Migration
{
  "workplaceId": 101,
  "executionType": "automated",
  "result": "successful",
  "migrationDate": "2026-02-03T09:00:00Z",
  "completedAt": "2026-02-03T11:10:00Z"
}
Request — Failed Automated Migration
{
  "workplaceId": 106,
  "executionType": "automated",
  "result": "failed",
  "migrationDate": "2026-04-08T09:00:00Z",
  "completedAt": "2026-04-08T09:42:00Z",
  "technicalError": "Automated installation process terminated during OS deployment"
}
Request — Manual Migration
{
  "workplaceId": 106,
  "executionType": "manual",
  "result": "successful",
  "migrationDate": "2026-04-08T12:30:00Z",
  "completedAt": "2026-04-08T16:20:00Z"
}
Required Fields
workplaceId
executionType
result
migrationDate
Response

201 Created

{
  "attemptId": 4002,
  "workplaceId": 106,
  "executionType": "manual",
  "result": "successful",
  "migrationDate": "2026-04-08T12:30:00Z",
  "completedAt": "2026-04-08T16:20:00Z",
  "technicalError": null
}
Business Validation

Allowed execution types:

automated
manual

Allowed results:

successful
failed

If:

result = failed

technicalError should be provided where the failure is technical.

Errors
400 INVALID_EXECUTION_TYPE
400 INVALID_MIGRATION_RESULT
404 WORKPLACE_NOT_FOUND
Related Requirements
FR-009
FR-010
FR-011
BR-008
BR-009
BR-010
GET /migration-attempts/{attemptId}

Returns one migration attempt.

Response

200 OK

{
  "attemptId": 4001,
  "workplaceId": 106,
  "executionType": "automated",
  "result": "failed",
  "migrationDate": "2026-04-08T09:00:00Z",
  "completedAt": "2026-04-08T09:42:00Z",
  "technicalError": "Automated installation process terminated during OS deployment"
}
Errors
404 MIGRATION_ATTEMPT_NOT_FOUND
5. Migration Blockers
POST /migration-blockers

Creates a migration blocker.

Request
{
  "workplaceId": 102,
  "blockerType": "software_compatibility",
  "description": "Required spreadsheet workflow is not supported in Astra Linux",
  "responsibleTeamId": 4
}
Required Fields
workplaceId
blockerType
description
Response

201 Created

{
  "blockerId": 7001,
  "workplaceId": 102,
  "blockerType": "software_compatibility",
  "description": "Required spreadsheet workflow is not supported in Astra Linux",
  "responsibleTeamId": 4,
  "status": "open"
}
Errors
404 WORKPLACE_NOT_FOUND
404 SUPPORT_TEAM_NOT_FOUND
409 DUPLICATE_ACTIVE_BLOCKER
Related Requirements
FR-012
BR-011
AC-009
PATCH /migration-blockers/{blockerId}

Updates a blocker.

Typical use cases:

assign responsible team;
change blocker status;
mark blocker as resolved.
Request
{
  "status": "resolved"
}
Response

200 OK

{
  "blockerId": 7001,
  "workplaceId": 102,
  "status": "resolved",
  "resolvedAt": "2026-09-10T14:30:00Z"
}
Errors
404 BLOCKER_NOT_FOUND
409 BLOCKER_ALREADY_RESOLVED
6. Software
GET /software

Returns software registered in the migration compatibility catalogue.

Query Parameters

Optional:

compatibilityStatus
businessCriticality
blockerOnly

Example:

GET /api/v1/software?blockerOnly=true

Response

200 OK

{
  "items": [
    {
      "softwareId": 8,
      "softwareName": "Internal Payment Client",
      "businessCriticality": "critical",
      "astraEquivalent": null
    }
  ],
  "total": 1
}
Related Requirements
FR-013
FR-020
GET /software/{softwareId}/compatibility

Returns compatibility information for a software product.

Response

200 OK

{
  "softwareId": 2,
  "softwareName": "Microsoft Excel",
  "assessment": {
    "compatibilityStatus": "partial",
    "replacementAvailable": true,
    "replacementMaturity": "limited",
    "blockerFlag": true,
    "assessmentDate": "2026-01-12",
    "responsibleTeamId": 4,
    "notes": "Some complex Excel workflows are not fully supported"
  }
}
Errors
404 SOFTWARE_NOT_FOUND
404 COMPATIBILITY_ASSESSMENT_NOT_FOUND
Related Requirements
FR-013
BR-012
AC-010
7. Common Error Model

All API errors should use a common structure.

{
  "code": "ERROR_CODE",
  "message": "Human-readable error description",
  "details": null
}

Example with details:

{
  "code": "VALIDATION_ERROR",
  "message": "Request validation failed",
  "details": [
    {
      "field": "plannedDate",
      "message": "plannedDate must not be empty"
    }
  ]
}
8. HTTP Method Semantics
GET

Used to retrieve resources.

GET requests must not modify migration data.

Examples:

GET /workplaces
GET /migration-attempts/4001
POST

Used when creating a new resource or recording a new event.

Examples:

create a migration schedule;
register a postponement request;
record a migration attempt;
create a blocker.
PATCH

Used for partial modification of an existing resource.

Examples:

assign a new migration date;
approve a postponement;
resolve a blocker.

PATCH is used instead of PUT because the client does not need to send the
complete resource representation for these operations.

9. Resource Relationship Examples

The API resource relationships reflect the underlying domain model.

Example:

User
  |
  +-- Workplace
        |
        +-- Software Dependencies
        |
        +-- Migration Schedules
        |
        +-- Migration Attempts
        |
        +-- Migration Blockers
        |
        +-- Postponement Requests

For this reason nested read endpoints are used where the relationship is
important to the consumer.

Examples:

GET /workplaces/{id}/software

GET /workplaces/{id}/migration-attempts

GET /workplaces/{id}/blockers

Creation operations use top-level resources because the created object has its
own lifecycle and identifier.

Examples:

POST /migration-blockers

POST /migration-attempts

POST /postponement-requests

10. Scope Boundaries

The Migration Management API does not directly:

install operating systems;
execute migration scripts;
configure workplace hardware;
replace Service Desk functionality;
make Information Security decisions;
develop missing software.

These responsibilities belong to external systems or support teams.

The API stores and exposes migration-management information required to
coordinate these activities.