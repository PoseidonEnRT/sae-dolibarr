# Déploiement de Dolibarr avec Docker


## Introduction

Dolibarr est une solution ERP et CRM open-source, qui permet de gérer des opérations commerciales et administratives. Docker, nous permet de simplifier son déploiement.

## Note

Attention les script doivent se lancer en sudo avec la commande : 
   ```bash
   sudo bash <nom du script>
   ```

## Prérequis

1. **Outils nécessaires :**
   - Docker installé sur votre machine.
   - Docker Compose configuré.



## Configuration Docker Compose

### Fichier `docker-compose.yml`


### Étapes de configuration

1. **Créer le fichier** : Copiez le contenu de ce dépot dans un dossier nommé `sae-dolibarr`.
2. **Lancer les conteneurs** : Exécutez la commande suivante :

   ```bash
   sudo bash install.sh
   ```

3. **Vérifier l'état** : Visiter l'adresse `http://0.0.0.0:8082` dans un navigateur pour s'assurer de la bonne exécution du fichier.

---

# Explications du `docker-compose.yaml`

## MariaDB

```bash
 mariadb:
        image: mariadb:latest
        environment:
            MYSQL_ROOT_PASSWORD: root
            MYSQL_DATABASE: dolidb
            MYSQL_USER: dolidbuser
            MYSQL_PASSWORD: dolidbpass

        volumes:
            - ./dolibarr_mariadb:/var/lib/mysql
            - ./csv:/home/csv
```

L'image utilisé ici est la dernière version stable de MariaDB.
- ```MYSQL_ROOT_Password``` renvoie au mot de passe admin.
- ```MYSQL_DATABASE``` renvoie au nom de la base de données.
- ```MYSQL_USER``` renvoie au nom de l'utilisateur.
- ```MYSQL_PASSWORD``` renvoie au mot de passe de l'utilisateur.

Ces données configurent l'accès a la base de donnée

Les volumes liés permettent de recuperer sur la machine hote les différents fichiers créer sur le docker.

Ces paramètres englobes la création du docker MariaDB.

## Dolibarr

```bash
 web:
        image: dolibarr/dolibarr:latest
        environment:
            WWW_USER_ID: 1000
            WWW_GROUP_ID: 1000
            DOLI_DB_HOST: mariadb
            DOLI_DB_NAME: dolidb
            DOLI_DB_USER: dolidbuser
            DOLI_DB_PASSWORD: dolidbpass
            DOLI_URL_ROOT: "http://0.0.0.0"
            DOLI_ADMIN_LOGIN: "admin"
            DOLI_ADMIN_PASSWORD: "admin"
            DOLI_CRON: 0
            DOLI_INIT_DEMO: 0
            DOLI_COMPANY_NAME: MyBigCompany
            DOLI_COMPANY_COUNTRYCODE: "FR"
            DOLI_ENABLE_MODULES: Societe,Import,Export

        ports:
            - 8082:80
        links:
            - mariadb
        volumes:
            - ./dolibarr_documents:/var/www/documents
            - ./dolibarr_custom:/var/www/html/custom
```

Comme pour MariaDB nous utilisons la dernière version stable de Dolibarr.
- ```WWW_USER_ID``` configure l'utilisateur web.
- ```WWW_GROUP_ID``` configure, lui, le groupe web.
- ```DOLI_DB_HOST``` renseigne le nom de la BDD a laquelle il se connecte
- ```DOLI_DB_NAME``` renseigne le nom de la base de donnée que Dolibarr utilisera.
- ```DOLI_DB_USER``` est utilisée pour spécifier le nom d'utilisateur qui sera utilisé par Dolibarr et vas de pair avec DOLI_DB_PASSWORD qui est le mot de passe de cet utilisateur.
- ```DOLI_URL_ROOT``` est utilisé pour spécifier l'url utiliser pour joindre Dolibarr via le web.
- ```DOLI_ADMIN_LOGIN``` et ```DOLI_ADMIN_PASSWORD``` sont utilisés pour configurer le compte admin

Les commandes suivantes sont utilisées pour configurer Dolibarr:
- ```DOLI_COMPANY_NAME``` est utilisé pour configurer le nom de la société hébérgant Dolibarr.
- ```DOLI_COMPANY_COUNTRYCODE``` est utilisé pour configurer le code du pays de la société
- ```DOLI_ENABLE_MODULES``` est utilisé pour configurer les modules qui sont activés par défaut au démarrage de Dolibarr. Ici les modules Societe pour la liste entreprises, Import et Export pour importer et exporter du CSV de manière guidée.

Le ports mappe le port 80 du container au port 8082 de l'hote.

```links``` permet de signaler à Docker de lancer le docker mariadb avant celui de dolibarr.

Enfin , volumes permet de recuperer les fichiers créer sur le container Dolibarr et de les stocker sur l'hote a l'aide de Bind Mounts.

# Explications du `save.sh`
```cp -r ./dolibarr_mariadb/ ./backup/dolidb_$(date +"%d-%m-%Y_%H:%M:%S")/```

Cette commande permet de copier (cp) de manière recursive (-r) le dossier et son contenu (./dolibarr_mariadb/) dans le dossier (./backup/) avec le nom "dolidb_" suivi de la date et l'heure a laquelle le dossier a été copier. Le nom du dossier pourait donc etre dolidb_05-12-2024_14:30:26 dans l'ordre: jour-mois-annee_heure:minute:seconde.

# Explications du `remove.sh`
```#!/bin/bash
docker kill sae-dolibarr_web_1
docker kill sae-dolibarr_mariadb_1
docker rm sae-dolibarr_web_1
docker rm sae-dolibarr_mariadb_1

rm -rf ./dolibarr_custom/ ./dolibarr_documents/ ./dolibarr_mariadb/ ./backup ./csv
```
Docker Kill permet de tuer un conteneur nommé, en l'occurence sae-dolibarr_web_1 et sae-dolibarr_mariadb_1. Cela revient a l'éteindre

Docker rm permet de supprimer un conteneur nommé. Ici la commande supprimera toute trace des conteneurs.

Enfin rm -rf permet de supprimer de manière récursive (-r) et forcé (-f) les fichiers et dossiers spécifiés.

Ce fihier permet de nettoyer totalement la machine hote des differents conteneurs et leurs dossiers et fichiers associés.

# Explications du `remove.sh`
Connecte sur docker mariadb en root sur la base dolidb et execute une commande d'import de donnée via un fichier. 
Il importe ensuite le csv depuis le volume et le rentre dans la table qui corespond aux Sociétés , la dernière ligne indique quand à elle quelle colonne du csv correspond à quelle colonne de la table
