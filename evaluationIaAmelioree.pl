% Liste qui sauvegarde le nombre de chaque alignement avec possibilité de jouer au dessu
:-dynamic(evalColonne/1).
evalColonne([]).

:-dynamic(evalLigne/1).
evalLigne([]).

:-dynamic(evalDiagonale/1).
evalDiagonale([]).

:-dynamic(temp/1).
temp([]).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%% Vérification verticale %%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

nbSeries3Verticales(Pion, Nombre) :-
	seriesVerticales(Pion),
	evalColonne(Eval),
	nbElementsDansListe(Eval, 3, 1, 0),
	temp(X), nth1(1, X, Resultat),
	Nombre is Resultat.

nbSeries2Verticales(Pion, Nombre) :-
	seriesVerticales(Pion),
	evalColonne(Eval),
	nbElementsDansListe(Eval, 2, 1, 0),
	temp(X), nth1(1, X, Resultat),
	Nombre is Resultat.

nbSeries1Verticales(Pion, Nombre) :-
	seriesVerticales(Pion),
	evalColonne(Eval),
	nbElementsDansListe(Eval, 1, 1, 0),
	temp(X), nth1(1, X, Resultat),
	Nombre is Resultat.

seriesVerticales(Pion) :-
	retract(evalColonne(_)), assert(evalColonne([])),
	nombrePionsAlignesVerticalement(1, Pion),
	nombrePionsAlignesVerticalement(2, Pion),
	nombrePionsAlignesVerticalement(3, Pion),
	nombrePionsAlignesVerticalement(4, Pion),
	nombrePionsAlignesVerticalement(5, Pion),
	nombrePionsAlignesVerticalement(6, Pion),
	nombrePionsAlignesVerticalement(7, Pion).

% On effectue la vérification pour un pion et une colonne donnés
nombrePionsAlignesVerticalement(NumColonne, Pion) :-
	gamestateTampon(X), nth1(NumColonne, X, Col),
	% On renverse la colonne car on parcours à l'envers (depuis tailleColonne jusqu'à 0)
	reverse(Col, Colonne),
	length(Colonne, TailleColonne),
	nombrePionsAlignesVerticalement(Colonne, Pion, TailleColonne, 0).

% Condition d'arrêt si on a explorer toute la colonne
nombrePionsAlignesVerticalement(_, _, TailleColonne, PionsAlignes) :-
	TailleColonne == 0,
	!,
	enregistrerDansEvalColonne(PionsAlignes).

nombrePionsAlignesVerticalement(Colonne, Pion, TailleColonne, PionsAlignes) :-
	TailleColonne \= 0,
	!,
	% On récupère le pion qui est à la place TailleColonne
	nth1(TailleColonne, Colonne, PionChoisi),
	incrementeSiIdentique(Colonne, PionChoisi, Pion, PionsAlignes, TailleColonne).

% Si le pion choisi est identique au pion du joueur on incrémente
incrementeSiIdentique(Colonne, PionChoisi, Pion, PionsAlignes, TailleColonne) :-
	PionChoisi == Pion,
	!,
	PionsAlignes2 is (PionsAlignes + 1),
	TailleColonne2 is (TailleColonne - 1),
	nombrePionsAlignesVerticalement(Colonne, Pion, TailleColonne2, PionsAlignes2).

% Si le pion choisi est différent du pion du joueur on recommence à zéro
incrementeSiIdentique(Colonne, PionChoisi, Pion, _, TailleColonne) :-
	PionChoisi \= Pion,
	!,
	TailleColonne2 is (TailleColonne - 1),
	nombrePionsAlignesVerticalement(Colonne, Pion, TailleColonne2, 0).

% Si on a un alignement supérieur ou égal à 1 pion, on sauvegarde
enregistrerDansEvalColonne(NombrePionsAlignes) :-
	NombrePionsAlignes >= 1,
	!,
	evalColonne(ListeNombrePions),
	append(ListeNombrePions, [NombrePionsAlignes], NouveauNombrePions),
	retract(evalColonne(_)),
	assert(evalColonne(NouveauNombrePions)).

% Si on a un alignement maximum d'un pion, ce n'est pas la peine de sauvegarder
enregistrerDansEvalColonne(NombrePionsAlignes) :-
	NombrePionsAlignes < 1,
	!,
	evalColonne(ListeNombrePions),
	append(ListeNombrePions, [NombrePionsAlignes], NouveauNombrePions),
	retract(evalColonne(_)),
	assert(evalColonne(NouveauNombrePions)).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%% Vérification horizontale %%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

nbSeries3Horizontales(Pion, Nombre) :-
	seriesHorizontales(Pion),
	evalLigne(Eval),
	nbElementsDansListe(Eval, 3, 1, 0),
	temp(X), nth1(1, X, Resultat),
	Nombre is Resultat,
	!.

nbSeries2Horizontales(Pion, Nombre) :-
	seriesHorizontales(Pion),
	evalLigne(Eval),
	nbElementsDansListe(Eval, 2, 1, 0),
	temp(X), nth1(1, X, Resultat),
	Nombre is Resultat,
	!.

nbSeries1Horizontales(Pion, Nombre) :-
	seriesHorizontales(Pion),
	evalLigne(Eval),
	nbElementsDansListe(Eval, 1, 1, 0),
	temp(X), nth1(1, X, Resultat),
	Nombre is Resultat,
	!.

seriesHorizontales(Pion) :-
	retract(evalLigne(_)), assert(evalLigne([])),
	reconstitutionLigne(1, L1),
	evalLignePleine(L1, Pion),
	reconstitutionLigne(2, L2),
	evalLignePleine(L2, Pion),
	reconstitutionLigne(3, L3),
	evalLignePleine(L3, Pion),
	reconstitutionLigne(4, L4),
	evalLignePleine(L4, Pion),
	reconstitutionLigne(5, L5),
	evalLignePleine(L5, Pion),
	reconstitutionLigne(6, L6),
	evalLignePleine(L6, Pion).

% On vérifie s'il n'y a pas de 0 dans la liste, ce qui veut dire que la liste est pleine on a pas besoin de faire de vérification
evalLignePleine(Ligne, _) :-
	nbElementsDansListe(Ligne, 0, 1, 0),
	temp(X), nth1(1, X, Resultat),
	Resultat == 0,
	!.

% On vérifie s'il y a des 0 dans la liste, on a besoin de faire les vérifications
evalLignePleine(Ligne, Pion) :-
	nbElementsDansListe(Ligne, 0, 1, 0),
	temp(X), nth1(1, X, Resultat),
	Resultat > 0,
	!,
	reconstitutionSousLigne(1, Ligne, SL1),
	reconstitutionSousLigne(2, Ligne, SL2),
	reconstitutionSousLigne(3, Ligne, SL3),
	reconstitutionSousLigne(4, Ligne, SL4),
	evalLigne_(SL1, Pion, 1, 0, 0),
	evalLigne_(SL2, Pion, 1, 0, 0),
	evalLigne_(SL3, Pion, 1, 0, 0),
	evalLigne_(SL4, Pion, 1, 0, 0).

evalLigne_(_, _, Iteration, PionsAlignes, Zeros) :-
	Iteration > 4,
	!,
	PionsAlignes2 is PionsAlignes - Zeros,
	enregistrerDansEvalLigne(PionsAlignes2).

evalLigne_(Ligne, Pion, Iteration, PionsAlignes, Zeros) :-
	Iteration =< 4,
	!,
	nth1(Iteration, Ligne, PionChoisi),
	incrementeSiIdentique_H(Ligne, PionChoisi, Pion, PionsAlignes, Zeros, Iteration).

incrementeSiIdentique_H(Ligne, PionChoisi, Pion, PionsAlignes, Zeros, Iteration) :-
	PionChoisi == Pion,
	!,
	PionsAlignes2 is (PionsAlignes + 1),
	Iteration2 is Iteration + 1,
	evalLigne_(Ligne, Pion, Iteration2, PionsAlignes2, Zeros).

incrementeSiIdentique_H(Ligne, PionChoisi, Pion, PionsAlignes, Zeros, Iteration) :-
	PionChoisi == 0,
	!,
	Zeros2 is Zeros+1,
	Iteration2 is Iteration + 1,
	PionsAlignes2 is PionsAlignes + 1,
	evalLigne_(Ligne, Pion, Iteration2, PionsAlignes2, Zeros2).

% Si le pion choisi est différent du pion du joueur on recommence à zéro
incrementeSiIdentique_H(_, PionChoisi, Pion, _, _, _) :-
	PionChoisi \= Pion,
	!.

enregistrerDansEvalLigne(NombrePionsAlignes) :-
	NombrePionsAlignes >= 1,
	!,
	evalLigne(ListeNombrePions),
	append(ListeNombrePions, [NombrePionsAlignes], NouveauNombrePions),
	retract(evalLigne(_)),
	assert(evalLigne(NouveauNombrePions)).

enregistrerDansEvalLigne(NombrePionsAlignes) :-
	NombrePionsAlignes < 1.

reconstitutionLigne(NumLigne, Ligne) :-
	gamestateTampon(Gamestate),
	nth1(1, Gamestate, C1), nth1(2, Gamestate, C2), nth1(3, Gamestate, C3), nth1(4, Gamestate, C4), nth1(5, Gamestate, C5), nth1(6, Gamestate, C6), nth1(7, Gamestate, C7),
	recupererElementPourLigne(NumLigne, C1, E1),
	recupererElementPourLigne(NumLigne, C2, E2),
	recupererElementPourLigne(NumLigne, C3, E3),
	recupererElementPourLigne(NumLigne, C4, E4),
	recupererElementPourLigne(NumLigne, C5, E5),
	recupererElementPourLigne(NumLigne, C6, E6),
	recupererElementPourLigne(NumLigne, C7, E7),
	append([E1], [E2], L1),
	append(L1, [E3], L2),
	append(L2, [E4], L3),
	append(L3, [E5], L4),
	append(L4, [E6], L5),
	append(L5, [E7], Ligne).

reconstitutionSousLigne(NumSousLigne, Ligne, SousLigne) :-
	nth1(NumSousLigne, Ligne, E1),
	NumSousLigne2 is NumSousLigne + 1,
	nth1(NumSousLigne2, Ligne, E2),
	NumSousLigne3 is NumSousLigne + 2,
	nth1(NumSousLigne3, Ligne, E3),
	NumSousLigne4 is NumSousLigne + 3,
	nth1(NumSousLigne4, Ligne, E4),
	append([E1], [E2], SL1),
	append(SL1, [E3], SL2),
	append(SL2, [E4], SousLigne).

recupererElementPourLigne(NumLigne, Colonne, Element) :-
	length(Colonne, TailleColonne),
	NumLigne =< TailleColonne,
	!,
	nth1(NumLigne, Colonne, Element).

recupererElementPourLigne(NumLigne, Colonne, Element) :-
	length(Colonne, TailleColonne),
	NumLigne > TailleColonne,
	!,
	Element is 0.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%% Vérification diagonale %%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

nbSeries3Diagonales(Pion, Nombre) :-
	seriesDiagonales(Pion),
	evalDiagonale(Eval),
	nbElementsDansListe(Eval, 3, 1, 0),
	temp(X), nth1(1, X, Resultat),
	Nombre is Resultat,
	!.

nbSeries2Diagonales(Pion, Nombre) :-
	seriesDiagonales(Pion),
	evalDiagonale(Eval),
	nbElementsDansListe(Eval, 2, 1, 0),
	temp(X), nth1(1, X, Resultat),
	Nombre is Resultat,
	!.

nbSeries1Diagonales(Pion, Nombre) :-
	seriesDiagonales(Pion),
	evalDiagonale(Eval),
	nbElementsDansListe(Eval, 1, 1, 0),
	temp(X), nth1(1, X, Resultat),
	Nombre is Resultat,
	!.

seriesDiagonales(Pion) :-
	retract(evalDiagonale(_)), assert(evalDiagonale([])),
	diagInfSimul1(DiagInfSimul1), evalDiagonale(DiagInfSimul1, Pion),
	diagInfSimul2(DiagInfSimul2), evalDiagonale(DiagInfSimul2, Pion),
	diagInfSimul3(DiagInfSimul3), evalDiagonale(DiagInfSimul3, Pion),
	diagInfSimul4(DiagInfSimul4), evalDiagonale(DiagInfSimul4, Pion),
	diagInfSimul5(DiagInfSimul5), evalDiagonale(DiagInfSimul5, Pion),
	diagInfSimul6(DiagInfSimul6), evalDiagonale(DiagInfSimul6, Pion),

	diagSupSimul1(DiagSupSimul1), evalDiagonale(DiagSupSimul1, Pion),
	diagSupSimul2(DiagSupSimul2), evalDiagonale(DiagSupSimul2, Pion),
	diagSupSimul3(DiagSupSimul3), evalDiagonale(DiagSupSimul3, Pion),
	diagSupSimul4(DiagSupSimul4), evalDiagonale(DiagSupSimul4, Pion),
	diagSupSimul5(DiagSupSimul5), evalDiagonale(DiagSupSimul5, Pion),
	diagSupSimul6(DiagSupSimul6), evalDiagonale(DiagSupSimul6, Pion).

evalDiagonale(Diagonale, Pion) :-
	evalDiagonale(Diagonale, Pion, 0, 1).

evalDiagonale(_, _, PionsAlignes, Iteration) :-
	Iteration > 7,
	!,
	enregistrerDansEvalDiagonale(PionsAlignes).

evalDiagonale(Diagonale, Pion, PionsAlignes, Iteration) :-
	Iteration =< 7,
	!,
	nth1(Iteration, Diagonale, PionChoisi),
	incrementeSiIdentique_D(Diagonale, PionChoisi, Pion, PionsAlignes, _, Iteration).


incrementeSiIdentique_D(Diagonale, PionChoisi, Pion, PionsAlignes, _, Iteration) :-
	PionChoisi == Pion,
	!,
	Iteration2 is Iteration + 1,
	PionsAlignes2 is PionsAlignes + 1,
	evalDiagonale(Diagonale, Pion, PionsAlignes2, Iteration2).

incrementeSiIdentique_D(Diagonale, PionChoisi, Pion, PionsAlignes, _, Iteration) :-
	Z =z,
	PionChoisi \= Pion, PionChoisi \= Z,
	!,
	Iteration2 is Iteration + 1,
	enregistrerDansEvalDiagonale(PionsAlignes),
	evalDiagonale(Diagonale, Pion, 0, Iteration2).

incrementeSiIdentique_D(Diagonale, PionChoisi, Pion, PionsAlignes, _, Iteration) :-
	Z = z,
	PionChoisi == Z,
	!,
	Iteration2 is Iteration + 1,
	evalDiagonale(Diagonale, Pion, PionsAlignes, Iteration2).

enregistrerDansEvalDiagonale(NombrePionsAlignes) :-
	NombrePionsAlignes >= 1,
	!,
	evalDiagonale(ListeNombrePions),
	append(ListeNombrePions, [NombrePionsAlignes], NouveauNombrePions),
	retract(evalDiagonale(_)),
	assert(evalDiagonale(NouveauNombrePions)).

enregistrerDansEvalDiagonale(NombrePionsAlignes) :-
	NombrePionsAlignes == 0,
	!.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

nbElementsDansListe(Liste, Element, Iteration, Nombre) :-
	length(Liste, TailleListe),
	Iteration =< TailleListe,
	!,
	nbElementsDansListe_(Liste, Element, Iteration, Nombre).

nbElementsDansListe(Liste, _, Iteration, Nombre) :-
	length(Liste, TailleListe),
	Iteration > TailleListe,
	!,
	retract(temp(_)), assert(temp([Nombre])).

nbElementsDansListe_(Liste, Element, Iteration, Nombre) :-
	nth1(Iteration, Liste, ElementAComparer),
	ElementAComparer == Element,
	!,
	Iteration2 is Iteration+1,
	Nombre2 is Nombre+1,
	nbElementsDansListe(Liste, Element, Iteration2, Nombre2).

nbElementsDansListe_(Liste, Element, Iteration, Nombre) :-
	nth1(Iteration, Liste, ElementAComparer),
	ElementAComparer \= Element,
	!,
	Iteration2 is Iteration+1,
	nbElementsDansListe(Liste, Element, Iteration2, Nombre).