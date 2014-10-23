partieIAvsRandom :-
	retract(gamestate(_)) , assert(gamestate([[],[],[],[],[],[],[]])),
	partieIAvsRandom(x,4,1).

partieIAvsRandom(Pion,CoupDavance,X) :-
	(1 is mod(X, 2)),
	!,
	iaMinMax(Pion,CoupDavance,NumColonne,LigneDuNouvelElem),
	afficherGrille,
	testGagner5(Pion, NumColonne,LigneDuNouvelElem,X).

partieIAvsRandom(Pion,_,X) :-
	not(1 is mod(X, 2)),
	!,
	iaRandom(Pion, Colonne,LigneDuNouvelElem),
	afficherGrille,
	testGagner5(Pion, Colonne,LigneDuNouvelElem,X).


testGagner5(Pion, NumColonne,LigneDuNouvelElem, Y) :-
	gamestate(X),
	Ligne is LigneDuNouvelElem - 1,
	Colonne is NumColonne-1,
	not(sh(_,X,Ligne)),
	not(sv(_,X,Colonne)),
	not(sd(_)),

	changerPion(Pion, Adversaire),
	write('\n Au tour de '),write(Adversaire), write(' de jouer\n'),
	sleep(2),
	Y2 is Y+1,
	partieIAvsRandom(Adversaire,4,Y2),!.


testGagner5(Pion, NumColonne,LigneDuNouvelElem, _) :-
	gamestate(X),
	Ligne is LigneDuNouvelElem - 1,
	Colonne is NumColonne-1,
	( (sh(UnPion,X,Ligne),Message = ' a gagné horizontalement');
	  (sv(UnPion,X,Colonne), Message = ' a gagné verticalement');
	  (sd(UnPion), Message = ' a gagné diagonalement')
	),
	Pion = UnPion,
	write(Pion), write(Message),
	finPartie.

partieIaAmeliorevsRandom :-
	retract(gamestate(_)) , assert(gamestate([[],[],[],[],[],[],[]])),
	partieIaAmeliorevsRandom(x,4,1).

partieIaAmeliorevsRandom(Pion,CoupDavance,X) :-
	(1 is mod(X, 2)),
	!,
	iaBigBoss(Pion,CoupDavance,NumColonne,LigneDuNouvelElem),
	afficherGrille,
	testGagner6(Pion, NumColonne,LigneDuNouvelElem,X).

partieIaAmeliorevsRandom(Pion,_,X) :-
	not(1 is mod(X, 2)),
	!,
	iaRandom(Pion, Colonne,LigneDuNouvelElem),
	afficherGrille,
	testGagner6(Pion, Colonne,LigneDuNouvelElem,X).

testGagner6(Pion, NumColonne,LigneDuNouvelElem, Y) :-
	gamestate(X),
	Ligne is LigneDuNouvelElem - 1,
	Colonne is NumColonne-1,
	not(sh(_,X,Ligne)),
	not(sv(_,X,Colonne)),
	not(sd(_)),

	changerPion(Pion, Adversaire),
	write('\n Au tour de '),write(Adversaire), write(' de jouer\n'),
	sleep(2),
	Y2 is Y+1,
	partieIaAmeliorevsRandom(Adversaire,4,Y2),!.


testGagner6(Pion, NumColonne,LigneDuNouvelElem, _) :-
	gamestate(X),
	Ligne is LigneDuNouvelElem - 1,
	Colonne is NumColonne-1,
	( (sh(UnPion,X,Ligne),Message = ' a gagné horizontalement');
	  (sv(UnPion,X,Colonne), Message = ' a gagné verticalement');
	  (sd(UnPion), Message = ' a gagné diagonalement')
	),
	Pion = UnPion,
	write(Pion), write(Message),
	finPartie.