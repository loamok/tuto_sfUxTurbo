## Mercure
### Introduction

Mercure ou plutôt Caddy vas venir remplacer Nginx ou Apache pour fournir les websocket nécessaires pour pouvoir pusher des modifications vers les clients.

*Mais en fait je me rends compte que je me trompe, Mercure ne remplacera pas Nginx ni Apache mais viendra en complément comme message-broker !*

Je suis parti de ça : https://github.com/dunglas/symfony-docker pour adapter notre stack Docker et j'ai galéré.

Je n'ais pas testé si ce qu'à fait @Dunglas est fonctionnel en l'état mais l'intégration avec notre stack à été délicate.

### Installation

Mettez votre stack à jour avec le contenu de cette branche : https://github.com/loamok/tuto_sfUxTurbo/tree/feature/sf_ux_turbo_mercure

Et plus particulièrement :

- docker-compose.yml
- le répertoire docker/caddy
- votre .env avec la fin de env-dist

Lancez la stack docker et installez les bundles manquants : 

    composer require symfony/ux-turbo-mercure

Symfony met encore de la confusion dans le .env, avec une confusion habituelle entre localhost et 127.0.0.1

Veillez donc bien à changer les urls "Mercure" dans votre .env en " https://localhost/.well-known/mercure "

Mettez à jour les dépendances Npm

    npm install --force

### Contrôle :

Au point ou j'en suis j'essaye de contrôler l'installation de Mercure mais en vain je n’ai qu'une page blanche en allant sur https://localhost/ .

Quand d'autres (https://afsy.fr/avent/2019/21-symfony-et-mercure) voient un message de bienvenue.

J'ai consulté d'autres tuto de chat symfony Mercure mais aucun n'utilisent Ux-Turbo et aucun n'est complet et exhaustif sur l'installation et la configuration de Mercure.

Il vas donc falloir allez plus loin pour tester ce fonctionnement.

### Code de contrôle

Sur la page Readme du bundle Ux-Turbo il y as un micro tuto de chat.

J'ai donc repris ce code et nous allons le tester.

> Written with [StackEdit](https://stackedit.io/).
