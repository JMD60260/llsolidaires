READ ME Les Logements Solidaires

__
Versions Utilisées

    Ruby version 2.6.5
    Rails version 6.0.2.1
    CSS : Bootstrap

API Utilisées
Pour Github

    dirige toi via ton terminal dans le dossier que tu souhaites
    git clone git@github.com:JMD60260/llsolidaires.git
    cd llsolidaires
    bundle install
    rails db:create

=> Puis pour commencer à travailler

    git checkout master

    git pull origin master

    git branch nom_de_ta_branche

    git checkout nom_de_ta_branche

Tu peux alors coder normalement / puis

    git add .

    git commit -m "ton commentaire"

Pour Merger

    git checkout master
    git pull origin master
    git checkout nom_de_ta_branche
    git merge master
    git checkout master
    git merge nom_de_ta_branche
    git push origin master
