% Liste qui sauvegarde le nombre de chaque alignement avec possibilit� de jouer au dessu
:-dynamic(evalColonne/1).
evalColonne([]).
	
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%% V�rification verticale %%%%%%%%%%%%%%%%%%%%%%%%%
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

% On effectue la v�rification pour un pion et une colonne donn�s
nombrePionsAlignesVerticalement(NumColonne, Pion) :-
	gamestate(X), nth1(NumColonne, X, Col),
	% On renverse la colonne car on parcours � l'envers (depuis tailleColonne jusqu'� 0)
	reverse(Col, Colonne),
	length(Colonne, TailleColonne),
	
	nombrePionsAlignesVerticalement(Colonne, Pion, TailleColonne, 0).

% Condition d'arr�t si on a explorer toute la colonne
nombrePionsAlignesVerticalement(Colonne, Pion, TailleColonne, PionAlignes) :-
	TailleColonne == 0,
	!,
	enregistrerDansEvalColonne(PionAlignes).
	
nombrePionsAlignesVerticalement(Colonne, Pion, TailleColonne, PionAlignes) :-
	TailleColonne \= 0,
	!,
	% On r�cup�re le pion qui est � la place TailleColonne
	nth1(TailleColonne, Colonne, PionChoisi),
	incrementeSiIdentique(Colonne, PionChoisi, Pion, PionAlignes, TailleColonne).

% Si le pion choisi est identique au pion du joueur on incr�mente
incrementeSiIdentique(Colonne, PionChoisi, Pion, PionAlignes, TailleColonne) :-
	PionChoisi == Pion,
	!,
	PionAlignes2 is (PionAlignes + 1),
	TailleColonne2 is (TailleColonne - 1),
	nombrePionsAlignesVerticalement(Colonne, Pion, TailleColonne2, PionAlignes2).

% Si le pion choisi est diff�rent du pion du joueur on recommence � z�ro 
incrementeSiIdentique(Colonne, PionChoisi, Pion, PionAlignes, TailleColonne) :-
	PionChoisi \= Pion,
	!,
	TailleColonne2 is (TailleColonne - 1),
	nombrePionsAlignesVerticalement(Colonne, Pion, TailleColonne2, 0).

% Si on a un alignement sup�rieur ou �gal � 1 pion, on sauvegarde
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

