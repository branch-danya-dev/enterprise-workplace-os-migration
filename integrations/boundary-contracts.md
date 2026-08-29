# External Boundary Contracts

This document describes the **meaning that crosses migration ownership boundaries**.

It intentionally avoids reconstructing internal APIs or workflows of adjacent corporate systems unless the migration case needs that detail.

The key question is not “which endpoint existed?” but:

> **What fact, command or evidence crossed the boundary, who owned it, and how did it affect migration meaning?**

## Interaction types

SSAD separates three useful categories:

```text
COMMAND
→ asks another domain to perform something

EVIDENCE
→ reports a fact/constraint the migration model must interpret

NOTIFICATION
→ communicates an already-owned migration fact
```

One integration may support more than one category, but the distinction prevents transport from becoming domain authority.

## Service Desk boundary

### Purpose

The Service Desk is the formal coordination channel for migration-related requests and stop factors in the reconstructed process.

### Migration-relevant interactions

```text
Postponement request
→ evidence/request consumed by Planning

Stop-factor / blocker ticket
→ evidence/coordination record consumed by Exceptions
```

### Ownership

Service Desk owns its ticket/workflow behavior.

It does not own:

- canonical migration schedule;
- final postponement semantics;
- readiness state;
- workplace operational state;
- blocker meaning inside the migration model.

A closed or updated ticket cannot silently redefine migration state without the relevant migration owner interpreting the result.

Legacy anchors: `BR-004`, `BR-005`, `BR-011`, `FR-004`, `FR-005`, `FR-012`, `AC-004`, `AC-009`.

## Automated migration tooling boundary

### Purpose

Automation performs the technical migration procedure for standard cases.

### Output to migration model

Typical evidence:

- attempt started;
- technical completion;
- technical failure;
- error/context required for support;
- backup/restore or installation outcomes where available.

```text
Migration tool
→ attempt evidence
→ Execution interprets/records
→ resulting cross-responsibility flow continues
```

### Ownership

Automation tooling owns its technical execution behavior.

It does not own arbitrary domain commands such as:

```text
set workplace = fully operational
```

A successful tool result can move the system toward operational validation but does not itself prove business completion.

Legacy anchors: `BR-008`, `BR-009`, `FR-008`, `FR-009`, `NFR-010`, `AC-006`, `AC-007`.

## Notification boundary

### Purpose

Users are informed about planned migration dates and rescheduled dates.

### Contract meaning

```text
Planning owns active date
→ Notification receives date/message request
→ delivery outcome may return as evidence
```

Notification delivery does not own the planned date.

Legacy anchors: `BR-002`, `BR-006`, `FR-003`, `AC-002`, `AC-005`.

## Software / Office Applications Support boundary

Provides evidence about:

- availability of Astra-compatible software;
- adequacy/maturity of replacement applications;
- known functionality gaps;
- application-specific constraints;
- remediation/vendor-development progress.

This evidence is consumed by Readiness and Exceptions.

The migration model does not own application internals.

## Information Security / access boundary

Provides constraints/evidence about:

- required security controls;
- network/access rules;
- authentication/certificates/tokens where relevant;
- whether required approved access can remain operational.

Migration Readiness consumes the consequence for migration without redefining security policy.

## Infrastructure Automation boundary

May provide:

- automated migration capability;
- tooling/infrastructure readiness;
- backup/deployment capabilities;
- technical attempt results.

The exact boundary can affect both Readiness (known capability before execution) and Execution (actual attempt evidence).

## Telephony and other specialized domains

Specialized support teams are included only when their domain affects required workplace capability.

The methodology rule is:

> Do not model every enterprise support system. Model the boundary where its evidence changes migration behavior.

## Vendor / development boundary

When a required target capability does not exist, Exceptions may initiate/coordinate an external development or adaptation request.

```text
migration blocker
→ missing capability description
→ vendor/development request
→ external implementation
→ compatibility evidence returns
→ readiness revalidation
```

The migration system owns the impact and requested capability context, not the vendor's delivery process.

## Failure and reconciliation questions

For each boundary, the migration analysis should ask:

- What if evidence is missing or stale?
- Can the same evidence/request appear more than once?
- What if a ticket closes but the underlying blocker is still present?
- What if automation reports technical success but operational validation fails?
- What if a notification fails after the plan changes?
- What fact is authoritative when local working tables and shared registers disagree?

Not all answers are historically recoverable from the sanitized case. Missing answers should be marked as reconstruction gaps rather than invented.

## Core ownership table

| Boundary | What crosses | Migration consumer | External authority remains with |
|---|---|---|---|
| Service Desk | postponement/blocker request evidence | Planning / Exceptions | Service Desk workflow |
| Migration tooling | attempt/result evidence | Execution | automation tooling internals |
| Notification | delivery capability/result | Planning | notification system |
| Software support | compatibility evidence | Readiness / Exceptions | software support/vendor domain |
| Information Security / access | constraints/approval evidence | Readiness | security/access domains |
| Infrastructure Automation | capability/result evidence | Readiness / Execution | infrastructure/automation domain |
| Specialized support | domain-specific evidence | Readiness / Exceptions | corresponding support domain |
| Vendor/development | remediation result | Exceptions / Readiness | vendor/development domain |

## Legacy traceability

This model absorbs cross-team and integration meaning from:

- `docs/03-dependency-model.md`;
- `BR-002`, `BR-004`, `BR-005`, `BR-011`, `BR-015`, `BR-016`;
- `FR-003`, `FR-004`, `FR-005`, `FR-012`, `FR-015`, `FR-018`;
- `NFR-005`, `NFR-007`, `NFR-010`, `NFR-016`;
- `AC-002`, `AC-004`, `AC-009`, `AC-010`;
- legacy sequence diagrams for postponement and manual recovery.
