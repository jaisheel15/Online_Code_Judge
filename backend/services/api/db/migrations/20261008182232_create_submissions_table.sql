-- +goose Up
CREATE TABLE submissions (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    user_id UUID NOT NULL
        REFERENCES users(id)
        ON DELETE CASCADE,

    problem_id UUID NOT NULL
        REFERENCES problems(id)
        ON DELETE CASCADE,

    language VARCHAR(50) NOT NULL
        CHECK (language IN (
            'c', 'cpp', 'java', 'python', 'go',
            'javascript', 'typescript', 'rust', 'csharp'
        )),

    source_code TEXT NOT NULL,

    status VARCHAR(50) NOT NULL DEFAULT 'pending'
        CHECK (status IN (
            'pending', 'judging', 'accepted', 'wrong_answer',
            'time_limit_exceeded', 'memory_limit_exceeded',
            'runtime_error', 'compile_error', 'internal_error'
        )),

    runtime_ms INTEGER,
    memory_kb INTEGER,

    score INTEGER NOT NULL DEFAULT 0
        CHECK (score >= 0),

    submitted_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_submissions_user_id
    ON submissions(user_id);

CREATE INDEX idx_submissions_problem_id
    ON submissions(problem_id);

CREATE INDEX idx_submissions_status
    ON submissions(status);

CREATE INDEX idx_submissions_submitted_at
    ON submissions(submitted_at DESC);

CREATE INDEX idx_submissions_user_problem
    ON submissions(user_id, problem_id);

CREATE TRIGGER trg_submissions_updated_at
    BEFORE UPDATE ON submissions
    FOR EACH ROW EXECUTE FUNCTION set_updated_at();

-- +goose Down
DROP TABLE IF EXISTS submissions;
