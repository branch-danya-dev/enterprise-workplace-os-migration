# Acceptance Criteria

## Purpose

This document defines acceptance criteria for the enterprise workplace
migration process from Microsoft Windows to Astra Linux.

The criteria describe the conditions under which migration-related
requirements can be considered satisfied.

---

## AC-001 — Workplace Scheduling

A workplace is considered successfully scheduled when:

- the workplace is present in the migration schedule;
- an assigned user is identified;
- a planned migration date is defined;
- the current migration status is recorded.

Related requirement:

- FR-001
- FR-002

---

## AC-002 — User Notification

User notification is considered successfully completed when:

- the user receives a migration notification;
- the notification contains the planned migration date;
- the workplace remains associated with that date unless the migration is
  formally postponed.

Related requirement:

- FR-003

---

## AC-003 — Migration Without Postponement

The workplace remains eligible for migration when:

- the user has been notified;
- no approved postponement request exists;
- no active migration blocker exists;
- the planned migration date has been reached.

Related rules and requirements:

- BR-003
- FR-008

---

## AC-004 — Postponement Request

A postponement request is considered valid when:

- it is registered through the corporate Service Desk;
- the affected user or workplace is identifiable;
- the current migration date is specified or identifiable;
- the reason for postponement is recorded.

Related rules and requirements:

- BR-004
- BR-005
- FR-004

---

## AC-005 — Approved Postponement

A workplace is considered successfully postponed when:

- the postponement request has been approved;
- the previous migration date is no longer active;
- a new migration date is assigned;
- the workplace status is updated;
- the user is informed about the new migration date.

Related rules and requirements:

- BR-006
- FR-005
- FR-006

---

## AC-006 — Automated Migration Success

Automated migration is considered successful when:

- the automated migration process completes without a blocking technical
  error;
- Astra Linux is installed;
- required user data is preserved or restored;
- required access configuration is preserved or restored;
- the workplace can proceed to operational validation.

Related requirements:

- FR-008
- FR-009
- FR-017
- NFR-002
- NFR-003
- NFR-004

---

## AC-007 — Automated Migration Failure

A failed automated migration is considered correctly handled when:

- the failure is recorded;
- the affected workplace is identifiable;
- the workplace is transferred to the manual migration path;
- Workplace Support can identify that manual intervention is required.

Related rules and requirements:

- BR-009
- BR-010
- FR-009
- FR-010
- NFR-010

---

## AC-008 — Manual Migration Completion

Manual migration is considered successfully completed when:

- Workplace Support performs the required migration activity;
- Windows is removed where the target migration state requires it;
- Astra Linux is installed;
- the required workplace environment is restored;
- the workplace is returned to an operational state;
- migration completion is recorded.

Related rules and requirements:

- BR-010
- FR-011
- NFR-001
- NFR-002

---

## AC-009 — Migration Blocker Registration

A migration blocker is considered correctly registered when:

- the affected workplace or workplace group is identified;
- the blocker reason is documented;
- the responsible support domain is identified;
- the workplace migration status reflects the blocker.

Related requirements:

- BR-011
- FR-012
- NFR-006
- NFR-007

---

## AC-010 — Software Compatibility

Software compatibility analysis is considered sufficient for migration
planning when required workplace software has a known compatibility state.

The compatibility state shall indicate at least whether:

- the software is compatible;
- an acceptable replacement exists;
- the replacement is incomplete or unstable;
- no acceptable replacement exists;
- adaptation or vendor development is required.

Related rules and requirements:

- BR-012
- BR-015
- FR-013
- FR-015

---

## AC-011 — Dual-Boot Transitional State

A dual-boot workplace is considered correctly tracked when:

- Astra Linux is installed;
- Windows remains available for required unsupported business scenarios;
- the workplace is identified as transitional rather than fully migrated;
- the unresolved dependency remains traceable.

Related rules and requirements:

- BR-013
- FR-014
- NFR-015

---

## AC-012 — Full Operational Migration

A workplace is considered fully migrated when:

- Astra Linux is installed as the target operating environment;
- required business-critical software is available;
- required corporate services are accessible;
- required user access is operational;
- no active blocker prevents the user from performing the agreed business
  activity.

Installation of Astra Linux alone does not satisfy this criterion.

Related rules and requirements:

- BR-014
- NFR-014

---

## AC-013 — Migration Status Accuracy

Migration status tracking is considered valid when responsible teams can
distinguish at least:

- ready;
- pending;
- blocked;
- postponed;
- migration in progress;
- manual migration required;
- dual boot;
- migrated.

Related requirements:

- FR-007
- FR-016
- NFR-011
- NFR-017

---

## AC-014 — Migration History

Migration history is considered sufficient when it is possible to determine,
for a workplace:

- planned migration dates;
- postponement events;
- blocker records;
- automated migration attempts;
- manual migration events;
- final migration result.

Related requirements:

- FR-019
- NFR-006
- NFR-007

---

## AC-015 — Operational Reporting

Migration reporting is considered sufficient when responsible teams can
identify:

- workplaces scheduled for migration;
- ready workplaces;
- postponed workplaces;
- blocked workplaces;
- automated migration failures;
- workplaces requiring manual intervention;
- completed migrations.

Related requirements:

- FR-020
- NFR-017