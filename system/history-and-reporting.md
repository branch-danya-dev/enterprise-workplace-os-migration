# Migration History and Operational Reporting

This document owns the **cross-responsibility view needed to explain what happened to a workplace over time**.

No single local owner contains the whole migration history:

```text
Planning
→ planned dates / postponements

Readiness
→ eligibility decisions and revalidations

Execution
→ attempts and technical outcomes

Exceptions
→ blockers / recovery

Workplace
→ environment / final operational state
```

The system view links those canonical facts without redefining them.

## Traceable workplace history

For a workplace, responsible teams should be able to reconstruct at least:

- planned migration dates and which one became active/superseded;
- postponement requests/decisions relevant to the plan;
- readiness changes when material to migration progression;
- blocker records and their affected period;
- automated migration attempts;
- failed attempt evidence;
- manual recovery/migration events where applicable;
- transitional dual-boot condition where applicable;
- final operational outcome.

Legacy anchors: `FR-019`, `NFR-006`, `NFR-007`, `AC-014`.

## Cross-owner timeline

A conceptual timeline may look like:

```text
Planning:   Date A assigned
Planning:   Postponement approved
Planning:   Date B assigned
Readiness:  GREEN
Execution:  Automated attempt #1 started
Execution:  Automated attempt #1 failed
Exceptions: Manual recovery opened
Execution:  Manual attempt/activity completed
Workplace:  Astra Installed — Pending Validation
Workplace:  Astra Operational
```

This view is assembled from canonical facts. It should not become another independent state store in the documentation.

## Audit questions

The reconstructed knowledge should make it possible to answer:

```text
What happened?
When did it happen?
Which workplace was affected?
Why was migration postponed or blocked?
Which responsibility/domain handled the next action?
What technical attempts occurred?
How did the workplace eventually reach its current state?
```

Where actor identity or exact timestamp data is unavailable in the sanitized reconstruction, the case should not invent it.

## Operational reporting

The programme required operational visibility across large numbers of workplaces.

Useful reporting views include:

- workplaces in active migration plans;
- readiness distribution (`GREEN / YELLOW / RED`);
- postponed workplaces;
- workplaces with active blockers;
- automated attempts and failures;
- cases requiring manual intervention/recovery;
- transitional dual-boot workplaces;
- operationally completed workplaces.

Legacy anchors: `FR-020`, `NFR-017`, `AC-015`.

## Reporting is a projection

A dashboard can flatten several dimensions for operational convenience.

For example:

```text
"Needs Manual Intervention"
```

may be derived from:

```text
latest execution result = failed
+
open recovery case exists
```

The report label does not become a new canonical domain state.

## Consistency checks

Cross-owner reporting should detect contradictions such as:

- `Astra Operational` workplace with an active blocker that prevents required business activity;
- automated attempt marked failed but no recovery/exception path visible;
- active migration schedule while an approved postponement superseded that date;
- `GREEN` readiness with known unresolved critical compatibility blocker;
- dual-boot workplace reported as final migration completion;
- multiple active migration dates for one workplace;
- completion reported with no traceable attempt/recovery path.

Some of the legacy SQL analysis queries demonstrate these kinds of consistency questions. Their SQL syntax belongs to `technical-projection/`; the system questions themselves belong here.

## Scale and operational use

The original programme operated across large numbers of workplaces, so reporting had to support group/segment analysis rather than only individual records.

This reinforces two system requirements:

1. standard cases should remain automatable at scale;
2. exceptions should be identifiable and isolated without forcing manual review of every workplace.

Legacy anchors: `NFR-008`, `NFR-009`, `NFR-012`, `NFR-017`.
