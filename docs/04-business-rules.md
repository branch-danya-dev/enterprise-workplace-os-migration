# Business Rules

## Purpose

This document defines the operational business rules used to manage workplace
migration from Microsoft Windows to Astra Linux.

The rules describe the conditions under which a workplace remains scheduled,
is postponed, enters manual migration, or is considered migrated.

---

## BR-001 — Migration Date Assignment

Each workplace included in the migration programme must have an assigned
migration date.

The assigned date is used as the planned execution point for the automated
migration process.

---

## BR-002 — User Notification

The user must be notified in advance that their workplace has been scheduled
for migration.

The notification must include the planned migration date.

---

## BR-003 — No Postponement Request Means Migration Proceeds

If no postponement request is received from the user before the scheduled
migration date, the workplace remains eligible for migration.

No additional user confirmation is required.

---

## BR-004 — Postponement Request Channel

A request to postpone migration must be submitted through the corporate
Service Desk.

Requests submitted outside the approved support process are not treated as
formal migration postponement requests.

---

## BR-005 — Postponement Requires Review

A postponement request must contain a reason explaining why migration cannot
be performed on the currently assigned date.

The request is reviewed by the responsible support group and, where required,
escalated to the appropriate manager or related support team.

---

## BR-006 — Approved Postponement Requires Rescheduling

If the postponement request is approved:

1. the workplace must be marked as postponed;
2. the current migration date must no longer be treated as active;
3. a new migration date must be assigned;
4. the user must be informed about the new date.

---

## BR-007 — Rejected Postponement Does Not Change the Schedule

If a postponement request is not approved, the original migration date
remains valid.

The workplace continues through the standard migration process.

---

## BR-008 — Automated Migration Is the Default Execution Method

Migration should be performed using the automated migration process whenever
the workplace can be processed successfully by the migration tooling.

Manual migration is treated as an exception path.

---

## BR-009 — Technical Failure Triggers Manual Migration

If the automated migration fails for technical reasons, the workplace must be
transferred to manual migration.

The failure does not automatically remove the workplace from the migration
programme.

---

## BR-010 — Manual Migration Is Performed by Workplace Support

Manual migration is performed by the Workplace Support team.

The typical manual process includes:

- taking over the workstation;
- removing the existing Windows environment;
- installing Astra Linux manually;
- restoring the required workplace environment;
- returning the workstation to the user.

---

## BR-011 — Migration Blocker Must Be Registered

If a workplace cannot be migrated due to a confirmed stop factor, the blocker
must be registered through the corporate support process.

The blocker may affect:

- one workplace;
- a group of workplaces;
- a department;
- a specific software-dependent user group.

---

## BR-012 — Software Compatibility Affects Migration Priority

Workplaces that depend on software without an acceptable Astra Linux
equivalent must be migrated at a later stage.

Workplaces using unstable or incomplete software replacements should also be
prioritised for later migration.

---

## BR-013 — Dual Boot Is a Transitional Migration State

A workplace may be configured in dual-boot mode if Astra Linux is deployed
but required business functionality is still available only in Windows.

Dual boot is considered a temporary migration state.

Once the required functionality becomes available in Astra Linux, the Windows
environment should be removed.

---

## BR-014 — Migration Completion Requires an Operational Workplace

A workplace is not considered fully migrated solely because Astra Linux has
been installed.

Migration is considered operationally complete when the user can continue the
agreed business activity using the target workplace environment.

---

## BR-015 — Missing Software May Require Vendor Development

If required functionality is unavailable in Astra Linux and no acceptable
replacement exists, a development or adaptation request may be prepared for
the responsible vendor or development team.

The request must describe the missing functionality that prevents migration.

---

## BR-016 — Migration Readiness Depends on Cross-Team Validation

Migration readiness may depend on validation or approval from multiple
support domains, including:

- Information Security;
- Infrastructure Automation;
- Software and Office Applications Support;
- Workplace Support;
- Telephony Support;
- other specialised support teams where required.

No single team owns all migration dependencies.