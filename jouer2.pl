%Ligne de code � mettre dans un fichier � part d'initialisation
%ou bien initialiser � la main directement
:- dynamic(col/2).
col([],1).
col([],2).
col([],3).
col([],4).
col([],5).
col([],6).
col([],7).

:- dynamic(joueur/2).
joueur(1,rouge).
joueur(2,noir).
joueur(ia,violet).

joueur(maria,jaune).
joueur(mehdi,vert).

jouerCoup(C,Jeton,CNew):-
	checkTaille(C),   %solution pas tr�s jolie pour tester la taille d'�l�ment contenu dans la colonne et afficher un message si taille max d�pass� (quest prof)
	append([Jeton],C,CNew).

checkTaille(C):-
	length(C,NbElem) , NbElem < 6;
	(   length(C,NbElem) , not(NbElem < 6),
	write(' Vous ne pouvez plus ajouter de jeton dans cette colonne veuillez choisir une autre') ).

coup(Jeton,I):-
	col(C,I),
	jouerCoup(C,Jeton,CNew),
	retract(col(_,I)),
	asserta(col(CNew,I)).

joue(Joueur,ColonneChoisi):-
	joueur(Joueur,Jeton),
	coup(Jeton,ColonneChoisi).




