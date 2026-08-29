# Readiness Decision Model

This document owns the **migration eligibility decision** for a workplace.

The decision is derived from current evidence. It is not equivalent to one team's approval, one spreadsheet color or one compatibility flag.

## Decision states

The historical operational process used three simple indicators:

### GREEN — Ready

Current evidence supports normal migration.

At minimum:

- required business capability is understood;
- required dependencies are identified sufficiently for the migration decision;
- required software or acceptable replacements are available;
- access/security/infrastructure constraints are acceptable;
- no active blocker prevents normal migration.

### YELLOW — Coordination Required

The workplace is not currently proven safe for normal migration, but there is not yet a confirmed terminal blocker.

Typical causes:

- unresolved question;
- incomplete compatibility evidence;
- pending approval/coordination;
- suspected dependency;
- remediation in progress.

### RED — Blocked

A confirmed condition prevents normal migration at the current time.

Examples:

- critical software has no acceptable target solution;
- required replacement functionality is insufficient;
- unresolved security/access condition;
- infrastructure blocker;
- business-critical stop factor.

## Decision logic

```text
Required business capability known?
        ├─ no → YELLOW
        └─ yes
             ↓
Required dependencies sufficiently identified?
        ├─ no → YELLOW
        └─ yes
             ↓
Software / functional compatibility acceptable?
        ├─ unknown → YELLOW
        ├─ blocked → RED
        └─ yes
             ↓
Access / security / infrastructure acceptable?
        ├─ unknown → YELLOW
        ├─ blocked → RED
        └─ yes
             ↓
Active blocker?
        ├─ yes → RED
        └─ no → GREEN
```

This is an analytical model, not a claim that one production engine evaluated the logic exactly this way.

## Readiness and scheduling

Readiness constrains planning but does not own dates.

```text
GREEN
→ may be selected for normal migration planning

YELLOW
→ planning should not assume normal execution until coordination completes

RED
→ normal migration must not proceed; plan is postponed/changed or an explicit transition strategy is chosen
```

A date already assigned to a workplace does not make `RED` evidence disappear.

## Readiness and postponement

A postponement request can reveal new readiness evidence but is not itself a readiness decision.

Examples:

```text
"I am unavailable on that date"
→ primarily planning issue

"Critical software I use does not work on Astra"
→ planning request + new readiness evidence
```

The reason must therefore be interpreted, not merely recorded.

## Readiness and dual boot

Dual boot is not another color in the readiness model.

It is an explicit transitional workplace strategy that may allow part of the migration programme to proceed while a Windows-only dependency remains.

The unresolved dependency must remain visible and continue to constrain final operational completion.

## Revalidation triggers

Readiness must be reopened when relevant evidence changes.

Typical triggers:

- blocker created/resolved;
- compatibility assessment changed;
- new required software or business scenario discovered;
- support team reports missing target functionality;
- security/access condition changes;
- migration incident reveals a wider dependency;
- vendor adaptation becomes available;
- dual-boot dependency is removed.

```text
previous readiness
+
new evidence
→ re-evaluate
→ new readiness decision
```

## Verification conditions

`GREEN` is valid only when available evidence does not contain an unresolved condition that contradicts safe normal migration.

`RED` should identify a concrete blocking reason and responsible/remediation domain where known.

`YELLOW` should identify what evidence or decision is still missing; it must not become an indefinite substitute for analysis.

## Legacy traceability

Primary anchors:

- `BR-003`, `BR-012`, `BR-016`;
- `FR-008`, `FR-013`, `FR-016`, `FR-018`;
- `NFR-011`, `NFR-014`, `NFR-016`;
- `AC-003`, `AC-010`, `AC-013`;
- readiness logic and green/yellow/red model from `docs/03-dependency-model.md`.
