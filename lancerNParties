
/* Commenter les affichages à l'écran */
lancerNParties(N) :-
	lancerNParties(1, N, 0, 0, 0), !.

lancerNParties(Iteration, IterationMax, Xgagne, Ogagne, Egalite) :-
	Iteration > IterationMax,
	write('X GAGNE : '), write(Xgagne),
	write('      O GAGNE : '), write(Ogagne),
	write('      EGALITE : '), write(Egalite).

lancerNParties(Iteration, IterationMax, Xgagne, Ogagne, Egalite) :-
	Iteration =< IterationMax,
	write_ln(Iteration),
	partieIAvsIA,
	testGagne(Iteration, IterationMax, Xgagne, Ogagne, Egalite).

testGagne(Iteration, IterationMax, Xgagne, Ogagne, Egalite) :-
	testPionGagnant(x, o, X), X == 1,
	!, 
	Xgagne2 is Xgagne + 1,
	IterationSuivante is Iteration + 1,
	lancerNParties(IterationSuivante, IterationMax, Xgagne2, Ogagne, Egalite).

testGagne(Iteration, IterationMax, Xgagne, Ogagne, Egalite) :-
	testPionGagnant(x, o, X), X == 2,
	!, 
	Ogagne2 is Ogagne + 1,
	IterationSuivante is Iteration + 1,
	lancerNParties(IterationSuivante, IterationMax, Xgagne, Ogagne2, Egalite).

testGagne(Iteration, IterationMax, Xgagne, Ogagne, Egalite) :-
	testPionGagnant(x, o, X), X == 2,
	!, 
	Egalite2 is Egalite + 1,
	IterationSuivante is Iteration + 1,
	lancerNParties(IterationSuivante, IterationMax, Xgagne, Ogagne, Egalite2).


