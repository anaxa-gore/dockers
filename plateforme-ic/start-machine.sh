#!/bin/bash
docker-machine start default

# On recrée l'arborescence de l'environnement
docker-machine ssh default "sudo mkdir /data"
docker-machine ssh default "sudo chmod -R 777 /data"

# On restaure les données de l'environnement & on remet les bonnes autorisations
if [ -f ./data_jenkins.tar.gz ]; then
    docker-machine scp ./data_jenkins.tar.gz default:/data
    docker-machine ssh default "sudo tar xzf /data/data_jenkins.tar.gz -C /data"
    docker-machine ssh default "sudo chmod -R 777 /data/jenkins_home"
fi
if [ -f ./data_mongo.tar.gz ]; then
    docker-machine scp ./data_mongo.tar.gz default:/data
    docker-machine ssh default "sudo tar xzf /data/data_mongo.tar.gz -C /data"
    docker-machine ssh default "sudo chmod -R 777 /data/mongo"
fi

docker-compose up -d