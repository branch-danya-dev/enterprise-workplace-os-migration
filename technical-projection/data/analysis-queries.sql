-- Operational and consistency queries for the SSAD-aligned projection.

-- 1. Current operational view across responsibility owners.
SELECT *
FROM workplace_operational_view
ORDER BY workplace_id;

-- 2. Workplaces currently blocked by open exceptions.
SELECT
    w.workplace_id,
    w.environment_state,
    b.blocker_type,
    b.description,
    st.team_name AS responsible_team
FROM workplaces w
JOIN migration_blockers b ON b.workplace_id = w.workplace_id
LEFT JOIN support_teams st ON st.team_id = b.responsible_team_id
WHERE b.status <> 'resolved'
ORDER BY w.workplace_id, b.created_at;

-- 3. Latest readiness decision for each workplace.
SELECT DISTINCT ON (workplace_id)
    workplace_id,
    decision,
    evaluated_at,
    reason_summary
FROM readiness_evaluations
ORDER BY workplace_id, evaluated_at DESC, evaluation_id DESC;

-- 4. Detect an active schedule whose latest readiness is not GREEN.
WITH latest_readiness AS (
    SELECT DISTINCT ON (workplace_id)
        workplace_id,
        decision,
        evaluated_at
    FROM readiness_evaluations
    ORDER BY workplace_id, evaluated_at DESC, evaluation_id DESC
)
SELECT
    s.schedule_id,
    s.workplace_id,
    s.planned_date,
    lr.decision AS latest_readiness,
    lr.evaluated_at
FROM migration_schedules s
LEFT JOIN latest_readiness lr ON lr.workplace_id = s.workplace_id
WHERE s.schedule_status = 'active'
  AND (lr.decision IS NULL OR lr.decision <> 'green');

-- 5. Technical attempt succeeded but operational validation has not passed.
WITH latest_success AS (
    SELECT DISTINCT ON (workplace_id)
        workplace_id,
        attempt_id,
        completed_at
    FROM migration_attempts
    WHERE result = 'successful'
    ORDER BY workplace_id, completed_at DESC NULLS LAST, attempt_id DESC
),
latest_validation AS (
    SELECT DISTINCT ON (workplace_id)
        workplace_id,
        validation_id,
        result,
        validated_at
    FROM operational_validations
    ORDER BY workplace_id, validated_at DESC, validation_id DESC
)
SELECT
    w.workplace_id,
    w.environment_state,
    ls.attempt_id,
    lv.validation_id,
    lv.result AS validation_result
FROM workplaces w
JOIN latest_success ls ON ls.workplace_id = w.workplace_id
LEFT JOIN latest_validation lv ON lv.workplace_id = w.workplace_id
WHERE lv.result IS DISTINCT FROM 'passed';

-- 6. Dual-boot workplaces with unresolved blockers.
SELECT
    w.workplace_id,
    COUNT(b.blocker_id) AS unresolved_blockers
FROM workplaces w
LEFT JOIN migration_blockers b
    ON b.workplace_id = w.workplace_id
   AND b.status <> 'resolved'
WHERE w.environment_state = 'dual_boot_transition'
GROUP BY w.workplace_id;

-- 7. History of schedule changes without mixing execution history.
SELECT
    workplace_id,
    schedule_id,
    planned_date,
    migration_wave,
    schedule_status,
    superseded_by_schedule_id,
    created_at
FROM migration_schedules
ORDER BY workplace_id, created_at;

-- 8. Migration-attempt history is independent from planning history.
SELECT
    workplace_id,
    attempt_id,
    source_system,
    external_attempt_id,
    execution_type,
    result,
    started_at,
    completed_at
FROM migration_attempts
ORDER BY workplace_id, started_at;

-- 9. Compatibility evidence history: do not overwrite old assessments.
SELECT
    s.software_name,
    ca.compatibility_status,
    ca.assessed_at,
    st.team_name AS evidence_owner,
    ca.notes
FROM compatibility_assessments ca
JOIN software s ON s.software_id = ca.software_id
LEFT JOIN support_teams st ON st.team_id = ca.responsible_team_id
ORDER BY s.software_name, ca.assessed_at;

-- 10. Operationally migrated means more than Astra installation.
SELECT
    workplace_id,
    environment_state,
    latest_validation_result,
    open_blocker_count,
    operationally_migrated
FROM workplace_operational_view
WHERE operationally_migrated = TRUE;
