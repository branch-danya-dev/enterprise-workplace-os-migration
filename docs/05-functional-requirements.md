# Functional Requirements

## Purpose

This document defines the functional requirements for the workplace migration
management process from Microsoft Windows to Astra Linux.

The requirements describe the expected behavior of the migration management
process and supporting tools from scheduling through completion and exception
handling.

---

## FR-001 — Add Workplace to Migration Schedule

The migration management process shall allow an eligible workplace to be added
to the migration schedule.

The workplace record shall include at least:

- workplace identifier;
- assigned user;
- planned migration date;
- current migration status.

---

## FR-002 — Assign Migration Date

The process shall support assigning a planned migration date to each workplace.

The assigned date shall be used to determine when the automated migration
process is initiated.

---

## FR-003 — Notify User About Migration

The process shall notify the user that the assigned workplace is scheduled for
migration.

The notification shall contain the planned migration date.

---

## FR-004 — Register Postponement Request

The process shall support registration of a migration postponement request
through the corporate Service Desk.

The request shall contain:

- workplace or user identifier;
- current migration date;
- reason for postponement;
- request status.

---

## FR-005 — Review Postponement Request

The responsible support team shall be able to review the postponement request
and record the decision.

Supported outcomes shall include:

- approved;
- rejected;
- additional coordination required.

---

## FR-006 — Reschedule Workplace

If postponement is approved, the process shall support assigning a new migration
date to the workplace.

The previous date shall no longer be treated as the active migration date.

---

## FR-007 — Track Migration Status

The process shall maintain the current migration status of each workplace.

The status model shall support at least:

- scheduled;
- pending;
- ready;
- postponed;
- blocked;
- migration in progress;
- dual boot;
- migrated;
- manual migration required.

---

## FR-008 — Start Automated Migration

On the scheduled migration date, the workplace shall be eligible for automated
migration if no approved postponement or active blocker exists.

---

## FR-009 — Record Automated Migration Result

The process shall record the result of the automated migration attempt.

Supported results shall include at least:

- successful;
- failed due to technical error.

---

## FR-010 — Transfer Failed Migration to Manual Processing

If automated migration fails for technical reasons, the workplace shall be
transferred to the manual migration process.

The Workplace Support team shall be able to identify such workplaces.

---

## FR-011 — Record Manual Migration Completion

The process shall allow Workplace Support to record completion of manual
migration.

The workplace shall then be moved to the migrated state.

---

## FR-012 — Register Migration Blocker

The process shall support registration of a migration blocker for a workplace
or a group of workplaces.

A blocker record shall contain at least:

- affected workplace or workplace group;
- blocker category;
- description;
- responsible support domain;
- current status.

---

## FR-013 — Track Software Compatibility

The migration process shall maintain information about software compatibility
with Astra Linux.

Software compatibility shall support at least the following states:

- compatible;
- replacement available;
- replacement incomplete or unstable;
- no acceptable replacement;
- under development or adaptation.

---

## FR-014 — Support Dual-Boot Migration

The process shall support a transitional dual-boot state for workplaces where
Astra Linux is deployed but selected business functionality still requires
Windows.

The workplace shall remain identifiable as transitional until Windows is
removed.

---

## FR-015 — Initiate Vendor Development Request

If a required software capability is unavailable in Astra Linux, the support
process shall allow a development or adaptation request to be prepared and
sent to the responsible vendor or development team.

The request shall describe the missing functionality and its migration impact.

---

## FR-016 — Maintain Migration Readiness Status

The process shall support readiness classification for each workplace.

At minimum:

- Green — ready for migration;
- Yellow — pending coordination;
- Red — blocked.

The readiness status shall be updated when blocker or compatibility information
changes.

---

## FR-017 — Preserve User Data and Access Configuration

The migration process shall support preservation or restoration of user data
and required access configuration during migration.

This includes:

- backup of user data;
- restoration of required workplace data;
- preservation or recreation of network access rules;
- restoration of access required for the user's business activity.

---

## FR-018 — Support Cross-Team Coordination

The migration process shall allow workplace-related issues to be assigned or
escalated to the relevant support domain.

Examples include:

- Information Security;
- Infrastructure Automation;
- Software and Office Applications Support;
- Telephony Support;
- Workplace Support;
- vendor or development teams.

---

## FR-019 — Maintain Migration History

The process shall preserve the migration history of each workplace.

The history should include:

- scheduled dates;
- postponement requests;
- blocker records;
- migration attempts;
- manual migration events;
- final migration result.

---

## FR-020 — Provide Operational Migration Reporting

The process shall support operational reporting for migration tracking.

Reports shall allow responsible teams to identify:

- workplaces scheduled for migration;
- ready workplaces;
- postponed workplaces;
- blocked workplaces;
- failed automated migrations;
- workplaces requiring manual intervention;
- migrated workplaces.