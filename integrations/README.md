# Integrations and External Boundaries

This area describes interactions across ownership boundaries that influence migration state, readiness, planning, execution or recovery.

It does not re-document the internals of adjacent corporate systems.

## Canonical document

→ [`boundary-contracts.md`](boundary-contracts.md) defines the migration meaning crossing Service Desk, automation tooling, notification, software support, Information Security/access, infrastructure and vendor/development boundaries.

## Interaction vocabulary

```text
COMMAND
→ asks another domain to perform something

EVIDENCE
→ reports a fact or constraint for migration interpretation

NOTIFICATION
→ communicates an already-owned migration fact
```

The distinction matters because transport does not determine authority.

## Main boundaries

- **Service Desk** — formal postponement/stop-factor coordination evidence;
- **Automated Migration Tooling** — technical attempt capability and result evidence;
- **Notification Service** — delivery of planning-owned dates/messages;
- **Software / Office Applications Support** — compatibility and functionality evidence;
- **Information Security / access domains** — security/access constraints and approvals;
- **Infrastructure Automation** — tooling/infrastructure capability and attempt evidence;
- **specialized support domains** — domain-specific evidence when it affects workplace capability;
- **vendor/development teams** — remediation outcomes for missing target functionality.

## Core principle

> **External systems report facts or provide capabilities. Internal migration meaning remains with the relevant migration responsibility owner.**

For every boundary ask:

```text
What crosses the boundary?
Who owns that fact?
Who consumes it?
Is it command, evidence or notification?
What if it is stale, duplicated or unavailable?
How is it reconciled with current migration knowledge?
```

Where the sanitized reconstruction cannot support an answer, the gap should be explicit rather than replaced with invented production behavior.
