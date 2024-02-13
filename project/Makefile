name = inception

all: make_dirs
	@printf "Building configuration ${name}...\n"
	# '-f' use compose file at the address
	@docker-compose -f srcs/docker-compose.yml --env-file srcs/.env up -d


make_dirs:
	@sh srcs/requirements/tools/make_dir.sh
	@sh srcs/requirements/nginx/tools/key_gen.sh
	# @sleep 1

mariadb: 
	@printf "Building Mariadb only ${name}...\n"
	@docker-compose -f srcs/docker-compose.yml up --env-file srcs/.env -d --no-deps mariadb

mariadb_check:
	@docker exec -it mariadb mysql -u root

down:
	@printf "Stopping configuration ${name}...\n"
	@docker-compose -f srcs/docker-compose.yml --env-file srcs/.env down

re:	down
	@printf "Rebuild configuration ${name}...\n"
	@docker-compose -f srcs/docker-compose.yml --env-file srcs/.env up -d --build

clean: down
	@printf "Cleaning configuration ${name}...\n"
	#all stoped containers and unused images removed 
	@docker system prune -a

fclean:
	@printf "Total clean of all configurations docker\n"
	@docker stop $$(docker ps -qa)
	@docker system prune --all --force --volumes
	@docker network prune --force
	@docker volume prune --force
	@rm -rf srcs/requirements/nginx/tools/*.key
	@rm -rf srcs/requirements/nginx/tools/*.crt