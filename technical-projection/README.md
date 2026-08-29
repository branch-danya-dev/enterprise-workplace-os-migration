# Technical Projection

This area contains **portfolio-oriented implementation projections** of the reconstructed migration domain.

They demonstrate how canonical SSAD knowledge can be represented through REST, OpenAPI and PostgreSQL without letting transport or storage redefine system meaning.

These artifacts are synthetic. They are **not evidence that these exact services, interfaces or schemas existed in the original banking environment**.

## Projection boundary

```text
CANONICAL SYSTEM KNOWLEDGE
system / workplace / readiness / planning / execution / exceptions / integrations

            ↓ represented by

TECHNICAL PROJECTION
API / OpenAPI / PostgreSQL / operational read models
```

If a projection contradicts canonical migration meaning, the projection is wrong unless new evidence explicitly reopens the domain model.

## Structure

```text
technical-projection/
├── README.md
├── visual-model.md
├── api/
│   ├── README.md
│   └── openapi.yaml
└── data/
    ├── README.md
    ├── schema.sql
    ├── sample-data.sql
    └── analysis-queries.sql
```

[`visual-model.md`](visual-model.md) shows how independently owned facts can share storage and read models without merging semantic ownership.

The previous top-level `api/` and `sql/` trees were removed after their useful concepts were reworked into this projection. Historical versions remain available in Git history.

## What changed after applying SSAD

The original technical model contained two important ownership leaks:

```text
workplaces.migration_status
migration_schedule.readiness_status
```

They made a single persistence/API model look like the owner of several different system meanings.

The normalized projection separates those meanings.

### Workplace

Owns only workplace/environment facts such as:

```text
windows_operational
dual_boot_transition
astra_installed_pending_validation
astra_operational
```

See [`../workplace/`](../workplace/).

### Readiness

Readiness is represented as immutable evaluation snapshots:

```text
current evidence
→ evaluation
→ GREEN / YELLOW / RED
```

A schedule does not store or accept readiness as its own field.

See [`../readiness/`](../readiness/).

### Planning

A schedule stores planning facts:

```text
planned date
migration wave
active / superseded / completed / cancelled
```

Rescheduling creates a new plan and supersedes the old one instead of rewriting history.

See [`../planning/`](../planning/).

### Execution

Migration attempts are immutable execution facts with an idempotency key:

```text
(sourceSystem, externalAttemptId)
```

A successful attempt does not automatically mean the workplace is operationally migrated.

See [`../execution/`](../execution/).

### Exceptions

Blockers have their own lifecycle. Resolving a blocker allows readiness to be evaluated again; it does not automatically set readiness to GREEN.

See [`../exceptions/`](../exceptions/).

### Operational validation

Technical installation and business-operational completion are represented separately.

```text
attempt successful
        ↓
Astra installed
        ↓
operational validation
        ↓
required business capability available?
required access available?
no blocking exception?
        ↓
Astra Operational
```

This preserves the central case invariant:

> **Astra installed != operational migration complete.**

## Derived read models are allowed

Operational consumers often need one combined view.

The projection therefore provides a derived `workplace_operational_view` and an API `operational-view` representation that may expose:

```text
workplace environment
latest readiness
active schedule
latest attempt
open blocker count
latest validation
```

This is intentionally a read model.

> **Convenient aggregation does not become canonical ownership.**

## API design principles

See [`api/README.md`](api/README.md) and [`api/openapi.yaml`](api/openapi.yaml).

Key rules:

1. do not expose one generic `migrationStatus` across unrelated responsibility dimensions;
2. do not accept `readinessStatus` when creating or editing a schedule;
3. prefer explicit business transitions over arbitrary status PATCH operations;
4. external tooling reports execution facts rather than setting workplace lifecycle meaning;
5. operational completion requires explicit validation;
6. duplicate external attempt delivery is idempotent;
7. a timeout means the result is unknown, not necessarily failed.

## Data design principles

See [`data/README.md`](data/README.md) and [`data/schema.sql`](data/schema.sql).

Key rules:

1. one database may persist facts from many owners;
2. physical foreign keys do not define semantic ownership;
3. evidence and decisions retain history rather than being overwritten where history matters;
4. schedule history and attempt history remain independent;
5. compatibility is timestamped evidence, not a permanent boolean;
6. read views may join owners but should remain clearly derived.

## Presentation rule

Technical diagrams are no longer stored in a separate top-level diagram tree. Visual explanations live beside the knowledge they project, primarily as Mermaid in Markdown.

This keeps presentation subordinate to canonical ownership and makes the repository render correctly on GitHub without generated SVG artifacts or a bundled diagram renderer.
