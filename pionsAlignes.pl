% Liste qui sauvegarde le nombre de chaque alignement > 1 pion
:-dynamic(nombrePions/1).
 nombrePions([]).
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%% V�rification horizontale %%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%	
 
nombrePionsAlignesHorizontalement(NumLigne, Pion) :-
	retract(nombrePions(_)), assert(nombrePions([]),
	nombrePionsAlignesHorizontalement(NumLigne, Pion, 1, 0).

% Condition d'arr�t si on a explorer toute la ligne, c'est � dire si on a d�pass� la derni�re colonne
nombrePionsAlignesHorizontalement(NumLigne, Pion, NumColonne, PionsAlignes) :-
	NumColonne == 8,
	!,
	enregistrerDansNombrePions(PionsAlignes).
 
% On effectue la v�rification pour un pion et un num�ro de ligne donn�s
nombrePionsAlignesHorizontalement(NumLigne, Pion, NumColonne, PionsAlignes) :-
	NumColonne < 8,
	!,
	% on recupere la colonne
	gamestate(X), nth1(NumColonne, X, Colonne),
	% On r�cup�re le pion
	nth1(NumLigne, Colonne, PionChoisi),
	incrementeSiIdentique(NumLigne, PionChoisi, Pion, PionsAlignes, NumColonne).
	
% Si le pion choisi est identique au pion du joueur on incr�mente
incrementeSiIdentique(NumLigne, PionChoisi, Pion, PionsAlignes, NumColonne) :-
	PionChoisi == Pion,
	!,
	PionsAlignes2 is (PionsAlignes + 1),
	NumColonne2 is (NumColonne + 1),
	nombrePionsAlignesHorizontalement(NumLigne, Pion, NumColonne2, PionsAlignes2).

% Si le pion choisi est diff�rent du pion du joueur on recommence � z�ro 
incrementeSiIdentique(NumLigne, PionChoisi, Pion, PionsAlignes, NumColonne) :-
	PionChoisi \= Pion,
	!,
	NumColonne2 is (NumColonne + 1),
	% Mais d'abord on enregistre l'alignement pr�c�dent dans la liste
	enregistrerDansNombrePions(PionsAlignes),
	nombrePionsAlignesHorizontalement(NumLigne, Pion, NumColonne2, 0).
	
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%% V�rification verticale %%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%	

% On effectue la v�rification pour un pion et une colonne donn�s
nombrePionsAlignesVerticalement(Colonne, Pion) :-
	retract(nombrePions(_)), assert(nombrePions([]),
	length(Colonne, TailleColonne),
	nombrePionsAlignesVerticalement(Colonne, Pion, TailleColonne, 0).

% Condition d'arr�t si on a explorer toute la colonne
nombrePionsAlignesVerticalement(Colonne, Pion, TailleColonne, PionAlignes) :-
	TailleColonne == 0,
	!,
	enregistrerDansNombrePions(PionAlignes).
	
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
	% Mais d'abord on enregistre l'alignement pr�c�dent dans la liste
	enregistrerDansNombrePions(PionAlignes),
	nombrePionsAlignesVerticalement(Colonne, Pion, TailleColonne2, 0).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%% Commun � toutes les v�rifications %%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	
% Si on a un alignement sup�rieur � 1 pion, on sauvegarde
enregistrerDansNombrePions(NombrePionsAlignes) :-
	NombrePionsAlignes > 1,
	!,
	nombrePions(ListeNombrePions),
	append(ListeNombrePions, [NombrePionsAlignes], NouveauNombrePions),
	retract(nombrePions(_)),
	assert(nombrePions(NouveauNombrePions)).

% Si on a un alignement maximum d'un pion, ce n'est pas la peine de sauvegarder
enregistrerDansNombrePions(NombrePionsAlignes) :-
	NombrePionsAlignes =< 1.