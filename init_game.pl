%lancer la commande load_files(init_game). en ligne de cmd pour bien
% charger ce fichier

:-dynamic(gamestate/1).
 gamestate([[],[],[],[],[],[],[]]).

:-dynamic(gamestateTampon/1).
 gamestateTampon([[],[],[],[],[],[],[]]).

c([x,x,y,x,x,x]).


%inclut les clauses des fichiers jouer.pl et aGagner.pl

:-use_module(library(random)).

:-include(jouer).
:-include(aGagner).
:-include(affichage).
:-include(verifications).
:-include(ia).
:-include(minMax).
%:-include(partieAleatoire).
:-include(partie2Joueurs).
%:- include(pionsAlignes).

