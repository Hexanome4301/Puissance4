% Dans ces deux regle on fait un scan total de la grille
sv(Pion):-
	(gamestate(Z),sv(Pion, Z,0),!); %en mettant une coupure ici des que la regle sera vrai elle nira pas tester les autres solution
	(gamestate(Z),sv(Pion, Z,1),!);
	(gamestate(Z),sv(Pion, Z,2),!);
	(gamestate(Z),sv(Pion, Z,3),!);
	(gamestate(Z),sv(Pion, Z,4),!);
	(gamestate(Z),sv(Pion, Z,5),!);
	(gamestate(Z),sv(Pion, Z,6)).

% Solution verticale, pour une grille Z, on regarde si le Pion est vainqueur à la colonne (NumCol+1)
sv(Pion,Z,NumCol):-

	%length(Z,NbElements), NbElements > 3,
	nth0(NumCol, Z, Y), nth0(0, Y, C1), nth0(1, Y, C2), nth0(2, Y, C3), nth0(3, Y, C4),
	(C1==C2,C2==C3,C3==C4, Pion = C1).

sv(Pion, Z, NumCol) :-

	%length(Z,NbElements), NbElements > 3,
	nth0(NumCol, Z, Y), nth0(1, Y, C2), nth0(2, Y, C3), nth0(3, Y, C4), nth0(4, Y, C5),
	(C2==C3,C3==C4,C4==C5, Pion = C2).

sv(Pion, Z, NumCol) :-

	%length(Z,NbElements), NbElements > 3,
	nth0(NumCol, Z, Y), nth0(2, Y, C3), nth0(3, Y, C4), nth0(4, Y, C5), nth0(5, Y, C6),
	(C3==C4,C4==C5,C5==C6, Pion=C3).


% on prend la premiere colone puis la deuxieme, puis ... Ensuite on prend le premier element de la colonne 1, puis le premier de la colonne 2, etc

sh(Pion):-
	(gamestate(Z),sh(Pion,Z,0),!);
	(gamestate(Z),sh(Pion,Z,1),!);
	(gamestate(Z),sh(Pion,Z,2),!);
	(gamestate(Z),sh(Pion,Z,3),!);
	(gamestate(Z),sh(Pion,Z,4),!);
	(gamestate(Z),sh(Pion,Z,5),!).

% Solution horizontal, pour une grille Z, on regarde si le Pion est vainqueur à la ligne (LigneNumber+1)
sh(Pion, Z, LineNumber) :-
	nth0(0, Z, C1), nth0(1, Z, C2), nth0(2, Z, C3), nth0(3, Z, C4),
	length(C1,LengthC1), length(C2,LengthC2),length(C3,LengthC3),length(C4,LengthC4),
	not(LengthC1=0),not(LengthC2=0),not(LengthC3=0),not(LengthC4=0),
	reverse(C1,C1r),reverse(C2,C2r),reverse(C3,C3r),reverse(C4,C4r),
	nth0(LineNumber, C1r, E1),nth0(LineNumber, C2r, E2),nth0(LineNumber, C3r, E3),nth0(LineNumber, C4r, E4),
	E1==E2,E2==E3,E3==E4,E4==E1,
	Pion = E1, !.	% ainsi on peut demander aussi qui est le vainqueur si on met une variable dans Pion


sh(Pion, Z, LineNumber) :-
	nth0(1, Z, C1), nth0(2, Z, C2), nth0(3, Z, C3), nth0(4, Z, C4),
	length(C1,LengthC1), length(C2,LengthC2),length(C3,LengthC3),length(C4,LengthC4),
	not(LengthC1=0),not(LengthC2=0),not(LengthC3=0),not(LengthC4=0),
	reverse(C1,C1r),reverse(C2,C2r),reverse(C3,C3r),reverse(C4,C4r),
	nth0(LineNumber, C1r, E1),nth0(LineNumber, C2r, E2),nth0(LineNumber, C3r, E3),nth0(LineNumber, C4r, E4),
	%forall(member(A==B,[E1==E2,E2==E3,E3==E4,E4==E1]),A==B),Pion = B.
	E1==E2,E2==E3,E3==E4,E4==E1,
	Pion = E1,!.

sh(Pion, Z, LineNumber) :-
	nth0(2, Z, C1), nth0(3, Z, C2), nth0(4, Z, C3), nth0(5, Z, C4),
	length(C1,LengthC1), length(C2,LengthC2),length(C3,LengthC3),length(C4,LengthC4),
	not(LengthC1=0),not(LengthC2=0),not(LengthC3=0),not(LengthC4=0),
	reverse(C1,C1r),reverse(C2,C2r),reverse(C3,C3r),reverse(C4,C4r),
	nth0(LineNumber, C1r, E1),nth0(LineNumber, C2r, E2),nth0(LineNumber, C3r, E3),nth0(LineNumber, C4r, E4),
	%forall(member(A==B,[E1==E2,E2==E3,E3==E4,E4==E1]),A==B),Pion = B.
	E1==E2,E2==E3,E3==E4,E4==E1,
	Pion = E1,!. % ainsi on peut demander aussi qui est le vainqueur si on met une variable dans Pion

sh(Pion, Z, LineNumber) :-
	nth0(3, Z, C1), nth0(4, Z, C2), nth0(5, Z, C3), nth0(6, Z, C4),
	length(C1,LengthC1), length(C2,LengthC2),length(C3,LengthC3),length(C4,LengthC4),
	not(LengthC1=0),not(LengthC2=0),not(LengthC3=0),not(LengthC4=0),
	reverse(C1,C1r),reverse(C2,C2r),reverse(C3,C3r),reverse(C4,C4r),
	nth0(LineNumber, C1r, E1),nth0(LineNumber, C2r, E2),nth0(LineNumber, C3r, E3),nth0(LineNumber, C4r, E4),
	%forall(member(A==B,[E1==E2,E2==E3,E3==E4,E4==E1]),A==B),Pion = B.
	E1==E2,E2==E3,E3==E4,E4==E1,
	Pion = E1,!. % ainsi on peut demander aussi qui est le vainqueur si on met une variable dans Pion


% Predicat qui verifie si il existe une solution diagonale.
sd(Pion):-

(	diagInf1(X1), length(X1,NbElements), NbElements > 3, nth0(0, X1, E1), nth0(1, X1, E2), nth0(2, X1, E3), nth0(3, X1, E4),
	forall(member(Result = Formula, [E1 = E2, E2 = E3, E3 = E4]),Result == Formula), not(E1 == []), Pion = E4);

(	diagInf2(X2), length(X2,NbElements), NbElements > 3, nth0(0, X2, E1), nth0(1, X2, E2), nth0(2, X2, E3), nth0(3, X2, E4), nth0(4, X2, E5),
	(forall(member(Result = Formula, [E1 = E2, E2 = E3, E3 = E4]),Result == Formula);
	forall(member(Result = Formula, [E2 = E3, E3 = E4, E4 = E5]),Result == Formula)), not(E2 == []),Pion = E4);

(	diagInf3(X3), length(X3,NbElements), NbElements > 3, nth0(0, X3, E1), nth0(1, X3, E2), nth0(2, X3, E3), nth0(3, X3, E4),
	nth0(4, X3, E5), nth0(5 , X3, E6),
	(forall(member(Result = Formula, [E1 = E2, E2 = E3, E3 = E4]),Result == Formula);
	forall(member(Result = Formula, [E2 = E3, E3 = E4, E4 = E5]),Result == Formula);
	forall(member(Result = Formula, [E3 = E4, E4 = E5, E5 = E6]),Result == Formula)), not(E3 == []),Pion = E4);

(	diagInf4(X4), length(X4,NbElements), NbElements > 3, nth0(1, X4, E1), nth0(2, X4, E2), nth0(3, X4, E3), nth0(4, X4, E4),
	nth0(4, X4, E5), nth0(5 , X4, E6),
	(forall(member(Result = Formula, [E1 = E2, E2 = E3, E3 = E4]),Result == Formula);
	forall(member(Result = Formula, [E2 = E3, E3 = E4, E4 = E5]),Result == Formula);
	forall(member(Result = Formula, [E3 = E4, E4 = E5, E5 = E6]),Result == Formula)), not(E4 == []),Pion = E4);

(	diagInf5(X5), length(X5,NbElements), NbElements > 3, nth0(2, X5, E1), nth0(3, X5, E2), nth0(4, X5, E3), nth0(5, X5, E4), nth0(6, X5, E5),
	(forall(member(Result = Formula, [E1 = E2, E2 = E3, E3 = E4]),Result == Formula);
	forall(member(Result = Formula, [E2 = E3, E3 = E4, E4 = E5]),Result == Formula)), not(E4 == []),Pion = E4);

(	diagInf6(X6), length(X6,NbElements), NbElements > 3, nth0(3, X6, E1), nth0(4, X6, E2), nth0(5, X6, E3), nth0(6, X6, E4),
	forall(member(Result = Formula, [E1 = E2, E2 = E3, E3 = E4]),Result == Formula), not(E3 == []),Pion = E4).

sd(Pion) :-

(	diagSup1(Y1), length(Y1,NbElements), NbElements > 3, nth0(0, Y1, E1), nth0(1, Y1, E2), nth0(2, Y1, E3), nth0(3, Y1, E4),
	forall(member(Result = Formula, [E1 = E2, E2 = E3, E3 = E4]),Result == Formula), not(E1 == []),Pion = E4);

(	diagSup2(Y2), length(Y2,NbElements), NbElements > 3, nth0(0, Y2, E1), nth0(1, Y2, E2), nth0(2, Y2, E3), nth0(3, Y2, E4), nth0(4, Y2, E5),
	(forall(member(Result = Formula, [E1 = E2, E2 = E3, E3 = E4]),Result == Formula);
	forall(member(Result = Formula, [E2 = E3, E3 = E4, E4 = E5]),Result == Formula)), not(E2 == []),Pion = E4);

(	diagSup3(Y3), length(Y3,NbElements), NbElements > 3, nth0(0, Y3, E1), nth0(1, Y3, E2), nth0(2, Y3, E3), nth0(3, Y3, E4),
	nth0(4, Y3, E5), nth0(5 , Y3, E6),
	(forall(member(Result = Formula, [E1 = E2, E2 = E3, E3 = E4]),Result == Formula);
	forall(member(Result = Formula, [E2 = E3, E3 = E4, E4 = E5]),Result == Formula);
	forall(member(Result = Formula, [E3 = E4, E4 = E5, E5 = E6]),Result == Formula)), not(E3 == []),Pion = E4);

(	diagSup4(Y4), length(Y4,NbElements), NbElements > 3, nth0(1, Y4, E1), nth0(2, Y4, E2), nth0(3, Y4, E3), nth0(4, Y4, E4),
	nth0(4, Y4, E5), nth0(5 , Y4, E6),
	(forall(member(Result = Formula, [E1 = E2, E2 = E3, E3 = E4]),Result == Formula);
	forall(member(Result = Formula, [E2 = E3, E3 = E4, E4 = E5]),Result == Formula);
	forall(member(Result = Formula, [E3 = E4, E4 = E5, E5 = E6]),Result == Formula)), not(E4 == []),Pion = E4);

(	diagSup5(Y5), length(Y5,NbElements), NbElements > 3, nth0(2, Y5, E1), nth0(3, Y5, E2), nth0(4, Y5, E3), nth0(5, Y5, E4), nth0(6, Y5, E5),
	(forall(member(Result = Formula, [E1 = E2, E2 = E3, E3 = E4]),Result == Formula);
	forall(member(Result = Formula, [E2 = E3, E3 = E4, E4 = E5]),Result == Formula)), not(E4 == []),Pion = E4);

(	diagSup6(Y6), length(Y6,NbElements), NbElements > 3, nth0(3, Y6, E1), nth0(4, Y6, E2), nth0(5, Y6, E3), nth0(6, Y6, E4),
	forall(member(Result = Formula, [E1 = E2, E2 = E3, E3 = E4]),Result == Formula), not(E3 == []),Pion = E4).


% Predicat qui vérifie si il y a une solution, qu'elle soit verticale, horizontale ou diagonale.
% En realisant un scan total de la grille de Jeu.
% Version fonctionnnant avec LA grille de jeu reelle
solution(Pion) :-
	sv(Pion);
	sh(Pion).
	%sd(Pion).

% Version permettant de renseigner une grille specifique.
solution(Pion,GamestateEnCours) :-
	sv(Pion,GamestateEnCours);
	sh(Pion,GamestateEnCours).

sh(Pion,GamestateEnCours):-
	(sh(Pion,GamestateEnCours,0),!);
	(sh(Pion,GamestateEnCours,1),!);
	(sh(Pion,GamestateEnCours,2),!);
	(sh(Pion,GamestateEnCours,3),!);
	(sh(Pion,GamestateEnCours,4),!);
	(sh(Pion,GamestateEnCours,5),!).
sv(Pion,GamestateEnCours):-
	sv(Pion, GamestateEnCours,0);
	sv(Pion, GamestateEnCours,1);
	sv(Pion, GamestateEnCours,2);
	sv(Pion, GamestateEnCours,3);
	sv(Pion, GamestateEnCours,4);
	sv(Pion, GamestateEnCours,5);
	sv(Pion, GamestateEnCours,6).
