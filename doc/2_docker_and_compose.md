## Docker et docker_compose
### Introduction

Dans notre définition de besoins nous stockons au moins les utilisateurs en base de données et nous savons que nous aurons besoin de :
- MariaDb (ou Mysql, Postgres, SQL Server, MongoDB, etc, etc ... à vous de choisir vos armes)
- PHP 7.4 (ou 8 mais je ne m'y suis pas penché encore vous me direz si vous osez PHP 8)
- Webpack Encore Npm et yarn, 
- Mercury

### Composition

Sur la branche https://github.com/loamok/tuto_sfUxTurbo/tree/feature/sf_dockerized vous trouverez tout ce qu'il vous faut pour commencer à Dockerizer notre SPA.

Un docker-compose avec
- Nginx
- Php-fpm
- MariaDB (vous pouvez le changer)

Un fichier .env.dist dont vous devez ajouter le contenu à votre .env.

À ce sujet. Docker, docker-compose ont besoin des valeurs d'environnement dans le fichier .env.

C'est dommage car ça risquerait de vous faire envoyer des mot de passe sur votre dépôt GIT et ça c'est mal.

Pour contourner cela je vous propose ce qui suis : 
- ajoutez .env à votre .gitignore (j'ai mis un exemple dans mon .gitignore)
- copiez votre .env en .env.local (ou autre si vous avez déjà un .env.local)
- supprimez votre .env
- comitez la suppression du .env et le .gitignore
- renommez votre copie en .env

Et voilà aucun mot de passe du .env ne partiras vers votre GIT.

En ajoutant le contenu de .env.dist à votre fichier .env vous pourrez voir et ajuster les diverses variables de fonctionnement de notre système Docker basique.

Nous l'enrichirons plus tard en fonction des besoins.

Vous trouverez aussi un répertoire "docker" avec les dockerFiles pour Php-fpm et Nginx.

Les fichiers pour Php-fpm sont spécialement conçuts pour automatiquement installer le client symfony, composer, initialiser automatiquement (symfony composer install) votre application et passer les éventuelles migrations Doctrine à chaque lancement de votre instance Php-fpm.

Une fois toutes les variables d'environnement configurées il ne vous reste plus qu'à construire votre stack docker et lancer l'application (docker-compose up -d) ou avec dockstation en créant un nouveau projet et en cliquant sur build.

> Written with [StackEdit](https://stackedit.io/).
