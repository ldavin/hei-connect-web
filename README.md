HEI Connect Web
=========

[![Code Climate](https://codeclimate.com/github/ldavin/hei-connect-web.png)](https://codeclimate.com/github/ldavin/hei-connect-web)

## Description
### En bref
HEI Connect Web est une web-app utilisant [HEI Connect](https://github.com/ldavin/hei-connect) pour récupérer les données (planning, notes et absences) des élèves de l'école d'ingénieurs [HEI](http://www.hei.fr) et les leur présenter de manière simple, efficace et rapide.

### HEI Connect / HEI Connect Web, quelle différence?
[HEI Connect](https://github.com/ldavin/hei-connect) est une API (interface de programmation). Dans la pratique, c'est une sorte de "robot" à qui on fournit des identifiants, puis qui navigue sur [e-campus](http://e-campus.hei.fr/), lit le code source de certaines pages, et en extrait les informations intéressantes qu'il retourne dans un format générique.

HEI Connect Web est un site internet qui utilise cette API, en stocke les résultats dans une base de données, et les traite de manière à les présenter à l'utilisateur avec une certaine valeur ajoutée (planning dynamique, graphe de la moyenne, calcul des moyennes de chaque examen, graphe du nombre d'absences en fonction du temps...)

### Et plus précisément?
D'un point de vue technique, HEI Connect Web est un projet écrit en [Ruby](http://www.ruby-lang.org/), basé sur le framework [Ruby on Rails](http://rubyonrails.org/).
Nous sommes conscients que ces deux technologies ne sont pas enseignées à HEI, et qu'il aurait été plus facile de profiter de la participation des élèves (notamment de la majeure informatique) au projet s'il avait été écrit en PHP. Cependant, l'environnement Ruby/Ruby on Rails permet un gain de productivité énorme par rapport au développement traditionnel en PHP. Si vous êtes un "geek" et que vous hésitez à participer, franchissez le pas. L'investissement vaut vraiment le coup.

L'application est hebergée sur l'offre gratuite de la plateforme de cloud-computing [AppFog](https://www.appfog.com/).

## Comment participer
### Vous êtes étudiant
[Inscrivez vous](http://www.hei-connect.eu/) et utilisez la web-app!
On sera ravi d'entendre vos retours, remarques, et idées pour améliorer le projet.
Un module de "feedback" interne au site internet est en développement, avec notamment un système de vote pour les idées d'améliorations.
Le [système de retour de github](https://github.com/ldavin/hei-connect-web/issues?state=open) reste reservé aux discussions techniques.

### Vous êtes étudiant et vous vous y connaissez un peu
En plus de participer sur le module de feeback de l'application, n'hesitez pas à faire un tour sur le [module de feedback de github](https://github.com/ldavin/hei-connect-web/issues?state=open). On attend vos remarques, rapports de bugs détaillés, et vos conseils!

### Vous êtes une rockstar (un étudiant qui s'y connait un peu ET qui veut bidouiller)
D'abord, merci! Ensuite, on attache nos ceintures. Rendez-vous dans le paragraphe suivant.

## Comment contribuer

### 1. Installer Ruby et Ruby on Rails (et autres)
Il y énormément de tutos sur internet pour installer tout ce qu'il faut, je recommande d'aller faire un tour sur [RailsInstaller](http://railsinstaller.org/) qui semble est la solution la plus simple.
Dans tous les cas, vous devez avoir les paquets suivants installés sur votre PC:

- Ruby (1.9.3)
- RubyGems
- Git
- SQLite

### 2. Installer redis
Redis est un gestionnaire de base de données clef-valeur, très léger et très rapide.
L'application utilise redis comme serveur de cache (par exemple pour sauvegarder certains resultats et court-circuiter les appels vers la base de données).
[L'installation de redis](http://redis.io/download) ne devrait pas être un problème, n'hésitez pas à suivre d'autres tutos trouvés sur le web, et rédigés spécifiquement pour votre système d'exploitation.

### 3. Cloner le projet
#### Forker le projet
Il faut être connecté sur son compte github, et cliquer sur l'icone "fork" tout en haut à droite de la page. Cela va créer votre propre copie du projet, sur laquelle vous allez pouvoir travailler.
#### Cloner le code
L'étape suivante est de récupérer le code sur votre ordinateur. Rendez-vous sur la page github de votre fork, et récupérez l'adresse de votre dépôt.
Clonez le dépôt sur votre ordinateur à l'aide de la commande `git clone ADRESSE_DU_DEPOT` dans un terminal.

### 4. Installer les gems
Les "gems" sont des paquets (librairies) écrits en ruby. Pour éviter d'avoir à ré-écrire constamment les même fonctionnalités propres à la plupart des sites internet, l'application utilise un certain nombre de gemmes. Le fichier `Gemfile` liste toutes les gemmes utilisées.
Pour les installer, lancez un simple `bundle install` dans la console depuis le repertoire de l'application.

### 5. Créer la base de données
Avant de pouvoir lancer l'application, il vous faut créer votre propre version de la BDD. Executez un `rake db:schema:load`, cela créera une base de données sqlite (development.sqlite3) dans le sous-dossier `db/` de l'application.
Voilà! La partie "installation" est terminée.

### 6. Lancer redis et les background jobs
Avant de lancer le serveur local, lancez l'instance de redis avec un `redis-server` dans une console.

L'application utilise un système pour pouvoir effectuer des tâches en arrière plan, qui ne ralentiront pas le chargement de la page.
Par exemple, lors de la création d'un compte, l'application doit aller demander à l'API HEI-Connect si le compte est valide. Cette requête prend plusieurs secondes (5 à 10), et on veut éviter de bloquer le chargement de la page pendant ce temps.
Pour lancer le script qui s'occupe des tâches longues en arrière plan, il faut lancer un `rake environment QUEUE='critical,high,medium,low' VERBOSE=true resque:work` dans une console.

### 7. Lancer l'application
Maintenant que tout est installé et que les différents services sont lancés, il n'y a plus qu'à faire un petit `rails server`, et c'est tout bon!
Rendez-vous sur `http://localhost:3000` pour naviguer sur l'appli.

### Récapitulons
Avant de lancer le serveur local:

* `redis-server` pour lancer redis (utilisé par l'application pour la mise en cache).
* `rake environment QUEUE='critical,high,medium,low' VERBOSE=true resque:work` pour lancer les background jobs (utilisés par l'application pour passer les appels à l'API, et récupérer les données e-campus)

Puis `rails server`, ou `rails s` pour lancer le serveur local.
Vous pouvez alors bidouiller le code de l'application, et un refresh dans le navigateur affichera les modifications.

Gardez à l'esprit que par défaut, la mise en cache est activée. Si vous modifiez du code HTML d'une page mise en cache, le resultat ne s'affichera pas à l'écran tant que la ressource liée n'aura pas été changée!
Pour éviter les prises de tête sans fin, vous pouvez désactiver la mise en cache, en commentant la ligne suivante du fichier `config/environments/development.rb`:
`config.action_controller.perform_caching = true`
Pour commenter une instruction en ruby, il faut ajouter un `#` en début de ligne.

Une fois terminé, `Ctrl+C` pour arrêter le serveur local, l'instance de redis, et les background jobs.

### Sauvegardez vos modifications et propagez-les
Au fur et à mesure de votre travail, sauvegardez vos modifications sur votre dépôt git. Une fois satifait du résultat, retournez sur la page github de votre fork, et lancez une "pull request".

Cela ouvrira une "pull request" sur github, où l'on pourra discuter de vos modifications, et les intégrer au dépôt principal.

### Pour en savoir plus
Pour comprendre ce que vous faites (et ce que vous avez fait en suivant les étapes 1 à 6), on vous recommande de vous plonger dans l'un des très nombreux tutos disponibles sur internet. Préférez les versions anglaises (oui...). Rails demande un certain investissement (le framework est dense, et il faut appréhender le Ruby), mais encore une fois, ça vaut le coup!

* [Railstutorial.org](http://ruby.railstutorial.org/)
* [Rails for zombies](http://railsforzombies.org/)

## Les projets autour d'HEI-Connect
### HEI-Connect
L'API de base permettant de récupérer en JSON des données depuis e-campus.
[Projet GitHub](https://github.com/ldavin/hei-connect)

### [HEI-Connect-Web](http://www.hei-connect.eu)
Une application web communiquant avec HEI-Connect, visant à créer un e-campus "parallèle", plus rapide, plus simple d'utilisation, avec de nouvelles fonctionnalités.
[Projet GitHub](https://github.com/ldavin/hei-connect-web)
