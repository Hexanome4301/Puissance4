partieAleatoire :-
	partieAleatoire(x).

partieAleatoire(Pion) :-
	iaRandom(Pion),
	afficherGrille,
	testGagner(Pion, Colonne). 
	
testGagner(Pion) :-
	gamestate(Grille), nth1(NumColonne, Grille, Colonne),
	length(Colonne, LineNumber), 
	LineNumber2 is LineNumber-1,
	(not(sv(Pion)), not(sh(Pion, LineNumber2))),
	!,
	changerPion(Pion, Adversaire), partieAleatoire(Adversaire).
	
testGagner(Pion, Colonne) :-
	sv(Pion),
	!,
	write(Pion), write(' a gagné verticalement'),
	finPartie.

testGagner(Pion, Colonne) :-
	gamestate(Grille), nth1(NumColonne, Grille, Colonne),
	length(Colonne, LineNumber),
	LineNumber2 is LineNumber-1,
	sh(Pion, LineNumber2), 
	!, 
	write(Pion), write(' a gagné horizontalement'),
	finPartie.