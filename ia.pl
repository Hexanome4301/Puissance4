iaRandom(Pion, Colonne) :-
		random(1, 7, Colonne),
		jouer(Pion, Colonne).

%condition d'arret de la recusion:
coupPossible([],[]).

% Principe: Au depart on passe en parametre l'etat du jeu ( la liste de
% liste )
% On recupere la premiere colonne (tete de la liste) puis on fait une
% recursion sur toute les colonnes suivante jusqu'a tomber sur une liste
% vide (marque de fin)
% Puis on dépile la recusion dans l'autre sens en ajoutant dans
% listResult l'index de la colonne ou on peut encore jouer
coupPossible(Gamestate,ListResult):-
	Gamestate = [Tete|Queue],

	%on test si la colonne n'est pas remplie
	length(Tete,Taille) , Taille <6,

	%si test reussi (true)
	%on cherche l'index de cette colonne dans Gamestate
	length(Queue,Taille2),
	Index is 7 - Taille2,
	%gamestate(Static),
	%nth0(Index,Static,Tete),

	%(recursion) on fait un parcours de chaque colonne ainsi
	coupPossible(Queue,L),
	%on ajoute cet index a la liste de coups possible
	append([Index],L,ListResult).

coupPossible(Gamestate,ListResult):-
	Gamestate = [Tete|Queue],

	%on test si la colonne EST remplie
	length(Tete,Taille) , not(Taille <6),

	%si test reussi (true)
	%on ajoute rien et on passe à la suite
	coupPossible(Queue,ListResult).
