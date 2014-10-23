%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% gamestate de TEST solution horizontale %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%premiere ligne
:-dynamic(gamestateTestHoriz11/1).
 gamestateTestHoriz11(([x],[x],[x],[x],[],[],[]]).

:-dynamic(gamestateTestHoriz12/1).
 gamestateTestHoriz12([[],[x],[x],[x],[x],[],[]]).

:-dynamic(gamestateTestHoriz13/1).
 gamestateTestHoriz13([[],[],[x],[x],[x],[x],[]]).

:-dynamic(gamestateTestHoriz14/1).
 gamestateTestHoriz14([[],[],[],[x],[x],[x],[x]]).

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
 gamestateTestVertic12([[x,x,x,x,o],[],[],[],[],[],[]]).

:-dynamic(gamestateTestVertic13/1).
 gamestateTestVertic13([[x,x,x,x,o,o],[],[],[],[],[],[]]).

%deuxieme colonne
 :-dynamic(gamestateTestVertic21/1).
 gamestateTestVertic21([[],[x,x,x,x],[],[],[],[],[]]).

:-dynamic(gamestateTestVertic22/1).
 gamestateTestVertic22([[],[x,x,x,x,o],[],[],[],[],[]]).

:-dynamic(gamestateTestVertic23/1).
 gamestateTestVertic23([[],[x,x,x,x,o,o],[],[],[],[],[]]).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% gamestate de TEST solution diagonale inférieure %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%premiere diagonale
:-dynamic(diagInfTest1/1).
diagInfTest1([x,x,x,x,[z],[z],[z]]).

%deuxieme diagonale
:-dynamic(diagInfTest21/1).
diagInfTest21([[],[x],[x],[x],[x],[z],[z]]).

:-dynamic(diagInfTest22/1).
diagInfTest22([[x],[x],[x],[x],[o],[z],[z]]).

%troisieme diagonale
:-dynamic(diagInfTest31/1).
diagInfTest31([[],[],[x],[x],[x],[x],[z]]).

:-dynamic(diagInfTest32/1).
diagInfTest32([[],[x],[x],[x],[x],[o],[z]]).

:-dynamic(diagInfTest33/1).
diagInfTest33([[x],[x],[x],[x],[o],[o],[z]]).

%quatrieme diagonale
:-dynamic(diagInfTest41/1).
diagInfTest41([[z],[x],[x],[x],[x],[],[]]).

:-dynamic(diagInfTest42/1).
diagInfTest42([[z],[],[x],[x],[x],[x],[]]).

:-dynamic(diagInfTest43/1).
diagInfTest43([[z],[],[o],[x],[x],[x],[x]]).

%cinquieme diagonale
:-dynamic(diagInfTest51/1).
diagInfTest51([[z],[z],[x],[x],[x],[x],[]]).

:-dynamic(diagInfTest52/1).
diagInfTest52([[z],[z],[],[x],[x],[x],[x]]).

%sixième diagonale
:-dynamic(diagInfTest6/1).
diagInfTest6([[z],[z],[z],[x],[x],[x],[x]]).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% gamestate de TEST solution diagonale supérieure %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%premiere diagonale
:-dynamic(diagSupTest1/1).
diagSupTest1([[x],[x],[x],[x],[z],[z],[z]]).

%deuxieme diagonale
:-dynamic(diagSupTest21/1).
diagSupTest21([[],[x],[x],[x],[x],[z],[z]]).

:-dynamic(diagSupTest22/1).
diagSupTest22([[x],[x],[x],[x],[o],[z],[z]]).

%troisieme diagonale
:-dynamic(diagSupTest31/1).
diagSupTest31([[],[],[x],[x],[x],[x],[z]]).

:-dynamic(diagSupTest32/1).
diagSupTest32([[],[x],[x],[x],[x],[o],[z]]).

:-dynamic(diagSupTest33/1).
diagSupTest33([[x],[x],[x],[x],[o],[o],[z]]).

%quatrieme diagonale
:-dynamic(diagSupTest41/1).
diagSupTest41([[z],[x],[x],[x],[x],[],[]]).

:-dynamic(diagSupTest42/1).
diagSupTest42([[z],[],[x],[x],[x],[x],[]]).

:-dynamic(diagSupTest43/1).
diagSupTest43([[z],[],[o],[x],[x],[x],[x]]).

%cinquieme diagonale
:-dynamic(diagSupTest51/1).
diagSupTest51([[z],[z],[x],[x],[x],[x],[]]).

:-dynamic(diagSupTest52/1).
diagSupTest52([[z],[z],[],[x],[x],[x],[x]]).

%sixième diagonale
:-dynamic(diagSupTest6/1).
diagSupTest6([[z],[z],[z],[x],[x],[x],[x]]).


%solutionHorizontale:-
	%(gamestateTestHoriz11(X),sh(x,X)),
	%(gamestateTestHoriz12(X),sh(x,X)),
	%(gamestateTestHoriz13(X),sh(x,X)),
	%(gamestateTestHoriz14(X),sh(x,X)),
	%(gamestateTestHoriz21(X),sh(x,X)),
	%(gamestateTestHoriz22(X),sh(x,X)),
	%(gamestateTestHoriz23(X),sh(x,X)),
	%(gamestateTestHoriz24(X),sh(x,X)).
	
%solutionVerticale:-
	%(gamestateTestVertic11(X),sv(x,X)),
	%(gamestateTestVertic12(X),sv(x,X)),
	%(gamestateTestVertic13(X),sv(x,X)),
	%(gamestateTestVertic21(X),sv(x,X)),
	%(gamestateTestVertic22(X),sv(x,X)),
	%(gamestateTestVertic23(X),sv(x,X)).
	
solutionDiagonaleInf:-
	(diagInfTest1(X),retract(diagInf1(_)),assert(diagInf1(X), sd(x)),retract(diagInf1(_)), assert(diagInf1([[],[],[],[],[z],[z],[z]])).
	%(diagInfTest21(X),sd(x,X)),
	%(diagInfTest22(X),sd(x,X)),
	%(diagInfTest31(X),sd(x,X)),
	%(diagInfTest32(X),sd(x,X)),
	%(diagInfTest33(X),sd(x,X)),
	%(diagInfTest41(X),sd(x,X)),
	%(diagInfTest42(X),sd(x,X)),
	%(diagInfTest43(X),sd(x,X)),
	%(diagInfTest51(X),sd(x,X)),
	%(diagInfTest52(X),sd(x,X)),
	%(diagInfTest6(X),sd(x,X)).

%solutionDiagonaleSup:-
	%(diagSupTest1(X),sd(x,X)),
	%(diagSupTest21(X),sd(x,X)),
	%(diagSupTest22(X),sd(x,X)),
	%(diagSupTest31(X),sd(x,X)),
	%(diagSupTest32(X),sd(x,X)),
	%(diagSupTest33(X),sd(x,X)),
	%(diagSupTest41(X),sd(x,X)),
	%(diagSupTest42(X),sd(x,X)),
	%(diagSupTest43(X),sd(x,X)),
	%(diagSupTest51(X),sd(x,X)),
	%(diagSupTest52(X),sd(x,X)),
	%(diagSupTest6(X),sd(x,X)).