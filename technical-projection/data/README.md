# Data Projection

This directory contains a **synthetic PostgreSQL projection** of the reconstructed migration domain.

It demonstrates persistence and analytical queries. It does not represent an internal production database from the original banking environment.

## Core rule

```text
physical storage
!=
semantic ownership
```

One database may store facts from several responsibility areas while those facts remain owned by different parts of the canonical system model.

## Main corrections from the legacy schema

### `workplaces.migration_status` removed

The former schema placed scheduling, readiness, execution, exception and environment concepts into one status column.

The new projection stores only the workplace-owned environment state on the workplace itself:

```text
windows_operational
dual_boot_transition
astra_installed_pending_validation
astra_operational
```

### Readiness moved out of schedule

`migration_schedules.readiness_status` was removed.

Readiness decisions are immutable snapshots in `readiness_evaluations`.

A schedule can be created only when the service observes an acceptable current readiness decision, but the schedule does not own that decision.

### Attempts are immutable facts

`migration_attempts` records actual execution facts and includes an idempotency key:

```text
(source_system, external_attempt_id)
```

A failed attempt can open a recovery path but does not become a generic workplace status.

### Operational completion is explicit

`operational_validations` records the verification that the migrated workplace can actually support the agreed business activity.

A successful technical attempt and a successful operational validation are deliberately different facts.

### Read models may join owners

The schema exposes `workplace_operational_view` as a convenience view combining:

- workplace environment;
- latest readiness;
- active schedule;
- latest attempt;
- open blocker count;
- latest operational validation.

The view is useful for operations and reporting but owns none of those source facts.

## Files

- [`schema.sql`](schema.sql) — normalized synthetic persistence projection;
- [`sample-data.sql`](sample-data.sql) — small scenario dataset;
- [`analysis-queries.sql`](analysis-queries.sql) — operational and consistency queries demonstrating the separated dimensions.

## Canonical links

| Stored fact | Canonical knowledge |
|---|---|
| workplace environment | [`workplace/`](../../workplace/) |
| readiness evaluation | [`readiness/`](../../readiness/) |
| schedule / postponement | [`planning/`](../../planning/) |
| attempt | [`execution/`](../../execution/) |
| blocker / recovery | [`exceptions/`](../../exceptions/) |
| compatibility/access evidence | [`readiness/`](../../readiness/) + [`integrations/`](../../integrations/) |
| operational completion | [`system/`](../../system/) + [`workplace/`](../../workplace/) |
