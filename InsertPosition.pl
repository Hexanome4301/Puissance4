

% a2b([],[]).
% a2b([H|L1],[H|L2]):- a2b(L1,L2).


insertElement(Val,[H|List],Pos,[H|Res]):- Pos > 1, !, 
                                Pos1 is Pos - 1, insertElement(Val,List,Pos1,Res). 
insertElement(Val, List, 1, [Val|List]).


deleteElement([H|List],Pos,[H|Res]):- Pos > 1, !, 
                                Pos1 is Pos - 1, deleteElement(List,Pos1,Res). 
deleteElement([_|Q], 1, Q).

insertPosition(X, Pos, Val, R) :-
 	deleteElement(X, Pos, Q),
 	insertElement(Val, Q, Pos, R).

