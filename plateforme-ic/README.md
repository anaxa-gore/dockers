# Plateforme IC

Plateforme IC permet de monter rapidement un environnement d'intégration continue intégrant :
- Jenkins
- Nexus
- SonarQube
- Rocket.chat

**Le projet a été conçu pour être utilisé sous Windows 7, avec les utilitaires 
[Docker Toolbox](https://www.docker.com/products/docker-toolbox).** 

Pour démarrer :
- Positionner dans le fichier `.env` les répertoires dans lequel seront stockées les données :
    - `ROOT_DATA` : Le répertoire sur la VM dans lequel stocker les données de Jenkins et Rocket.chat (non compatible avec
       le partage de répertoire entre la machine Windows host et la machine virtuelle hébergeant les conteneurs)
    - `ROOT_SHARED_DATA` : Le répertoire sur la machine Windows host dans lequel seront stockées les autres données.
- Lancer le script `start_machine.sh` dans le *Docker Quickstart Terminal* pour démarrer la VM, monter l'environnement 
  et restaurer les données d'une éventuelle session précédente (Jenkins & Rocket.chat) 
- Lancer le script `stop_machine.sh` dans le *Docker Quickstart Terminal* pour sauvegarder les données de la session,
  démonter l'environnement et arrêter la VM 

