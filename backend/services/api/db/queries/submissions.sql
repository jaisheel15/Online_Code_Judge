-- name: CreateSubmission :one
INSERT INTO submissions (user_id, problem_id, language, source_code, status)
VALUES ($1, $2, $3, $4, $5)
RETURNING *;

-- name: UpdateSubmissionStatus :one
UPDATE submissions
SET status = $2, runtime_ms = $3, memory_kb = $4, score = $5
WHERE id = $1
RETURNING *;

-- name: GetSubmission :one 
SELECT *
FROM submissions
WHERE id = $1;

-- name: ListSubmissionsByUserId :many
SELECT *
FROM submissions
WHERE user_id = $1
ORDER BY submitted_at DESC
LIMIT $2 OFFSET $3;

-- name: ListSubmissionsByProblemId :many
SELECT *
FROM submissions
WHERE problem_id = $1
ORDER BY submitted_at DESC
LIMIT $2 OFFSET $3; 