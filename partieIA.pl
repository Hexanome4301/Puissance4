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
	afficherGrille,
	testGagner2(Pion, NumColonne,LigneDuNouvelElem).

partieIAameliorevsIAameliore :-
	retract(gamestate(_)) , assert(gamestate([[],[],[],[],[],[],[]])),
	partieIAameliorevsIAameliore(x,4).

partieIAameliorevsIAameliore(Pion,CoupDavance) :-
	iaMinMaxAmelioree(Pion,CoupDavance,NumColonne,LigneDuNouvelElem),
	afficherGrille,
	testGagner3(Pion, NumColonne,LigneDuNouvelElem).

partieIAvsIAameliore :-
	retract(gamestate(_)) , assert(gamestate([[],[],[],[],[],[],[]])),
	partieIAvsIAameliore(x,4, 1).

partieIAvsIAameliore(Pion,CoupDavance, X) :-
	(1 is mod(X, 2)),
	!,
	iaMinMaxAmelioree(Pion,CoupDavance,NumColonne,LigneDuNouvelElem),
	afficherGrille,
	testGagner4(Pion, NumColonne,LigneDuNouvelElem, X).

partieIAvsIAameliore(Pion,CoupDavance, X) :-
	not(1 is mod(X, 2)),
	!,
	iaMinMax(Pion,CoupDavance,NumColonne,LigneDuNouvelElem),
	afficherGrille,
	testGagner4(Pion, NumColonne,LigneDuNouvelElem, X).


	partieIaAmeliorevsRandom :-
	retract(gamestate(_)) , assert(gamestate([[],[],[],[],[],[],[]])),
	partieIaAmeliorevsRandom(x,4,1).

partieIaAmeliorevsRandom(Pion,CoupDavance,X) :-
	(1 is mod(X, 2)),
	!,
	iaMinMaxAmelioree(Pion,CoupDavance,NumColonne,LigneDuNouvelElem),
	afficherGrille,
	testGagner6(Pion, NumColonne,LigneDuNouvelElem,X).

partieIaAmeliorevsRandom(Pion,_,X) :-
	not(1 is mod(X, 2)),
	!,
	iaRandom(Pion, Colonne,LigneDuNouvelElem),
	afficherGrille,
	testGagner6(Pion, Colonne,LigneDuNouvelElem,X).

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

testGagner(Pion, NumColonne,LigneDuNouvelElem) :-
	gamestate(X),
	Ligne is LigneDuNouvelElem - 1,
	Colonne is NumColonne-1,
	not(sh(_,X,Ligne)),
	not(sd(_)),
	not(sv(_,X,Colonne)),

	changerPion(Pion, Adversaire),
	write('\n Au tour de '),write(Adversaire), write(' de jouer\n'),
	sleep(2),
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
	write(Pion), write(Message),
	finPartie.

testGagner2(Pion, NumColonne,LigneDuNouvelElem) :-
	gamestate(X),
	Ligne is LigneDuNouvelElem - 1,
	Colonne is NumColonne-1,
	not(sh(_,X,Ligne)),
	not(sv(_,X,Colonne)),
	not(sd(_)),

	changerPion(Pion, Adversaire),
	write('\n Au tour de '),write(Adversaire), write(' de jouer\n'),
	sleep(2),
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
	write(Pion), write(Message),
	finPartie.

testGagner3(Pion, NumColonne,LigneDuNouvelElem) :-
	gamestate(X),
	Ligne is LigneDuNouvelElem - 1,
	Colonne is NumColonne-1,
	not(sh(_,X,Ligne)),
	not(sv(_,X,Colonne)),
	not(sd(_)),

	changerPion(Pion, Adversaire),
	write('\n Au tour de '),write(Adversaire), write(' de jouer\n'),
	sleep(2),
	partieIAameliorevsIAameliore(Adversaire,4),!.

testGagner3(Pion, NumColonne,LigneDuNouvelElem) :-
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

testGagner4(Pion, NumColonne,LigneDuNouvelElem, Y) :-
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
	partieIAvsIAameliore(Adversaire,4,Y2),!.


testGagner4(Pion, NumColonne,LigneDuNouvelElem, _) :-
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

