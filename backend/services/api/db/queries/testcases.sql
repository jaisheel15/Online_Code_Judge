-- name: CreateTestCase :one
INSERT INTO testcases (slug , problem_id , input , expected_output, is_hidden, weight, order_no)
VALUES ($1 , $2 , $3 , $4, $5, $6, $7)
RETURNING *;

-- name: GetTestCasesByProblemId :many
SELECT * FROM testcases
WHERE problem_id = $1
ORDER BY order_no;

-- name: GetPublicTestCasesByProblemId :many
SELECT id, slug, problem_id, input, expected_output, is_hidden, weight, order_no, created_at, updated_at
FROM testcases
WHERE problem_id = $1 AND is_hidden = FALSE
ORDER BY order_no;

