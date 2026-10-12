-- +goose Up
CREATE TABLE submission_results (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    submission_id UUID NOT NULL
        REFERENCES submissions(id)
        ON DELETE CASCADE,

    test_case_id UUID NOT NULL
        REFERENCES testcases(id)
        ON DELETE CASCADE,

    status VARCHAR(50) NOT NULL
        CHECK (status IN (
            'accepted', 'wrong_answer', 'time_limit_exceeded',
            'memory_limit_exceeded', 'runtime_error',
            'compile_error', 'internal_error'
        )),

    runtime_ms INTEGER,
    memory_kb INTEGER,

    stdout TEXT,
    stderr TEXT,

    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    UNIQUE(submission_id, test_case_id)
);

CREATE INDEX idx_submission_results_submission_id
    ON submission_results(submission_id);

CREATE INDEX idx_submission_results_test_case_id
    ON submission_results(test_case_id);

CREATE TRIGGER trg_submission_results_updated_at
    BEFORE UPDATE ON submission_results
    FOR EACH ROW EXECUTE FUNCTION set_updated_at();

-- +goose Down
DROP TABLE IF EXISTS submission_results;
