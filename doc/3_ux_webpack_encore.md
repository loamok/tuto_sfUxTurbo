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

> Written with [StackEdit](https://stackedit.io/).
