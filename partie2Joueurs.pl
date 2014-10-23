% Lance une partie par defaut entre 2 joueurs : joueur x VS joueur o
partie2Joueurs :-
	retract(gamestate(_)) , assert(gamestate([[],[],[],[],[],[],[]])),
	partie2Joueurs(x).

% Demarre une partie avec en premier le joueur Pion
% Demande au joueur quelle colonne il veut jouer et tente de realiser
% sa demande via la règle jouePion.
partie2Joueurs(Pion) :-
	write(Pion), write(' à votre tour : '),
	read(NumColonne),
	jouePion(Pion, NumColonne).

% Tente de realiser la demande du Joueur. Si le pion est bien joue on
% teste si il y a une victoire sinon on redemande au joueur de jouer
% son pion autre part
jouePion(Pion,NumColonne):-
	jouer(Pion, NumColonne,_, LigneDuNouvelElem),
	afficherGrille,
	testGagner2Joueurs(Pion,LigneDuNouvelElem,NumColonne),! .

jouePion(Pion,_):-
	%not(jouer(Pion, NumColonne,_, _)),  % BUG affiche Deux fois la phrase d'erreur
	partie2Joueurs(Pion).

% Teste si un Pion (le joueur Pion) a gagne apres son coup
% en observant la ligne sur laquelle il a joue ainsi que la colonne (TOdO)
% Quand il y a victoire la partie est finie
testGagner2Joueurs(Pion,LigneDuNouvelElem,NumColonne) :-
	gamestate(X),
	% Dans les regle sh , sv on commence a partir de 0.
	Ligne is LigneDuNouvelElem - 1,
	Colonne is NumColonne-1,
	% UnPion represente le nom du vainqueur a ce coup.
	% En principe si il y a vainqueur UnPion forcement est egale a Pion

	( (sh(UnPion,X,Ligne),Message = ' a gagné horizontalement');
	  (sv(UnPion,X,Colonne), Message = ' a gagné verticalement');
	  (sd(UnPion), Message = ' a gagné diagonalement')
	),
	Pion = UnPion,
	%write(Pion), write(Message),
	finPartie.

% Deuxieme regle s'effectuant si la premiere n'a trouver aucun vainqueur (sh,sd,sv qui renvoient false chacun)
% Il n'y a eu aucun vainqueur apres le coup alors on passe au joueur suivant via changerPion;
testGagner2Joueurs(Pion,LigneDuNouvelElem,NumColonne) :-
	gamestate(X),
	Ligne is LigneDuNouvelElem - 1,
	Colonne is NumColonne-1,
	not(sh(_,X,Ligne)),

	not(sv(_,X,Colonne)),

	changerPion(Pion, Adversaire), partie2Joueurs(Adversaire).


finPartie :-
	retract(diagInf1(_)) , assert(diagInf1([[],[],[],[],[z],[z],[z]])),
	retract(diagInf2(_)) , assert(diagInf2([[],[],[],[],[],[z],[z]])),
	retract(diagInf3(_)) , assert(diagInf3([[],[],[],[],[],[],[z]])),
	retract(diagInf4(_)) , assert(diagInf4([[z],[],[],[],[],[],[]])),
	retract(diagInf5(_)) , assert(diagInf5([[z],[z],[],[],[],[],[]])),
	retract(diagInf6(_)) , assert(diagInf6([[z],[z],[z],[],[],[],[]])),
	retract(diagSup1(_)) , assert(diagSup1([[],[],[],[],[z],[z],[z]])),
	retract(diagSup2(_)) , assert(diagSup2([[],[],[],[],[],[z],[z]])),
	retract(diagSup3(_)) , assert(diagSup3([[],[],[],[],[],[],[z]])),
	retract(diagSup4(_)) , assert(diagSup4([[z],[],[],[],[],[],[]])),
	retract(diagSup5(_)) , assert(diagSup5([[z],[z],[],[],[],[],[]])),
	retract(diagSup6(_)) , assert(diagSup6([[z],[z],[z],[],[],[],[]])).
	%retract(gamestate(_)) , assert(gamestate([[],[],[],[],[],[],[]])).

changerPion(x, NouveauPion) :-
	NouveauPion = o.

changerPion(o, NouveauPion) :-
	NouveauPion = x.


