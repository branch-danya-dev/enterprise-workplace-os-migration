# Legacy Knowledge Migration Map

This document records how the original artifact-oriented repository was decomposed into the SSAD responsibility structure.

It is a **migration/audit aid**, not a second source of truth.

## Current status

```text
docs/
→ canonical domain knowledge migrated
→ legacy files removed

api/
→ technical projection redesigned around canonical owners
→ legacy top-level files removed

sql/
→ storage projection redesigned around canonical owners
→ legacy top-level files removed

diagrams/
→ visual meaning redistributed to canonical owners
→ generated SVG / centralized diagram tree removed

tools/plantuml.jar
→ removed with obsolete rendering workflow
```

Historical files remain available through Git history.

## Migration rule used

```text
legacy artifact
→ identify individual claims / represented facts
→ assign canonical owner
→ rewrite near that owner or as an explicit projection
→ preserve only useful traceability
→ remove superseded artifact tree
```

## Domain-document migration

| Removed legacy source | Knowledge inside it | Canonical destination |
|---|---|---|
| `docs/01-context-and-scope.md` | boundary, workplace meaning, success condition | `system/`, `workplace/` |
| `docs/02-as-is.md` | workplace profiles/environment/dependencies | `workplace/profiles-and-dependencies.md`, `readiness/`, `integrations/` |
| `docs/03-dependency-model.md` | compatibility evidence, dual boot, access/security, support domains, readiness logic | `readiness/`, `exceptions/`, `integrations/`, `workplace/` |
| `docs/04-business-rules.md` | scheduling, postponement, execution, recovery, blockers, completion | split by canonical responsibility owner |
| `docs/05-functional-requirements.md` | required behavior across migration lifecycle | split by canonical responsibility owner |
| `docs/06-non-functional-requirements.md` | continuity, recovery, traceability, rollout, supportability | `system/invariants.md`, local constraints, `system/history-and-reporting.md` |
| `docs/07-acceptance-criteria.md` | verification conditions | colocated with canonical behavior |
| `docs/08-requirements-traceability-matrix.md` | BR → FR → NFR → AC artifact traceability | legacy-ID anchors + owner-based links |
| `docs/09-migration-data-model.md` | domain concepts mixed with storage-shaped fields | `system/data-ownership.md`, local models, `technical-projection/data/` |
| `docs/10-workplace-state-model.md` | planning/readiness/execution/exception/workplace statuses in one machine | `workplace/states.md` + local responsibility models |

## Technical projection migration

The former API and SQL layers were useful portfolio artifacts, but they reintroduced the flattened migration model through a broad `migrationStatus` and persistence fields such as `workplaces.migration_status` and `migration_schedule.readiness_status`.

They were replaced by the owner-aware projection under [`../technical-projection/`](../technical-projection/).

The active representation separates:

```text
Workplace environment
Readiness evaluation
Migration schedule
Postponement decision
Migration attempt
Migration blocker
Compatibility evidence
Operational validation
Derived operational read model
```

A derived `workplace_operational_view` may join those facts for reporting without becoming their canonical owner.

## Visual migration

The old `diagrams/` tree mixed several kinds of visual representation and could itself imply the wrong model.

### Old global state machine

`workplace-state-machine.puml` treated these as one lifecycle:

```text
Scheduled
Ready
Postponed
Blocked
Migration In Progress
Manual Migration Required
Dual Boot
Migrated
Fully Operational
```

SSAD showed that these values belong to different responsibility dimensions. The replacement [`../workplace/visual-model.md`](../workplace/visual-model.md) therefore contains only workplace-environment states.

### Old conceptual data model

`migration-data-model.puml` visually encoded `migration_status` on Workplace and `readiness_status` on MigrationSchedule. It was retired after the ownership-aware data projection was established under [`../technical-projection/data/`](../technical-projection/data/).

### Old process / sequence diagrams

The old migration, manual-recovery and postponement diagrams contained useful scenario knowledge but coupled it to the obsolete flattened status/API model.

Their useful meaning was rebuilt as local Mermaid models:

- [`visual-models.md`](visual-models.md) — responsibility map and end-to-end synthesis;
- [`../workplace/visual-model.md`](../workplace/visual-model.md) — environment states;
- [`../readiness/visual-model.md`](../readiness/visual-model.md) — readiness evidence/decision;
- [`../planning/visual-model.md`](../planning/visual-model.md) — postponement and schedule lifecycle;
- [`../exceptions/visual-model.md`](../exceptions/visual-model.md) — manual recovery and blocker lifecycle;
- [`../integrations/visual-model.md`](../integrations/visual-model.md) — cross-boundary evidence/commands;
- [`../technical-projection/visual-model.md`](../technical-projection/visual-model.md) — persistence/API/read-model projection.

Generated SVGs and the bundled PlantUML renderer were removed. GitHub renders the Mermaid source directly beside canonical knowledge.

## Legacy IDs after migration

`BR-*`, `FR-*`, `NFR-*` and `AC-*` identifiers remain in canonical documents only as **historical traceability anchors**.

Example:

```text
BR-009 / FR-010 / NFR-002 / AC-007
        ↓
Execution records technical failure
        ↓
Exceptions opens recovery path
```

They preserve evidence of coverage but no longer define repository navigation.

## Structural migration completion

The repository now satisfies the migration target:

1. canonical domain knowledge lives under responsibility owners;
2. technical projections explicitly depend on canonical knowledge rather than redefine it;
3. visual models live beside the knowledge they represent;
4. no artifact-oriented `docs/`, `api/`, `sql/` or `diagrams/` tree competes with active knowledge;
5. historical versions remain available through Git history.

Further work should be driven by new evidence, review findings or real use of the case — not by preserving the legacy artifact taxonomy.
