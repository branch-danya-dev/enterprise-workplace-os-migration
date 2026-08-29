# Migration Readiness

This area owns the canonical decision:

> **Can this workplace be migrated safely at the current point in the programme?**

Readiness is not identical to a single team's approval and not identical to one compatibility flag. It is an aggregate system decision based on evidence from multiple responsibility domains.

## Canonical documents

- [`evidence-model.md`](evidence-model.md) — what evidence contributes to readiness, who provides it and why compatibility is more than a boolean;
- [`decision-model.md`](decision-model.md) — `GREEN / YELLOW / RED` semantics, gating logic and revalidation triggers.

## Core model

```text
Business capability
+
software / functionality evidence
+
access / security evidence
+
infrastructure / tooling evidence
+
workplace evidence
+
open blocker evidence
        ↓
READINESS DECISION
        ↓
GREEN / YELLOW / RED
```

Multiple teams can provide authoritative evidence about their own domain without owning the final migration-readiness meaning.

> **Distributed validation does not require distributed meaning.**

## Readiness is time-sensitive

A previous decision can become stale when evidence changes.

```text
previous readiness
+
new evidence
→ reopen decision
→ revalidate
```

This is why readiness should not be treated as an immutable property of a workplace or software record.

## Ownership boundary

Readiness owns the **eligibility decision**.

It does not own:

- migration scheduling — [`planning/`](../planning/);
- actual execution result — [`execution/`](../execution/);
- blocker remediation — [`exceptions/`](../exceptions/);
- internal behavior of external support systems — [`integrations/`](../integrations/).

The underlying evidence may remain authoritative in specialized domains even when the migration process stores a projection of it.
