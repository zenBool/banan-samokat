# A Makefile can help automate common tasks like building images, running containers, and cleaning up

# Variables
DOCKER_COMPOSE=docker compose

# Default target
.PHONY: help
help:
	@echo "Available targets:"
	@echo "  build       Build all Docker images"
	@echo "  up          Start all services"
	@echo "  down        Stop all services"
	@echo "  migrate     Run database migrations"
	@echo "  logs        Show logs from all services"
	@echo "  clean       Remove Docker images"

.PHONY: build
build:
	./scripts/pre-build.sh
	$(DOCKER_COMPOSE) build

.PHONY: up
up:
	$(DOCKER_COMPOSE) up -d

.PHONY: down
down:
	$(DOCKER_COMPOSE) down

.PHONY: restart
restart:
	$(DOCKER_COMPOSE) restart

#.PHONY: migrate
#migrate:
#	./scripts/migrate.sh

.PHONY: logs
logs:
	$(DOCKER_COMPOSE) logs -f

.PHONY: clean
clean:
	$(DOCKER_COMPOSE) down --rmi local
