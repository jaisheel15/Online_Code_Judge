-- name: CreateSubmissionResult :one
INSERT INTO submission_results (submission_id, test_case_id , status , runtime_ms, memory_kb, stdout, stderr )
VALUES ($1, $2, $3, $4, $5, $6, $7)
RETURNING *;

-- name: GetSubmissionResult :one
SELECT *
FROM submission_results
WHERE id = $1;  

-- name: ListSubmissionResultsBySubmissionId :many
SELECT *
FROM submission_results
WHERE submission_id = $1
ORDER BY created_at DESC
LIMIT $2 OFFSET $3; 

       