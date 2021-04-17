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
https://github.com/loamok/tuto_sfUxTurbo/tree/initial/sf_naked

*Indice : selon vos manipulation le projet sera dans un dossier "tuto_sfUxTurbo"*

### Point de contrôle : 

Si Php est installé sur votre poste vous devriez d'ors et déjà être en mesure d'afficher l'accueil de base de Symfony en lançant votre serveur et en ouvrant votre navigateur ici : https://127.0.0.1:8000/ avec la commande *server:start* depuis le répertoire des sources de l'application.

    symfony server:start -d

Si vous n'avez pas Php sur votre poste ou que c'est plus compliqué (utilisateurs de Windows, Mac os ..) je vous ajoute un docker-compose au chapitre suivant.

Le système Docker sera de toute façon très utile pour la suite à la mise en place des utilitaires Webpack,  Mercury, et autres (qui as dit Rabbit ? non normalement on ne se servira pas de RabbitMq, enfin c'est pas prévu d'être utile ici mais je ne pense pas que UX Turbo et Mercure vous empêche d'avoir le broker de message aussi) donc autant commencer par là.

- - -


- - -

*liens : 
 - [1] https://github.com/symfony/ux-turbo
 - [2] https://turbo.hotwire.dev/
 - [3] https://symfony.com/doc/current/setup.html
 - [4] https://symfony.com/blog/new-in-symfony-the-ux-initiative-a-new-javascript-ecosystem-for-symfony
 - [5] https://symfony.com/doc/current/mercure.html

> Written with [StackEdit](https://stackedit.io/).
