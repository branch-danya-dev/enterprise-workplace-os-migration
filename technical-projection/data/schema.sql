-- ============================================================
-- Enterprise Workplace OS Migration
-- Synthetic PostgreSQL projection aligned with SSAD ownership.
-- This is portfolio material, not a production banking schema.
-- ============================================================

CREATE TABLE users (
    user_id BIGSERIAL PRIMARY KEY,
    full_name VARCHAR(200) NOT NULL,
    department VARCHAR(200),
    business_role VARCHAR(200),
    work_mode VARCHAR(50),
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE workplace_profiles (
    profile_id BIGSERIAL PRIMARY KEY,
    profile_name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT
);

-- Workplace owns environment meaning, not planning/readiness/execution.
CREATE TABLE workplaces (
    workplace_id BIGSERIAL PRIMARY KEY,
    user_id BIGINT NOT NULL REFERENCES users(user_id),
    profile_id BIGINT REFERENCES workplace_profiles(profile_id),
    current_os VARCHAR(100) NOT NULL,
    target_os VARCHAR(100) NOT NULL DEFAULT 'Astra Linux',
    environment_state VARCHAR(60) NOT NULL DEFAULT 'windows_operational',
    location VARCHAR(200),
    workplace_type VARCHAR(100),
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT chk_environment_state CHECK (
        environment_state IN (
            'windows_operational',
            'dual_boot_transition',
            'astra_installed_pending_validation',
            'astra_operational'
        )
    )
);

CREATE TABLE software (
    software_id BIGSERIAL PRIMARY KEY,
    software_name VARCHAR(200) NOT NULL UNIQUE,
    software_category VARCHAR(100),
    windows_version VARCHAR(100),
    astra_equivalent VARCHAR(200),
    business_criticality VARCHAR(50),
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE workplace_software (
    workplace_id BIGINT NOT NULL REFERENCES workplaces(workplace_id),
    software_id BIGINT NOT NULL REFERENCES software(software_id),
    required BOOLEAN NOT NULL DEFAULT TRUE,
    business_critical BOOLEAN NOT NULL DEFAULT FALSE,
    dependency_note TEXT,
    PRIMARY KEY (workplace_id, software_id)
);

CREATE TABLE support_teams (
    team_id BIGSERIAL PRIMARY KEY,
    team_name VARCHAR(200) NOT NULL UNIQUE,
    responsibility_area TEXT
);

-- Compatibility is timestamped evidence, not a permanent software property.
CREATE TABLE compatibility_assessments (
    assessment_id BIGSERIAL PRIMARY KEY,
    software_id BIGINT NOT NULL REFERENCES software(software_id),
    responsible_team_id BIGINT REFERENCES support_teams(team_id),
    compatibility_status VARCHAR(50) NOT NULL,
    replacement_available BOOLEAN NOT NULL DEFAULT FALSE,
    replacement_maturity VARCHAR(50),
    assessed_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    notes TEXT,
    CONSTRAINT chk_compatibility_status CHECK (
        compatibility_status IN (
            'compatible',
            'partial',
            'under_development',
            'no_replacement',
            'unknown'
        )
    )
);

CREATE TABLE access_dependencies (
    access_id BIGSERIAL PRIMARY KEY,
    user_id BIGINT NOT NULL REFERENCES users(user_id),
    access_type VARCHAR(100) NOT NULL,
    target_system VARCHAR(200) NOT NULL,
    security_approval_required BOOLEAN NOT NULL DEFAULT FALSE,
    evidence_status VARCHAR(50) NOT NULL,
    observed_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Readiness is a decision snapshot over current evidence.
CREATE TABLE readiness_evaluations (
    evaluation_id BIGSERIAL PRIMARY KEY,
    workplace_id BIGINT NOT NULL REFERENCES workplaces(workplace_id),
    decision VARCHAR(20) NOT NULL,
    evaluated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    reason_summary TEXT,
    CONSTRAINT chk_readiness_decision CHECK (decision IN ('green', 'yellow', 'red'))
);

-- Planning facts only. No readiness column here.
CREATE TABLE migration_schedules (
    schedule_id BIGSERIAL PRIMARY KEY,
    workplace_id BIGINT NOT NULL REFERENCES workplaces(workplace_id),
    planned_date DATE NOT NULL,
    migration_wave VARCHAR(100),
    schedule_status VARCHAR(30) NOT NULL DEFAULT 'active',
    superseded_by_schedule_id BIGINT REFERENCES migration_schedules(schedule_id),
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT chk_schedule_status CHECK (
        schedule_status IN ('active', 'superseded', 'completed', 'cancelled')
    )
);

CREATE UNIQUE INDEX uq_active_schedule_per_workplace
    ON migration_schedules(workplace_id)
    WHERE schedule_status = 'active';

CREATE TABLE postponement_requests (
    request_id BIGSERIAL PRIMARY KEY,
    workplace_id BIGINT NOT NULL REFERENCES workplaces(workplace_id),
    service_desk_ticket_id VARCHAR(100) NOT NULL,
    reason TEXT NOT NULL,
    decision VARCHAR(20) NOT NULL DEFAULT 'pending',
    replacement_schedule_id BIGINT REFERENCES migration_schedules(schedule_id),
    requested_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    decided_at TIMESTAMP,
    CONSTRAINT chk_postponement_decision CHECK (
        decision IN ('pending', 'approved', 'rejected')
    )
);

-- Attempt facts are immutable and idempotent per source system.
CREATE TABLE migration_attempts (
    attempt_id BIGSERIAL PRIMARY KEY,
    external_attempt_id VARCHAR(200) NOT NULL,
    source_system VARCHAR(100) NOT NULL,
    workplace_id BIGINT NOT NULL REFERENCES workplaces(workplace_id),
    execution_type VARCHAR(20) NOT NULL,
    result VARCHAR(20) NOT NULL,
    started_at TIMESTAMP NOT NULL,
    completed_at TIMESTAMP,
    technical_error TEXT,
    recorded_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT uq_external_attempt UNIQUE (source_system, external_attempt_id),
    CONSTRAINT chk_execution_type CHECK (execution_type IN ('automated', 'manual')),
    CONSTRAINT chk_attempt_result CHECK (result IN ('successful', 'failed')),
    CONSTRAINT chk_attempt_time CHECK (completed_at IS NULL OR completed_at >= started_at)
);

CREATE TABLE migration_blockers (
    blocker_id BIGSERIAL PRIMARY KEY,
    workplace_id BIGINT NOT NULL REFERENCES workplaces(workplace_id),
    responsible_team_id BIGINT REFERENCES support_teams(team_id),
    blocker_type VARCHAR(100) NOT NULL,
    description TEXT NOT NULL,
    status VARCHAR(30) NOT NULL DEFAULT 'open',
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    resolved_at TIMESTAMP,
    CONSTRAINT chk_blocker_status CHECK (status IN ('open', 'in_progress', 'resolved'))
);

-- Technical success is not enough; business capability must be verified separately.
CREATE TABLE operational_validations (
    validation_id BIGSERIAL PRIMARY KEY,
    workplace_id BIGINT NOT NULL REFERENCES workplaces(workplace_id),
    business_capability_available BOOLEAN NOT NULL,
    required_access_available BOOLEAN NOT NULL,
    no_blocking_exceptions BOOLEAN NOT NULL,
    result VARCHAR(20) NOT NULL,
    notes TEXT,
    validated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT chk_validation_result CHECK (result IN ('passed', 'failed'))
);

CREATE INDEX idx_workplaces_user ON workplaces(user_id);
CREATE INDEX idx_workplaces_environment ON workplaces(environment_state);
CREATE INDEX idx_compatibility_software_time ON compatibility_assessments(software_id, assessed_at DESC);
CREATE INDEX idx_readiness_workplace_time ON readiness_evaluations(workplace_id, evaluated_at DESC);
CREATE INDEX idx_schedule_workplace ON migration_schedules(workplace_id);
CREATE INDEX idx_schedule_date ON migration_schedules(planned_date);
CREATE INDEX idx_attempt_workplace_time ON migration_attempts(workplace_id, started_at DESC);
CREATE INDEX idx_blocker_workplace_status ON migration_blockers(workplace_id, status);
CREATE INDEX idx_validation_workplace_time ON operational_validations(workplace_id, validated_at DESC);

-- Convenience read model. It aggregates source facts but owns none of them.
CREATE VIEW workplace_operational_view AS
WITH latest_readiness AS (
    SELECT DISTINCT ON (workplace_id)
        workplace_id,
        decision,
        evaluation_id,
        evaluated_at
    FROM readiness_evaluations
    ORDER BY workplace_id, evaluated_at DESC, evaluation_id DESC
),
active_schedule AS (
    SELECT workplace_id, schedule_id, planned_date, migration_wave
    FROM migration_schedules
    WHERE schedule_status = 'active'
),
latest_attempt AS (
    SELECT DISTINCT ON (workplace_id)
        workplace_id,
        attempt_id,
        result,
        execution_type,
        started_at
    FROM migration_attempts
    ORDER BY workplace_id, started_at DESC, attempt_id DESC
),
open_blockers AS (
    SELECT workplace_id, COUNT(*) AS open_blocker_count
    FROM migration_blockers
    WHERE status <> 'resolved'
    GROUP BY workplace_id
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
    w.user_id,
    w.environment_state,
    lr.decision AS latest_readiness,
    a.schedule_id AS active_schedule_id,
    a.planned_date,
    la.attempt_id AS latest_attempt_id,
    la.result AS latest_attempt_result,
    COALESCE(ob.open_blocker_count, 0) AS open_blocker_count,
    lv.result AS latest_validation_result,
    (w.environment_state = 'astra_operational' AND lv.result = 'passed') AS operationally_migrated
FROM workplaces w
LEFT JOIN latest_readiness lr ON lr.workplace_id = w.workplace_id
LEFT JOIN active_schedule a ON a.workplace_id = w.workplace_id
LEFT JOIN latest_attempt la ON la.workplace_id = w.workplace_id
LEFT JOIN open_blockers ob ON ob.workplace_id = w.workplace_id
LEFT JOIN latest_validation lv ON lv.workplace_id = w.workplace_id;
