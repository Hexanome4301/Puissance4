% Liste qui sauvegarde le nombre de chaque alignement avec possibilité de jouer au dessu
:-dynamic(evalColonne/1).
evalColonne([]).
	
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%% Vérification verticale %%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%	

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
	gamestate(X), nth1(NumColonne, X, Col),
	% On renverse la colonne car on parcours à l'envers (depuis tailleColonne jusqu'à 0)
	reverse(Col, Colonne),
	length(Colonne, TailleColonne),
	
	nombrePionsAlignesVerticalement(Colonne, Pion, TailleColonne, 0).

% Condition d'arrêt si on a explorer toute la colonne
nombrePionsAlignesVerticalement(Colonne, Pion, TailleColonne, PionAlignes) :-
	TailleColonne == 0,
	!,
	enregistrerDansEvalColonne(PionAlignes).
	
nombrePionsAlignesVerticalement(Colonne, Pion, TailleColonne, PionAlignes) :-
	TailleColonne \= 0,
	!,
	% On récupère le pion qui est à la place TailleColonne
	nth1(TailleColonne, Colonne, PionChoisi),
	incrementeSiIdentique(Colonne, PionChoisi, Pion, PionAlignes, TailleColonne).

% Si le pion choisi est identique au pion du joueur on incrémente
incrementeSiIdentique(Colonne, PionChoisi, Pion, PionAlignes, TailleColonne) :-
	PionChoisi == Pion,
	!,
	PionAlignes2 is (PionAlignes + 1),
	TailleColonne2 is (TailleColonne - 1),
	nombrePionsAlignesVerticalement(Colonne, Pion, TailleColonne2, PionAlignes2).

% Si le pion choisi est différent du pion du joueur on recommence à zéro 
incrementeSiIdentique(Colonne, PionChoisi, Pion, PionAlignes, TailleColonne) :-
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

