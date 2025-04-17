# Makefile for managing Docker Compose services

COMPOSE_FILE = .dev/docker-compose.postgres.yaml

.PHONY: up down logs restart ps upgrade

up:
	@echo "Starting Docker Compose services..."
	docker-compose -f $(COMPOSE_FILE) up -d
	@echo "Waiting for services to initialize..."
	@sleep 3
	@echo "N8N is available at:"
	@echo "http://localhost:5678"

down:
	@echo "Stopping Docker Compose services..."
	docker-compose -f $(COMPOSE_FILE) down

logs:
	@echo "Following logs for Docker Compose services..."
	docker-compose -f $(COMPOSE_FILE) logs -f

restart:
	@echo "Restarting Docker Compose services..."
	$(MAKE) down
	$(MAKE) up

ps:
	@echo "Listing Docker Compose services..."
	docker-compose -f $(COMPOSE_FILE) ps

upgrade:
	@echo "Pulling latest images..."
	docker-compose -f $(COMPOSE_FILE) pull
	@echo "Stopping and removing old containers..."
	$(MAKE) down
	@echo "Starting containers with new images..."
	$(MAKE) up
