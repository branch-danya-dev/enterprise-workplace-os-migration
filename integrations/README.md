# Integrations and External Boundaries

This area describes interactions across ownership boundaries that influence migration state, readiness, planning or execution.

It does not re-document the internals of adjacent corporate systems.

## Main external actors and systems

### Service Desk

Provides the formal channel for postponement requests, stop-factor registration and coordination records.

Canonical migration meaning remains in the migration model; Service Desk supplies workflow evidence and coordination artifacts.

### Automated Migration Tooling

Performs the automated technical migration procedure and reports attempt outcomes.

```text
migration tool result
→ execution evidence
→ migration model decides resulting domain transition
```

The tooling does not own arbitrary workplace lifecycle state.

### Notification Service

Delivers user-facing migration-date and rescheduling notifications.

It owns delivery behavior, not the canonical migration schedule.

### Specialized Support Domains

Examples include Information Security, Software/Office Applications Support, Infrastructure Automation, Telephony and other specialized support teams.

They provide authoritative evidence about their own areas. Migration readiness consumes that evidence without absorbing ownership of those systems.

## Cross-boundary contract questions

For every integration, analyze:

```text
What fact crosses the boundary?
Who owns that fact?
Who consumes it?
Is the interaction a command, evidence or notification?
What happens if it is late, duplicated or unavailable?
How is the result reconciled with migration state?
```

## Core principle

> **External systems report facts or provide capabilities. Internal migration meaning remains with the relevant migration responsibility owner.**

This principle is especially important in the portfolio API projection, where transport operations must not redefine the real domain model.
