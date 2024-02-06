name = inception

all:
	@printf "Launch configuration ${name}...\n"
	# '-f' use compose file at the address
	@docker-compose -f srcs/docker-compose.yml up -d

build:
	@printf "Building configuration ${name}...\n"
	@docker-compose -f srcs/docker-compose.yml up -d --build

mariadb: 
	@printf "Building Mariadb only ${name}...\n"
	@docker-compose -f srcs/docker-compose.yml up -d --no-deps mariadb

mariadb_check:
	@docker exec -it mariadb mysql -u root

down:
	@printf "Stopping configuration ${name}...\n"
	@docker-compose -f srcs/docker-compose.yml down

re:	down
	@printf "Rebuild configuration ${name}...\n"
	@docker-compose -f srcs/docker-compose.yml up -d --build

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