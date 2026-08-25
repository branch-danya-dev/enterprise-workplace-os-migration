# Migration Management API

## Purpose

This API provides access to migration planning, execution status,
postponement handling, blocker management and workplace migration data.

The API represents a simplified portfolio implementation of the migration
management domain described in the repository.

It does not represent a real production interface used by the organization.

---

## API Responsibilities

The API provides operations for:

- retrieving workplaces;
- retrieving migration status;
- retrieving workplace software dependencies;
- retrieving migration blockers;
- managing migration schedules;
- registering postponement requests;
- retrieving migration attempts;
- retrieving software compatibility information;
- updating migration-related status where permitted.

---

## Main Resources

The API exposes the following primary resources:

- `/users`
- `/workplaces`
- `/software`
- `/migration-schedules`
- `/migration-attempts`
- `/migration-blockers`
- `/postponement-requests`
- `/compatibility-assessments`

---

## Architectural Context

The simplified interaction model is:

Client
↓
Migration Management API
↓
Migration Database

Other corporate systems may interact with the API indirectly.

Examples:

- Service Desk
- automated migration tooling;
- reporting tools;
- support interfaces;
- administrative tools.

---

## API Style

The API uses REST-style HTTP interfaces.

Data is exchanged using JSON.

Example:

GET /api/v1/workplaces/123

Response:

```json
{
  "workplaceId": 123,
  "userId": 45,
  "currentOs": "Windows 10",
  "targetOs": "Astra Linux",
  "migrationStatus": "scheduled"
}

Versioning

API endpoints use URI-based versioning.

Example:

/api/v1/workplaces

Future incompatible API changes may be introduced under a new version,
for example:

/api/v2/workplaces

Identifier Strategy

API resources use stable numeric identifiers.

Examples:

userId
workplaceId
softwareId
attemptId
blockerId

Identifiers are treated as internal resource identifiers and should not
contain business meaning.

Date and Time Format

Dates use ISO 8601 format.

Examples:

Date:

2026-08-28

Date and time:

2026-08-28T09:30:00Z

Error Format

All API errors use a common response structure.

Example:

{
  "code": "WORKPLACE_NOT_FOUND",
  "message": "Workplace with id 123 was not found",
  "details": null
}

Possible fields:

code — stable machine-readable error code;
message — human-readable description;
details — optional additional information.
HTTP Status Codes

Typical HTTP statuses:

200 OK — successful request;
201 Created — resource created;
204 No Content — successful update without response body;
400 Bad Request — invalid request;
404 Not Found — resource does not exist;
409 Conflict — request conflicts with current resource state;
500 Internal Server Error — unexpected server-side failure.
Scope

This API focuses on migration management information.

The API does not directly perform operating-system installation.

Actual automated migration is handled by separate migration tooling.

The API may store or expose the result of migration attempts performed by
that tooling.