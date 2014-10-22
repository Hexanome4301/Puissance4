%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% gamestate de TEST solution horizontale %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
:-dynamic(gamestateTestHoriz11/1).
 gamestateTestHoriz11([[x],[x],[x],[x],[],[],[]]).

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



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% gamestate de TEST solution verticale   %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%JE sais pas si c'est bien ecrit
:-dynamic(diagInfTest1/1).
diagInfTest1([[x],[x],[x],[x],[z],[z],[z]]).

%deuxiem diagonale
:-dynamic(diagInfTest2/1).
diagInfTest21([[],[x],[x],[x],[x],[z],[z]]).

%deuxiem diagonale
:-dynamic(diagInfTest2/1).
diagInfTest21([[x],[x],[x],[x],[o],[z],[z]]).


:-dynamic(diagInfTest31/1).
diagInfTest31([[],[],[x],[x],[x],[x],[z]]).

:-dynamic(diagInfTest32/1).
diagInfTest32([[],[x],[x],[x],[x],[o],[z]]).

:-dynamic(diagInfTest33/1).
diagInfTest33([[x],[x],[x],[x],[o],[o],[z]]).

 %etc

%solutionHorizontale:-
	%(gamestateTestHoriz11(X),sh(x,X) ),
	%(gamestateTestHoriz12(X),sh(x,X)),

%etc