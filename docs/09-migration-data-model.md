# Migration Data Model

## Purpose

This document defines the conceptual data model of the enterprise workplace
migration process from Microsoft Windows to Astra Linux.

The model describes the main business entities involved in migration planning,
execution, compatibility management and exception handling.

The model is technology-independent and does not imply that all entities were
stored in a single database.

---

## Core Entities

### User

Represents an employee whose workplace is included in the migration programme.

Key attributes:

- user_id
- full_name
- department
- business_role
- workplace_profile
- work_mode
- current_migration_status

A user may have one or more assigned workplaces.

---

### Workplace

Represents a physical or logical workstation assigned to a user.

Key attributes:

- workplace_id
- user_id
- current_os
- target_os
- location
- workplace_type
- migration_status
- planned_migration_date

A workplace belongs to a user and may contain multiple software dependencies.

---

### WorkplaceProfile

Represents the type of workplace and its characteristic requirements.

Examples:

- Office User
- Remote User
- Restricted-Environment User
- Developer
- Specialized Workplace

Key attributes:

- profile_id
- profile_name
- description

A workplace profile determines the typical software, access and security
dependencies expected for a workplace.

---

### Software

Represents software required or installed on a workplace.

Key attributes:

- software_id
- software_name
- software_category
- windows_version
- astra_equivalent
- compatibility_status
- business_criticality

Examples:

- Yandex Browser
- Microsoft Excel
- R7 Spreadsheets
- 1C-based software
- IDEs
- specialized business applications

---

### WorkplaceSoftware

Represents the relationship between a workplace and required software.

Key attributes:

- workplace_id
- software_id
- required
- business_critical
- current_status

This entity allows one workplace to depend on multiple software products and
one software product to be used by many workplaces.

---

### CompatibilityAssessment

Represents the compatibility status of a software product or workplace
dependency with Astra Linux.

Key attributes:

- assessment_id
- software_id
- compatibility_status
- replacement_available
- replacement_maturity
- blocker_flag
- assessment_date
- responsible_team
- notes

Possible compatibility states:

- compatible
- replacement available
- replacement incomplete
- no acceptable replacement
- under development
- unknown

---

### MigrationSchedule

Represents the planned migration of a workplace.

Key attributes:

- schedule_id
- workplace_id
- planned_date
- readiness_status
- current_status
- migration_wave

A workplace may receive multiple planned dates during the migration lifecycle
if migration is postponed.

---

### PostponementRequest

Represents a formal request to postpone migration.

Key attributes:

- request_id
- workplace_id
- service_desk_ticket_id
- requested_date
- reason
- approval_status
- new_migration_date

Possible approval states:

- pending
- approved
- rejected

---

### MigrationAttempt

Represents one attempt to migrate a workplace.

Key attributes:

- attempt_id
- workplace_id
- migration_date
- execution_type
- result
- technical_error
- completion_time

Execution types:

- automated
- manual

Possible results:

- successful
- failed

A workplace may have more than one migration attempt.

---

### MigrationBlocker

Represents a condition preventing or delaying migration.

Key attributes:

- blocker_id
- workplace_id
- blocker_type
- description
- responsible_team
- status
- created_date
- resolved_date

Possible blocker categories:

- software compatibility
- access
- information security
- infrastructure
- hardware
- business dependency
- other

---

### AccessDependency

Represents access required by the user to perform their business activity.

Key attributes:

- access_id
- user_id
- access_type
- target_system
- security_approval_required
- status

Examples:

- network folder access
- internal web application access
- firewall rule
- certificate-based access
- remote access

---

### SupportTeam

Represents a team responsible for resolving a migration-related dependency.

Examples:

- Workplace Support
- Information Security
- Infrastructure Automation
- Software and Office Applications Support
- Telephony Support
- Vendor / Development Team

Key attributes:

- team_id
- team_name
- responsibility_area

---

## Entity Relationships

The main conceptual relationships are:

User
1 → N
Workplace

WorkplaceProfile
1 → N
Workplace

Workplace
N → M
Software
via WorkplaceSoftware

Software
1 → N
CompatibilityAssessment

Workplace
1 → N
MigrationSchedule

Workplace
1 → N
MigrationAttempt

Workplace
1 → N
MigrationBlocker

Workplace
1 → N
PostponementRequest

User
1 → N
AccessDependency

SupportTeam
1 → N
MigrationBlocker

SupportTeam
1 → N
CompatibilityAssessment

---

## Simplified Domain Model

User
↓
Workplace
├── Workplace Profile
├── Software Dependencies
│    └── Compatibility Assessments
├── Access Dependencies
├── Migration Schedule
├── Postponement Requests
├── Migration Attempts
└── Migration Blockers

Migration blockers and compatibility assessments may be assigned to
responsible support teams.

---

## Important Modelling Decisions

### User and Workplace are separate entities

The migration target is the workplace, but the business impact belongs to the
user.

A single user may have more than one workplace.

Therefore User and Workplace should not be represented as the same entity.

### Software requires a many-to-many relationship

One workplace may require many software products.

One software product may be required by thousands of workplaces.

Therefore the relationship is represented through WorkplaceSoftware.

### MigrationSchedule and MigrationAttempt are different entities

A planned migration does not guarantee that migration actually occurred.

MigrationSchedule represents intention.

MigrationAttempt represents execution.

This distinction is important when migration is postponed or technically
fails.

### Compatibility is not stored directly as a boolean

Software compatibility is not simply:

compatible = true / false

Real migration states include partial compatibility, immature replacements
and development dependencies.

Therefore compatibility is represented as a separate assessment with a status.

### Blocker is a separate entity

A blocker has its own lifecycle:

identified
→ assigned
→ investigated
→ resolved

It should therefore not be represented only as a text field inside the
workplace record.

## SQL Reference

A simplified relational implementation of this conceptual model is available in:

- `sql/01-schema.sql`
- `sql/02-sample-data.sql`
- `sql/03-analysis-queries.sql`

The SQL implementation uses synthetic portfolio data and does not represent
the internal production database of the organization.