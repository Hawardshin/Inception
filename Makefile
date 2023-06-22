name = inception

all:
	@printf "Launch configuration ${name}...\n"
	@bash srcs/requirements/wordpress/tools/make_dir.sh
	@docker compose -f ./srcs/docker-compose.yml --env-file ./srcs/.env up -d

build:
	@printf "Building configuration ${name}...\n"
	@bash srcs/requirements/wordpress/tools/make_dir.sh
	@docker compose -f ./srcs/docker-compose.yml --env-file ./srcs/.env up -d --build

down:
	@printf "Stopping configuration ${name}...\n"
	@docker compose -f ./srcs/docker-compose.yml --env-file ./srcs/.env down

re: fclean
	@printf "Rebuild configuration ${name}...\n"
	@docker compose -f ./srcs/docker-compose.yml --env-file ./srcs/.env up -d --build

clean: down
	@printf "Cleaning configuration ${name}...\n"
	@docker system prune -a
	@sudo rm -rf ~/data/wordpress/*
	@sudo rm -rf ~/data/mariadb/*

fclean:
	@printf "Total clean of all configurations docker\n"
	@docker compose -f ./srcs/docker-compose.yml --env-file ./srcs/.env down
	#@docker stop $$(docker ps -qa)
	@docker system prune --volumes
	@docker network prune
	@docker volume prune -a
	@docker image prune -a
	@docker system prune -a

.PHONY	: all build down re clean fclean
