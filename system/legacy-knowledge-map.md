# Legacy Knowledge Migration Map

This document records how the original artifact-oriented repository was decomposed into the SSAD responsibility structure.

It is a **migration/audit aid**, not a second source of truth.

## Current status

```text
docs/
→ canonical domain knowledge migrated
→ legacy files removed

api/
→ technical projection migration pending

sql/
→ technical projection migration pending

diagrams/
→ presentation validation / relocation pending
```

The historical `docs/` files remain available through Git history. Active reconstructed system knowledge now lives only in canonical SSAD responsibility areas.

## Migration rule used

```text
legacy document
→ identify individual claims
→ assign canonical owner
→ move/rewrite claim near that owner
→ keep old IDs only as traceability anchors
→ remove superseded artifact document
```

The documents were not moved wholesale because many mixed several responsibility areas.

## Completed domain-document migration

| Removed legacy source | Knowledge inside it | Canonical destination |
|---|---|---|
| `docs/01-context-and-scope.md` | boundary, workplace meaning, success condition | `system/`, `workplace/` |
| `docs/02-as-is.md` | workplace profiles/environment/dependencies | `workplace/profiles-and-dependencies.md`, `readiness/`, `integrations/` |
| `docs/03-dependency-model.md` | compatibility evidence, dual boot, access/security, support domains, readiness logic | `readiness/`, `exceptions/`, `integrations/`, `workplace/` |
| `docs/04-business-rules.md` | scheduling, postponement, execution, recovery, blockers, completion | split by canonical responsibility owner |
| `docs/05-functional-requirements.md` | required behavior across migration lifecycle | split by canonical responsibility owner |
| `docs/06-non-functional-requirements.md` | continuity, recovery, traceability, rollout, supportability | `system/invariants.md`, local constraints, `system/history-and-reporting.md` |
| `docs/07-acceptance-criteria.md` | verification conditions | colocated with the canonical behavior they verify |
| `docs/08-requirements-traceability-matrix.md` | BR → FR → NFR → AC artifact traceability | local legacy-ID anchors + owner-based links |
| `docs/09-migration-data-model.md` | domain concepts mixed with storage-shaped fields | `system/data-ownership.md`, local models, `technical-projection/` |
| `docs/10-workplace-state-model.md` | planning/readiness/execution/exception/workplace statuses in one machine | `workplace/states.md` + local responsibility models |

## Business-rule decomposition

The former `docs/04-business-rules.md` is the clearest example of why artifact-level migration would have failed.

| Legacy rule | Canonical owner |
|---|---|
| BR-001 — Migration Date Assignment | `planning/` |
| BR-002 — User Notification | `planning/` + notification boundary |
| BR-003 — No Postponement Means Migration Proceeds | `planning/` + `readiness/` gating |
| BR-004 — Postponement Request Channel | `planning/` + Service Desk boundary |
| BR-005 — Postponement Requires Review | `planning/` |
| BR-006 — Approved Postponement Requires Rescheduling | `planning/` |
| BR-007 — Rejected Postponement Keeps Schedule | `planning/` |
| BR-008 — Automated Migration Default | `execution/` |
| BR-009 — Technical Failure Triggers Manual Migration | `execution/` → `exceptions/` |
| BR-010 — Manual Migration by Workplace Support | `exceptions/` recovery |
| BR-011 — Migration Blocker Must Be Registered | `exceptions/` |
| BR-012 — Compatibility Affects Priority | `readiness/` + `planning/` |
| BR-013 — Dual Boot Is Transitional | `workplace/` + `exceptions/` |
| BR-014 — Completion Requires Operational Workplace | `workplace/` + `system/` invariant |
| BR-015 — Missing Software May Require Development | `exceptions/` + vendor/development boundary |
| BR-016 — Readiness Depends on Cross-Team Validation | `readiness/` + `integrations/` |

## Legacy IDs after migration

`BR-*`, `FR-*`, `NFR-*` and `AC-*` identifiers are retained in canonical documents only as **historical traceability anchors**.

They no longer define navigation or knowledge ownership.

Example:

```text
BR-009 / FR-010 / NFR-002 / AC-007
        ↓
canonical behavior:
Execution records technical failure
        ↓
Exceptions opens recovery path
```

This preserves evidence of requirement coverage while removing the need to maintain four parallel artifact catalogs.

## Remaining artifact-oriented sources

### `api/`

Hypothetical portfolio REST/OpenAPI representation. It should move under the logic of `technical-projection/` and be corrected where endpoint/status design conflicts with canonical ownership.

### `sql/`

Hypothetical PostgreSQL schema/sample/query layer. It should be treated as storage projection of facts owned by several domains, not as the domain model itself.

### `diagrams/`

Visual artifacts remain useful, but each diagram must be checked against the new canonical model. The legacy workplace state machine in particular now represents a flattened process/status projection rather than the canonical workplace-owned state semantics.

## Final removal criterion for remaining legacy areas

A legacy technical/presentation file can be retired or relocated when:

1. its represented facts have clear canonical owners;
2. it links to or accurately projects those owners;
3. it does not imply unsupported historical production architecture;
4. no active documentation depends on it as the only explanation.
