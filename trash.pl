% Lance une partie par defaut entre 2 joueurs : joueur x VS joueur o
partie2Joueurs :-
	partie2Joueurs(x).

partie2Joueurs(Pion) :-
	write(Pion), write(' à votre tour : '),
	read(NumColonne),
	jouer(Pion, NumColonne),
	afficherGrille,
	testGagner2Joueurs(Pion).

partie2Joueurs(Pion) :-
	write(Pion), write(' à votre tour : '),
	read(NumColonne),
	not(jouer(Pion, NumColonne)),
	partie2Joueurs(Pion).

testGagner2Joueurs(Pion) :-
	%gamestate(Grille), nth1(NumColonne, Grille, Colonne),
	%length(Colonne, LineNumber),
	%LineNumber2 is LineNumber-1,
	sh(Qui),
	Pion == Qui,
	write(Pion), write(' a gagné horizontalement'),
	finPartie.

%testGagner2Joueurs(Pion) :-
%	sd(Pion),
%	write(Pion), write(' a gagné diagonalement'),
%	finPartie.

%testGagner2Joueurs(Pion) :-
%	sv(Pion),
%	write(Pion), write(' a gagné verticalement'),
%	finPartie.

testGagner2Joueurs(Pion) :-
	%gamestate(Grille), nth1(NumColonne, Grille, Colonne),
	%length(Colonne, LineNumber),
	%LineNumber2 is LineNumber-1,
	%(not(sv(Pion)), not(sh(Pion)), not(sd(Pion))),
	sh(Qui),
	Pion == Qui,
	changerPion(Pion, Adversaire), partie2Joueurs(Adversaire).

finPartie :-
	retract(gamestate(_)) , assert(gamestate([[],[],[],[],[],[],[]])).

changerPion(x, NouveauPion) :-
	NouveauPion = o.

changerPion(o, NouveauPion) :-
	NouveauPion = x.
