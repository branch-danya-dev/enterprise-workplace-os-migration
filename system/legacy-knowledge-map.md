# Legacy Knowledge Migration Map

This document tracks how the original artifact-oriented repository is being decomposed into the new SSAD responsibility structure.

It is a **migration aid**, not a second source of truth.

## Migration rule

```text
legacy document
→ identify individual claims
→ assign canonical owner
→ move/rewrite the claim near that owner
→ preserve only necessary cross-links
→ remove the superseded legacy document when coverage is complete
```

The old documents are not moved wholesale because many of them mix several responsibility areas.

## Legacy documents → canonical owners

| Legacy source | Knowledge inside it | Canonical destination |
|---|---|---|
| `docs/01-context-and-scope.md` | system boundary, workplace meaning, success condition | `system/`, `workplace/` |
| `docs/02-as-is.md` | current environment/dependencies | `workplace/`, `readiness/`, `integrations/` |
| `docs/03-dependency-model.md` | compatibility evidence, dual boot, access/security, support domains, readiness logic | `readiness/`, `exceptions/`, `integrations/`, `workplace/` |
| `docs/04-business-rules.md` | scheduling, postponement, execution, recovery, blockers, completion | split across `planning/`, `execution/`, `exceptions/`, `workplace/`, `system/` |
| `docs/05-functional-requirements.md` | behavior requirements across entire migration lifecycle | split by responsibility owner |
| `docs/06-non-functional-requirements.md` | continuity, recovery, traceability, rollout, supportability | `system/` invariants plus local responsibility constraints |
| `docs/07-acceptance-criteria.md` | verification conditions | colocated with the canonical behavior they verify; cross-system criteria in `system/` |
| `docs/08-requirements-traceability-matrix.md` | artifact-to-artifact traceability | replaced by local legacy-ID references + owner-based links |
| `docs/09-migration-data-model.md` | useful domain concepts mixed with storage-shaped fields | `system/data-ownership.md` + local models + `technical-projection/` |
| `docs/10-workplace-state-model.md` | process/status states mixed into one machine | decomposed into workplace/readiness/planning/execution/exception dimensions |
| `api/*` | hypothetical REST representation | `technical-projection/` |
| `sql/*` | hypothetical relational representation | `technical-projection/` |
| `diagrams/*` | visual projections of several concepts | keep while referenced; later relocate or regenerate beside canonical knowledge |

## Business-rule decomposition

The old `docs/04-business-rules.md` is a useful example of why artifact-level migration would fail.

| Legacy rule | Canonical owner |
|---|---|
| BR-001 — Migration Date Assignment | `planning/` |
| BR-002 — User Notification | `planning/` + notification integration |
| BR-003 — No Postponement Means Migration Proceeds | `planning/` + `readiness/` gating |
| BR-004 — Postponement Request Channel | `planning/` + Service Desk integration |
| BR-005 — Postponement Requires Review | `planning/` |
| BR-006 — Approved Postponement Requires Rescheduling | `planning/` |
| BR-007 — Rejected Postponement Keeps Schedule | `planning/` |
| BR-008 — Automated Migration Default | `execution/` |
| BR-009 — Technical Failure Triggers Manual Migration | `execution/` → `exceptions/` boundary |
| BR-010 — Manual Migration by Workplace Support | `exceptions/` / recovery |
| BR-011 — Migration Blocker Must Be Registered | `exceptions/` |
| BR-012 — Compatibility Affects Priority | `readiness/` + `planning/` |
| BR-013 — Dual Boot Is Transitional | `workplace/` + `exceptions/` |
| BR-014 — Completion Requires Operational Workplace | `workplace/` + `system/` invariant |
| BR-015 — Missing Software May Require Development | `exceptions/` + external software/vendor boundary |
| BR-016 — Readiness Depends on Cross-Team Validation | `readiness/` + `integrations/` |

## Requirement IDs during migration

Legacy `BR-*`, `FR-*`, `NFR-*` and `AC-*` identifiers are temporarily retained as **traceability anchors** inside the new canonical documents.

They no longer define the repository structure.

For example:

```text
BR-009 / FR-010 / NFR-002 / AC-007
        ↓
execution attempt fails
        ↓
exceptions/manual recovery is opened
```

The canonical behavior is the responsibility model. The old IDs simply help prove that no useful requirement was lost during restructuring.

## Removal criterion

A legacy file may be deleted when:

1. all meaningful claims have a canonical owner;
2. the new owner document contains sufficient context and verification conditions;
3. any still-useful diagram or technical projection links to the new owner;
4. no active README or canonical document depends on the old file as its only explanation.

Historical versions remain recoverable through Git history.
