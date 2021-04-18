# Tutoriel de mise en place et d'utilisation de Symfony ux turbo
## De 0 à une SPA complète
*Huby Franck à compter du 17/04/2021*

**Symfony ux turbo**[1] est un bundle intégrant la librairie **Hotwire Turbo**[2] au sein d'une application **Symfony**[3].

**Symfony ux turbo** Fait partie de l'initiative **Symfony UX**[4].

Il sert à faire de la "single page application (SPA)" sans framework javascript complexe et lourd (qui à dit Angular ? View.js, .
Et donc sans avoir à apprendre et maîtriser ce framework js.

Il apporte l'intégration avec **Symfony Mercure**[5] et est compatible avec d'autres système de broadcast de modifications du DOM.

Pré-requis : php 7.2+ (7.4 dans notre cas), Symfony 5.2+, un serveur de Base de données (mysql ou mariaDB (10.5) ou ce que vous maîtriser MariaDB est un choix très personnel), un ide, une console, optionnel mais fortement recommandé : Docker / docker-compose (dock-station est utile dans ce cas là).

## Objectif du tuto :

J'ai entendu parler de **Symfony UX Turbo** lors du Symfony live spécial 15 ans de 2021. Et j'ai tout de suite été séduit.

Je me suis donc mis en quête de documentation et le peu que j'ai trouvé ne me semblais pas assez complet, avec l'impression qu'il me manquais des étapes.

C'est pourquoi j'ai décidé d'écrire ce tutoriel.

Dans ce tutoriel nous allons voir comment mettre en place les éléments nécessaire à la conception d'une SPA complètement fonctionnelle.

Nous commencerons par l'exemple le plus complet du dépôt du bundle le chat (non ce n'est pas très original mais, comme vous, je débute sur UX Turbo ; et c'est un exemple complet des fonctions de Turbo).

Que nous enrichirons avec la gestion d'utilisateurs de Symfony, et donc une base de données, et poserons ce qui pourrais être le chat en direct d'un site en ligne.

Avec: 
* Un salon de discutions libre (abonnés et anonymes) 
* Un salon privé réservé aux administrateurs
* La possibilité d'ouvrir un message privé vers les administrateurs sans cibler un admin en particulier
* Chat privé entre 2 utilisateurs

Donc en résumé nous auront :
* ***n to n identifié ou non***, (salon d'acceuil)
* ***n to n admins uniquements***, (salon privé admins)
* ***one to n id or not to group***,
* ***one to one private***

Ce système pourrais être utilisé pour de l'assistance en direct sur un site e-commerce ou pour de la discussion sur un site communautaire ou de fans d'un jeu vidéo.

Vous pourrez vous resservir d'une des étapes du tuto pour tout besoin d'UX Turbo dans vos applications Symfony existantes ou le suivre du début pour démarrer une nouvelle SPA depuis ce tutoriel.

## Installation de Symfony : 
### Installation

On démarre avec un projet Symfony vierge à partir de la console sf :

     symfony check:requirements
     symfony new tuto_sfUxTurbo --full

Cela doit nous amenez à l’état de la branche suivante : 
https://github.com/loamok/tuto_sfUxTurbo/tree/feature/sf_naked

*Indice : selon vos manipulation le projet sera dans un dossier "tuto_sfUxTurbo"*

### Point de contrôle : 

Si Php est installé sur votre poste vous devriez d'ors et déjà être en mesure d'afficher l'accueil de base de Symfony en lançant votre serveur et en ouvrant votre navigateur ici : https://127.0.0.1:8000/ avec la commande *server:start* depuis le répertoire des sources de l'application.

    symfony server:start -d

Si vous n'avez pas Php sur votre poste ou que c'est plus compliqué (utilisateurs de Windows, Mac os ..) je vous ajoute un docker-compose au chapitre suivant.

Le système Docker sera de toute façon très utile pour la suite à la mise en place des utilitaires Webpack,  Mercury, et autres (qui as dit Rabbit ? non normalement on ne se servira pas de RabbitMq, enfin c'est pas prévu d'être utile ici mais je ne pense pas que UX Turbo et Mercure vous empêche d'avoir le broker de message aussi) donc autant commencer par là.

- - -
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

- - -

## Symfony Ux Webpack encore
### Introduction

Symfony UX Turbo fait partie de l'initiative Symfony UX.

Alors il faut installer et mettre en place Symfony UX

### Mise en place

Faites une copie de sauvegarde des fichiers en dehors du dossier du projet (croyez moi c'est la galère sinon à rattraper): 
- .env.dist
- .env
- .gitignore

Veillez à bien avoir flex à jour : 

     symfony composer update symfony/flex

Installez webpack/encore : 

     symfony composer req symfony/webpack-encore-bundle

Cette commande je n'ais pas compris pourquoi il faut la faire mais elle vas renommer votre .env.dist en .env et le supprimer.

Mais d'après Sensio il faut la lancer sans plus d'explication ...

     composer recipes:install symfony/webpack-encore-bundle --force -v

Il faut forcer la mise à jour de Npm (ou yarn) : 

     npm install --force

Compiler une première fois vos source en un jeu d'assets : 

     npm run dev

Et enfin décommenter 2 lignes dans le fichier base.html.twig (c'est indiqué en commentaire lesquels dedans) pour charger les assets css et js de webpack.

Vous trouvez ça plus simple vous ? Pas moi !

### Docker

En tout cas je vous ai ajouté :
- un répertoire encore dans le répertoire docker
- une entrée encore dans le docker-compose.yml
- et un tout petit peu de conf dans le .env-dist

Ces nouveaux éléments vous ajoutent la gestion auto de l'installation de npm, la régénération des nodes-sass et un premier lancement de encore dev.

Le tout au lancement de la vm encore.

Donc un docker-compose up -d ou un build dans dockstation et vous voilà avec une instance de Symfony Ux fonctionelle.

J'y ai passé l'après-midi et n’ai pas encore commencé la moindre ligne de notre SPA.

Du coup pour le moment je trouve pas ça plus simple que de se lancer dans autre chose on as même pas encore Turbo de configuré et de fonctionnel.

Bah ce sera le prochain chapitre alors ..

L'état actuel de notre future SPA ici : https://github.com/loamok/tuto_sfUxTurbo/tree/feature/sf_ux

- - -


## Symfony UX Turbo avec Mercure
### Introduction

Au point ou nous en sommes il nous manque UX Turbo et Mercure.

Un exemple de ce qu'il manque dans les documentations est le suivant : 

- Est-ce que installer le bundle Ux-Turbo suffit à lui seul à installer les dépendances à Mercure ou faut-il d'abord installer configurer et tester Mercure ? 

Nous allons voir ça lors de l'installation.

### Première tentative d'installation

Pour en avoir le cœur net sans détruire tout mon travail à ce point d'avancement, je vais avancer prudemment : 

- clone de la branche master dans un nouveau répertoire
- application de symfony composer install
- création ou mise à jour du .env
- mise à jour Npm et dépendances d'UX
- Et enfin, installation du bundle Ux-Turbo

Alors le résultat dépasse mes espérances, je m'attendais à ce que ça ne fonctionne pas et que mon squelette soit cassé.

Je ne dit pas que ça ne s'est pas fait sans mal (perte du .env, connection à la bdd perdue à cause d'une mauvaise reconstruction du .env, j'en passe).

Mais force est de constater que tel quel ça fonctionne.

### Installation

Installer le bundle requis : 

    symfony composer require symfony/ux-turbo

Installer les dépendances : 

    npm install --force 

Yarn ne fonctionne pas sur mon environnement sinon vous pouvez faire :
    
    yarn install --force
    yarn encore dev

Compilation des JS : 
    
    npm run dev // (inutile si vous faites fonctionner yarn avec yarn encore dev

Branche contenant le tout : https://github.com/loamok/tuto_sfUxTurbo/tree/feature/sf_ux_turbo

### Point de contrôle

Pour le valider j'ai mis en place le petit exemple sur la "turbo-frame" présent sur le readme du repo Ux-Turbo :

Création du controlleur "Home" avec deux actions ; index et plop.

Avec dans leurs twigs : 

    {% extends 'base.html.twig' %}
    {% block title %}Hello HomeController action index !{% endblock %}
    {% block body %}
        {{ parent() }}
    <style>
        .example-wrapper { margin: 1em auto; max-width: 800px; width: 95%; font: 18px/1.5 sans-serif; }
        .example-wrapper code { background: #F5F5F5; padding: 2px 6px; }
    </style>
        <h1>this is Home !</h1>
        <turbo-frame id="the_frame_id">
            <div class="example-wrapper">
                <h1>Hello {{ controller_name }}!</h1>
                <p>
                    <a href="{{ path('home_plop') }}"> Go to Plop </a> <br />   
                This friendly message is coming from:
                </p>
                <ul>
                    <li>Your controller at <code><a href="{{ '/home/symio/Developpement/Loamok/tuto/sfUxTurbo_copie/src/Controller/HomeController.php'|file_link(0) }}">src/Controller/HomeController.php</a></code></li>
                    <li>Your template at <code><a href="{{ '/home/symio/Developpement/Loamok/tuto/sfUxTurbo_copie/templates/home/index.html.twig'|file_link(0) }}">templates/home/index.html.twig</a></code></li>
                </ul>
            </div>
        </turbo-frame>
    {% endblock %}

Et :

    {% extends 'base.html.twig' %}
    {% block title %}Hello HomeController!{% endblock %}
    {% block body %}
    <style>
        .example-wrapper { margin: 1em auto; max-width: 800px; width: 95%; font: 18px/1.5 sans-serif; }
        .example-wrapper code { background: #F5F5F5; padding: 2px 6px; }
    </style>
        <h1>this is Plop !</h1>
        <turbo-frame id="the_frame_id">
            <div class="example-wrapper">
                <h1>Hello {{ tag }}! </h1>
                <p>
                    <a href="{{ path('home') }}"> Go back to Home </a> <br />   
                    This friendly message is coming from:
                </p>
    
                <ul>
                    <li>Your controller at <code><a href="{{ '/home/symio/Developpement/Loamok/tuto/sfUxTurbo_copie/src/Controller/HomeController.php'|file_link(0) }}">src/Controller/HomeController.php</a></code></li>
                    <li>Your template at <code><a href="{{ '/home/symio/Developpement/Loamok/tuto/sfUxTurbo_copie/templates/home/plop.html.twig'|file_link(0) }}">templates/home/index.html.twig</a></code></li>
                </ul>
            </div>
        </turbo-frame>
    {% endblock %}

Une fois le js recompilé (npm run dev), le cache nettoyé (symfony console cache:clear), le serveur lancé (symfony server:start -d) je suis allé sur la page d'accueil https://127.0.0.1:8000/ et là ! surprise ! seul le bloc central est rechargé c'est bluffant et bluffant de simplicité !

(pas bluffant de simplicité d'installation malheureusement)

Du coup, je n'ai pas encore compris pourquoi on nous parle de Mercure. On voit ça dans le prochain chapitre.

- - -

*liens : 
 - [1] https://github.com/symfony/ux-turbo
 - [2] https://turbo.hotwire.dev/
 - [3] https://symfony.com/doc/current/setup.html
 - [4] https://symfony.com/blog/new-in-symfony-the-ux-initiative-a-new-javascript-ecosystem-for-symfony
 - [5] https://symfony.com/doc/current/mercure.html

> Written with [StackEdit](https://stackedit.io/).
