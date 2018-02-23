# Procédure installation PIC en environnement PROD

## Installation de Gitlab <image src="./logos/gitlab.png" width="32">
@TODO

## Installation de Redmine <image src="./logos/redmine.png" width="32">
@TODO
- Installation du thème [Circle](https://www.redmineup.com/pages/fr/themes/circle)
- Installation du plugin [Agile](https://www.redmineup.com/pages/fr/plugins/agile)
- Installation du plugin [LDAP](http://www.redmine.org/plugins/redmine_ldap_sync)
- Installation du plugin [Localizable](https://redmine.ociotec.com/projects/localizable) ???

## Installation de Rocket.chat <image src="./logos/rocket.png" width="32">
### Références

- [Pré-requis](https://rocket.chat/docs/installation/minimum-requirements)
- [Une installation très complète & un peu complexe](http://www.akitaonrails.com/2016/08/09/moving-away-from-slack-into-rocket-chat-good-enough)

### Outils annexes

- Installer `graphicsmagick` sur la machine portant Rocket.Chat

### Paramètres des comptes
`-> Administration -> Comptes`
- Autoriser la lecture anonyme : **Non**
- Autoriser l'écriture anonyme : **Non**
- Autoriser les utilisateurs à supprimer leur propre compte : **Non**
- Autoriser la modification de profil : **Oui**
- Autoriser le changement d'avatar : **Oui**
- Autoriser le changement de nom d'utilisateur : **Non**
- Autoriser le changement d'adresse e-mail : **Non**
- Autoriser le changement de mot de passe : **Non**

### Paramètres généraux
`-> Administration -> Général`

Vérifier que la valeur soit correcte sur :
- URL du site : **adresse + port d'exposition du service Rocket.chat**

### Paramètres LDAP
`-> Administration -> LDAP`
- Activer : **Oui**
- Login Fallback : **Oui**
- Hôte : **Adresse du LDAP**
- Port : **Port du LDAP** (389)
- Chiffrement : **Pas de chiffrement**
- Domaine de base : **dc=dc,dc=grp**
- Utiliser la recherche personnalisée dans le domaine : **Non**
- Utilisateur pour la recherche dans le domaine : **compte de service**
- Mot de passe pour la recherche dans le domaine : **mot de passe du compte de service**
- Activer le filtre des utilisateurs sur un groupe LDAP : **Non**
- ID de l'utilisateur pour la recherche dans le domaine : **sAMAccountName**
- Classe d'objet pour la recherche dans le domaine : **user**
- Catégorie d'objet pour la recherche dans le domaine : **CN=Person,CN=Schema,CN=Configuration,DC=dc,DC=grp**
- Champ du nom d'utilisateur : **cn** (ou autre ?)
- Champ de l'identifiant unique : **objectGUID**
- Synchronisation des données : **Oui**
- Synchronisation de l'avatar utilisateur : **Oui**
- Domaine par défaut : **dc.grp**
- Fusionner les utilisateurs existants : **Non**
- Importer les utilisateurs LDAP : **Non** si les utilisateurs sont importés à la première connexion.

### Configuration de l'authentification LDAP
`-> Administration -> LDAP `
- Activer : **Oui**
- Login Fallback : **OUI**
- Hôte : **adresse LDAP**
- Port : **389**
- Domaine de base : **dc=dc,dc=grp**
- Utilisateur pour la recherche dans le domaine : **Utilisateur compte de service>**
- Mot de passe pour la recherche dans le domaine : **Mot de passe compte de service>**
- Catégorie d'objet pour la recherche dans le domaine : **CN=Person,CN=Schema,CN=Configuration,DC=dc,DC=grp**
- Champs du nom d'utilisateur : **name**

## Installation de SonarQube <image src="./logos/sonar.png" width="32">

Le paramétrage décrit ci-après autorise tous les utilisateurs à voir les rapports sur projets sans aucun droits
particulier.

### Références

- [Pré-requis](https://docs.sonarqube.org/display/SONAR/Requirements)
- [Installation](https://help.sonatype.com/display/HSC/Installation+-+NXRM+3)
- [Sécurisation derrière un proxy](https://docs.sonarqube.org/display/SONAR/Securing+the+Server+Behind+a+Proxy)

### Installation des plugins
`-> Administration -> System -> Update Center`

Installer les plugins suivants :
- SonarC#
- SonarJS
- SonarTS
- SonarJava
- SonarPHP
- SonarPython
- Web
- CSS / SCSS / Less
- LDAP

### Configuration de l'authentification LDAP

- [Installation & Configuration](https://docs.sonarqube.org/display/PLUG/LDAP+Plugin)

Configurer un administrateur local

## Installation de Nexus <image src="./logos/nexus.png" width="32">
Dans la configuration exposée ci-dessous, les utilisateurs sont authentifiés à travers l'AD
d'entreprise. Les autorisations sont gérés via des groupes créés dans l'AD auxquels sont associés
des rôles dans NEXUS. Les groupes créés dans l'AD sont les suivants :
- GU-RES-PIC-ADMIN-GRP - auquel sont ajoutés les administrateurs de la PIC
- GU-RES-PIC-USERS-GRP - auquel sont ajoutés les utilisateurs de la PIC

### Références

- [Pré-requis](https://help.sonatype.com/display/HSC/System+Requirements+-+NXRM+3)
- [Eléments de sizing](http://blog.sonatype.com/2012/04/how-can-we-prove-that-nexus-can-scale/)

### Configuration de l'authentification LDAP
`Server administration and configuration -> Security -> LDAP -> Create Connection`
- Name : **Nom de la connection à créer** (arbitraire)
- LDAP server address : **ldap://adresse_de_l_AD:port_de_l_AD**
- LDAP Location : **dc=dc,dc=grp**
- Authentication mode : **Simple authentication**
- Username or DN : **Login et password du compte de service à utiliser**

`Next`

- User subtree : **True**
- Object class : **user**
- User ID attribute : **sAMAccountName**
- Real name attribute : **cn**
- Email attribute : **mail**
- Map LDAP groups as roles : **True**
- Group type : **Dynamic Groups**
- Group member of attribute : **memberOf**

`Create`

`Server administration and configuration -> Security -> Realms -> Create Connection`
- Ajouter `LDAP Realm` aux actifs

### Création des Rôles
On crée deux rôles, un pour les utilisateurs et un pour les administrateurs, correspondant auxquels
deux groupes de l'AD.

`Server administration and configuration -> Security -> Rôles`

`Create role`
- Role ID : **GU-RES-PIC-ADMIN-GRP** (nom du groupe des administrateurs dans l'AD)
- Role Name : **ADMIN**
- Role description :
- Privileges : **nx-all**

`Save`

`Create role`
- Role ID : **GU-RES-PIC-USERS-GRP** (nom du groupe des utilisateurs dans l'AD)
- Role Name : **USERS**
- Role description :
- Privileges : (aucun)

`Save`

### Configuration des repositories
Les repositories suivants sont configurés par défaut dans NEXUS et sont utilisés dans la configuration :
- *maven-central* - sert de proxy vers le répo MAVEN de référence.
- *maven-snapshots* - sert à collecter l'ensemble des artefacts MAVEN de l'entreprise (en mode snapshots)
- *maven-releases* - sert à collecter l'ensemble des artefacts MAVEN de l'entreprise (en mode releases)
- *maven-public* - sert de proxy vers les trois repositories précédemment cités pour avoir un seul point d'entrée. Utilisé par l'ensemble des projets de l'entreprise pour récupérer les dépendances.

---

Les repositories supplémentaires suivants sont ajoutés :

*maven-oracle-proxy* - sert de proxy vers le MAVEN d'oracle

`Server administration and configuration -> Repository -> Repositories -> Create repository -> maven2 (proxy)`
- Name : **maven-oracle-proxy**
- Online : **True**
- Version policy : **Release**
- Layout policy : **Strict**
- Remote storage : **https://maven.oracle.com**
- Use the Nexus truststore : **False**
- Blocked : **False**
- Auto blocking enabled : **True**
- Maximum component age : **-1**
- Maximum metadata age : **1440**
- Blob store : **default**
- Strict content type validation : **True**
- Not found cache enabled : **True**
- Not found cache TTL : **1440**
- Authentication : **True**
  - Authentication type : **Username**
  - Username : **\<compte oracle valide\>**
  - Paswword : **\<mot de passe du compte\>**
- HTTP Request settings : **True**
  - Enable circular redirect : **True**
  - Enable cookies : **True**

`Create repository`

*maven-oracle-bipub* - sert à héberger les librairies BI Publisher

`Server administration and configuration -> Repository -> Repositories -> Create repository -> maven2 (hosted)`
- Name : **maven-oracle-bipub**
- Online : **True**
- Version policy : **Release**
- Layout policy : **Strict**
- Blob store : **default**
- Strict content type validation : **False**
- Deployment policy : **Disable redeploy**

`Create repository`

*maven-esb-snapshots* - sert à héberger l'ensemble des artefacts MAVEN de l'ESB (en mode snapshots)

`Server administration and configuration -> Repository -> Repositories -> Create repository -> maven2 (hosted)`
- Name : **maven-esb-snapshots**
- Online : **True**
- Version policy : **Snapshot**
- Layout policy : **Strict**
- Blob store : **default**
- Strict content type validation : **False**
- Deployment policy : **Allow redeploy**

`Create repository`

*maven-esb-releases* - sert à héberger l'ensemble des artefacts MAVEN de l'ESB (en mode releases)

`Server administration and configuration -> Repository -> Repositories -> Create repository -> maven2 (hosted)`
- Name : **maven-esb-releases**
- Online : **True**
- Version policy : **Release**
- Layout policy : **Strict**
- Blob store : **default**
- Strict content type validation : **False**
- Deployment policy : **Disable redeploy**

`Create repository`

*maven-etl-snapshots* - sert à héberger l'ensemble des artefacts MAVEN de l'ETL (en mode snapshots)

`Server administration and configuration -> Repository -> Repositories -> Create repository -> maven2 (hosted)`
- Name : **maven-etl-snapshots**
- Online : **True**
- Version policy : **Snapshot**
- Layout policy : **Strict**
- Blob store : **default**
- Strict content type validation : **False**
- Deployment policy : **Allow redeploy**

`Create repository`

*maven-etl-releases* - sert à héberger l'ensemble des artefacts MAVEN de l'ETL (en mode releases)

`Server administration and configuration -> Repository -> Repositories -> Create repository -> maven2 (hosted)`
- Name : **maven-etl-releases**
- Online : **True**
- Version policy : **Release**
- Layout policy : **Strict**
- Blob store : **default**
- Strict content type validation : **False**
- Deployment policy : **Disable redeploy**

`Create repository`

---

Il faut ensuite ajouter ces repositories au *maven-public* :

`Server administration and configuration -> Repository -> Repositories -> maven-public`
- Member repositories : **Ajouter maven-esb-snapshots, maven-esb-releases, maven-etl-snapshots, maven-etl-releases, maven-oracle-bipub, maven-oracle-proxy à la liste *Members***

`Save`

---

Pour NPM

*npm-proxy* - sert de proxy vers le NPM standard

`Server administration and configuration -> Repository -> Repositories -> Create repository -> npm (proxy)`
- Name : **npm-central**
- Remote storage : **http://registry.npmjs.org**
- Blob store : **npm** (créer au préalable un blob store différent pour le npm afin de ne pas stocker les NPM au même endroit que les maven)

*npm-releases* - stocke les artefacts en mode release

`Server administration and configuration -> Repository -> Repositories -> Create repository -> npm (hosted)`
- Name : **npm-releases**
- Blob store : **npm**
- Deployment policy : **Disable redeploy**.

*npm-snapshots* - stocke les artefacts en mode release

`Server administration and configuration -> Repository -> Repositories -> Create repository -> npm (hosted)`
- Name : **npm-snapshots**
- Blob store : **npm**
- Deployment policy : **Allow redeploy**.

*npm-public* - sert de proxy vers l'ensemble des repositories NPM

`Server administration and configuration -> Repository -> Repositories -> Create repository -> npm (group)`
- Name : **npm-public**
- Blob store : **npm**
- Group : Ajouter *npm-central*, *npm-releases* et *npm-snapshots*.

---

Il reste à ajouter manuellement les librairies BI Publisher au repository *maven-oracle-bipub*, celles-ci n'étant pas
disponibles sur le repository maven d'Oracle.

@TODO : Ajouter le script permettant de le faire.

### Purge des repositories de Snapshots
`Server administration and configuration -> Tasks -> Create Task -> Remove Snapshots from Maven Repository`
- Task name : **Nettoyage snapshots**
- Notification email : **\<email@en_cas_dechec\>**
- Repository : **maven-public**
- Minimim snapshots count : **1**
- Snapshots retention : **2**
- Task frequency : **Weekly**
- Start date : **\<date_de_demmarage\>**
- Time to run this task : **00:00**
- Days to run this task : **Sunday / Wednesday / Saturday**

`Create task`

## Installation de Jenkins <image src="./logos/jenkins.png" width="32">
### Références

- [Installer Jenkins (éléments de sizing)](https://jenkins.io/doc/book/getting-started/installing/)
- [Scaling Jenkins](https://jenkins.io/doc/book/architecting-for-scale/)
- [Sécurisation derrière un proxy](https://wiki.jenkins.io/display/JENKINS/Running+Jenkins+behind+Apache)

### Installation
Au premier démarrage :
- Installer les plugins suggérés
- Créer un compte administrateur

Sur la machine, configurer Git pour pouvoir effectuer des commits/push :
```
git config --global user.email "jenkins@apave.com"
git config --global user.name "jenkins"
```

### Installation des plugins
`-> Administrer Jenkins -> Gestion des plugins -> Onglet "disponibles"`

Installer les plugins suivants :
- Blue Ocean
- RocketChat Notifier
- Pipeline Maven Integration Plugin
- Pipeline NPM Integration Plugin
- NodeJS Plugin
- SonarQube Scanner for Jenkins
- Gitlab Plugin
- Role-based Authorization Strategy
- Active Directory plugin
- Pipeline Utility Steps Plugin
- Monitoring
- Lockable Resources Plugin
- Validating String Parameter Plugin
- SSH Agent Plugin
- Copy Artifact Plugin

### Gestion de l'authentification & des rôles
Dans la configuration exposée ci-dessous, les utilisateurs sont authentifiés à travers l'AD
d'entreprise. Les autorisations sont gérés via des groupes créés dans l'AD auxquels sont associés
des rôles dans Jenkins. Les groupes créés dans l'AD sont les suivants :
- GU-RES-PIC-ADMIN-GRP - auquel sont ajoutés les administrateurs de la PIC
- GU-RES-PIC-USERS-GRP - auquel sont ajoutés les utilisateurs de la PIC

`-> Administrer Jenkins -> Configurer la sécurité globale`
- Activer la sécurité : **Oui**
- Royaume pour la sécurité (Realm)
  - Active Directory : **Oui**  
  - Nom du domaine : **societe.com**
  - Domain controller : **ip:port**
  - Site : **-**
  - Bind DN : **Utilisateur de service utilisé pour l'AD**
  - Bind Password : **Mot de passe de l'utilisateur de service**
- Autorisations
  - Stratégie basée sur les rôles : **Oui**

`Enregistrer`

`-> Administrer Jenkins -> Gérer et assigner les rôles ->  Gérer les rôles`

Normalement, un rôle *admin* existe par défaut avec tous les droits cochés. Si ce n'est pas le cas, le créer.

Dans *Rôles globaux*, créer le rôle *default* et lui assigner uniquement les droits suivants :
- Global / Read
- Job / Read
- Job / Workspace

Dans *Rôles globaux*, créer le rôle *users* et lui assigner les droits suivants :
- Global / Read
- Identifiants / View
- Job / build
- Job / Cancel
- Job / Discover
- Job / Read
- Job / Workspace
- Historique des builds / Replay
- Historique des builds / update
- Vues / Configure
- Vues / Create
- Vues / Delete
- Vues / Read
- Gestion des versions / Tag

`Enregistrer`

`-> Administrer Jenkins -> Gérer et assigner les rôles ->  Assigner les rôles`

On crée deux groupes, un pour les utilisateurs et un pour les administrateurs, correspondant auxquels
deux groupes de l'AD. Le groupe *Anonyme* permet aux utilisateurs non connectés de visualiser l'état des jobs.

- Ajouter un groupe nommé **GU-RES-PIC-ADMIN-GRP** et lui affecter le rôle **admin**
- Ajouter un groupe nommé **GU-RES-PIC-USERS-GRP** et lui affecter le rôle **users**


- Assigner au groupe **Anonyme** le rôle **default**

`Enregistrer`

### Configuration des outils
`-> Administrer Jenkins -> Configurer le système -> Git plugin`
- Global Config user.name Value : **Jenkins**
- Global Config user.email Value : **jenkins@domain.com**

`-> Administrer Jenkins -> Configuration globale des outils`
- `JDK -> Ajouter JDK`
    - Nom : **jdk1.8.0_151**
    - Install automatically : OUI / Ou installer manuellement la bonne version
- @TODO `SonarQube Scanner -> Ajouter SonarQube Scanner`
    - Name : **sonar**
    - Install automatically : OUI / Ou installer manuellement la bonne version
- `Maven -> Ajouter Maven`
    - Nom : **M3**
    - Install automatically : OUI / Ou installer manuellement la bonne version
- `NodeJS -> Ajouter NodeJS`
    - Nom : **nodejs8.9.4**
    - Install automatically : OUI / Ou installer manuellement la bonne version

#### Configuration de Nexus dans Jenkins
**Dans NEXUS - Création d'un utilisateur pour Jenkins**

`Server administration and configuration -> Security -> Users -> Create User`
- ID : **svc-jenkins**
- First name : **Jenkins**
- Last name : **Jenkins**
- Email : **jenkins@jenkins.com** (peu importe)
- Password : **\<pwd\>**
- Confirm password : **\<pwd\>**
- Status : **Active**
- Roles : **nx-admin**

`Create user`

**Dans Jenkins**
`-> Administrer Jenkins -> Configuration files -> Add a new Config`
- Type de fichier : **Global Maven settings.xml**
- ID : **globalMaven**

`Submit`

- Name : **globalMaven**
- `Server Credentials -> Ajouter`
    - ServerId: **releases**
    - Credentials:
        - `-> Ajouter -> Jenkins`
            - Portée : **Système (Jenkins et escales seulement)**
            - Nom d'utilisateur : **--NexusUser--**
            - Mot de passe : **--NexusUserPwd--**
            - ID : **Nexus**
            - Description : **Nexus**
            - Credentials : **Nexus**


- `Server Credentials -> Ajouter`
    - ServerId: **snapshots**
    - Credentials: **Nexus**

- `Server Credentials -> Ajouter`
    - ServerId: **snapshots-esb**
    - Credentials: **Nexus**

- `Server Credentials -> Ajouter`
    - ServerId: **releases-esb**
    - Credentials: **Nexus**

- `Server Credentials -> Ajouter`
    - ServerId: **snapshots-etl**
    - Credentials: **Nexus**

- `Server Credentials -> Ajouter`
    - ServerId: **releases-etl**
    - Credentials: **Nexus**

- Content :

```xml
<!-- Utilisation du scanner sonar -->
<pluginGroups>
    <pluginGroup>org.sonarsource.scanner.maven</pluginGroup>
</pluginGroups>

<!-- Utilisation du Nexus interne plutôt que des repositories externes. -->
<mirrors>
    <mirror>
      <id>central</id>
      <name>central</name>
      <url>http://srv:8081/repository/maven-public/</url> <!-- Adresse du Nexus -->
      <mirrorOf>*</mirrorOf>
    </mirror>
</mirrors>

<!-- Profil générant le déclenchement de Sonar lors d'un build => Utilisé par défaut -->
<profiles>
    <profile>
        <id>sonar</id>
        <activation>
            <activeByDefault>true</activeByDefault>
        </activation>
        <properties>
            <!-- Adresse du serveur Sonar -->
            <sonar.host.url>
              http://srv:9009
            </sonar.host.url>
        </properties>
    </profile>
</profiles>
<activeProfiles>
    <activeProfile>sonar</activeProfile>
</activeProfiles>
```

`Submit`

#### Configuration de NPM dans Jenkins
`-> Administrer Jenkins -> Configuration Files -> Add New Config`
- Type de fichier : **Fichier Npm de configuration**
- ID : **globalNpmrc**

`Submit`

- Name: **globalNpmrc**
- `-> NPM Registry -> Ajouter`
    - URL: **http://srv:8081/repository/npm-public/** (URL Nexus pour stockage des artefacts Web)
    - Credentials : **Nexus**
    - Content (Ajouter en fin de fichier) :
```
    registry=http://srv:8081/repository/npm-public/
    _auth=YWRtaW46YWRtaW4xMjM=          => echo -n 'user:passwd' | openssl base64 où <user = user nexus> & <passwd = pwd user nexus>
    user=admin                          => utilisateur Nexus
    email=admin@admin.com
```

`Submit`

#### Configuration de Rocket.Chat dans Jenkins
**Dans Rocket.Chat - Création d'un utilisateur pour Jenkins**

`-> Administration -> Utilisateurs -> Ajouter un utilisateur`
- Nom : **Jenkins**
- Nom d'utilisateur : **jenkins**
- Mot de passe : **mdp**
- Changement de mot de passe : **Non**
- Rôle : **bot**
- Rejoindre les canaux par défaut : **Non**
- Envoyer un e-mail de bienvenue : **Non**

`Enregistrer`

**Dans Jenkins**

`-> Administrer Jenkins -> Configurer le système -> "Global RocketChat Notifier Settings"`
- Endpoint : **url de Rocket.Chat**
- Channel :
- Icon to use : **URL Image Jenkins**
- Build Server URL : **Valeur par défaut**

`Enregistrer`


#### Configuration de SonarQube dans Jenkins
**Dans SonarQube**

`-> Administrator -> My Account -> Security`
- Generate New Token : Jenkins
- Generate
- COPIER LE TOKEN GENERE

**Dans Jenkins**

`-> Administrer Jenkins -> Configurer le système -> SonarQube servers -> Ajouter une installation SonarQube`
- Nom : **Sonar<Nom Société>**
- URL du serveur : **http://srv:9009** (Sonar URL)
- Server version : **5.3 or higher**
- Server authentication token : **VALEUR DU TOKEN COPIE DANS SonarQube**

`Enregistrer`

#### Configuration des Shared Libraries dans Jenkins
*Pour cette étape il est nécessaire de se doter d'une clé private/public. Pour générer une clé, consulter [ce lien](https://docs.gitlab.com/ce/ssh/README.html)*

**Dans GitLab - Création d'un utilisateur de service Jenkins (droits admin)**

`-> Admin area -> New User`
- Name : **Jenkins PIC**
- Username : **pic-svc-jenkins**
- Email : **pic-jenkins@jenkins.com**
- Access level : **Admin**

`Create user`

**Dans Jenkins**

`Identifiants -> System -> Identifiants globaux (illimité) -> Ajouter des identifiants`
- Type : **SSH Username with private key**
- Portée : **Global (Jenkins, esclaves, items, etc...)**
- Username : **pic-svc-jenkins**
- Private Key : **Enter Directly** + coller la clé privée générée précédemment
- Passphrase : **\<vide si pas de passphrase\> ou \<passphrase\>**
- ID : **jenkins_gitlab**
- Description : **GitLab**

`OK`

`Administrer Jenkins -> Global Pipeline Libraries`
- Name : **\<Nom permettant d'importer la librairie\>**
- Default version : **develop**
- Allow default version to be overridden : **true**
- Include @Library changes in job recent changes : **true**
- Retrieval method : **Modern SCM**
- Source Code Management : **Git**
    - Project repository : **\<repository SSH de la librairie\>**
    - Credentials : **pic-svc-jenkins (GitLab)**

`Enregistrer`

#### Configuration d'un slave Linux/Maven/NPM dans Jenkins

##### Pré-requis
- Git doit obligatoirement être installé sur le noeud pour que les builds puissent se dérouler correctement.
- Le noeud doit avoir accès à GitLab
- Le noeud doit avoir accès à Nexus
- Le noeud doit avoir bzip2 installé

##### Configuration

`-> Administrer Jenkins -> Gérer les noeuds -> Créer un noeud`
- Nom du noeud : **\<Nom du noeud\>**
- Permanent agent : **Oui**

`OK`

- Description : **\<Courte description permettant d'identifier le noeud\>**
- Nb d'exécuteurs : **\<A remplir en fonction des perfs de la machine\>** (Attention au nommage pour pouvoir facilement retrouver les noeuds par patterns : [Allocation des noeuds](https://jenkins.io/doc/pipeline/steps/workflow-durable-task-step/#code-node-code-allocate-node))
- Répertoire de travail : **\<Répertoire dans lequel Jenkins stocke les données sur le noeud\>**
- Méthode de lancement : **Launch slave agents via SSH**
  - Host : **\<Nom du serveur ou adresse IP\>**
  - Credentials : **\<Choisir l'identifiant du serveur ou en créer un nouveau\>**
  - Host Key Verification Strategy : **Non verifyin Verification Strategy**

Configurer éventuellement l'emplacement des différents outils sur le noeud.

`Enregistrer`






====================================================================================

---------- Configuration de Jenkins pour build onPush dans GitLab    =>     VERIFIER QUE C'EST BIEN NECESSAIRE
    - GitLab :
        Se connecter en tant qu'administrateur
        -> Profile Settings -> Account
        COPIER "Private token"

    - Jenkins
        -> Administrer Jenkins -> Configurer le système -> Gitlab
            Connection name : Build on Push
            Gitlab host URL : http://srv.grp:1212    (GitLab URL)
            Credentials :
                Ajouter -> Jenkins
                    Type : GitLab API Token
                    Portée : Global
                    API token : "Private token" copié précédemment
                    ID : GitlabAdmin
                    Description : GiLab Admin

        Enregistrer






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
        URL : http://srv:8092/project/{NOM_PROJET}
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
          <name>Repository <Nom Société> Snapshots</name>
          <url>http://srv:8081/repository/maven-snapshots/</url>
        </repository>
        <repository>
          <id>releases</id>
          <name>Repository <Nom Société> Release</name>
          <url>http://srv:8081/repository/maven-releases/</url>
        </repository>
      </repositories>
    </profile>
Juste avant la fin du fichier (avant </settings>), ajouter :
    <activeProfiles>
        <activeProfile>jenkins</activeProfile>
    </activeProfiles>
=======
