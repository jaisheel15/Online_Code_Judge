DATABASE_URL := "postgres://admin:admin@localhost:5432/oj?sslmode=disable"
migrations_path := "backend/services/api/db/migrations"
sqlc_config := "backend/services/api/sqlc.yaml"

migrate-up:
    goose -dir {{migrations_path}} postgres {{DATABASE_URL}} up

migrate-down:
    goose -dir {{migrations_path}} postgres {{DATABASE_URL}} down

migrate-reset:
    goose -dir {{migrations_path}} postgres {{DATABASE_URL}} down-to 0
    goose -dir {{migrations_path}} postgres {{DATABASE_URL}} up

generate:
    sqlc generate -f {{sqlc_config}}

run-api:
    cd backend && go run ./services/api/cmd/main.go