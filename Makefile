NAME	=	inception

all:	up

up:
		docker compose -f srcs/docker-compose.yml up -d --build --progress=tty

down:
		docker compose -f srcs/docker-compose.yml down

logs:
		docker compose -f srcs/docker-compose.yml logs -f

ps:
		docker compose -f srcs/docker-compose.yml ps

clean:	down
		docker system prune -af --volumes

fclean: clean
		@docker volume rm $$(docker volume ls -q) || true
		@docker network rm $$(docker network ls -q) 2>/dev/null || true
		@sudo rm -rf /home/itsmeachraf/data/mariadb/*
		@sudo rm -rf /home/itsmeachraf/data/wordpress/*
		@sudo rm -rf /home/itsmeachraf/data/portainer/*

restart:	down up
re:			fclean all
