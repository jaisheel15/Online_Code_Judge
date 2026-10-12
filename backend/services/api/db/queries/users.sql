-- name: CreateUser :one
INSERT INTO users (username)
VALUES ($1)
RETURNING id, username, created_at;


-- name: GetUser :one
SELECT id, username, created_at
FROM users
WHERE id = $1;


-- name: ListUsers :many
SELECT id, username,  created_at
FROM users
ORDER BY created_at, id;


-- name: UpdateUser :one
UPDATE users
SET username = $2
WHERE id = $1
RETURNING id, username, created_at;


-- name: DeleteUser :exec
DELETE FROM users
WHERE id = $1;