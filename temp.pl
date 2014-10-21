:-dynamic(diagInf1/4).
diagInf1([],[],[],[],[]).

:-dynamic(diagInf2/5).
diagInf2([],[],[],[],[]).

:-dynamic(diagInf3/6).
diagInf3([],[],[],[],[],[]).

:-dynamic(diagInf4/6).
diagInf4([],[],[],[],[],[]).

:-dynamic(diagInf5/5).
diagInf5([],[],[],[],[]).

:-dynamic(diagInf6/4).
diagInf6([],[],[],[]).

:-dynamic(diagSup1/4).
diagSup1([,],[],[],[]).

:-dynamic(diagSup2/5).
diagSup2([],[],[],[],[]).

:-dynamic(diagSup3/6).
diagSup3([],[],[],[],[],[]).

:-dynamic(diagSup4/6).
diagSup4([],[],[],[],[],[]).

:-dynamic(diagSup5/5).
diagSup5([],[],[],[],[]).

:-dynamic(diagSup6/4).
diagSup6([],[],[],[]).


% insertPosition(X, Pos, Val, R) :-
% 	deleteElement(X, Pos, Q),
% 	insertElement(Val, Q, Pos, R).

ins(Val,[H|List],Pos,[H|Res]):- Pos > 1, !, 
                                Pos1 is Pos - 1, ins(Val,List,Pos1,Res). 
ins(Val, List, 1, [Val|List]).