
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


> Written with [StackEdit](https://stackedit.io/).
