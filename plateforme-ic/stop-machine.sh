#!/bin/bash

# On arrête tous les containers de l'environnement
docker-compose down

# On supprime les anciens packages
if [ -f ./data_jenkins.old.tar.gz ]; then
    rm -f ./data_jenkins.old.tar.gz
fi
if [ -f ./data_mongo.old.tar.gz ]; then
    rm -f ./data_mongo.old.tar.gz
fi

# On renomme les packages courants en anciens
if [ -f ./data_jenkins.tar.gz ]; then
    mv ./data_jenkins.tar.gz ./data_jenkins.old.tar.gz
fi
if [ -f ./data_mongo.tar.gz ]; then
    mv ./data_mongo.tar.gz ./data_mongo.old.tar.gz
fi

# On sauvegarde les données de l'environnement
docker-machine ssh default "cd /data && sudo tar czf /data/data_jenkins.tar.gz jenkins_home/"
docker-machine ssh default "cd /data && tar czf /data/data_mongo.tar.gz mongo/"

docker-machine scp default:/data/data_jenkins.tar.gz .
docker-machine scp default:/data/data_mongo.tar.gz .

docker-machine stop default