-- Synthetic sample data for the SSAD-aligned projection.

INSERT INTO users (user_id, full_name, department, business_role, work_mode) VALUES
(1, 'Employee A', 'Operations', 'Specialist', 'office'),
(2, 'Employee B', 'Development', 'Developer', 'office'),
(3, 'Employee C', 'Finance', 'Analyst', 'remote');

INSERT INTO workplace_profiles (profile_id, profile_name, description) VALUES
(1, 'Office User', 'Standard office workplace'),
(2, 'Developer', 'Workplace with development tools and additional access'),
(3, 'Remote User', 'Corporate remote-access workplace');

INSERT INTO workplaces (
    workplace_id, user_id, profile_id, current_os, target_os,
    environment_state, location, workplace_type
) VALUES
(101, 1, 1, 'Astra Linux', 'Astra Linux', 'astra_operational', 'Office A', 'Desktop'),
(102, 2, 2, 'Windows 10', 'Astra Linux', 'windows_operational', 'Office B', 'Desktop'),
(103, 3, 3, 'Windows 10 + Astra Linux', 'Astra Linux', 'dual_boot_transition', 'Remote', 'Laptop');

INSERT INTO software (software_id, software_name, software_category, astra_equivalent, business_criticality) VALUES
(1, 'Yandex Browser', 'browser', 'Yandex Browser', 'standard'),
(2, 'Microsoft Excel', 'office', 'R7 Spreadsheets', 'critical'),
(3, 'Developer IDE', 'development', NULL, 'critical');

INSERT INTO workplace_software (workplace_id, software_id, required, business_critical, dependency_note) VALUES
(101, 1, TRUE, FALSE, 'Standard browser dependency'),
(102, 2, TRUE, TRUE, 'Complex spreadsheet workflow required'),
(102, 3, TRUE, TRUE, 'Required development environment'),
(103, 2, TRUE, TRUE, 'Windows retained for unsupported spreadsheet scenario');

INSERT INTO support_teams (team_id, team_name, responsibility_area) VALUES
(1, 'Workplace Support', 'Workplace operation and manual migration'),
(2, 'Software Support', 'Application compatibility evidence'),
(3, 'Infrastructure Automation', 'Automated migration tooling'),
(4, 'Information Security', 'Security and access constraints');

INSERT INTO compatibility_assessments (
    assessment_id, software_id, responsible_team_id, compatibility_status,
    replacement_available, replacement_maturity, assessed_at, notes
) VALUES
(1001, 1, 2, 'compatible', TRUE, 'stable', '2026-01-10 09:00:00', 'Validated on target environment'),
(1002, 2, 2, 'partial', TRUE, 'limited', '2026-02-20 10:00:00', 'Complex spreadsheet workflow not fully supported'),
(1003, 3, 2, 'under_development', FALSE, NULL, '2026-02-20 10:15:00', 'Required tooling not yet available');

INSERT INTO readiness_evaluations (
    evaluation_id, workplace_id, decision, evaluated_at, reason_summary
) VALUES
(3001, 101, 'green', '2026-02-01 08:00:00', 'Dependencies validated'),
(3002, 102, 'red', '2026-02-20 13:10:00', 'Critical software capability unavailable'),
(3003, 103, 'yellow', '2026-02-21 09:00:00', 'Transitional dual-boot dependency remains');

INSERT INTO migration_schedules (
    schedule_id, workplace_id, planned_date, migration_wave, schedule_status
) VALUES
(9001, 101, '2026-02-03', 'Wave 1', 'completed'),
(9002, 102, '2026-03-15', 'Wave 3', 'superseded'),
(9003, 102, '2026-04-15', 'Wave 4', 'cancelled');

UPDATE migration_schedules
SET superseded_by_schedule_id = 9003
WHERE schedule_id = 9002;

INSERT INTO postponement_requests (
    request_id, workplace_id, service_desk_ticket_id, reason, decision,
    replacement_schedule_id, requested_at, decided_at
) VALUES
(5001, 102, 'SD-2026-00421', 'Required development tooling is not ready', 'approved', 9003,
 '2026-03-01 10:00:00', '2026-03-02 12:00:00');

INSERT INTO migration_attempts (
    attempt_id, external_attempt_id, source_system, workplace_id,
    execution_type, result, started_at, completed_at, technical_error
) VALUES
(4001, 'mig-101-auto-001', 'automated-migration-tool', 101,
 'automated', 'successful', '2026-02-03 09:00:00', '2026-02-03 11:10:00', NULL),
(4002, 'mig-103-auto-001', 'automated-migration-tool', 103,
 'automated', 'successful', '2026-02-18 09:00:00', '2026-02-18 11:20:00', NULL);

INSERT INTO migration_blockers (
    blocker_id, workplace_id, responsible_team_id, blocker_type,
    description, status, created_at, resolved_at
) VALUES
(7001, 102, 2, 'software_compatibility',
 'Required spreadsheet/development workflow is not supported', 'open', '2026-02-20 13:00:00', NULL),
(7002, 103, 2, 'software_compatibility',
 'Selected workflow still requires Windows', 'in_progress', '2026-02-18 12:00:00', NULL);

INSERT INTO operational_validations (
    validation_id, workplace_id, business_capability_available,
    required_access_available, no_blocking_exceptions, result, notes, validated_at
) VALUES
(8001, 101, TRUE, TRUE, TRUE, 'passed', 'User workflow validated after migration', '2026-02-03 15:00:00'),
(8002, 103, FALSE, TRUE, FALSE, 'failed', 'Windows dependency remains; dual boot is transitional', '2026-02-18 15:00:00');
