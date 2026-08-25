# Non-Functional Requirements

## Purpose

This document defines the non-functional requirements for the enterprise
workplace migration process from Microsoft Windows to Astra Linux.

The requirements describe the operational, reliability, security,
traceability and supportability characteristics expected from the migration
process and its supporting tooling.

---

## NFR-001 — Business Continuity

Migration activities shall minimize disruption to the user's normal business
activity.

A migration shall not leave the user without an operational workplace for an
uncontrolled period of time.

---

## NFR-002 — Recoverability

The migration process shall provide a recovery path if the automated migration
cannot be completed successfully.

Recovery mechanisms may include:

- backup restoration;
- manual migration;
- temporary use of Windows through a transitional configuration;
- reassignment or replacement of the workplace where required.

---

## NFR-003 — Data Preservation

User data required for normal business activity shall be preserved during the
migration process.

A backup shall be created before destructive operating-system changes are
performed.

---

## NFR-004 — Access Preservation

Required user access to corporate systems and network resources shall be
preserved or restored after migration.

Migration shall not intentionally remove access required for the user's
approved business activity.

---

## NFR-005 — Security Compliance

The migrated workplace shall comply with applicable corporate information
security requirements.

Security controls may include:

- approved operating-system configuration;
- antivirus and security software;
- network access rules;
- authentication mechanisms;
- certificates and security tokens;
- access-control policies.

---

## NFR-006 — Traceability

The migration status of each workplace shall be traceable throughout the
migration lifecycle.

Relevant events should be identifiable, including:

- scheduled migration date;
- postponement;
- blocker registration;
- migration attempt;
- automated migration failure;
- manual migration;
- final completion.

---

## NFR-007 — Auditability

Migration-related decisions and exceptions shall be recorded in a way that
allows responsible teams to determine:

- what happened;
- when it happened;
- which workplace was affected;
- why migration was postponed or blocked;
- which support domain handled the issue.

---

## NFR-008 — Controlled Rollout

Migration shall be performed in controlled groups or waves rather than as an
uncontrolled simultaneous transition.

The process shall support delaying or stopping migration for affected
workplaces when a significant compatibility or operational issue is detected.

---

## NFR-009 — Exception Isolation

A problem affecting one workplace or a limited group of workplaces should not
automatically stop migration for unrelated workplaces.

Where a systemic issue is identified, the affected migration segment may be
paused until the issue is resolved.

---

## NFR-010 — Supportability

Migration results and failures shall provide sufficient information for
support teams to identify affected workplaces and determine the required
follow-up action.

Technical failures requiring manual intervention shall be distinguishable from
business or compatibility blockers.

---

## NFR-011 — Status Accuracy

Migration readiness and execution status shall reflect the current known state
of the workplace.

When a blocker is resolved, postponed, or newly identified, the operational
migration status shall be updated accordingly.

---

## NFR-012 — Scalability of the Migration Process

The operational process and supporting tooling shall support large-scale
migration across thousands of workplaces without requiring individual manual
processing of every standard migration case.

Manual intervention should be reserved for exceptions and technical failures.

---

## NFR-013 — Automation Preference

Standard migration scenarios should be processed through automated tooling
where technically possible.

The migration process should minimize repetitive manual actions performed by
Workplace Support.

---

## NFR-014 — Compatibility Safety

A workplace shall not be treated as fully operational if the target
environment prevents the user from performing required business activities.

Installation of Astra Linux alone is not sufficient evidence of operational
migration success.

---

## NFR-015 — Transitional-State Support

The migration process shall support temporary transitional states where full
migration cannot yet be completed.

For example, dual-boot configuration may be used while selected business
functionality remains available only in Windows.

Transitional states shall remain identifiable until the migration is
completed.

---

## NFR-016 — Cross-Team Coordination

Migration-related dependencies shall be identifiable and transferable to the
appropriate support domain.

The process shall support coordination across relevant teams without requiring
one team to own all technical dependencies.

---

## NFR-017 — Operational Transparency

Responsible teams shall have access to current migration information required
for daily operational control.

At minimum, it should be possible to distinguish:

- ready workplaces;
- pending workplaces;
- blocked workplaces;
- postponed workplaces;
- failed automated migrations;
- manual migration cases;
- completed migrations.