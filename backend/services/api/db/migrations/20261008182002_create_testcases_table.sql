-- +goose Up
CREATE TABLE testcases (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    slug VARCHAR(255) NOT NULL,

    problem_id UUID NOT NULL
        REFERENCES problems(id)
        ON DELETE CASCADE,

    input TEXT NOT NULL,
    expected_output TEXT NOT NULL,

    is_hidden BOOLEAN NOT NULL DEFAULT FALSE,

    weight INTEGER NOT NULL DEFAULT 1
        CHECK (weight > 0),

    order_no INTEGER NOT NULL
        CHECK (order_no > 0),

    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    UNIQUE(problem_id, slug),
    UNIQUE(problem_id, order_no)
);

CREATE INDEX idx_testcases_problem_id
    ON testcases(problem_id);

CREATE TRIGGER trg_testcases_updated_at
    BEFORE UPDATE ON testcases
    FOR EACH ROW EXECUTE FUNCTION set_updated_at();

-- +goose Down
DROP TABLE IF EXISTS testcases;
