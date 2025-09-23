# ============================================================================ #
#                                  VARIABLES                                   #
# ============================================================================ #

NAME			= inception

DATA_DIR		= /home/itsmeachraf/data
COMPOSE_FILE	= srcs/docker-compose.yml

RESET			= \033[0m
RED				= \033[0;31m
GREEN			= \033[0;32m
YELLOW			= \033[0;33m
BLUE			= \033[0;34m
MAGENTA			= \033[0;35m
CYAN			= \033[0;36m

ECHO			= echo -e

all: banner up

# ============================================================================ #
#                                 DOCKER COMMANDS                              #
# ============================================================================ #

## Start all containers
up: banner-up
	@$(ECHO) "$(CYAN)🚀 Starting $(NAME) containers...$(RESET)"
	@docker compose -f $(COMPOSE_FILE) up -d --build
	@$(ECHO) "$(GREEN)✅ $(NAME) containers started successfully!$(RESET)"

## Stop all containers
down: banner-down
	@$(ECHO) "$(YELLOW)🛑 Stopping $(NAME) containers...$(RESET)"
	@docker compose -f $(COMPOSE_FILE) down
	@$(ECHO) "$(GREEN)✅ $(NAME) containers stopped successfully!$(RESET)"

## Show container logs
logs:
	@$(ECHO) "$(BLUE)📋 Showing logs for $(NAME) containers...$(RESET)"
	@docker compose -f $(COMPOSE_FILE) logs -f

## Show container status
ps:
	@$(ECHO) "$(MAGENTA)📊 Container status for $(NAME):$(RESET)"
	@docker compose -f $(COMPOSE_FILE) ps

## Clean system (stop containers + prune)
clean: banner-clean
	@$(ECHO) "$(YELLOW)🧹 Cleaning Docker system...$(RESET)"
	@docker compose -f $(COMPOSE_FILE) down
	@docker system prune -af --volumes
	@$(ECHO) "$(GREEN)✅ Docker system cleaned!$(RESET)"

## Full clean (everything including volumes and data)
fclean: banner-fclean
	@$(ECHO) "$(RED)💥 Nuclear cleanup initiated...$(RESET)"
	@docker compose -f $(COMPOSE_FILE) down
	@$(ECHO) "$(YELLOW)Removing volumes...$(RESET)"
	@docker volume rm $$(docker volume ls -q) 2>/dev/null || true
	@$(ECHO) "$(YELLOW)Removing networks...$(RESET)"
	@docker network rm $$(docker network ls -q) 2>/dev/null || true
	@$(ECHO) "$(YELLOW)Cleaning data directories...$(RESET)"
	@sudo rm -rf $(DATA_DIR)/mariadb/*
	@sudo rm -rf $(DATA_DIR)/wordpress/*
	@sudo rm -rf $(DATA_DIR)/portainer/*
	@$(ECHO) "$(GREEN)✅ Full cleanup completed!$(RESET)"

## Restart containers
restart: down up
	@$(ECHO) "$(GREEN)🔄 Restart completed!$(RESET)"

## Rebuild from scratch
re: fclean all
	@$(ECHO) "$(GREEN)♻️  Complete rebuild finished!$(RESET)"

# ============================================================================ #
#                                 UTILITIES                                    #
# ============================================================================ #

## Show this help message
help:
	@$(ECHO) "$(CYAN)"
	@$(ECHO) "╔══════════════════════════════════════════════════════════════╗"
	@$(ECHO) "║                     $(NAME) - Makefile Help                  ║"
	@$(ECHO) "╚══════════════════════════════════════════════════════════════╝"
	@$(ECHO) "$(RESET)"
	@$(ECHO) "$(YELLOW)Available targets:$(RESET)"
	@$(ECHO) ""
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "  $(GREEN)%-15s$(RESET) %s\n", $$1, $$2}' $(MAKEFILE_LIST)
	@$(ECHO) ""

## Display project banner
banner:
	@$(ECHO) "$(CYAN)"
	@$(ECHO) "╔══════════════════════════════════════════════════════════════╗"
	@$(ECHO) "║                        $(NAME)                             ║"
	@$(ECHO) "║                    Docker Environment                        ║"
	@$(ECHO) "╚══════════════════════════════════════════════════════════════╝"
	@$(ECHO) "$(RESET)"

banner-up:
	@$(ECHO) "$(GREEN)"
	@$(ECHO) "╔══════════════════════════════════════════════════════════════╗"
	@$(ECHO) "║                       STARTING CONTAINERS                    ║"
	@$(ECHO) "╚══════════════════════════════════════════════════════════════╝"
	@$(ECHO) "$(RESET)"

banner-down:
	@$(ECHO) "$(YELLOW)"
	@$(ECHO) "╔══════════════════════════════════════════════════════════════╗"
	@$(ECHO) "║                       STOPPING CONTAINERS                    ║"
	@$(ECHO) "╚══════════════════════════════════════════════════════════════╝"
	@$(ECHO) "$(RESET)"

banner-clean:
	@$(ECHO) "$(BLUE)"
	@$(ECHO) "╔══════════════════════════════════════════════════════════════╗"
	@$(ECHO) "║                         CLEANING SYSTEM                      ║"
	@$(ECHO) "╚══════════════════════════════════════════════════════════════╝"
	@$(ECHO) "$(RESET)"

banner-fclean:
	@$(ECHO) "$(RED)"
	@$(ECHO) "╔══════════════════════════════════════════════════════════════╗"
	@$(ECHO) "║                        FULL CLEANUP                          ║"
	@$(ECHO) "╚══════════════════════════════════════════════════════════════╝"
	@$(ECHO) "$(RESET)"

# ============================================================================ #
#                                 PHONY TARGETS                                #
# ============================================================================ #

.PHONY: all up down logs ps clean fclean restart re help banner \
		banner-up banner-down banner-clean banner-fclean