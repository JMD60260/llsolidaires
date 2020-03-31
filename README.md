# README Les Logements Solidaires #

## Membres bénévoles ayant participé à cette aventure ##

+ Paul (Github ApaeP)(back)
+ Inés (back + front)
+ Brian (Github BrianRid)(back)
+ Emilie (back)
+ Alexandre (back)
+ Hugo (back + front)
+ Julien (front)
+ Pavel (front)
+ Maximilien (front)
+ Youenn (back)
+ Slim (recrutement)
+ Julie (code review et testing)
+ Saad (PO)
+ Jean-Marc DARDY git ID JMD60260 (Chef de Projet Agile)
  
***

### Outils de Gestion ###

    Trello publique (https://trello.com/b/i1IQ3aIw)
    Slack
    Zoom
    Serveur Jitsi
    Google Drive

***

#### Versions Utilisées ####

    Ruby version 2.6.5
    Rails version 6.0.2.1
    Bundler 2.1.4
    CSS : Bootstrap
    Licence AGPL3 (Merci de ne pas faire une utilisation commerciale de ce repository car nous l'avons concu pour aider les personnels de première ligne respectez notre philosophie)

***

#### API Utilisées Pour Github ####

    dirige toi via ton terminal dans le dossier que tu souhaites
    git clone git@github.com:JMD60260/llsolidaires.git
    cd llsolidaires
    bundle install
    rails db:create

***

=> Puis pour commencer à travailler

    git checkout master

    git pull origin master

    git branch nom_de_ta_branche

    git checkout nom_de_ta_branche

Tu peux alors coder normalement / puis

    git add .

    git commit -m "ton commentaire"

#### Pour Merger ####

    git checkout master
    git pull origin master
    git checkout nom_de_ta_branche
    git merge master
    git checkout master
    git merge nom_de_ta_branche
    git push origin master
