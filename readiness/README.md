# Migration Readiness

This area owns the canonical decision:

> **Can this workplace be migrated safely at the current point in the programme?**

Readiness is not identical to a single team's approval and not identical to one compatibility flag. It is an aggregate system decision based on evidence from multiple responsibility domains.

## Evidence used by readiness

Typical evidence includes:

- required business activity;
- required workplace software;
- availability and adequacy of Astra Linux replacements;
- application-specific compatibility gaps such as macros or extensions;
- access and security requirements;
- infrastructure dependencies;
- hardware/peripheral compatibility where relevant;
- unresolved migration blockers;
- evidence from specialized support teams.

## Evidence is not authority

Multiple teams can provide authoritative evidence about their own domain without owning the final migration-readiness meaning.

```text
Software Support
→ compatibility evidence

Information Security
→ security/access constraints

Infrastructure Automation
→ tooling/infrastructure readiness evidence

Workplace Support
→ workplace and operational evidence

Migration readiness
→ aggregate decision used by the migration process
```

This is a central SSAD distinction for this case: **distributed validation does not require distributed meaning**.

## Readiness outcomes

The historical operational model used a simple status vocabulary:

```text
GREEN
→ ready to proceed

YELLOW
→ unresolved question / coordination required

RED
→ confirmed blocker; migration must not proceed normally
```

These labels are presentation-level indicators. Canonical readiness meaning is the underlying decision and its evidence.

## Readiness logic

```text
Required business capability known?
        ↓
Required dependencies identified?
        ↓
Software acceptable?
        ↓
Access / infrastructure acceptable?
        ↓
No unresolved blocker?
        ↓
READY
```

A negative answer does not necessarily terminate the programme. It may produce postponement, remediation, dual boot, vendor adaptation or another exception path.

## Ownership boundary

Readiness owns the **eligibility decision**.

It does not own:

- migration scheduling — [`planning/`](../planning/);
- actual execution result — [`execution/`](../execution/);
- blocker remediation — [`exceptions/`](../exceptions/);
- internal behavior of external support systems — [`integrations/`](../integrations/).
