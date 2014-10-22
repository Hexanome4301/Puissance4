	
% Declaration des diagonales inferieures ainsi que leurs positions.
:-dynamic(diagInf1/1).
diagInf1([[],[],[],[],[z],[z],[z]]).
:-dynamic(diagInf2/1).
diagInf2([[],[],[],[],[],[z],[z]]).
:-dynamic(diagInf3/1).
diagInf3([[],[],[],[],[],[],[z]]).
:-dynamic(diagInf4/1).
diagInf4([[z],[],[],[],[],[],[]]).
:-dynamic(diagInf5/1).
diagInf5([[z],[z],[],[],[],[],[]]).
:-dynamic(diagInf6/1).
diagInf6([[z],[z],[z],[],[],[],[]]).

:-dynamic(diagInf1Elem/1).
diagInf1Elem([[4,1], [3,2], [2,3], [1,4]]).
:-dynamic(diagInf2Elem/1).
diagInf2Elem([[5,1], [4,2], [3,3], [2,4], [1,5]]).
:-dynamic(diagInf3Elem/1).
diagInf3Elem([[6,1], [5,2], [4,3], [3,4], [2,5], [1,6]]).
:-dynamic(diagInf4Elem/1).
diagInf4Elem([[6,2], [5,3], [4,4], [3,5], [2,6], [1,7]]).
:-dynamic(diagInf5Elem/1).
diagInf5Elem([[6,3], [5,4], [4,5], [3,6],[2,7]]).
:-dynamic(diagInf6Elem/1).
diagInf6Elem([[6,4], [5,5], [4,6], [3,7]]).


% Declaration des diagonales superieures ainsi que leurs positions.
:-dynamic(diagSup1/1).
diagSup1([[],[],[],[],[z],[z],[z]]).
:-dynamic(diagSup2/1).
diagSup2([[],[],[],[],[],[z],[z]]).
:-dynamic(diagSup3/1).
diagSup3([[],[],[],[],[],[],[z]]).
:-dynamic(diagSup4/1).
diagSup4([[z],[],[],[],[],[],[]]).
:-dynamic(diagSup5/1).
diagSup5([[z],[z],[],[],[],[],[]]).
:-dynamic(diagSup6/1).
diagSup6([[z],[z],[z],[],[],[],[]]).

:-dynamic(diagSup1Elem/1).
diagSup1Elem([[3,1], [4,2], [5,3], [6,4]]).
:-dynamic(diagSup2Elem/1).
diagSup2Elem([[2,1], [3,2], [4,3], [5,4], [6,5]]).
:-dynamic(diagSup3Elem/1).
diagSup3Elem([[1,1], [2,2], [3,3], [4,4], [5,5], [6,6]]).
:-dynamic(diagSup4Elem/1).
diagSup4Elem([[1,2], [2,3], [3,4], [4,5], [5,6], [6,7]]).
:-dynamic(diagSup5Elem/1).
diagSup5Elem([[1,3], [2,4], [3,5], [4,6],[5,7]]).
:-dynamic(diagSup6Elem/1).
diagSup6Elem([[1,4], [2,5], [3,6], [4,7]]).


% Optimiser pour pouvoir avoir n'importe quelle taille de grille car ici non seulement jouer d�pend de la taille mais la r�solution aussi
% ces proc�dures sont � param�trer

% Predicat qui permet la copie de L1 dans L2
 copyList([],[]).
 copyList([H|L1],[H|L2]):- copyList(L1,L2).

 % Predicat qui fait l'insertion d'une élément dans une liste à la position Pos
insertElement(Val,[H|List],Pos,[H|Res]):- Pos > 1, !,
                                Pos1 is Pos - 1, insertElement(Val,List,Pos1,Res).
insertElement(Val, List, 1, [Val|List]).

% Predicat qui supprime un element d'une liste à une position donnée
deleteElement([H|List],Pos,[H|Res]):- Pos > 1, !,
                                Pos1 is Pos - 1, deleteElement(List,Pos1,Res).
deleteElement([_|Q], 1, Q).


% Predicat qui fait l'insertion d'une élément dans une liste à la position Pos ( prend le cas ou la liste ne contient pas d'elements
insertPosition(X, Pos, Val, R) :-
	length(X,L),L>0,
	deleteElement(X, Pos, Q),
	insertElement(Val, Q, Pos, R);

	length(X,L),L=0,
	R = [Val].

% Predicat qui insere une element dans la diagonale à laquelle il appartient
insertInDiagInf(Ligne, Colonne, Couleur) :-

(	diagInf1(X1), diagInf1Elem(Y1), member([Ligne, Colonne], Y1), insertPosition(X1, Colonne, Couleur, Z1), retract(diagInf1(X1)), assert(diagInf1(Z1));
	diagInf2(X1), diagInf2Elem(Y1), member([Ligne, Colonne], Y1), insertPosition(X1, Colonne, Couleur, Z1), retract(diagInf2(X1)), assert(diagInf2(Z1));
	diagInf3(X1), diagInf3Elem(Y1), member([Ligne, Colonne], Y1), insertPosition(X1, Colonne, Couleur, Z1), retract(diagInf3(X1)), assert(diagInf3(Z1));
	diagInf4(X1), diagInf4Elem(Y1), member([Ligne, Colonne], Y1), insertPosition(X1, Colonne, Couleur, Z1), retract(diagInf4(X1)), assert(diagInf4(Z1));
	diagInf5(X1), diagInf5Elem(Y1), member([Ligne, Colonne], Y1), insertPosition(X1, Colonne, Couleur, Z1), retract(diagInf5(X1)), assert(diagInf5(Z1));
	diagInf6(X1), diagInf6Elem(Y1), member([Ligne, Colonne], Y1), insertPosition(X1, Colonne, Couleur, Z1), retract(diagInf6(X1)), assert(diagInf6(Z1))).

insertInDiagSup(Ligne, Colonne, Couleur) :-

(	diagSup1(X2), diagSup1Elem(Y2), member([Ligne, Colonne], Y2), insertPosition(X2, Colonne, Couleur, Z2), retract(diagSup1(X2)), assert(diagSup1(Z2));
	diagSup2(X2), diagSup2Elem(Y2), member([Ligne, Colonne], Y2), insertPosition(X2, Colonne, Couleur, Z2), retract(diagSup2(X2)), assert(diagSup2(Z2));
	diagSup3(X2), diagSup3Elem(Y2), member([Ligne, Colonne], Y2), insertPosition(X2, Colonne, Couleur, Z2), retract(diagSup3(X2)), assert(diagSup3(Z2));
	diagSup4(X2), diagSup4Elem(Y2), member([Ligne, Colonne], Y2), insertPosition(X2, Colonne, Couleur, Z2), retract(diagSup4(X2)), assert(diagSup4(Z2));
	diagSup5(X2), diagSup5Elem(Y2), member([Ligne, Colonne], Y2), insertPosition(X2, Colonne, Couleur, Z2), retract(diagSup5(X2)), assert(diagSup5(Z2));
	diagSup6(X2), diagSup6Elem(Y2), member([Ligne, Colonne], Y2), insertPosition(X2, Colonne, Couleur, Z2), retract(diagSup6(X2)), assert(diagSup6(Z2))).


displayAllDiags:-
	listing(diagInf1),
	listing(diagInf2),
	listing(diagInf3),
	listing(diagInf4),
	listing(diagInf5),
	listing(diagInf6),
	listing(diagSup1),
	listing(diagSup2),
	listing(diagSup3),
	listing(diagSup4),
	listing(diagSup5),
	listing(diagSup6).

accReverse([ ],L,L). 
accReverse([H|T],Acc,Rev):-
accReverse(T,[H|Acc],Rev).

reverseList(L1,L2):- accReverse(L1,[ ],L2).

% Predicat qui insère un élément dans la diagonale à laquelle il appartient
insertDiag(Ligne, Colonne, Couleur):-
	insertInDiagInf(Ligne, Colonne, Couleur),
	insertInDiagSup(Ligne, Colonne, Couleur).

insertDiag(Ligne, Colonne, Couleur):-
	insertInDiagSup(Ligne, Colonne, Couleur),
	insertInDiagInf(Ligne, Colonne, Couleur).
insertDiag(Ligne, Colonne, Couleur).



