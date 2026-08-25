-- ============================================================
-- Enterprise Workplace OS Migration
-- File: sql/02-sample-data.sql
--
-- Purpose:
-- Synthetic sample data for the workplace migration
-- portfolio case.
--
-- The data below is fictional and does not represent
-- real employees, systems or internal production records.
-- ============================================================


-- ============================================================
-- 1. SUPPORT TEAMS
-- ============================================================

INSERT INTO support_teams (
    team_name,
    responsibility_area
)
VALUES
    (
        'Workplace Support',
        'Workstation migration, workplace recovery and manual migration'
    ),
    (
        'Information Security',
        'Security approvals, certificates and protected access'
    ),
    (
        'Infrastructure Automation',
        'Automated migration tooling and infrastructure automation'
    ),
    (
        'Software and Office Applications Support',
        'Software compatibility and office application support'
    ),
    (
        'Telephony Support',
        'Telephony-related workplace dependencies'
    ),
    (
        'Vendor Development',
        'Software adaptation and missing Linux functionality'
    );


-- ============================================================
-- 2. WORKPLACE PROFILES
-- ============================================================

INSERT INTO workplace_profiles (
    profile_name,
    description
)
VALUES
    (
        'Office User',
        'Standard office workplace with common corporate software and services'
    ),
    (
        'Remote User',
        'Corporate workplace used for remote access through VPN and remote desktop'
    ),
    (
        'Restricted Environment User',
        'Workplace operating in a protected environment with certificate-based access'
    ),
    (
        'Developer',
        'Technical workplace requiring development tools, libraries and specialized access'
    ),
    (
        'Specialized Workplace',
        'Workplace requiring business-specific applications or additional technical dependencies'
    );


-- ============================================================
-- 3. USERS
-- ============================================================

INSERT INTO users (
    full_name,
    department,
    business_role,
    work_mode
)
VALUES
    (
        'Alexey Morozov',
        'Retail Operations',
        'Operations Specialist',
        'office'
    ),
    (
        'Maria Volkova',
        'Finance',
        'Financial Analyst',
        'office'
    ),
    (
        'Sergey Lebedev',
        'Payment Systems',
        'Payment Systems Specialist',
        'office'
    ),
    (
        'Elena Petrova',
        'Software Development',
        'Backend Developer',
        'office'
    ),
    (
        'Dmitry Sokolov',
        'Regional Operations',
        'Remote Operations Specialist',
        'remote'
    ),
    (
        'Anna Fedorova',
        'Corporate Services',
        'Department Manager',
        'office'
    );


-- ============================================================
-- 4. WORKPLACES
-- ============================================================

INSERT INTO workplaces (
    user_id,
    profile_id,
    current_os,
    target_os,
    location,
    workplace_type,
    migration_status
)
VALUES
    (
        1,
        1,
        'Windows 10',
        'Astra Linux',
        'Office A',
        'Desktop',
        'migrated'
    ),
    (
        2,
        1,
        'Windows 10',
        'Astra Linux',
        'Office A',
        'blocked'
    ),
    (
        3,
        5,
        'Windows 10',
        'Astra Linux',
        'Office B',
        'dual_boot'
    ),
    (
        4,
        4,
        'Windows 11',
        'Astra Linux',
        'Office C',
        'postponed'
    ),
    (
        5,
        2,
        'Astra Linux',
        'Astra Linux',
        'Remote',
        'migrated'
    ),
    (
        6,
        3,
        'Windows 10',
        'Astra Linux',
        'Office D',
        'migrated'
    ),
    (
        6,
        1,
        'Windows 10',
        'Astra Linux',
        'Office D',
        'scheduled'
    );


-- ============================================================
-- 5. SOFTWARE
-- ============================================================

INSERT INTO software (
    software_name,
    software_category,
    windows_version,
    astra_equivalent,
    business_criticality
)
VALUES
    (
        'Yandex Browser',
        'Browser',
        'Windows',
        'Yandex Browser for Linux',
        'high'
    ),
    (
        'Microsoft Excel',
        'Office',
        'Microsoft 365',
        'R7 Spreadsheets',
        'high'
    ),
    (
        'Kaspersky Endpoint Security',
        'Security',
        'Windows',
        'Kaspersky Endpoint Security for Linux',
        'high'
    ),
    (
        '1C Enterprise',
        'Business Application',
        '8.x',
        '1C Enterprise Linux Client',
        'critical'
    ),
    (
        'JetBrains Rider',
        'Development',
        'Windows',
        'JetBrains Rider for Linux',
        'medium'
    ),
    (
        'Corporate Diagram Tool',
        'Productivity',
        'Windows',
        NULL,
        'medium'
    ),
    (
        'CryptoPro CSP',
        'Security',
        'Windows',
        'CryptoPro CSP for Linux',
        'critical'
    ),
    (
        'Internal Payment Client',
        'Specialized Application',
        'Windows',
        NULL,
        'critical'
    );


-- ============================================================
-- 6. WORKPLACE SOFTWARE
-- ============================================================

-- Workplace 1:
-- Standard office workplace, all required software is compatible.

INSERT INTO workplace_software (
    workplace_id,
    software_id,
    required,
    business_critical,
    current_status
)
VALUES
    (1, 1, TRUE, TRUE, 'available'),
    (1, 2, TRUE, TRUE, 'available'),
    (1, 3, TRUE, TRUE, 'available');


-- Workplace 2:
-- Financial analyst blocked because required Excel workflows
-- depend on functionality not fully supported by the replacement.

INSERT INTO workplace_software (
    workplace_id,
    software_id,
    required,
    business_critical,
    current_status
)
VALUES
    (2, 1, TRUE, TRUE, 'available'),
    (2, 2, TRUE, TRUE, 'blocked'),
    (2, 3, TRUE, TRUE, 'available');


-- Workplace 3:
-- Specialized payment workplace.
-- Astra is available, but the payment client still requires Windows.

INSERT INTO workplace_software (
    workplace_id,
    software_id,
    required,
    business_critical,
    current_status
)
VALUES
    (3, 1, TRUE, TRUE, 'available'),
    (3, 3, TRUE, TRUE, 'available'),
    (3, 8, TRUE, TRUE, 'windows_only');


-- Workplace 4:
-- Developer workplace.

INSERT INTO workplace_software (
    workplace_id,
    software_id,
    required,
    business_critical,
    current_status
)
VALUES
    (4, 1, TRUE, FALSE, 'available'),
    (4, 5, TRUE, TRUE, 'available'),
    (4, 6, TRUE, FALSE, 'pending');


-- Workplace 5:
-- Remote Astra workplace.

INSERT INTO workplace_software (
    workplace_id,
    software_id,
    required,
    business_critical,
    current_status
)
VALUES
    (5, 1, TRUE, TRUE, 'available'),
    (5, 3, TRUE, TRUE, 'available'),
    (5, 7, TRUE, TRUE, 'available');


-- Workplace 6:
-- Restricted environment.

INSERT INTO workplace_software (
    workplace_id,
    software_id,
    required,
    business_critical,
    current_status
)
VALUES
    (6, 1, TRUE, TRUE, 'available'),
    (6, 3, TRUE, TRUE, 'available'),
    (6, 7, TRUE, TRUE, 'available');


-- Workplace 7:
-- Second workplace of the same user.

INSERT INTO workplace_software (
    workplace_id,
    software_id,
    required,
    business_critical,
    current_status
)
VALUES
    (7, 1, TRUE, TRUE, 'available'),
    (7, 2, TRUE, FALSE, 'available'),
    (7, 3, TRUE, TRUE, 'available');


-- ============================================================
-- 7. COMPATIBILITY ASSESSMENTS
-- ============================================================

INSERT INTO compatibility_assessments (
    software_id,
    responsible_team_id,
    compatibility_status,
    replacement_available,
    replacement_maturity,
    blocker_flag,
    assessment_date,
    notes
)
VALUES
    (
        1,
        4,
        'compatible',
        TRUE,
        'stable',
        FALSE,
        '2026-01-10',
        'Linux-compatible browser version is available'
    ),
    (
        2,
        4,
        'partial',
        TRUE,
        'limited',
        TRUE,
        '2026-01-12',
        'Basic spreadsheet functionality is available, but some complex Excel workflows are not fully supported'
    ),
    (
        3,
        2,
        'compatible',
        TRUE,
        'stable',
        FALSE,
        '2026-01-11',
        'Approved Linux security client is available'
    ),
    (
        4,
        4,
        'compatible',
        TRUE,
        'stable',
        FALSE,
        '2026-01-14',
        'Supported Linux client is available'
    ),
    (
        5,
        4,
        'compatible',
        TRUE,
        'stable',
        FALSE,
        '2026-01-16',
        'Development environment is supported on Linux'
    ),
    (
        6,
        6,
        'under_development',
        FALSE,
        NULL,
        TRUE,
        '2026-01-18',
        'No approved Astra Linux equivalent is currently available'
    ),
    (
        7,
        2,
        'compatible',
        TRUE,
        'stable',
        FALSE,
        '2026-01-19',
        'Linux version is approved for remote and protected access'
    ),
    (
        8,
        6,
        'no_replacement',
        FALSE,
        NULL,
        TRUE,
        '2026-01-20',
        'Business-critical payment application currently requires Windows'
    );


-- ============================================================
-- 8. MIGRATION SCHEDULE
-- ============================================================

-- Workplace 1:
-- Migrated on the original date.

INSERT INTO migration_schedule (
    workplace_id,
    planned_date,
    readiness_status,
    schedule_status,
    migration_wave
)
VALUES
    (
        1,
        '2026-02-03',
        'green',
        'completed',
        'Wave 1'
    );


-- Workplace 2:
-- Currently blocked.

INSERT INTO migration_schedule (
    workplace_id,
    planned_date,
    readiness_status,
    schedule_status,
    migration_wave
)
VALUES
    (
        2,
        '2026-03-10',
        'red',
        'blocked',
        'Wave 3'
    );


-- Workplace 3:
-- Migrated to transitional dual boot.

INSERT INTO migration_schedule (
    workplace_id,
    planned_date,
    readiness_status,
    schedule_status,
    migration_wave
)
VALUES
    (
        3,
        '2026-04-15',
        'yellow',
        'completed',
        'Wave 4'
    );


-- Workplace 4:
-- Original migration date.

INSERT INTO migration_schedule (
    workplace_id,
    planned_date,
    readiness_status,
    schedule_status,
    migration_wave
)
VALUES
    (
        4,
        '2026-05-20',
        'green',
        'postponed',
        'Wave 5'
    );


-- Workplace 4:
-- New date after postponement.

INSERT INTO migration_schedule (
    workplace_id,
    planned_date,
    readiness_status,
    schedule_status,
    migration_wave
)
VALUES
    (
        4,
        '2026-06-17',
        'yellow',
        'scheduled',
        'Wave 6'
    );


-- Workplace 5:
-- Remote user migrated successfully.

INSERT INTO migration_schedule (
    workplace_id,
    planned_date,
    readiness_status,
    schedule_status,
    migration_wave
)
VALUES
    (
        5,
        '2026-03-05',
        'green',
        'completed',
        'Wave 2'
    );


-- Workplace 6:
-- Migration completed after technical failure
-- and manual intervention.

INSERT INTO migration_schedule (
    workplace_id,
    planned_date,
    readiness_status,
    schedule_status,
    migration_wave
)
VALUES
    (
        6,
        '2026-04-08',
        'green',
        'completed',
        'Wave 4'
    );


-- Workplace 7:
-- Planned future migration.

INSERT INTO migration_schedule (
    workplace_id,
    planned_date,
    readiness_status,
    schedule_status,
    migration_wave
)
VALUES
    (
        7,
        '2026-08-28',
        'green',
        'scheduled',
        'Wave 8'
    );


-- ============================================================
-- 9. POSTPONEMENT REQUESTS
-- ============================================================

-- Developer requested migration postponement because part of
-- the required toolset was still under coordination.

INSERT INTO postponement_requests (
    workplace_id,
    service_desk_ticket_id,
    requested_at,
    reason,
    approval_status,
    new_migration_date
)
VALUES
    (
        4,
        'SD-2026-00421',
        '2026-05-15 10:20:00',
        'Required development tooling is still being coordinated for the Astra Linux environment',
        'approved',
        '2026-06-17'
    );


-- ============================================================
-- 10. MIGRATION ATTEMPTS
-- ============================================================

-- Workplace 1:
-- Standard successful automated migration.

INSERT INTO migration_attempts (
    workplace_id,
    migration_date,
    execution_type,
    result,
    technical_error,
    completed_at
)
VALUES
    (
        1,
        '2026-02-03 09:00:00',
        'automated',
        'successful',
        NULL,
        '2026-02-03 11:10:00'
    );


-- Workplace 3:
-- Automated deployment succeeded,
-- but workplace remained dual boot.

INSERT INTO migration_attempts (
    workplace_id,
    migration_date,
    execution_type,
    result,
    technical_error,
    completed_at
)
VALUES
    (
        3,
        '2026-04-15 09:00:00',
        'automated',
        'successful',
        NULL,
        '2026-04-15 11:35:00'
    );


-- Workplace 5:
-- Successful automated migration.

INSERT INTO migration_attempts (
    workplace_id,
    migration_date,
    execution_type,
    result,
    technical_error,
    completed_at
)
VALUES
    (
        5,
        '2026-03-05 09:00:00',
        'automated',
        'successful',
        NULL,
        '2026-03-05 10:45:00'
    );


-- Workplace 6:
-- Automated migration failed.

INSERT INTO migration_attempts (
    workplace_id,
    migration_date,
    execution_type,
    result,
    technical_error,
    completed_at
)
VALUES
    (
        6,
        '2026-04-08 09:00:00',
        'automated',
        'failed',
        'Automated installation process terminated during OS deployment',
        '2026-04-08 09:42:00'
    );


-- Workplace 6:
-- Workplace Support performed manual migration.

INSERT INTO migration_attempts (
    workplace_id,
    migration_date,
    execution_type,
    result,
    technical_error,
    completed_at
)
VALUES
    (
        6,
        '2026-04-08 12:30:00',
        'manual',
        'successful',
        NULL,
        '2026-04-08 16:20:00'
    );


-- ============================================================
-- 11. MIGRATION BLOCKERS
-- ============================================================

-- Workplace 2:
-- Excel replacement does not support the complete
-- business workflow.

INSERT INTO migration_blockers (
    workplace_id,
    responsible_team_id,
    blocker_type,
    description,
    status,
    created_at,
    resolved_at
)
VALUES
    (
        2,
        4,
        'software_compatibility',
        'Required spreadsheet workflows are not fully supported by the available Astra Linux replacement',
        'open',
        '2026-02-20 13:00:00',
        NULL
    );


-- Workplace 3:
-- Windows-only payment software currently requires
-- a dual-boot configuration.

INSERT INTO migration_blockers (
    workplace_id,
    responsible_team_id,
    blocker_type,
    description,
    status,
    created_at,
    resolved_at
)
VALUES
    (
        3,
        6,
        'software_compatibility',
        'Internal Payment Client is not currently available for Astra Linux',
        'open',
        '2026-03-18 09:30:00',
        NULL
    );


-- Workplace 4:
-- Temporary software/tooling dependency.

INSERT INTO migration_blockers (
    workplace_id,
    responsible_team_id,
    blocker_type,
    description,
    status,
    created_at,
    resolved_at
)
VALUES
    (
        4,
        4,
        'software_readiness',
        'Required development tooling configuration was not ready for the original migration date',
        'resolved',
        '2026-05-15 11:00:00',
        '2026-06-10 15:00:00'
    );


-- ============================================================
-- 12. ACCESS DEPENDENCIES
-- ============================================================

-- Standard corporate services for User 1.

INSERT INTO access_dependencies (
    user_id,
    access_type,
    target_system,
    security_approval_required,
    status
)
VALUES
    (
        1,
        'corporate_service',
        'Internal Web Applications',
        FALSE,
        'active'
    ),
    (
        1,
        'network_resource',
        'Corporate Network Drives',
        FALSE,
        'active'
    );


-- Remote user.

INSERT INTO access_dependencies (
    user_id,
    access_type,
    target_system,
    security_approval_required,
    status
)
VALUES
    (
        5,
        'vpn',
        'Corporate VPN',
        TRUE,
        'active'
    ),
    (
        5,
        'certificate',
        'CryptoPro Token Authentication',
        TRUE,
        'active'
    ),
    (
        5,
        'remote_desktop',
        'Remote Workplace Farm',
        TRUE,
        'active'
    );


-- Restricted environment user.

INSERT INTO access_dependencies (
    user_id,
    access_type,
    target_system,
    security_approval_required,
    status
)
VALUES
    (
        6,
        'certificate',
        'Protected Workplace Authentication',
        TRUE,
        'active'
    ),
    (
        6,
        'firewall_rule',
        'Restricted Corporate Network Segment',
        TRUE,
        'active'
    );


-- Developer.

INSERT INTO access_dependencies (
    user_id,
    access_type,
    target_system,
    security_approval_required,
    status
)
VALUES
    (
        4,
        'development_access',
        'Development Infrastructure',
        TRUE,
        'active'
    );