#!/bin/bash

docker swarm leave --force

docker swarm status
docker ps
docker image ls
docker container ls
docker volume ls

sudo mkdir /etc/portainer
cd /etc/portainer/

sudo nano docker-compose.yml
sudo docker compose up --pull always --force-recreate -d --timestamps