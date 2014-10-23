%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% gamestate de TEST solution horizontale %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%premiere ligne
:-dynamic(gamestateTestHoriz11/1).
 gamestateTestHoriz11([[x], [x], [x], [x],[],[],[]]).

:-dynamic(gamestateTestHoriz12/1).
 gamestateTestHoriz12([[], [x], [x], [x], [x],[],[]]).

:-dynamic(gamestateTestHoriz13/1).
 gamestateTestHoriz13([[],[], [x], [x], [x], [x],[]]).

:-dynamic(gamestateTestHoriz14/1).
 gamestateTestHoriz14([[],[],[], [x], [x], [x], [x]]).

%deuxieme ligne
:-dynamic(gamestateTestHoriz21/1).
gamestateTestHoriz21([[x,o],[x,o],[x,o],[x,o],[],[],[]]).

:-dynamic(gamestateTestHoriz22/1).
 gamestateTestHoriz22([[],[x,o],[x,o],[x,o],[x,o],[],[]]).

:-dynamic(gamestateTestHoriz23/1).
 gamestateTestHoriz23([[],[],[x,o],[x,o],[x,o],[x,o],[]]).

:-dynamic(gamestateTestHoriz24/1).
 gamestateTestHoriz24([[],[],[],[x,o],[x,o],[x,o],[x,o]]).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% gamestate de TEST solution verticale   %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
:-dynamic(gamestateTestVertic11/1).
 gamestateTestVertic11([[x,x,x,x],[],[],[],[],[],[]]).

:-dynamic(gamestateTestVertic12/1).
 gamestateTestVertic12([[o,x,x,x,x],[],[],[],[],[],[]]).

:-dynamic(gamestateTestVertic13/1).
 gamestateTestVertic13([[o,o,x,x,x,x],[],[],[],[],[],[]]).

%deuxieme colonne
 :-dynamic(gamestateTestVertic21/1).
 gamestateTestVertic21([[],[x,x,x,x],[],[],[],[],[]]).

:-dynamic(gamestateTestVertic22/1).
 gamestateTestVertic22([[],[o,x,x,x,x],[],[],[],[],[]]).

:-dynamic(gamestateTestVertic23/1).
 gamestateTestVertic23([[],[o,o,x,x,x,x],[],[],[],[],[]]).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% gamestate de TEST solution diagonale inférieure %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%premiere diagonale
:-dynamic(diagInfTest1/1).
diagInfTest1([x, x, x, x,[z],[z],[z]]).

%deuxieme diagonale
:-dynamic(diagInfTest2/1).
diagInfTest2([[], x, x, x, x,[z],[z]]).

%troisieme diagonale
:-dynamic(diagInfTest3/1).
diagInfTest3([[],[], x, x, x, x,[z]]).

%quatrieme diagonale
:-dynamic(diagInfTest4/1).
diagInfTest4([[z], x, x, x, x,[],[]]).

%cinquieme diagonale
:-dynamic(diagInfTest5/1).
diagInfTest5([[z],[z], x, x, x, x,[]]).

%sixième diagonale
:-dynamic(diagInfTest6/1).
diagInfTest6([[z],[z],[z], x, x, x, x]).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% gamestate de TEST solution diagonale supérieure %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%premiere diagonale
:-dynamic(diagSupTest1/1).
diagSupTest1([x, x, x, x,[z],[z],[z]]).

%deuxieme diagonale
:-dynamic(diagSupTest2/1).
diagSupTest2([[], x, x, x, x,[z],[z]]).

%troisieme diagonale
:-dynamic(diagSupTest3/1).
diagSupTest3([[],[], x, x, x, x,[]]).

%quatrieme diagonale
:-dynamic(diagSupTest4/1).
diagSupTest4([[z],x,x,x,x,[],[]]).

%cinquieme diagonale
:-dynamic(diagSupTest5/1).
diagSupTest5([[z],[z],x,x,x,x,[]]).

%sixième diagonale
:-dynamic(diagSupTest6/1).
diagSupTest6([[z],[z],[z], x, x, x, x]).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% gamestate de TEST solution verticale gagnante   %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
:-dynamic(vertGagnanteX/1).
vertGagnanteX([[x,x,x],[],[x,o,x],[x],[o,x,x],[o,o,o,x],[]]).

:-dynamic(vertGagnanteO/1).
vertGagnanteO([[x,x,x,o],[o],[x,o,x],[x],[o,x,o,o],[o,o,o],[o,x]]).


solutionHorizontale:-
	gamestateTestHoriz11(X1), sh(x, X1),
	gamestateTestHoriz12(X2), sh(x, X2),
	gamestateTestHoriz13(X3), sh(x, X3),
	gamestateTestHoriz14(X4), sh(x, X4),
	gamestateTestHoriz21(X5), sh(x, X5),
	gamestateTestHoriz22(X6), sh(x, X6),
	gamestateTestHoriz23(X7), sh(x, X7),
	gamestateTestHoriz24(X8), sh(x, X8).

	
solutionVerticale:-
	gamestateTestVertic11(X1), sv(x, X1),
	gamestateTestVertic12(X2), sv(x, X2),
	gamestateTestVertic13(X3), sv(x, X3),
	gamestateTestVertic21(X4), sv(x, X4),
	gamestateTestVertic22(X5), sv(x, X5),
	gamestateTestVertic23(X6), sv(x, X6).
	
solutionDiagonaleInf :-
	diagInfTest1(X1), retract(diagInf1(_)), assert(diagInf1(X1)), sd(x),retract(diagInf1(_)), assert(diagInf1([[],[],[],[],[z],[z],[z]])),
	diagInfTest2(X2), retract(diagInf2(_)), assert(diagInf2(X2)), sd(x),retract(diagInf2(_)), assert(diagInf2([[],[],[],[],[],[z],[z]])),
	diagInfTest3(X3), retract(diagInf3(_)), assert(diagInf3(X3)), sd(x),retract(diagInf3(_)), assert(diagInf3([[],[],[],[],[],[],[z]])),
	diagInfTest4(X4), retract(diagInf4(_)), assert(diagInf4(X4)), sd(x),retract(diagInf4(_)), assert(diagInf4([[z],[],[],[],[],[],[]])),
	diagInfTest5(X5), retract(diagInf5(_)), assert(diagInf5(X5)), sd(x),retract(diagInf5(_)), assert(diagInf5([[z],[z],[],[],[],[],[]])),
	diagInfTest6(X6), retract(diagInf6(_)), assert(diagInf6(X6)), sd(x),retract(diagInf6(_)), assert(diagInf6([[z],[z],[z],[],[],[],[]])).

solutionDiagonaleSup:-
	diagSupTest1(X1), retract(diagSup1(_)), assert(diagSup1(X1)), sd(x),retract(diagSup1(_)), assert(diagSup1([[],[],[],[],[z],[z],[z]])),
	diagSupTest2(X2), retract(diagSup2(_)), assert(diagSup2(X2)), sd(x),retract(diagSup2(_)), assert(diagSup2([[],[],[],[],[],[z],[z]])),
	diagSupTest3(X3), retract(diagSup3(_)), assert(diagSup3(X3)), sd(x),retract(diagSup3(_)), assert(diagSup3([[],[],[],[],[],[],[z]])),
	diagSupTest4(X4), retract(diagSup4(_)), assert(diagSup4(X4)), sd(x),retract(diagSup4(_)), assert(diagSup4([[z],[],[],[],[],[],[]])),
	diagSupTest5(X5), retract(diagSup5(_)), assert(diagSup5(X5)), sd(x),retract(diagSup5(_)), assert(diagSup5([[z],[z],[],[],[],[],[]])),
	diagSupTest6(X6), retract(diagSup6(_)), assert(diagSup6(X6)), sd(x),retract(diagSup6(_)), assert(diagSup6([[z],[z],[z],[],[],[],[]])).

solutionGagnanteVerticaleX :-
	vertGagnanteX(W), write('Le resultat attendu est : 3 pour la serie de 1, 1 pour la serie de 2 et 1 pour la serie de 3\n'), 
	retract(gamestate(_)), assert(gamestate(W)), nbSeries1Verticales(x, X),
	nbSeries2Verticales(x, Y), nbSeries3Verticales(x, Z), write('Serie de 1 : '), write(X), write('\nSerie de 2 : '), write(Y), 
	write('\nSerie e 3 : '), write(Z).

solutionGagnanteVerticaleO :-
	vertGagnanteO(W), write('Le resultat attendu est : 2 pour la serie de 1, 1 pour la serie de 2 et 1 pour la serie de 3\n'), 
	retract(gamestate(_)), assert(gamestate(W)), nbSeries1Verticales(o, X),
	nbSeries2Verticales(o, Y), nbSeries3Verticales(o, Z), write('Serie de 1 : '), write(X), write('\nSerie de 2 : '), write(Y), 
	write('\nSerie e 3 : '), write(Z).
	
testUnitaire :-

	solutionVerticale,
	solutionHorizontale,
	solutionDiagonaleInf,
	solutionDiagonaleSup,
	solutionGagnanteVerticaleX,
	solutionGagnanteVerticaleO.

