#!/bin/bash
docker-machine start default

# On recrée l'arborescence de l'environnement
docker-machine ssh default "sudo mkdir /data"
docker-machine ssh default "sudo chmod -R 777 /data"

# On restaure les données de l'environnement
docker-machine scp -r ./data_jenkins_home_save default:/data
docker-machine scp -r ./data_mongo_save default:/data
docker-machine ssh default "sudo mv /data/data_jenkins_home_save /data/jenkins_home"
docker-machine ssh default "sudo mv /data/data_mongo_save /data/mongo"

# On remet les bonnes autorisations
docker-machine ssh default "sudo chmod -R 777 /data/jenkins_home"
docker-machine ssh default "sudo chmod -R 777 /data/mongo"

docker-compose up -d