# JSON Contracts

## Purpose

This document defines JSON request and response contracts used by the
Migration Management API.

The contracts describe field names, data types, required fields, nullable
values and validation rules.

---

# 1. Common Conventions

## Naming

JSON fields use `camelCase`.

Examples:

- `workplaceId`
- `migrationStatus`
- `plannedDate`
- `technicalError`

---

## Identifiers

Identifiers are positive integer values.

Example:

```json
{
  "workplaceId": 102
}

Dates

Calendar dates use ISO 8601 format:

YYYY-MM-DD

Example:

{
  "plannedDate": "2026-09-15"
}
Date and Time

Date-time values use ISO 8601 UTC format.

Example:

{
  "migrationDate": "2026-04-08T09:00:00Z"
}
Nullable Fields

A nullable field may contain null.

Example:

{
  "technicalError": null
}

A nullable field is not the same as an optional field.

Optional means the client may omit the field entirely.

Nullable means the field may be present with the value null.

2. Workplace Contract
WorkplaceResponse

Represents a workplace.

Field	Type	Required	Nullable	Description
workplaceId	integer	yes	no	Unique workplace identifier
userId	integer	yes	no	Assigned user identifier
profileId	integer	no	yes	Workplace profile identifier
currentOs	string	yes	no	Current operating system
targetOs	string	yes	no	Target operating system
location	string	no	yes	Workplace location
workplaceType	string	no	yes	Workplace form/type
migrationStatus	string	yes	no	Current migration status

Example:

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
migrationStatus values

Allowed values:

scheduled
ready
pending
postponed
blocked
migration_in_progress
manual_migration_required
dual_boot
migrated
3. Software Dependency Contract
WorkplaceSoftwareResponse

Represents software required by a workplace.

Field	Type	Required	Nullable	Description
softwareId	integer	yes	no	Software identifier
softwareName	string	yes	no	Software name
required	boolean	yes	no	Whether software is required
businessCritical	boolean	yes	no	Whether dependency is business-critical
currentStatus	string	yes	no	Current dependency status

Example:

{
  "softwareId": 2,
  "softwareName": "Microsoft Excel",
  "required": true,
  "businessCritical": true,
  "currentStatus": "blocked"
}
currentStatus values
available
pending
blocked
windows_only
4. Migration Schedule Contracts
CreateMigrationScheduleRequest

Used by:

POST /api/v1/migration-schedules

Field	Type	Required	Nullable	Description
workplaceId	integer	yes	no	Workplace to schedule
plannedDate	date	yes	no	Planned migration date
readinessStatus	string	yes	no	Current readiness classification
migrationWave	string	no	yes	Migration wave/group

Example:

{
  "workplaceId": 102,
  "plannedDate": "2026-09-15",
  "readinessStatus": "green",
  "migrationWave": "Wave 9"
}
Validation

workplaceId:

must reference an existing workplace.

plannedDate:

must be a valid ISO 8601 date.

readinessStatus:

Allowed values:

green
yellow
red
MigrationScheduleResponse
Field	Type	Required	Nullable
scheduleId	integer	yes	no
workplaceId	integer	yes	no
plannedDate	date	yes	no
readinessStatus	string	yes	no
scheduleStatus	string	yes	no
migrationWave	string	no	yes

Example:

{
  "scheduleId": 9001,
  "workplaceId": 102,
  "plannedDate": "2026-09-15",
  "readinessStatus": "green",
  "scheduleStatus": "scheduled",
  "migrationWave": "Wave 9"
}
scheduleStatus values
scheduled
postponed
blocked
completed
cancelled
UpdateMigrationScheduleRequest

Used by:

PATCH /api/v1/migration-schedules/{scheduleId}

All fields are optional because PATCH modifies only supplied fields.

Field	Type	Required	Nullable
plannedDate	date	no	no
readinessStatus	string	no	no
scheduleStatus	string	no	no
migrationWave	string	no	yes

Example:

{
  "plannedDate": "2026-09-29",
  "scheduleStatus": "scheduled"
}

At least one field must be provided.

5. Postponement Contracts
CreatePostponementRequest

Used by:

POST /api/v1/postponement-requests

Field	Type	Required	Nullable	Description
workplaceId	integer	yes	no	Affected workplace
serviceDeskTicketId	string	yes	no	Service Desk ticket
reason	string	yes	no	Postponement reason

Example:

{
  "workplaceId": 104,
  "serviceDeskTicketId": "SD-2026-00421",
  "reason": "Required development tooling is not ready"
}
Validation

reason:

must not be empty;
should contain enough information for the support team to evaluate the request.
PostponementResponse
Field	Type	Required	Nullable
requestId	integer	yes	no
workplaceId	integer	yes	no
serviceDeskTicketId	string	yes	no
reason	string	yes	no
approvalStatus	string	yes	no
newMigrationDate	date	yes	yes

Example:

{
  "requestId": 5001,
  "workplaceId": 104,
  "serviceDeskTicketId": "SD-2026-00421",
  "reason": "Required development tooling is not ready",
  "approvalStatus": "pending",
  "newMigrationDate": null
}
approvalStatus values
pending
approved
rejected
UpdatePostponementRequest

Used by:

PATCH /api/v1/postponement-requests/{requestId}

Field	Type	Required	Nullable
approvalStatus	string	yes	no
newMigrationDate	date	conditional	yes

Validation rule:

If:

approvalStatus = approved

then:

newMigrationDate

is required and must not be null.

Example:

{
  "approvalStatus": "approved",
  "newMigrationDate": "2026-06-17"
}
6. Migration Attempt Contracts
CreateMigrationAttemptRequest

Used by:

POST /api/v1/migration-attempts

Field	Type	Required	Nullable	Description
workplaceId	integer	yes	no	Affected workplace
executionType	string	yes	no	Automated or manual
result	string	yes	no	Migration result
migrationDate	datetime	yes	no	Start/registration time
completedAt	datetime	no	yes	Completion time
technicalError	string	no	yes	Failure description

Example:

{
  "workplaceId": 106,
  "executionType": "automated",
  "result": "failed",
  "migrationDate": "2026-04-08T09:00:00Z",
  "completedAt": "2026-04-08T09:42:00Z",
  "technicalError": "Automated installation process terminated during OS deployment"
}
executionType values
automated
manual
result values
successful
failed
Validation

If:

result = failed

and the failure is technical, technicalError must contain the technical
failure description.

If:

completedAt != null

then:

completedAt >= migrationDate
MigrationAttemptResponse
Field	Type	Required	Nullable
attemptId	integer	yes	no
workplaceId	integer	yes	no
executionType	string	yes	no
result	string	yes	no
migrationDate	datetime	yes	no
completedAt	datetime	yes	yes
technicalError	string	yes	yes

Example:

{
  "attemptId": 4001,
  "workplaceId": 106,
  "executionType": "automated",
  "result": "failed",
  "migrationDate": "2026-04-08T09:00:00Z",
  "completedAt": "2026-04-08T09:42:00Z",
  "technicalError": "Automated installation process terminated during OS deployment"
}
7. Migration Blocker Contracts
CreateMigrationBlockerRequest

Used by:

POST /api/v1/migration-blockers

Field	Type	Required	Nullable
workplaceId	integer	yes	no
blockerType	string	yes	no
description	string	yes	no
responsibleTeamId	integer	no	yes

Example:

{
  "workplaceId": 102,
  "blockerType": "software_compatibility",
  "description": "Required spreadsheet workflow is not supported in Astra Linux",
  "responsibleTeamId": 4
}
blockerType values

Possible values:

software_compatibility
software_readiness
access
information_security
infrastructure
hardware
business_dependency
other
MigrationBlockerResponse
Field	Type	Required	Nullable
blockerId	integer	yes	no
workplaceId	integer	yes	no
blockerType	string	yes	no
description	string	yes	no
responsibleTeamId	integer	yes	yes
status	string	yes	no
createdAt	datetime	yes	no
resolvedAt	datetime	yes	yes

Example:

{
  "blockerId": 7001,
  "workplaceId": 102,
  "blockerType": "software_compatibility",
  "description": "Required spreadsheet workflow is not supported in Astra Linux",
  "responsibleTeamId": 4,
  "status": "open",
  "createdAt": "2026-02-20T13:00:00Z",
  "resolvedAt": null
}
status values
open
in_progress
resolved
UpdateMigrationBlockerRequest

All fields are optional.

Field	Type	Required	Nullable
responsibleTeamId	integer	no	yes
status	string	no	no

Example:

{
  "status": "resolved"
}

If:

status = resolved

the service sets resolvedAt automatically.

8. Compatibility Assessment Contract
CompatibilityAssessmentResponse
Field	Type	Required	Nullable
softwareId	integer	yes	no
softwareName	string	yes	no
compatibilityStatus	string	yes	no
replacementAvailable	boolean	yes	no
replacementMaturity	string	yes	yes
blockerFlag	boolean	yes	no
assessmentDate	date	yes	no
responsibleTeamId	integer	yes	yes
notes	string	yes	yes

Example:

{
  "softwareId": 2,
  "softwareName": "Microsoft Excel",
  "compatibilityStatus": "partial",
  "replacementAvailable": true,
  "replacementMaturity": "limited",
  "blockerFlag": true,
  "assessmentDate": "2026-01-12",
  "responsibleTeamId": 4,
  "notes": "Some complex Excel workflows are not fully supported"
}
compatibilityStatus values
compatible
partial
under_development
no_replacement
unknown
9. Pagination Contract

List endpoints return a common paginated structure.

Example:

{
  "items": [],
  "page": 1,
  "pageSize": 50,
  "total": 0
}
Field	Type	Description
items	array	Current page resources
page	integer	Current page number
pageSize	integer	Maximum number of records per page
total	integer	Total matching record count

Validation:

page >= 1
pageSize >= 1
pageSize <= 100
10. Error Contract
ErrorResponse

All API errors use the same base structure.

Field	Type	Required	Nullable
code	string	yes	no
message	string	yes	no
details	object / array	yes	yes

Example:

{
  "code": "WORKPLACE_NOT_FOUND",
  "message": "Workplace with id 102 was not found",
  "details": null
}

Validation error example:

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
11. Contract Design Principles

The API contracts follow these principles:

Request and response models are separated where their responsibilities
differ.
Internal database column names are not exposed directly as a database
contract.
API field names remain stable even if the internal persistence model
changes.
Enumerated values are explicitly documented.
Conditional requirements are documented as validation rules.
Nullable and optional fields are treated as different concepts.
API consumers should not infer undocumented migration states.
Error responses use stable machine-readable error codes.