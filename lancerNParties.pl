
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
	testPionGagnant(x, o, X), X == 3,
	!, 
	Egalite2 is Egalite + 1,
	IterationSuivante is Iteration + 1,
	lancerNParties(IterationSuivante, IterationMax, Xgagne, Ogagne, Egalite2).


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