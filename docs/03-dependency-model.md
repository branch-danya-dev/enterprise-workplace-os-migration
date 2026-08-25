# Dependency Model and Migration Readiness

## Purpose

This document describes the dependencies that affected workplace migration
from Microsoft Windows to Astra Linux and the logic used to determine
migration readiness.

The main migration constraint was not the operating system itself, but the
ability to preserve the user's working environment after the transition.

Migration readiness therefore depended on software compatibility, access
preservation, security requirements, infrastructure readiness and the absence
of unresolved migration blockers.

---

## Core Dependency Model

A simplified workplace dependency chain can be represented as:

User
↓
Business Role / Department
↓
Workplace
↓
Required Software
↓
Access Rights and Security Configuration
↓
Corporate Services
↓
Infrastructure Dependencies
↓
Business Activity

A migration issue at any level could prevent or delay migration of the
workplace.

---

## Software Dependency

Software compatibility was one of the primary factors affecting migration
priority.

Applications could be divided into several practical categories.

### Compatible

The required software or an acceptable Astra Linux equivalent was available
and sufficiently stable for production use.

Such workplaces could be migrated according to the standard migration
schedule.

### Partially Compatible

An alternative application existed but did not yet provide all functionality
required by the user.

These workplaces were normally migrated at a later stage to reduce business
impact.

### No Acceptable Alternative

A required application had no available Astra Linux equivalent.

These workplaces were treated as migration blockers and were moved to the
latest migration stages until an acceptable solution became available.

---

## Dual-Boot Transitional State

For some users, Astra Linux could be deployed while certain required
applications were still available only in Windows.

In these cases, the workstation was configured in dual-boot mode:

Windows + Astra Linux

This allowed the workplace to be included in the migration programme while
the user could continue using Windows for unsupported business scenarios.

Once the required software became available and was validated for Astra
Linux, the Windows environment could be removed.

This created an important distinction between:

- technically migrated workplace;
- transition-state workplace;
- fully operational Astra Linux workplace.

A workstation running Astra Linux in dual-boot mode was therefore not
necessarily considered fully migrated from an operational perspective.

---

## Software Compatibility Register

Software compatibility information was collected continuously during the
migration programme.

Sources of information included:

- department managers;
- application support teams;
- infrastructure support teams;
- workplace support teams;
- users and business units reporting missing functionality;
- migration incidents.

A shared migration register was maintained by the participating support
groups.

Relevant information from the common register was then used in local working
tables maintained by the workplace support team for operational migration
control.

This model allowed global migration information to be combined with
site-specific operational tracking.

---

## Missing Software Escalation Flow

When a required application or functional equivalent was unavailable on
Astra Linux, a development request could be initiated.

A typical flow was:

Migration blocker identified
↓
Required functionality analysed
↓
Technical requirement prepared
↓
Approval by workplace support management
↓
Approval / coordination with office software support
↓
Request sent to vendor / developer
↓
Development or adaptation
↓
Compatibility validation
↓
Workplace returned to migration pipeline

The request contained the required functionality and described the gap that
prevented migration.

Until the blocker was resolved, the affected workplace could be delayed or
placed into a transitional configuration.

---

## Access and Security Dependencies

Migration also required preservation of user access rights.

The migration tooling developed by the infrastructure automation team was
designed to preserve user data and required access configuration during the
operating system transition.

Before migration:

- user data was backed up;
- a workstation image / backup was created;
- required network access configuration was prepared;
- security-related access associated with the user was recreated or
  transferred as part of the migration procedure.

Network access rules were associated with the user through the corporate
firewall / access-control environment.

As a result, successful operating-system deployment alone was not sufficient.
The user also had to retain access to the systems required for their work.

---

## Application-Level Dependencies

Some applications depended on functionality that could not be reproduced
directly in the Astra Linux environment.

For example, Microsoft Excel was replaced by R7-Office Spreadsheets.

However, compatibility of the application itself did not guarantee
compatibility of all user scenarios.

Examples included:

- macros;
- application-specific extensions;
- complex spreadsheets;
- integrations with other software.

These dependencies could create additional migration blockers even when an
official replacement application existed.

Detailed application-to-application dependency analysis was generally owned
by specialised support teams and was outside the direct responsibility of
the workplace support group.

However, such dependencies were considered when they affected workplace
migration readiness.

---

## Hardware and Peripheral Dependencies

Hardware and office equipment were not a major migration blocker.

In isolated cases, particular peripheral devices did not have compatible
drivers for Astra Linux.

Typical remediation included:

1. replacement of the affected device with a supported model;
2. creation of a development request for the required driver.

As a result, hardware incompatibility was generally treated as a resolvable
exception rather than a systemic blocker.

---

## Migration Readiness Status

Migration readiness was maintained in operational Excel-based migration
schedules.

A simple colour-based status model was used:

### Green — Ready

The workplace had no known migration blocker and could be migrated according
to schedule.

### Yellow — Pending / Under Coordination

The workplace had an unresolved question or dependency that required
coordination before migration.

### Red — Blocked

The workplace had a confirmed blocker and could not be migrated safely.

Examples included:

- missing critical software;
- unacceptable software replacement;
- unresolved security requirement;
- infrastructure dependency;
- other business-critical stop factors.

---

## Migration Stop-Factor Flow

Migration normally followed the approved schedule.

If a blocking condition was identified for a user or group of users, the
workplace support team did not unilaterally remove the workplace from the
migration programme.

Instead, a separate Service Desk request was created in Inframanager.

The request documented the stop factor and initiated coordination of the
migration delay.

The outcome could include:

- temporary suspension of migration for one workplace;
- suspension of migration for a group of workplaces;
- additional technical analysis;
- remediation activity;
- rescheduling into a later migration wave.

---

## Cross-Team Dependencies

Migration readiness depended on multiple support and infrastructure groups.

Participants could include:

- Information Security;
- Telephony Support;
- Infrastructure Automation Support;
- Software and Office Applications Support;
- Workplace Support;
- other specialised support teams where required.

Migration readiness was therefore not owned by one isolated team.

Different groups validated different parts of the workplace environment before
the migration could proceed.

The workplace support team acted as one of the final operational layers in
this chain, ensuring that workplace-related dependencies and blockers were
identified and handled.

---

## Migration Readiness Logic

A simplified decision model can be represented as:

Workplace scheduled
↓
Required software identified
↓
Compatible?
├── Yes
│    ↓
│  Access and infrastructure checks
│    ↓
│  No blockers?
│    ├── Yes → GREEN → migrate
│    └── No  → YELLOW / RED
│
└── No
     ↓
Alternative available?
├── Stable → migrate / validate
├── Partial → delay or dual boot
└── None → RED → vendor development / exception

After blocker resolution:

Re-validation
↓
Return to migration schedule
↓
Astra Linux operational state