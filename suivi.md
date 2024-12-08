# Journal de bord

* SAE51 Dolibarr
* Kylian Laloux
* Yann Beaudouin
* 05/11/2024


## Séance n° 1

* 05/11/2024 De 8h30 à 11h30
* Configuration de l'organisation, configuration et découvertes des module, installation sgbd (mysql), installation dolibarr (pacquet deb), configuration dolibarr guidée (création utilisateur et database)
* Découverte des modules, prise en main du module client, importation d'une liste de client
* Difficultés pour se connecter a la base SQL et pour connecter la BDD à Dolibarr (Connecter le user Dolibarr a la base)


## Séance n° 2

* 05/11/2024 de 14h30 à 17h30
* création d'un simple utilisateur, ajout module ticket, création d'un csv avec les infos clients (champ obligatoire + cerains chains optionnel), import du csv dans la catégorie Tiers, attirubution des clients à un utilisateur
* Commencer la création d'un dockerfile pour Dolibarr et le SGBD, se renseigner sur la méthode de création possible de ces deux dockerfiles
* Trouver les catégories nécessaires dans le csv pour importer dans Dolibarr.



## Séance n° 3

* 06/11/2024 de 8h30 à 11h30
* recherche documentation dockerfile pour httpd mysql, création dockerfile httpd "test" pour prendre en main l'image httpd, création dockerfile mysql, création bdd et user
* liée bdd mysql avec dockerfile dolibarr, installation dolibarr sur le dockerfile
* peu de documentation pour des dockerfile sur dolibarr (beaucoup de docker-compose), site docs.docker.com down pendant environ 1h (erreur 503)
* beaucoup de reflexion sur comment utiliser les dockerfile. Comment les lier, partir sur quelle image (2 debian ou mysql et apache), ou bien si il fallait partir sur un docker-compose à la place


## Séance n° 4

* 07/11/2024 de 8h30 à 11h30
* début listage commande nécessaire pour install.sh, test lancement dockerfile mysql, recherche pour débuger les problèmes sur le dockerfile mysql
* commencer l'ajout de dolibarr sur le dockerfile apache, essayer de régler le problème sur le dockerfile mysql
* ERROR 2002 (HY000) pendant les commandes mysql quand on lance le Dockerfile du SGBD, essaie de résolution du bug avec infos sur internet pour l'instant infructueux

## Séance n° 5

* 07/11/2024 de 13h à 16h
* Le problème avec la connexion sur mysql dans le Dockerfile n'est toujours pas réglé malgré les tentatives. On a décidé de partir à la place sur un docker-compose. On a commencé à se renseigner sur la mise en place du docker-compose avec les images mariadb et dolibarr
* Commencer la mise en place du docker-compose avec des test
* La documentation et les solutions sur les forums pour le Dockerfile mysql n'ont pas fonctionnés
* On aurrait dû commencer par utiliser docker-compose, cependant avoir commencé par de simples Dockerfile nous a permis de nous rendre compte des nombreux avantages de docker-compose comparé à un Dockerfile que ce soit au niveau de la mise en place et de l'efficacité.

## Séance n° 6

* 12/11/2024 de 14h30 à 17h30
* recherche documentation docker-compose, création docker compose avec mappage des ports, création utilisateurs mariadb et dolibarr ainsi que la base de donnée, création des volumes dolibarr et mariadb, création de l'entreprise qui "heberge" dolibarr, ajout du .gitignore pour les fichiers créés par install.sh, ajout install.sh qui lance le docker-compose et créer les dossiers nécéssaires, ajout remove.sh qui arrête et supprime les dockers ainsi que supprime les fichiers créés par install.sh
* Se documenter pour le script d'import csv et créer ce script
*  après les difficultés passées sur les Dockerfile nous avons décidé de passer sur docker-compose ce qui a été concluant. Nous avons quand même décidé de mettre les Dockerfile dans un dossier old_versions dans un but pédagogique

## Séance n° 7

* 03/12/2024 de 10h à 11h30 & de 14h30 à 16h
* Début du compte rendu, test d'implementation de cron pour automatiser la sauvegarde pour backups
* Continuer compte rendu et approfondir la recherche pour cron
* Difficultés pour exporter et importer le CSV


## Séance n° 8

* 04/12/2024 de 10h à 16h
* Création de l'import csv