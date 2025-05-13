.PHONY: start_mysql stop_mysql start_pgsql stop_pgsql

start_mysql:
	@echo "Running Mysql Server"
	@docker compose -f ./mysql/docker-compose.yaml up -d

stop_mysql:
	@echo "Stopping Mysql Server"
	@docker compose -f ./mysql/docker-compose.yaml down

start_pgsql:
	@echo "Running Postgres Server"
	@docker compose -f ./postgresql/docker-compose.yaml up -d

stop_pgsql:
	@echo "Stopping Postgres Server"
	@docker compose -f ./postgresql/docker-compose.yaml down