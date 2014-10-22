%principe : Affiche les elements du jeu en faisant un parcours d'une
% grille de gauche a droite en commencant par l'etage 6 (étage du haut)
% puis en descendant jusqu'a la fin du jeu etage 1

:-dynamic iteration/1.
iteration([6,5,4,3,2,1]).

%affiche toute la grille grace a un nombre d'iteration predefini
afficherGrille :-
	iteration(Y), Y = [Tete|_],
	write('\n   ________________________________________\n'),
	gamestate(X),

	afficherGrille(X, Tete).
	%nth1(1, X, Col1), nth1(2, X, Col2), nth1(3, X, Col3), nth1(4, X, Col4), nth1(5, X, Col5), nth1(6, X, Col6), nth1(7, X, Col7),
	%reverse(Col1, Col1_), reverse(Col2, Col2_), reverse(Col3, Col3_), reverse(Col4, Col4_), reverse(Col5, Col5_), reverse(Col6, Col6_), reverse(Col7, Col7_),
	%afficherGrille([Col1_, Col2_, Col3_, Col4_, Col5_, Col6_, Col7_], Tete).


%regle d'arrivee a la fin du ligne
afficherGrille([], _) :-
	finLigne.

%affiche la ligne NumLigne du jeu Gamestate
afficherGrille(Gamestate, NumLigne) :-
	write('  |  '),
	%recupere la premiere liste ( la premiere colonne du jeu) dans Tete
	Gamestate = [Tete|Queue],
	length(Tete, Longueur),
	%calcul le NbElementsVides a partir de la ligne NumLigne de la grille
	NbElementsVides is NumLigne-Longueur,
	ecrireElement(Tete, Queue, NumLigne, NbElementsVides).

finAfficherGrille :-
	retract(iteration(_)) , assert(iteration([6,5,4,3,2,1])).

ecrireElement(Colonne, ColonnesSuivantes, NumLigne, NbElementsVides) :-
	NbElementsVides =< 0,

	%Colonne = [Tete|_],
	Index is NumLigne - 1 ,    %indice commence a partir de 0
	%on renverse l'orde des éléments de la colonne pour l'affichage!
	%reverse(Colonne,ColonneReversed),
	%nth0(Index,ColonneReversed,Elem),
	nth0(Index,Colonne,Elem),
	write(Elem),
	afficherGrille(ColonnesSuivantes, NumLigne).

ecrireElement( _ , ColonnesSuivantes, NumLigne, NbElementsVides) :-
	NbElementsVides > 0,
	!,
	write(' '),
	afficherGrille(ColonnesSuivantes, NumLigne).

finLigne :-
	write('  |\n'),
	write('   ________________________________________\n'),
	iteration(X), pop(X, Y),
	retract(iteration(X)) , assert(iteration(Y)),
	testTableauIteration(Y).

testTableauIteration(Iteration) :-
	Iteration = [IterationCourante| _ ],% [IterationCourante|IterationRestantes],
	!,
	write('\n'),
	gamestate(X), afficherGrille(X, IterationCourante).

testTableauIteration([]) :-
	finAfficherGrille.

pop(Liste, Queue) :-
			Liste = [_|Queue].
