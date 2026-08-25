-- ============================================================
-- Enterprise Workplace OS Migration
-- File: sql/01-schema.sql
--
-- Purpose:
-- Simplified relational schema for the workplace migration
-- portfolio case.
--
-- This schema uses synthetic portfolio entities and does not
-- represent any internal production database.
-- ============================================================


-- ============================================================
-- 1. USERS
-- ============================================================

CREATE TABLE users (
    user_id BIGSERIAL PRIMARY KEY,

    full_name VARCHAR(200) NOT NULL,
    department VARCHAR(200),
    business_role VARCHAR(200),
    work_mode VARCHAR(50),

    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);


-- ============================================================
-- 2. WORKPLACE PROFILES
-- ============================================================

CREATE TABLE workplace_profiles (
    profile_id BIGSERIAL PRIMARY KEY,

    profile_name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT
);


-- ============================================================
-- 3. WORKPLACES
-- ============================================================

CREATE TABLE workplaces (
    workplace_id BIGSERIAL PRIMARY KEY,

    user_id BIGINT NOT NULL,
    profile_id BIGINT,

    current_os VARCHAR(100) NOT NULL,
    target_os VARCHAR(100) NOT NULL DEFAULT 'Astra Linux',

    location VARCHAR(200),
    workplace_type VARCHAR(100),

    migration_status VARCHAR(50) NOT NULL DEFAULT 'scheduled',

    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_workplaces_user
        FOREIGN KEY (user_id)
        REFERENCES users(user_id),

    CONSTRAINT fk_workplaces_profile
        FOREIGN KEY (profile_id)
        REFERENCES workplace_profiles(profile_id)
);


-- ============================================================
-- 4. SOFTWARE
-- ============================================================

CREATE TABLE software (
    software_id BIGSERIAL PRIMARY KEY,

    software_name VARCHAR(200) NOT NULL,
    software_category VARCHAR(100),

    windows_version VARCHAR(100),
    astra_equivalent VARCHAR(200),

    business_criticality VARCHAR(50),

    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT uq_software_name
        UNIQUE (software_name)
);


-- ============================================================
-- 5. WORKPLACE <-> SOFTWARE
--
-- Junction table for the many-to-many relationship:
--
-- one workplace -> many software products
-- one software product -> many workplaces
-- ============================================================

CREATE TABLE workplace_software (
    workplace_id BIGINT NOT NULL,
    software_id BIGINT NOT NULL,

    required BOOLEAN NOT NULL DEFAULT TRUE,
    business_critical BOOLEAN NOT NULL DEFAULT FALSE,

    current_status VARCHAR(50),

    PRIMARY KEY (workplace_id, software_id),

    CONSTRAINT fk_workplace_software_workplace
        FOREIGN KEY (workplace_id)
        REFERENCES workplaces(workplace_id),

    CONSTRAINT fk_workplace_software_software
        FOREIGN KEY (software_id)
        REFERENCES software(software_id)
);


-- ============================================================
-- 6. SUPPORT TEAMS
-- ============================================================

CREATE TABLE support_teams (
    team_id BIGSERIAL PRIMARY KEY,

    team_name VARCHAR(200) NOT NULL UNIQUE,
    responsibility_area TEXT
);


-- ============================================================
-- 7. SOFTWARE COMPATIBILITY ASSESSMENTS
-- ============================================================

CREATE TABLE compatibility_assessments (
    assessment_id BIGSERIAL PRIMARY KEY,

    software_id BIGINT NOT NULL,
    responsible_team_id BIGINT,

    compatibility_status VARCHAR(50) NOT NULL,

    replacement_available BOOLEAN NOT NULL DEFAULT FALSE,
    replacement_maturity VARCHAR(50),

    blocker_flag BOOLEAN NOT NULL DEFAULT FALSE,

    assessment_date DATE NOT NULL DEFAULT CURRENT_DATE,
    notes TEXT,

    CONSTRAINT fk_compatibility_software
        FOREIGN KEY (software_id)
        REFERENCES software(software_id),

    CONSTRAINT fk_compatibility_team
        FOREIGN KEY (responsible_team_id)
        REFERENCES support_teams(team_id)
);


-- ============================================================
-- 8. MIGRATION SCHEDULE
--
-- One workplace may have multiple schedule records because
-- migration may be postponed and rescheduled.
-- ============================================================

CREATE TABLE migration_schedule (
    schedule_id BIGSERIAL PRIMARY KEY,

    workplace_id BIGINT NOT NULL,

    planned_date DATE NOT NULL,

    readiness_status VARCHAR(20) NOT NULL,
    schedule_status VARCHAR(50) NOT NULL DEFAULT 'scheduled',

    migration_wave VARCHAR(100),

    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_schedule_workplace
        FOREIGN KEY (workplace_id)
        REFERENCES workplaces(workplace_id)
);


-- ============================================================
-- 9. POSTPONEMENT REQUESTS
-- ============================================================

CREATE TABLE postponement_requests (
    request_id BIGSERIAL PRIMARY KEY,

    workplace_id BIGINT NOT NULL,

    service_desk_ticket_id VARCHAR(100),

    requested_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    reason TEXT NOT NULL,

    approval_status VARCHAR(30) NOT NULL DEFAULT 'pending',

    new_migration_date DATE,

    CONSTRAINT fk_postponement_workplace
        FOREIGN KEY (workplace_id)
        REFERENCES workplaces(workplace_id)
);


-- ============================================================
-- 10. MIGRATION ATTEMPTS
--
-- Represents actual execution, not planning.
--
-- Example:
-- attempt 1 -> automated -> failed
-- attempt 2 -> manual    -> successful
-- ============================================================

CREATE TABLE migration_attempts (
    attempt_id BIGSERIAL PRIMARY KEY,

    workplace_id BIGINT NOT NULL,

    migration_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    execution_type VARCHAR(20) NOT NULL,
    result VARCHAR(20) NOT NULL,

    technical_error TEXT,

    completed_at TIMESTAMP,

    CONSTRAINT fk_migration_attempt_workplace
        FOREIGN KEY (workplace_id)
        REFERENCES workplaces(workplace_id)
);


-- ============================================================
-- 11. MIGRATION BLOCKERS
-- ============================================================

CREATE TABLE migration_blockers (
    blocker_id BIGSERIAL PRIMARY KEY,

    workplace_id BIGINT NOT NULL,
    responsible_team_id BIGINT,

    blocker_type VARCHAR(100) NOT NULL,

    description TEXT NOT NULL,

    status VARCHAR(30) NOT NULL DEFAULT 'open',

    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    resolved_at TIMESTAMP,

    CONSTRAINT fk_blocker_workplace
        FOREIGN KEY (workplace_id)
        REFERENCES workplaces(workplace_id),

    CONSTRAINT fk_blocker_team
        FOREIGN KEY (responsible_team_id)
        REFERENCES support_teams(team_id)
);


-- ============================================================
-- 12. ACCESS DEPENDENCIES
-- ============================================================

CREATE TABLE access_dependencies (
    access_id BIGSERIAL PRIMARY KEY,

    user_id BIGINT NOT NULL,

    access_type VARCHAR(100) NOT NULL,
    target_system VARCHAR(200) NOT NULL,

    security_approval_required BOOLEAN NOT NULL DEFAULT FALSE,

    status VARCHAR(50) NOT NULL,

    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_access_user
        FOREIGN KEY (user_id)
        REFERENCES users(user_id)
);


-- ============================================================
-- 13. INDEXES
--
-- These indexes are not mandatory for understanding the model,
-- but represent common fields used for filtering and joins.
-- ============================================================

CREATE INDEX idx_workplaces_user_id
    ON workplaces(user_id);

CREATE INDEX idx_workplaces_migration_status
    ON workplaces(migration_status);

CREATE INDEX idx_workplace_software_software_id
    ON workplace_software(software_id);

CREATE INDEX idx_compatibility_software_id
    ON compatibility_assessments(software_id);

CREATE INDEX idx_compatibility_status
    ON compatibility_assessments(compatibility_status);

CREATE INDEX idx_schedule_workplace_id
    ON migration_schedule(workplace_id);

CREATE INDEX idx_schedule_planned_date
    ON migration_schedule(planned_date);

CREATE INDEX idx_schedule_readiness_status
    ON migration_schedule(readiness_status);

CREATE INDEX idx_postponement_workplace_id
    ON postponement_requests(workplace_id);

CREATE INDEX idx_attempts_workplace_id
    ON migration_attempts(workplace_id);

CREATE INDEX idx_attempts_result
    ON migration_attempts(result);

CREATE INDEX idx_attempts_execution_type
    ON migration_attempts(execution_type);

CREATE INDEX idx_blockers_workplace_id
    ON migration_blockers(workplace_id);

CREATE INDEX idx_blockers_status
    ON migration_blockers(status);

CREATE INDEX idx_access_user_id
    ON access_dependencies(user_id);