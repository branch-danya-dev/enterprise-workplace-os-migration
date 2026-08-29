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
→ presentation validation / relocation pending
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

The legacy API and SQL artifacts were useful, but they reintroduced the old flattened migration model.

### Legacy API issue

The old API exposed one `migrationStatus` containing values from several different owners:

```text
scheduled
ready
postponed
blocked
migration_in_progress
manual_migration_required
dual_boot
migrated
```

It also accepted `readinessStatus` as part of `MigrationSchedule`.

After the SSAD domain migration, both patterns became invalid projections.

### API correction

The new API lives in:

```text
technical-projection/api/
```

It separates:

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

Important behavior changes include:

```text
PATCH arbitrary status
→ replaced by explicit owner-specific operations

schedule.readinessStatus
→ removed

successful migration attempt
→ does not automatically mean operational completion

blocker resolved
→ allows readiness re-evaluation; does not force GREEN
```

### Legacy SQL issue

The old schema contained:

```text
workplaces.migration_status
migration_schedule.readiness_status
```

These columns made persistence look like the semantic owner of several unrelated dimensions.

### SQL correction

The normalized projection now lives in:

```text
technical-projection/data/
```

The main ownership split is:

| Stored representation | Meaning owner |
|---|---|
| `workplaces.environment_state` | Workplace |
| `readiness_evaluations` | Readiness |
| `migration_schedules` | Planning |
| `migration_attempts` | Execution |
| `migration_blockers` | Exceptions |
| `compatibility_assessments` | External/specialized evidence consumed by Readiness |
| `operational_validations` | Workplace/System completion verification |

A derived `workplace_operational_view` joins these facts for convenience without becoming their canonical owner.

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

## Remaining artifact-oriented source

### `diagrams/`

Visual artifacts remain useful, but each diagram must be checked against the current model.

The legacy global workplace state machine is especially important: it now represents a flattened operational/process projection rather than canonical workplace state semantics.

The next pass should either:

- redraw it into several owner-specific diagrams;
- replace it with a cross-system synthesis diagram;
- or clearly label any retained flattened diagram as a derived view.

## Completion criterion

The structural migration is complete when:

1. canonical domain knowledge lives only under responsibility owners;
2. technical projections explicitly depend on canonical knowledge rather than redefine it;
3. presentation artifacts accurately visualize the current model;
4. no artifact-oriented legacy tree competes with active knowledge.
