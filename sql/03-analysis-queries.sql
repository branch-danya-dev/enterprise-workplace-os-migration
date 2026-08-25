-- ============================================================
-- Enterprise Workplace OS Migration
-- File: sql/03-analysis-queries.sql
--
-- Purpose:
-- Example analytical SQL queries for the workplace migration
-- portfolio case.
--
-- The queries below use synthetic data from:
--   sql/01-schema.sql
--   sql/02-sample-data.sql
-- ============================================================


-- ============================================================
-- Q-001
-- Show all workplaces.
-- ============================================================

SELECT
    workplace_id,
    user_id,
    current_os,
    target_os,
    location,
    migration_status
FROM workplaces
ORDER BY workplace_id;


-- ============================================================
-- Q-002
-- Show only blocked workplaces.
--
-- Demonstrates:
-- WHERE
-- ============================================================

SELECT
    workplace_id,
    user_id,
    current_os,
    migration_status
FROM workplaces
WHERE migration_status = 'blocked'
ORDER BY workplace_id;


-- ============================================================
-- Q-003
-- Show workplaces together with assigned users.
--
-- Demonstrates:
-- INNER JOIN
-- ============================================================

SELECT
    w.workplace_id,
    u.full_name,
    u.department,
    w.current_os,
    w.migration_status
FROM workplaces w
JOIN users u
    ON u.user_id = w.user_id
ORDER BY w.workplace_id;


-- ============================================================
-- Q-004
-- Show all software required by each workplace.
--
-- Relationship:
--
-- Workplace
--   -> WorkplaceSoftware
--   -> Software
--
-- Demonstrates:
-- multiple JOINs
-- ============================================================

SELECT
    w.workplace_id,
    u.full_name,
    s.software_name,
    ws.business_critical,
    ws.current_status
FROM workplaces w
JOIN users u
    ON u.user_id = w.user_id
JOIN workplace_software ws
    ON ws.workplace_id = w.workplace_id
JOIN software s
    ON s.software_id = ws.software_id
ORDER BY
    w.workplace_id,
    s.software_name;


-- ============================================================
-- Q-005
-- Find workplaces with software dependencies that are
-- currently blocked or Windows-only.
--
-- Demonstrates:
-- WHERE with multiple conditions
-- ============================================================

SELECT
    w.workplace_id,
    u.full_name,
    s.software_name,
    ws.current_status
FROM workplaces w
JOIN users u
    ON u.user_id = w.user_id
JOIN workplace_software ws
    ON ws.workplace_id = w.workplace_id
JOIN software s
    ON s.software_id = ws.software_id
WHERE ws.current_status IN ('blocked', 'windows_only')
ORDER BY w.workplace_id;


-- ============================================================
-- Q-006
-- Find workplaces affected by software compatibility
-- assessments marked as blockers.
--
-- Demonstrates:
-- JOIN across compatibility data
-- DISTINCT
-- ============================================================

SELECT DISTINCT
    w.workplace_id,
    u.full_name,
    s.software_name,
    ca.compatibility_status,
    ca.replacement_maturity
FROM workplaces w
JOIN users u
    ON u.user_id = w.user_id
JOIN workplace_software ws
    ON ws.workplace_id = w.workplace_id
JOIN software s
    ON s.software_id = ws.software_id
JOIN compatibility_assessments ca
    ON ca.software_id = s.software_id
WHERE ca.blocker_flag = TRUE
ORDER BY w.workplace_id;


-- ============================================================
-- Q-007
-- Show open migration blockers and responsible teams.
--
-- Demonstrates:
-- JOIN with support ownership
-- ============================================================

SELECT
    mb.blocker_id,
    w.workplace_id,
    u.full_name,
    mb.blocker_type,
    mb.description,
    st.team_name AS responsible_team,
    mb.status
FROM migration_blockers mb
JOIN workplaces w
    ON w.workplace_id = mb.workplace_id
JOIN users u
    ON u.user_id = w.user_id
LEFT JOIN support_teams st
    ON st.team_id = mb.responsible_team_id
WHERE mb.status = 'open'
ORDER BY mb.created_at;


-- ============================================================
-- Q-008
-- Show all migration schedule records for each workplace.
--
-- Useful for seeing rescheduling history.
-- ============================================================

SELECT
    w.workplace_id,
    u.full_name,
    ms.planned_date,
    ms.readiness_status,
    ms.schedule_status,
    ms.migration_wave
FROM migration_schedule ms
JOIN workplaces w
    ON w.workplace_id = ms.workplace_id
JOIN users u
    ON u.user_id = w.user_id
ORDER BY
    w.workplace_id,
    ms.planned_date;


-- ============================================================
-- Q-009
-- Find workplaces that were postponed.
--
-- Demonstrates:
-- joining postponement requests with users/workplaces
-- ============================================================

SELECT
    pr.request_id,
    w.workplace_id,
    u.full_name,
    pr.service_desk_ticket_id,
    pr.reason,
    pr.approval_status,
    pr.new_migration_date
FROM postponement_requests pr
JOIN workplaces w
    ON w.workplace_id = pr.workplace_id
JOIN users u
    ON u.user_id = w.user_id
WHERE pr.approval_status = 'approved'
ORDER BY pr.requested_at;


-- ============================================================
-- Q-010
-- Find automated migration attempts that failed.
--
-- Demonstrates:
-- simple filtering over execution history
-- ============================================================

SELECT
    ma.attempt_id,
    ma.workplace_id,
    u.full_name,
    ma.migration_date,
    ma.technical_error
FROM migration_attempts ma
JOIN workplaces w
    ON w.workplace_id = ma.workplace_id
JOIN users u
    ON u.user_id = w.user_id
WHERE
    ma.execution_type = 'automated'
    AND ma.result = 'failed'
ORDER BY ma.migration_date;


-- ============================================================
-- Q-011
-- Find workplaces where automated migration failed
-- and a successful manual migration was later performed.
--
-- Demonstrates:
-- self-join through the same table
-- EXISTS
-- ============================================================

SELECT
    w.workplace_id,
    u.full_name
FROM workplaces w
JOIN users u
    ON u.user_id = w.user_id
WHERE EXISTS (
    SELECT 1
    FROM migration_attempts automated
    WHERE
        automated.workplace_id = w.workplace_id
        AND automated.execution_type = 'automated'
        AND automated.result = 'failed'
)
AND EXISTS (
    SELECT 1
    FROM migration_attempts manual
    WHERE
        manual.workplace_id = w.workplace_id
        AND manual.execution_type = 'manual'
        AND manual.result = 'successful'
)
ORDER BY w.workplace_id;


-- ============================================================
-- Q-012
-- Count workplaces by migration status.
--
-- Demonstrates:
-- GROUP BY
-- COUNT
-- ============================================================

SELECT
    migration_status,
    COUNT(*) AS workplace_count
FROM workplaces
GROUP BY migration_status
ORDER BY workplace_count DESC;


-- ============================================================
-- Q-013
-- Count workplaces by readiness status.
--
-- Note:
-- This counts schedule records, not unique workplaces.
-- A workplace may appear more than once after rescheduling.
-- ============================================================

SELECT
    readiness_status,
    COUNT(*) AS schedule_record_count
FROM migration_schedule
GROUP BY readiness_status
ORDER BY schedule_record_count DESC;


-- ============================================================
-- Q-014
-- Count unique workplaces by readiness status.
--
-- Demonstrates:
-- COUNT(DISTINCT ...)
-- ============================================================

SELECT
    readiness_status,
    COUNT(DISTINCT workplace_id) AS workplace_count
FROM migration_schedule
GROUP BY readiness_status
ORDER BY workplace_count DESC;


-- ============================================================
-- Q-015
-- Find users who have more than one workplace.
--
-- Demonstrates:
-- GROUP BY
-- HAVING
-- ============================================================

SELECT
    u.user_id,
    u.full_name,
    COUNT(w.workplace_id) AS workplace_count
FROM users u
JOIN workplaces w
    ON w.user_id = u.user_id
GROUP BY
    u.user_id,
    u.full_name
HAVING COUNT(w.workplace_id) > 1
ORDER BY workplace_count DESC;


-- ============================================================
-- Q-016
-- Count software products required by each workplace.
--
-- Demonstrates:
-- aggregate over a many-to-many relationship
-- ============================================================

SELECT
    w.workplace_id,
    u.full_name,
    COUNT(ws.software_id) AS software_count
FROM workplaces w
JOIN users u
    ON u.user_id = w.user_id
LEFT JOIN workplace_software ws
    ON ws.workplace_id = w.workplace_id
GROUP BY
    w.workplace_id,
    u.full_name
ORDER BY software_count DESC;


-- ============================================================
-- Q-017
-- Find workplaces with at least one business-critical
-- software dependency.
--
-- Demonstrates:
-- DISTINCT
-- boolean filtering
-- ============================================================

SELECT DISTINCT
    w.workplace_id,
    u.full_name
FROM workplaces w
JOIN users u
    ON u.user_id = w.user_id
JOIN workplace_software ws
    ON ws.workplace_id = w.workplace_id
WHERE ws.business_critical = TRUE
ORDER BY w.workplace_id;


-- ============================================================
-- Q-018
-- Find workplaces with more than one business-critical
-- software dependency.
--
-- Demonstrates:
-- GROUP BY + HAVING
-- ============================================================

SELECT
    w.workplace_id,
    u.full_name,
    COUNT(*) AS critical_dependency_count
FROM workplaces w
JOIN users u
    ON u.user_id = w.user_id
JOIN workplace_software ws
    ON ws.workplace_id = w.workplace_id
WHERE ws.business_critical = TRUE
GROUP BY
    w.workplace_id,
    u.full_name
HAVING COUNT(*) > 1
ORDER BY critical_dependency_count DESC;


-- ============================================================
-- Q-019
-- Show all users and their access dependencies.
--
-- LEFT JOIN is used because a user may have no explicit
-- access dependency records.
-- ============================================================

SELECT
    u.user_id,
    u.full_name,
    ad.access_type,
    ad.target_system,
    ad.security_approval_required,
    ad.status
FROM users u
LEFT JOIN access_dependencies ad
    ON ad.user_id = u.user_id
ORDER BY
    u.user_id,
    ad.access_type;


-- ============================================================
-- Q-020
-- Find users with access dependencies requiring
-- Information Security approval.
-- ============================================================

SELECT DISTINCT
    u.user_id,
    u.full_name,
    ad.access_type,
    ad.target_system
FROM users u
JOIN access_dependencies ad
    ON ad.user_id = u.user_id
WHERE ad.security_approval_required = TRUE
ORDER BY u.full_name;


-- ============================================================
-- Q-021
-- Find software with no Astra Linux replacement.
--
-- Demonstrates:
-- NULL filtering
-- ============================================================

SELECT
    software_id,
    software_name,
    business_criticality
FROM software
WHERE astra_equivalent IS NULL
ORDER BY software_name;


-- ============================================================
-- Q-022
-- Find business-critical software with no Astra equivalent.
-- ============================================================

SELECT
    software_id,
    software_name,
    business_criticality
FROM software
WHERE
    astra_equivalent IS NULL
    AND business_criticality = 'critical'
ORDER BY software_name;


-- ============================================================
-- Q-023
-- Find workplaces depending on software with no
-- Astra Linux equivalent.
-- ============================================================

SELECT DISTINCT
    w.workplace_id,
    u.full_name,
    s.software_name
FROM workplaces w
JOIN users u
    ON u.user_id = w.user_id
JOIN workplace_software ws
    ON ws.workplace_id = w.workplace_id
JOIN software s
    ON s.software_id = ws.software_id
WHERE s.astra_equivalent IS NULL
ORDER BY w.workplace_id;


-- ============================================================
-- Q-024
-- Show migration attempt count for each workplace.
--
-- LEFT JOIN ensures workplaces with zero attempts
-- are also shown.
-- ============================================================

SELECT
    w.workplace_id,
    u.full_name,
    COUNT(ma.attempt_id) AS attempt_count
FROM workplaces w
JOIN users u
    ON u.user_id = w.user_id
LEFT JOIN migration_attempts ma
    ON ma.workplace_id = w.workplace_id
GROUP BY
    w.workplace_id,
    u.full_name
ORDER BY
    attempt_count DESC,
    w.workplace_id;


-- ============================================================
-- Q-025
-- Find workplaces with more than one migration attempt.
--
-- Useful for detecting retries or transition
-- from automated to manual migration.
-- ============================================================

SELECT
    w.workplace_id,
    u.full_name,
    COUNT(ma.attempt_id) AS attempt_count
FROM workplaces w
JOIN users u
    ON u.user_id = w.user_id
JOIN migration_attempts ma
    ON ma.workplace_id = w.workplace_id
GROUP BY
    w.workplace_id,
    u.full_name
HAVING COUNT(ma.attempt_id) > 1
ORDER BY attempt_count DESC;


-- ============================================================
-- Q-026
-- Show the latest scheduled migration date for each workplace.
--
-- Demonstrates:
-- MAX
-- GROUP BY
-- ============================================================

SELECT
    w.workplace_id,
    u.full_name,
    MAX(ms.planned_date) AS latest_planned_date
FROM workplaces w
JOIN users u
    ON u.user_id = w.user_id
JOIN migration_schedule ms
    ON ms.workplace_id = w.workplace_id
GROUP BY
    w.workplace_id,
    u.full_name
ORDER BY latest_planned_date;


-- ============================================================
-- Q-027
-- Find workplaces that have been scheduled more than once.
--
-- A possible indication of postponement or rescheduling.
-- ============================================================

SELECT
    w.workplace_id,
    u.full_name,
    COUNT(ms.schedule_id) AS schedule_count
FROM workplaces w
JOIN users u
    ON u.user_id = w.user_id
JOIN migration_schedule ms
    ON ms.workplace_id = w.workplace_id
GROUP BY
    w.workplace_id,
    u.full_name
HAVING COUNT(ms.schedule_id) > 1
ORDER BY schedule_count DESC;


-- ============================================================
-- Q-028
-- Find workplaces that currently have open blockers
-- but are not marked as blocked.
--
-- This is a simple data-quality / consistency check.
-- ============================================================

SELECT DISTINCT
    w.workplace_id,
    u.full_name,
    w.migration_status,
    mb.blocker_type
FROM workplaces w
JOIN users u
    ON u.user_id = w.user_id
JOIN migration_blockers mb
    ON mb.workplace_id = w.workplace_id
WHERE
    mb.status = 'open'
    AND w.migration_status <> 'blocked'
ORDER BY w.workplace_id;


-- ============================================================
-- Q-029
-- Find workplaces marked as blocked but without an
-- open blocker record.
--
-- Another consistency check.
-- ============================================================

SELECT
    w.workplace_id,
    u.full_name,
    w.migration_status
FROM workplaces w
JOIN users u
    ON u.user_id = w.user_id
LEFT JOIN migration_blockers mb
    ON mb.workplace_id = w.workplace_id
    AND mb.status = 'open'
WHERE
    w.migration_status = 'blocked'
    AND mb.blocker_id IS NULL
ORDER BY w.workplace_id;


-- ============================================================
-- Q-030
-- Migration status summary with percentage of all workplaces.
--
-- Demonstrates:
-- aggregate
-- subquery
-- numeric calculation
-- ============================================================

SELECT
    migration_status,
    COUNT(*) AS workplace_count,
    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM workplaces),
        2
    ) AS percentage
FROM workplaces
GROUP BY migration_status
ORDER BY workplace_count DESC;