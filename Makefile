run-server:
	go run main.go

createdb:
	docker exec -it postgres15 createdb --username=root --owner=root simple_bank

dropdb:
	docker exec -it postgres15 dropdb simple_bank

postgres:
	docker run --name postgres15 -p 5432:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=12345678 -d postgres:15-alpine

migrateup:
	migrate -path db/migration -database "postgresql://root:12345678@localhost:5432/simple_bank?sslmode=disable" -verbose up

migratedown:
	migrate -path db/migration -database "postgresql://root:12345678@localhost:5432/simple_bank?sslmode=disable" -verbose down

sqlc:
	sqlc generate
test:
	go test -v -cover ./db/sqlc

.PHONY: postgres createdb dropdb migrateup migratedown sqlc test