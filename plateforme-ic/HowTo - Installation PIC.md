# Procédure installation PIC en environnement PROD

## Installation de Gitlab <image src="./logos/gitlab.png" width="32">
TODO

## Installation de Redmine <image src="./logos/redmine.png" width="32">
TODO

## Installation de Rocket.chat <image src="./logos/rocket.png" width="32">
TODO

## Installation de SonarQube <image src="./logos/sonar.png" width="32">
### Références :

- [Pré-requis](https://docs.sonarqube.org/display/SONAR/Requirements)
- [Sécurisation derrière un proxy](https://docs.sonarqube.org/display/SONAR/Securing+the+Server+Behind+a+Proxy)
    
### Installation des plugins
`-> Administration -> System -> Update Center`

Installer les plugins suivants :
- "C#"
- "SonarJS"
- "SonarJava"
- "SonarPHP"
- "SonarPython"
- "LDAP"
        
### Configuration de l'authentification LDAP
    -> https://docs.sonarqube.org/display/PLUG/LDAP+Plugin
    -> Plusieurs serveurs LDAP : https://docs.sonarqube.org/display/PLUG/Multiple+Servers


## Installation de Nexus <image src="./logos/nexus.png" width="32">
### Références

- [Pré-requis](https://help.sonatype.com/display/HSC/System+Requirements+-+NXRM+3)

TODO
    
## Installation de Jenkins <image src="./logos/jenkins.png" width="32">
### Références :

- [Installer Jenkins (éléments de sizing)](https://jenkins.io/doc/book/getting-started/installing/)
- [Scaling Jenkins](https://jenkins.io/doc/book/architecting-for-scale/)
- [Sécurisation derrière un proxy](https://wiki.jenkins.io/display/JENKINS/Running+Jenkins+behind+Apache)

### Installation 
- Installer les plugins suggérés
- Créer un compte administrateur
    
### Installation des plugins
`-> Administrer Jenkins -> Gestion des plugins -> Onglet "disponibles"`

Installer les plugins suivants :
- "Blue Ocean"
- "RocketChat Notifier"
- "Pipeline Maven Integration Plugin"
- "Pipeline NPM Integration Plugin"
- "NodeJS Plugin"
- "SonarQube Scanner for Jenkins"
- "Gitlab Plugin"
- "Gitlab Authentication Plugin"             => Si Authentification via Gitlab => Possibilité de gérer les droits également de cette manière (A VOIR)
- "Role-based Authorization Strategy"
- "Xvfb plugin" (TIBCO 5)
- "Active Directory plugin"
    
    ACTIVATION DE LA GESTION DES ROLES
    -> Administrer Jenkins -> Configurer le système
    
    CONFIGURATION DES OUTILS
    -> Administrer Jenkins -> Configurer le système
        - Global Config user.name Value : Jenkins
        - Global Config user.email Value : jenkins@apave.com
    -> Administrer Jenkins -> Configuration globale des outils
        - JDK -> Ajouter JDK 
            Nom : jdk8
            Install automatically : OUI / Ou installer manuellement la bonne version
        - SonarQube Scanner -> Ajouter SonarQube Scanner
            Name : sonar
            Install automatically : OUI / Ou installer manuellement la bonne version
        - Maven -> Ajouter Maven
            Nom : M3
            Install automatically : OUI / Ou installer manuellement la bonne version
        - NodeJS -> Ajouter NodeJS
            Nom : nodejs
            Install automatically : OUI / Ou installer manuellement la bonne version
        Enregister

---------- Configuration de Nexus dans Jenkins
    - Jenkins
        -> Administrer Jenkins -> Configuration files -> Add a new Config -> "Global Maven settings.xml"
        ID : globalMaven
        Submit
            Name : globalMaven
            -> Server Credentials
            Ajouter
                ServerId: releases
                Credentials: 
                    -> Ajouter -> Jenkins
                        Nom d'utilisateur : <NexusUser>
                        Mot de passe : <NexusUserPwd>
                        ID : Nexus
                        Description : Nexus
                Credentials : Nexus
            Ajouter
                ServerId: snapshots
                Credentials: Nexus        
                    
            Submit

---------- Configuration de NPM dans Jenkins
    - Jenkins
        -> Administrer Jenkins -> Configuration Files -> Add New Config -> "Fichier Npm de configuration"
        ID : npmrc
        Submit
            Name: npmrc
            -> NPM Registry -> "Ajouter"
                URL: http://srv0270a.apave.grp:8081/repository/apave-web-snapshots/ (Nexus URL)
                Credentials : Nexus
                
                Content :
                    AJOUTER EN FIN DE Fichier
                        registry=http://srv0270a.apave.grp:8081/repository/apave-web-snapshots/
                        _auth=YWRtaW46YWRtaW4xMjM=                                                      => echo -n 'admin:admin123' | openssl base64 où <admin = user nexus> & <admin123 = pwd user nexus>
                        user=admin                                                                      => utilisateur Nexus
                        email=admin@admin.com
                Submit
        
---------- Configuration de Rocket.Chat dans Jenkins
    - Rocket.Chat
        -> Administration -> Integrations -> Nouvelle intégration -> Webhook entrant
            Activé : Oui
            Nom : Jenkins
            Publié en tant que : jenkins (un utilisateur de service)
            Alias : Jenkins
            
            Save
            COPIER  "Webhook URL"
    - Jenkins
        -> Administrer Jenkins -> Configurer le système -> "Global RocketChat Notifier Settings"
            Endpoint : url de Rocket.Chat
            Channel : 
            Icon to use : https://wiki.jenkins-ci.org/download/attachments/2916393/headshot.png?version=1&modificationDate=1302753947000&api=v2
            Build Server URL : <Valeur par défaut>
            
        Enregistrer
        
---------- Configuration de SonarQube dans Jenkins
    - SonarQube
        Login en tant qu'administrateur
        -> Administrator -> My Account -> Security
            Generate New Token : Jenkins
            Generate
            COPIER LE TOKEN GENERE
            
    - Jenkins
        -> Administrer Jenkins -> Configurer le système -> SonarQube servers
            Ajouter une installation SonarQube
                Nom : SonarApave
                URL du serveur : http://srv0270a.apave.grp:9009 (Sonar URL)
                Server authentication token : VALEUR DU TOKEN COPIE DANS SonarQube
        Enregistrer

---------- Configuration du noeud TIBCO dans Jenkins
    - Jenkins
        -> Administrer Jenkins -> Gérer les noeuds -> Créer un noeud
            Nom du noeud : tibco
            Permanent agent : oui
            OK
            
            Description : TIBCO Dev
            Répertoire de travail : /APPLI/dev/tibco/temp_jenkins           (Répertoire à créer sur la plateforme de dev TIBCO)
            Méthode de lancement : Launch slave agents via SSH
                Host : <nom_serveur_dev_tibco>
                Credentials : user/password serveur de dev tibco
                Host Key Verification Strategy : Non verifyin Verification Strategy
            Disponibilité : Take this agent online when in demand, and offline when idle
                Délai d'attente lors d'une demande : 0
                Délai d'inactivité : 2
            Enregistrer
            
        -> TIBCO 5 : Installer Xvfb (yum install xorg-X11-server-Xvfb) sur l'environnement de dev TIBCO
        -> Installer git sur l'environnement de dev TIBCO

---------- Configuration de l'authentification Jenkins via GitLab OAuth
    - GitLab
        -> Admin area -> Applications
            Name : Authentication Jenkins
            Redirect URI : http://srv0270a.apave.grp:8092/securityRealm/finishLogin (http://srv0270a.apave.grp:8092 = Jenkins URL)
            
            Submit
            
            COPIER "Application Id" ET "Secret"
    
    - Jenkins
        -> Administrer Jenkins -> Configurer la sécurité globale -> Royaume de la sécurité (Realm)
            Cocher "Gitlab Authentication Plugin"
            Gitlab Web URI : http://srv0270a.apave.grp:1212 (GitLab URL)
            Gitlab API URI : http://srv0270a.apave.grp:1212 (GitLab URL)
            Client ID : "Application Id" copié précédemment
            Client Secret : "Secret" copié précédemment
            
            
---------- Configuration de Jenkins pour build onPush dans GitLab    =>     VERIFIER QUE C'EST BIEN NECESSAIRE
    - GitLab :
        Se connecter en tant qu'administrateur
        -> Profile Settings -> Account
        COPIER "Private token"
    
    - Jenkins
        -> Administrer Jenkins -> Configurer le système -> Gitlab
            Connection name : Build on Push
            Gitlab host URL : http://srv0270a.apave.grp:1212    (GitLab URL)
            Credentials :
                Ajouter -> Jenkins
                    Type : GitLab API Token
                    Portée : Global
                    API token : "Private token" copié précédemment
                    ID : GitlabAdmin
                    Description : GiLab Admin
            
        Enregistrer
       
---------- Configuration de l'authentification Rocket.Chat via LDAP
    - Rocket.Chat
        -> Administration -> LDAP 
            Activer : Oui
            Login Fallback : OUI
            Hôte : <adresse LDAP>
            Port : 389
            Domaine de base : dc=apave,dc=grp
            Utilisateur pour la recherche dans le domaine : <Utilisateur compte de service>
            Mot de passe pour la recherche dans le domaine : <Mot de passe compte de service>
            Catégorie d'objet pour la recherche dans le domaine : CN=Person,CN=Schema,CN=Configuration,DC=apave,DC=grp
            Champs du nom d'utilisateur : name

---------- Installation de Redmine
    - Theme Circle (https://www.redmineup.com/pages/fr/themes/circle) 
        -> Copier/coller dans $redmine$/public/theme
        -> Dézipper dans le même répertoire
        
    PLUGINS (Attention aux noms de répertoires de déploiement des plugins !)
    - Plugin Agile (https://www.redmineup.com/pages/plugins/agile/installation)
    - Plugin Messenger (https://github.com/alphanodes/redmine_messenger#installation)
    - Plugin Gitlab Hook (https://github.com/phlegx/redmine_gitlab_hook)


    
---------- Configuration du plugin Messenger Redmine
    - Rocket.Chat 
        -> Administration -> Intégrations -> Nouvelle intégration -> Webhook entrant
            Activé : OUI
            Nom : Redmine
            publié sur le canal : #general
            publié en tant que : rocket.cat
            Alias : Redmine
            URL de l'avatar : https://raw.githubusercontent.com/sciyoshi/redmine-slack/gh-pages/icon.png
            
            SAUVEGARDER LES MODIFICATIONS
            COPIER LE LIEN dans "Webhook URL"
    
    - Redmine 
        -> Administration -> Plugins -> Redmine Messenger / Configurer
            Messenger URL : URL COPIE PRECEDEMMENT
            Messenger icon : https://raw.githubusercontent.com/sciyoshi/redmine-slack/gh-pages/icon.png
            Messenger channel : general
            Messenger username : Redmine
            
            Cocher toutes les cases de notification
            
    A NOTER : POUR CHANGER LE CHANNEL PAR PROJET, dans chaque projet :
        -> Configuration -> Messenger
            Messenger Channel : <Nom du chan à utiliser>
      
RAF :
    OK - Gestion des droits dans Jenkins via l'authentification GitLab ???
    
    - Politique de stockage des artefacts en snapshots pour ne pas stocker un fichier à chaque post
    - Gestion du <distributionManagement> dans un pom parent pour tous
    
    - Pousser dans Nexus une application Angular2
    
    - Gestion des repositories et du mirroring dans Nexus
    
    

---------- A la création d'un projet dans GitLab pour bénéficier du build on push
    -> Settings -> Integrations
        URL : http://srv0270a.apave.grp:8092/project/{NOM_PROJET}
        Push Events : OUI
        Enable SSL Verification : NON
        
        Add Webhook

---------- Initialisation d'un projet dans Redmine
    -> Création du projet
    -> Descendre le repo git en mode mirror dans le répert
        
        
---------- Utilisation de l'API REST de Redmine 
    -> Pour connaitre toutes les routes disponibles 
        RAILS_ENV=production rake routes
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
A SUPPRIMER
Dans la partie <profiles>, ajouter les descriptions des serveurs
    <profile>
      <id>jenkins</id>
      <repositories>
        <repository>
          <id>snapshots</id>
          <name>Repository Apave Snapshots</name>
          <url>http://srv0270a.apave.grp:8081/repository/maven-snapshots/</url>
        </repository>
        <repository>
          <id>releases</id>
          <name>Repository Apave Release</name>
          <url>http://srv0270a.apave.grp:8081/repository/maven-releases/</url>
        </repository>
      </repositories>
    </profile>
Juste avant la fin du fichier (avant </settings>), ajouter :
    <activeProfiles>
        <activeProfile>jenkins</activeProfile>
    </activeProfiles>