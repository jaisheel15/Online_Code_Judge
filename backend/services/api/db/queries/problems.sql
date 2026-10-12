-- name: CreateProblem :one
INSERT INTO problems (name, description, difficulty, time_limit_ms, memory_limit_mb)
VALUES ($1, $2, $3, $4, $5)
RETURNING id, name, description, difficulty, time_limit_ms, memory_limit_mb, created_at, updated_at;

-- name: GetProblem :one
SELECT id, name, description, difficulty, time_limit_ms, memory_limit_mb, created_at, updated_at
FROM problems
WHERE id = $1;

-- name: ListProblems :many
SELECT id, name, description, difficulty, time_limit_ms, memory_limit_mb, created_at, updated_at
FROM problems
ORDER BY created_at, id
LIMIT $1 
OFFSET $2;

-- name: UpdateProblem :one
UPDATE problems
SET name = $2, description = $3, difficulty = $4, time_limit_ms = $5, memory_limit_mb = $6
WHERE id = $1
RETURNING id, name, description, difficulty, time_limit_ms, memory_limit_mb,created_at, updated_at;

-- name: DeleteProblem :exec
DELETE FROM problems
WHERE id = $1;  

