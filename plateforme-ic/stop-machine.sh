#!/bin/bash

# On arrête tous les containers de l'environnement
docker-compose down

# On supprime les anciens répertoires
if [ -d ./data_jenkins_home_save_old ]; then
    rm -rf ./data_jenkins_home_save_old
fi
if [ -d ./data_mongo_save_old ]; then
    rm -rf ./data_mongo_save_old
fi

# On renomme les répertoires de données courants en anciens répertoires
if [ -d ./data_jenkins_home_save ]; then
    mv ./data_jenkins_home_save ./data_jenkins_home_save_old
fi
if [ -d ./data_mongo_save ]; then
    mv ./data_mongo_save ./data_mongo_save_old
fi

# On sauvegarde les données de l'environnement
docker-machine scp -r default:/data/jenkins_home .
docker-machine scp -r default:/data/mongo .

mv ./jenkins_home ./data_jenkins_home_save
mv ./mongo ./data_mongo_save

docker-machine stop default