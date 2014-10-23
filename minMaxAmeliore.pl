%en fonction de si on a gagner, perdu, qu'on ai un avantage
%ou un desavantage, la regle renvoie un certain score
eval2(GamestateEnCours,Joueur,Score):-
	solution(Qui,GamestateEnCours),  %on demande si il y a un vainqueur et de le mettre dans Qui

	%on compare si c'est notre Joueur
	%si c'est oui on donne un gros score positif
	%si c'est non on donne un scrore negatif
	(	(Qui = Joueur , Score = 1000 , ! );	(not(Qui = Joueur),Score = -1000 , ! )	).

eval2(GamestateEnCours,Joueur,Score):-
	%supposons que solution renvoie true et le nom du vainqueur quand on lui demande et false sinon
	not(solution(_,GamestateEnCours)),
	changerPion(Joueur,Adversaire),
	nbSeries3Diagonales(Joueur,Nb3DJoueur),
	nbSeries3Diagonales(Adversaire,Nb3DAdvers),

	nbSeries3Horizontales(Joueur,Nb3HJoueur),
	nbSeries3Horizontales(Adversaire,Nb3HAdvers),

	nbSeries3Verticales(Joueur,Nb3VJoueur),
	nbSeries3Verticales(Adversaire,Nb3VAdvers),

	Nb3Joueur is Nb3VJoueur + Nb3HJoueur + Nb3DJoueur ,
	Nb3Advers is Nb3VAdvers + Nb3HAdvers + Nb3DAdvers ,

	nbSeries2Diagonales(Joueur,Nb2DJoueur),
	nbSeries2Diagonales(Adversaire,Nb2DAdvers),

	nbSeries2Horizontales(Joueur,Nb2HJoueur),
	nbSeries2Horizontales(Adversaire,Nb2HAdvers),

	nbSeries2Verticales(Joueur,Nb2VJoueur),
	nbSeries2Verticales(Adversaire,Nb2VAdvers),

	Nb2Joueur is Nb2VJoueur + Nb2HJoueur + Nb2DJoueur ,
	Nb2Advers is Nb2VAdvers + Nb2HAdvers + Nb2DAdvers ,


	Score is (5*(Nb3Joueur) + 2*(Nb2Joueur)) - (5*(Nb3Advers) + 2*(Nb2Advers)).


iaBigBoss(Joueur,CoupDAvance,MeilleurCoup,LigneDuNouvelElem):-
	iaBigBoss(Joueur,CoupDAvance,MeilleurCoup,LigneDuNouvelElem,_).
iaBigBoss(Joueur,CoupDAvance,MeilleurCoup,LigneDuNouvelElem,ListPoids):-
	gamestate(X),

	init_gamestate,

	coupPossible(X,ListeDeCoup),

	simul2(Joueur,CoupDAvance,ListeDeCoup,ListPoids,MeilleurCoup),
	joueIa2(Joueur,MeilleurCoup,LigneDuNouvelElem).

joueIa2(Joueur,_,LigneDuNouvelElem):-
	gamestate(X),X=[[],[],[],[],[],[],[]],jouer(Joueur,4,_,LigneDuNouvelElem), ! .

joueIa2(Joueur,MeilleurCoup,LigneDuNouvelElem):-
	jouer(Joueur,MeilleurCoup,_,LigneDuNouvelElem),!.

simul2(_,_,[],Poids,4):-
	Poids = [-1000000].

simul2(Joueur,ProfondeurEnCours,ListeDeCoup,ListPoids,MeilleurCoup):-
	ListeDeCoup = [CoupActuel|Queue],

	current_context(GamestateEnCours,DiagInf1EnCours,DiagInf2EnCours,DiagInf3EnCours,DiagInf4EnCours,DiagInf5EnCours,DiagInf6EnCours,DiagSup1EnCours,DiagSup2EnCours,DiagSup3EnCours,DiagSup4EnCours,DiagSup5EnCours,DiagSup6EnCours),

	simulationCoup(Joueur,CoupActuel,NewGamestate),

	ProfondeurSuivante is ProfondeurEnCours-1,
	min2(NewGamestate,Joueur,ProfondeurSuivante,PoidsCoupActuel),

	restore_context(GamestateEnCours,DiagInf1EnCours,DiagInf2EnCours,DiagInf3EnCours,DiagInf4EnCours,DiagInf5EnCours,DiagInf6EnCours,DiagSup1EnCours,DiagSup2EnCours,DiagSup3EnCours,DiagSup4EnCours,DiagSup5EnCours,DiagSup6EnCours),

	simul2(Joueur,ProfondeurEnCours,Queue,ListPoidsCoupsSuivants,CoupSuivantAssocie),

	append([PoidsCoupActuel],ListPoidsCoupsSuivants,ListPoids),
	meilleurCoup(ListPoids,PoidsCoupActuel,CoupActuel,CoupSuivantAssocie,MeilleurCoup).

min2(GamestateEnCours,Joueur,Profondeur, Result):-
	not(Profondeur = 0),

	coupPossible(GamestateEnCours,ListeDeCoup),

	simulAdversaire2(Joueur,Profondeur,ListeDeCoup,ListPoids,_),
	min_member(Result,ListPoids).

min2(GamestateEnCours,Joueur,0, Result):-
	eval2(GamestateEnCours,Joueur,Result).

simulAdversaire2(_,_,[],PirePoids,4):-
	PirePoids = [1000000].

simulAdversaire2(Joueur,ProfondeurEnCours,ListeDeCoup,ListPoids,PireCoup):-
	ListeDeCoup = [CoupActuel|Queue],
	changerPion(Joueur,Adversaire),

	current_context(GamestateEnCours,DiagInf1EnCours,DiagInf2EnCours,DiagInf3EnCours,DiagInf4EnCours,DiagInf5EnCours,DiagInf6EnCours,DiagSup1EnCours,DiagSup2EnCours,DiagSup3EnCours,DiagSup4EnCours,DiagSup5EnCours,DiagSup6EnCours),

	simulationCoup(Adversaire,CoupActuel,NewGamestate),

	ProfondeurSuivante is ProfondeurEnCours-1,
	max2(NewGamestate,Joueur,ProfondeurSuivante,PoidsCoupActuel),

	restore_context(GamestateEnCours,DiagInf1EnCours,DiagInf2EnCours,DiagInf3EnCours,DiagInf4EnCours,DiagInf5EnCours,DiagInf6EnCours,DiagSup1EnCours,DiagSup2EnCours,DiagSup3EnCours,DiagSup4EnCours,DiagSup5EnCours,DiagSup6EnCours),

	simulAdversaire2(Joueur,ProfondeurEnCours,Queue,ListPoidsCoupsSuivants, CoupSuivantAssocie),

	append([PoidsCoupActuel],ListPoidsCoupsSuivants,ListPoids),
	pireCoup(ListPoids,PoidsCoupActuel,CoupActuel,CoupSuivantAssocie,PireCoup).

max2(GamestateEnCours,Joueur,Profondeur, Result):-
	not(Profondeur = 0),

	coupPossible(GamestateEnCours,ListeDeCoup),

	simul2(Joueur,Profondeur,ListeDeCoup,ListPoids,_),
	max_member(Result,ListPoids).

max2(GamestateEnCours,Joueur,0, Result):-
	eval2(GamestateEnCours,Joueur,Result).