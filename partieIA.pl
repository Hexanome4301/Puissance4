partieAleatoire :-
	retract(gamestate(_)) , assert(gamestate([[],[],[],[],[],[],[]])),
	partieAleatoire(x).

partieAleatoire(Pion) :-
	iaRandom(Pion,NumColonne,LigneDuNouvelElem),
	afficherGrille,
	testGagner(Pion, NumColonne,LigneDuNouvelElem).

partieIAvsIA :-
	retract(gamestate(_)) , assert(gamestate([[],[],[],[],[],[],[]])),
	partieIAvsIA(x,2).

partieIAvsIA(Pion,CoupDavance) :-
	iaMinMax(Pion,CoupDavance,NumColonne,LigneDuNouvelElem),
	%afficherGrille,
	testGagner2(Pion, NumColonne,LigneDuNouvelElem).


testGagner(Pion, NumColonne,LigneDuNouvelElem) :-
	gamestate(X),
	Ligne is LigneDuNouvelElem - 1,
	Colonne is NumColonne-1,
	not(sh(_,X,Ligne)),
	not( sd(_)),
	not(sv(_,X,Colonne)),

	changerPion(Pion, Adversaire),
	%write('\n Au tour de '),write(Adversaire), write(' de jouer\n'),
	%sleep(2),
	partieAleatoire(Adversaire),!.


testGagner(Pion, NumColonne,LigneDuNouvelElem) :-
	gamestate(X),
	Ligne is LigneDuNouvelElem - 1,
	Colonne is NumColonne-1,
	% UnPion represente le nom du vainqueur a ce coup.
	% En principe si il y a vainqueur UnPion forcement est egale a Pion

	( (sh(UnPion,X,Ligne),Message = ' a gagné horizontalement');
	  (sv(UnPion,X,Colonne), Message = ' a gagné verticalement');
	  (sd(UnPion), Message = ' a gagné diagonalement')
	),
	Pion = UnPion,
	%write(Pion), write(Message),
	finPartie.

testGagner2(Pion, NumColonne,LigneDuNouvelElem) :-
	gamestate(X),
	Ligne is LigneDuNouvelElem - 1,
	Colonne is NumColonne-1,
	not(sh(_,X,Ligne)),

	not(sv(_,X,Colonne)),

	changerPion(Pion, Adversaire),
	%write('\n Au tour de '),write(Adversaire), write(' de jouer\n'),
	%sleep(2),
	partieIAvsIA(Adversaire,2),!.


testGagner2(Pion, NumColonne,LigneDuNouvelElem) :-
	gamestate(X),
	Ligne is LigneDuNouvelElem - 1,
	Colonne is NumColonne-1,
	( (sh(UnPion,X,Ligne),Message = ' a gagné horizontalement');
	  (sv(UnPion,X,Colonne), Message = ' a gagné verticalement');
	  (sd(UnPion), Message = ' a gagné diagonalement')
	),
	Pion = UnPion,
	%write(Pion), write(Message),
	finPartie.

testPionGagnant(Pion, Adversaire, X) :-
	(sd(Pion) ; sh(Pion) ; sv(Pion)), not(sd(Adversaire)), not(sh(Adversaire)), not(sv(Adversaire)),
	!,
	X is 1.

testPionGagnant(Pion, Adversaire, X) :-
	not(sd(Pion)), not(sh(Pion)), not(sv(Pion)), (sd(Adversaire) ; sh(Adversaire) ; sv(Adversaire)),
	!,
	X is 2.

testPionGagnant(Pion, Adversaire, X) :-
	not(sd(Pion)), not(sh(Pion)), not(sv(Pion)), not(sd(Adversaire)), not(sh(Adversaire)), not(sv(Adversaire)),
	!,
	X is 3.
