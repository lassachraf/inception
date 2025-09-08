# Project name
NAME		= inception

# Docker Compose command with config file
COMPOSE		= docker compose -f ./srcs/docker-compose.yml

# Environment file
ENV_FILE	= ./srcs/.env

# Default target: build and start all containers in detached mode
all:		up

# Build the images without cache
build:
			@$(COMPOSE) --env-file $(ENV_FILE) build --no-cache

# Start all containers in detached mode
up:		
			@$(COMPOSE) --env-file $(ENV_FILE) up --detach

# Stop and remove all containers, networks, and volumes
down:
			@$(COMPOSE) --env-file $(ENV_FILE) down

# Stop all containers without removing them
stop:
			@$(COMPOSE) --env-file $(ENV_FILE) stop

# Start stopped containers
start:
			@$(COMPOSE) --env-file $(ENV_FILE) start

# Show container status
ps:
			@$(COMPOSE) --env-file $(ENV_FILE) ps

# Show logs from all containers
logs:
			@$(COMPOSE) --env-file $(ENV_FILE) logs

# Follow logs from all containers
logs-f:
			@$(COMPOSE) --env-file $(ENV_FILE) logs --follow

# Remove all containers, networks, volumes, and images
clean:		down
			@docker system prune -a --force

# Remove all volumes (warning: will delete all data)
fclean:		clean
			@docker volume prune --force

# Rebuild everything from scratch
re:			fclean all

# Check if .env file exists
$(ENV_FILE):
			@echo "ERROR: .env file not found at $(ENV_FILE)"
			@echo "Create it based on the .env.example template"
			@exit 1

# Prevent make from confusing with files of the same name
.PHONY:		all build up down stop start ps logs logs-f clean fclean re
