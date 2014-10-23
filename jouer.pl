jouer(x, Colonne) :-
	jouer(x, Colonne, _).

jouer(o, Colonne) :-
	jouer(o, Colonne, _).

jouer(Jeton,NumCol,Newgamestate):-
	jouer(Jeton,NumCol,Newgamestate,_).

jouer(Jeton,1,Newgamestate,LigneDuNouvelElem):-
	% on recupere toute les colonnes dans les variables
	gamestate(X), nth0(0, X, ColChoisi), nth0(1, X, C2), nth0(2, X, C3), nth0(3, X, C4), nth0(4, X, C5), nth0(5, X, C6), nth0(6, X, C7),

	checkTaille(ColChoisi),
	                      								%ici test si ColChoisi n'a pas deja 6 jetons
	reverse(ColChoisi, Temp1),
	append([Jeton],Temp1,Temp2),
	reverse(Temp2, NewCol),
		              								%ajout du nouveau jeton
	length(NewCol,NewTaille),
	LigneDuNouvelElem = NewTaille,

	retract(gamestate(_)),	                       								%on retire la configuration du precedent gamestate en donnee
	assert(gamestate([NewCol,C2,C3,C4,C5,C6,C7])), 								%on insere la nouvelle configuration de gamestate en donnee
	gamestate(Newgamestate),                       								%on affiche en resultat l'etat du gamestate apres le coup joue
	nth0(0, Newgamestate, NewCol), length(NewCol, L), insertDiag(L,1,Jeton). 	%on insere l'élément qu on ajoute dans une diagonale

jouer(Jeton,2,Newgamestate,LigneDuNouvelElem):-
	gamestate(X), nth0(0, X, C1), nth0(1, X, ColChoisi), nth0(2, X, C3), nth0(3, X, C4), nth0(4, X, C5), nth0(5, X, C6), nth0(6, X, C7),

	checkTaille(ColChoisi),

	reverse(ColChoisi, Temp1),
	append([Jeton],Temp1,Temp2),
	reverse(Temp2, NewCol),

	length(NewCol,NewTaille),
	LigneDuNouvelElem = NewTaille,

	retract(gamestate(_)),
	assert(gamestate([C1,NewCol,C3,C4,C5,C6,C7])),
	gamestate(Newgamestate),
	nth0(1, Newgamestate, NewCol), length(NewCol, L), insertDiag(L,2,Jeton).

jouer(Jeton,3,Newgamestate,LigneDuNouvelElem):-
	gamestate(X), nth0(0, X, C1), nth0(1, X, C2), nth0(2, X, ColChoisi), nth0(3, X, C4),nth0(4, X, C5),nth0(5, X, C6), nth0(6, X, C7),

	checkTaille(ColChoisi),

	reverse(ColChoisi, Temp1),
	append([Jeton],Temp1,Temp2),
	reverse(Temp2, NewCol),

	length(NewCol,NewTaille),
	LigneDuNouvelElem = NewTaille,

	retract(gamestate(_)),
	assert(gamestate([C1,C2,NewCol,C4,C5,C6,C7])),
	gamestate(Newgamestate),
	nth0(2, Newgamestate, NewCol), length(NewCol, L),insertDiag(L,3,Jeton).

jouer(Jeton,4,Newgamestate,LigneDuNouvelElem):-
	gamestate(X), nth0(0, X, C1), nth0(1, X, C2), nth0(2, X, C3), nth0(3, X, ColChoisi), nth0(4, X, C5),nth0(5, X, C6), nth0(6, X, C7),

	checkTaille(ColChoisi),

	reverse(ColChoisi, Temp1),
	append([Jeton],Temp1,Temp2),
	reverse(Temp2, NewCol),

	length(NewCol,NewTaille),
	LigneDuNouvelElem = NewTaille,

	retract(gamestate(_)),
	assert(gamestate([C1,C2,C3,NewCol,C5,C6,C7])),
	gamestate(Newgamestate),
	nth0(3, Newgamestate, NewCol), length(NewCol, L), insertDiag(L,4,Jeton).

jouer(Jeton,5,Newgamestate,LigneDuNouvelElem):-
	gamestate(X), nth0(0, X, C1),nth0(1, X, C2), nth0(2, X, C3),nth0(3, X, C4),nth0(4, X, ColChoisi), nth0(5, X, C6), nth0(6, X, C7),

	checkTaille(ColChoisi),

	reverse(ColChoisi, Temp1),
	append([Jeton],Temp1,Temp2),
	reverse(Temp2, NewCol),

	length(NewCol,NewTaille),
	LigneDuNouvelElem = NewTaille,

	retract(gamestate(_)),
	assert(gamestate([C1,C2,C3,C4,NewCol,C6,C7])),
	gamestate(Newgamestate),
	nth0(4, Newgamestate, NewCol), length(NewCol, L),insertDiag(L,5,Jeton).

jouer(Jeton,6,Newgamestate,LigneDuNouvelElem):-
	gamestate(X), nth0(0, X, C1),nth0(1, X, C2),nth0(2, X, C3),nth0(3, X, C4),nth0(4, X, C5),nth0(5, X, ColChoisi), nth0(6, X, C7),

	checkTaille(ColChoisi),

	reverse(ColChoisi, Temp1),
	append([Jeton],Temp1,Temp2),
	reverse(Temp2, NewCol),

	length(NewCol,NewTaille),
	LigneDuNouvelElem = NewTaille,

	retract(gamestate(_)),
	assert(gamestate([C1,C2,C3,C4,C5,NewCol,C7])),
	gamestate(Newgamestate),
	nth0(5, Newgamestate, NewCol), length(NewCol, L), insertDiag(L,6,Jeton).

jouer(Jeton,7,Newgamestate,LigneDuNouvelElem):-
	gamestate(X), nth0(0, X, C1), nth0(1, X, C2), nth0(2, X, C3), nth0(3, X, C4), nth0(4, X, C5), nth0(5, X, C6), nth0(6, X, ColChoisi),

	checkTaille(ColChoisi),

	reverse(ColChoisi, Temp1),
	append([Jeton],Temp1,Temp2),
	reverse(Temp2, NewCol),

	length(NewCol,NewTaille),
	LigneDuNouvelElem = NewTaille,

	retract(gamestate(_)),
	assert(gamestate([C1,C2,C3,C4,C5,C6,NewCol])),
	gamestate(Newgamestate),
	nth0(6, Newgamestate, NewCol), length(NewCol, L), insertDiag(L,7,Jeton).

simulationCoup(Jeton,NumCol,Newgamestate):-
	simulationCoup(Jeton,NumCol,Newgamestate,_).

simulationCoup(Jeton,1,Newgamestate,LigneDuNouvelElem):-
	% on recupere toute les colonnes dans les variables
	gamestateTampon(X), nth0(0, X, ColChoisi), nth0(1, X, C2), nth0(2, X, C3), nth0(3, X, C4), nth0(4, X, C5), nth0(5, X, C6), nth0(6, X, C7),

	checkTaille(ColChoisi),                       								%ici test si ColChoisi n'a pas deja 6 jetons

	reverse(ColChoisi, Temp1),
	append([Jeton],Temp1,Temp2),
	reverse(Temp2, NewCol),

	length(NewCol,NewTaille),
	LigneDuNouvelElem = NewTaille,

	retract(gamestateTampon(_)),	                       								%on retire la configuration du precedent gamestateTampon en donnee
	assert(gamestateTampon([NewCol,C2,C3,C4,C5,C6,C7])), 								%on insere la nouvelle configuration de gamestateTampon en donnee
	gamestateTampon(Newgamestate),                       								%on affiche en resultat l'etat du gamestateTampon apres le coup joue
	nth0(0, Newgamestate, NewCol), length(NewCol, L), insertDiagSimul(L,1,Jeton).

simulationCoup(Jeton,2,Newgamestate,LigneDuNouvelElem):-
	gamestateTampon(X), nth0(0, X, C1), nth0(1, X, ColChoisi), nth0(2, X, C3), nth0(3, X, C4), nth0(4, X, C5), nth0(5, X, C6), nth0(6, X, C7),

	checkTaille(ColChoisi),

	reverse(ColChoisi, Temp1),
	append([Jeton],Temp1,Temp2),
	reverse(Temp2, NewCol),

	length(NewCol,NewTaille),
	LigneDuNouvelElem = NewTaille,

	retract(gamestateTampon(_)),
	assert(gamestateTampon([C1,NewCol,C3,C4,C5,C6,C7])),
	gamestateTampon(Newgamestate),
	nth0(1, Newgamestate, NewCol), length(NewCol, L), insertDiagSimul(L,2,Jeton).


simulationCoup(Jeton,3,Newgamestate,LigneDuNouvelElem):-
	gamestateTampon(X), nth0(0, X, C1), nth0(1, X, C2), nth0(2, X, ColChoisi), nth0(3, X, C4),nth0(4, X, C5),nth0(5, X, C6), nth0(6, X, C7),

	checkTaille(ColChoisi),

	reverse(ColChoisi, Temp1),
	append([Jeton],Temp1,Temp2),
	reverse(Temp2, NewCol),

	length(NewCol,NewTaille),
	LigneDuNouvelElem = NewTaille,

	retract(gamestateTampon(_)),
	assert(gamestateTampon([C1,C2,NewCol,C4,C5,C6,C7])),
	gamestateTampon(Newgamestate),
	nth0(2, Newgamestate, NewCol), length(NewCol, L), insertDiagSimul(L,3,Jeton).


simulationCoup(Jeton,4,Newgamestate,LigneDuNouvelElem):-
	gamestateTampon(X), nth0(0, X, C1), nth0(1, X, C2), nth0(2, X, C3), nth0(3, X, ColChoisi), nth0(4, X, C5),nth0(5, X, C6), nth0(6, X, C7),

	checkTaille(ColChoisi),

	reverse(ColChoisi, Temp1),
	append([Jeton],Temp1,Temp2),
	reverse(Temp2, NewCol),

	length(NewCol,NewTaille),
	LigneDuNouvelElem = NewTaille,

	retract(gamestateTampon(_)),
	assert(gamestateTampon([C1,C2,C3,NewCol,C5,C6,C7])),
	gamestateTampon(Newgamestate),
	nth0(3, Newgamestate, NewCol), length(NewCol, L), insertDiagSimul(L,4,Jeton).


simulationCoup(Jeton,5,Newgamestate,LigneDuNouvelElem):-
	gamestateTampon(X), nth0(0, X, C1),nth0(1, X, C2), nth0(2, X, C3),nth0(3, X, C4),nth0(4, X, ColChoisi), nth0(5, X, C6), nth0(6, X, C7),

	checkTaille(ColChoisi),

	reverse(ColChoisi, Temp1),
	append([Jeton],Temp1,Temp2),
	reverse(Temp2, NewCol),

	length(NewCol,NewTaille),
	LigneDuNouvelElem = NewTaille,

	retract(gamestateTampon(_)),
	assert(gamestateTampon([C1,C2,C3,C4,NewCol,C6,C7])),
	gamestateTampon(Newgamestate),
	nth0(4, Newgamestate, NewCol), length(NewCol, L), insertDiagSimul(L,5,Jeton).


simulationCoup(Jeton,6,Newgamestate,LigneDuNouvelElem):-
	gamestateTampon(X), nth0(0, X, C1),nth0(1, X, C2),nth0(2, X, C3),nth0(3, X, C4),nth0(4, X, C5),nth0(5, X, ColChoisi), nth0(6, X, C7),

	checkTaille(ColChoisi),

	reverse(ColChoisi, Temp1),
	append([Jeton],Temp1,Temp2),
	reverse(Temp2, NewCol),

	length(NewCol,NewTaille),
	LigneDuNouvelElem = NewTaille,

	retract(gamestateTampon(_)),
	assert(gamestateTampon([C1,C2,C3,C4,C5,NewCol,C7])),
	gamestateTampon(Newgamestate),
	nth0(5, Newgamestate, NewCol), length(NewCol, L), insertDiagSimul(L,6,Jeton).


simulationCoup(Jeton,7,Newgamestate,LigneDuNouvelElem):-
	gamestateTampon(X), nth0(0, X, C1), nth0(1, X, C2), nth0(2, X, C3), nth0(3, X, C4), nth0(4, X, C5), nth0(5, X, C6), nth0(6, X, ColChoisi),

	checkTaille(ColChoisi),

	reverse(ColChoisi, Temp1),
	append([Jeton],Temp1,Temp2),
	reverse(Temp2, NewCol),

	length(NewCol,NewTaille),
	LigneDuNouvelElem = NewTaille,

	retract(gamestateTampon(_)),
	assert(gamestateTampon([C1,C2,C3,C4,C5,C6,NewCol])),
	gamestateTampon(Newgamestate),
	nth0(6, Newgamestate, NewCol), length(NewCol, L), insertDiagSimul(L,7,Jeton).


% regle verifiant si la liste passe en parametre est bien inferieure a 6
checkTaille(L):-
	length(L,Nb), Nb <6.

%regle envoyant un message d'erreur si la liste est deja égale à 6
checkTaille(L):-
	length(L,Nb), not(Nb<6),
	gamestate(X),
	coupPossible(X,CoupPossible),
	ListColonne = [1,2,3,4,5,6,7],
	subtract(ListColonne,CoupPossible,CoupPasPossible),

	write('Colonne(s) ') , write(CoupPasPossible) , write(' deja remplie(s), veuillez sélectionner une autre \n'),false.
