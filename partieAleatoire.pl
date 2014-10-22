partieAleatoire :-
	retract(gamestate(_)) , assert(gamestate([[],[],[],[],[],[],[]])),
	partieAleatoire(x).

partieAleatoire(Pion) :-
	iaRandom(Pion,NumColonne,LigneDuNouvelElem),
	afficherGrille,
	testGagner(Pion, NumColonne,LigneDuNouvelElem).

%testGagner(Pion) :-
%	gamestate(Grille), nth1(NumColonne, Grille, Colonne),
%	length(Colonne, LineNumber),
%	LineNumber2 is LineNumber-1,
%	(not(sv(Pion)), not(sh(Pion, LineNumber2))),
%	!,
%	changerPion(Pion, Adversaire), partieAleatoire(Adversaire).

testGagner(Pion, NumColonne,LigneDuNouvelElem) :-
	gamestate(X),
	Ligne is LigneDuNouvelElem - 1,
	Colonne is NumColonne-1,
	not(sh(_,X,Ligne)),

	not(sv(_,X,Colonne)),

	changerPion(Pion, Adversaire),
	write('\n Au tour de '),write(Adversaire), write(' de jouer\n'),
	partieAleatoire(Adversaire),!.


testGagner(Pion, NumColonne,LigneDuNouvelElem) :-
	gamestate(X),
	Ligne is LigneDuNouvelElem - 1,
	Colonne is NumColonne-1,
	% UnPion represente le nom du vainqueur a ce coup.
	% En principe si il y a vainqueur UnPion forcement est egale a Pion

	( (sh(UnPion,X,Ligne),Message = ' a gagné horizontalement');
	  (sv(UnPion,X,Colonne), Message = ' a gagné verticalement')
	),
	Pion = UnPion,
	write(Pion), write(Message),
	finPartie.