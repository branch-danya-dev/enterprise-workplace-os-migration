# Readiness Evidence Model

This document describes the evidence consumed by the migration-readiness decision.

Readiness does not own the internals of every contributing domain. It owns the interpretation of their evidence for the question:

> **Can this workplace be migrated safely now without breaking the required business activity?**

## Evidence categories

### Business capability

The analysis must know what the user actually needs to do at the workplace.

Examples:

- role-specific business activity;
- critical applications;
- complex spreadsheets/macros;
- specialized client software;
- restricted-environment scenarios;
- remote-work requirements.

A technically compatible OS is not useful if the required business scenario stops working.

### Software compatibility

Required software should have an explicit compatibility assessment rather than a permanent boolean flag.

Useful states include:

```text
COMPATIBLE
→ required software works acceptably on Astra Linux

REPLACEMENT AVAILABLE
→ an acceptable alternative exists

REPLACEMENT INCOMPLETE
→ alternative exists but required functionality is missing/unstable

NO ACCEPTABLE REPLACEMENT
→ migration blocker unless another transition strategy exists

UNDER DEVELOPMENT / ADAPTATION
→ dependency remains unresolved

UNKNOWN
→ insufficient evidence; normal readiness must not be assumed
```

The assessment should preserve source, date/maturity and responsible domain when known.

### Application-level compatibility

Product-level compatibility does not prove scenario-level compatibility.

For example, replacing Microsoft Excel with another spreadsheet product does not prove that all of the following still work:

- macros;
- extensions;
- complex formulas/files;
- integrations with other applications;
- department-specific workflows.

Readiness therefore evaluates required functionality, not only application names.

### Access and security

The target workplace must preserve or restore access needed for approved business activity.

Relevant evidence may include:

- internal web-system access;
- network resources and folders;
- firewall/access-control rules;
- certificate/token requirements;
- remote access;
- security software/configuration;
- other corporate security constraints.

Information Security or access-control domains remain authoritative for their own rules. Readiness consumes the resulting constraint/evidence.

### Infrastructure and automation

Migration may depend on:

- infrastructure availability;
- migration tooling readiness;
- backup/restore capability;
- required deployment services;
- site-specific constraints.

A failure of the migration tool itself is normally an execution issue, but a known inability to process a workplace class is readiness evidence before execution.

### Hardware and peripherals

Hardware was generally not a systemic blocker in the reconstructed case, but isolated driver/peripheral incompatibilities could affect readiness.

Typical remediation:

- replace the device with a supported model;
- obtain/develop the required driver;
- temporarily delay the affected workplace.

### Open blockers

An active blocker is explicit evidence that the normal migration path cannot safely continue.

The blocker record is owned by [`../exceptions/`](../exceptions/), while readiness consumes its unresolved impact.

## Distributed evidence sources

```text
Business / user context
        ↓
required capability

Software / vendor domain
        ↓
compatibility evidence

Information Security / access domains
        ↓
security and access evidence

Infrastructure Automation
        ↓
platform/tooling evidence

Workplace Support
        ↓
local workplace evidence

Exceptions
        ↓
open blocker evidence

        ↓
MIGRATION READINESS DECISION
```

No single evidence provider automatically owns the final readiness decision.

## Evidence freshness

Readiness is time-sensitive.

A previous `GREEN` result may become invalid when:

- a new blocker appears;
- a software replacement is found inadequate;
- required functionality changes;
- a security/infrastructure constraint changes;
- a migration incident reveals a wider issue.

Likewise, a previous `RED` result may be reopened after remediation or new compatibility evidence.

Therefore:

```text
readiness decision
= evidence set + interpretation at a point in time
```

It is not an immutable attribute of the workplace.

## Legacy traceability

This evidence model absorbs knowledge previously spread across:

- `docs/02-as-is.md`;
- `docs/03-dependency-model.md`;
- `docs/04-business-rules.md` (`BR-012`, `BR-015`, `BR-016`);
- `FR-013`, `FR-015`, `FR-016`, `FR-017`, `FR-018`;
- `NFR-003`, `NFR-004`, `NFR-005`, `NFR-014`, `NFR-016`;
- `AC-010`, `AC-012`;
- conceptual entities `WorkplaceSoftware`, `CompatibilityAssessment`, `AccessDependency`.
