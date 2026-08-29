# Migration Execution

This area owns the fact of **what actually happened when migration was attempted**.

Execution is intentionally separate from planning, readiness and final workplace state.

## Canonical document

→ [`attempt-model.md`](attempt-model.md) defines automated/manual attempt semantics, success/failure evidence, history and the handoff to recovery.

## Core model

```text
active plan
+
current readiness permits migration
        ↓
ATTEMPT
        ↓
technical result
   ├─ success → operational validation continues
   └─ failure → exception / recovery path opens
```

Automated migration is the default path for standard eligible cases. Manual activity is primarily a recovery/exception mechanism.

## Execution does not own business completion

A migration tool or support engineer can provide technical evidence such as:

```text
installation completed
backup restored
script failed
manual activity completed
```

But the attempt does not itself own the final statement:

```text
workplace is operationally migrated
```

That meaning depends on the workplace environment and cross-system invariants.

## Ownership boundary

Execution owns:

- attempt identity/history;
- execution method;
- start/completion facts;
- technical result;
- technical failure evidence;
- handoff trigger to recovery.

It does not own:

- the plan that caused the attempt — [`planning/`](../planning/);
- readiness eligibility — [`readiness/`](../readiness/);
- workplace-state semantics — [`workplace/`](../workplace/);
- recovery/blocker coordination after failure — [`exceptions/`](../exceptions/).
