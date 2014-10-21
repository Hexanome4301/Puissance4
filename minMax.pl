%en fonction de si on a gagner, perdu, qu'on ai un avantage
%ou un desavantage, la regle renvoie un certain score
eval(GamestateEnCours,Joueur,Score):-
	solution(Qui,GamestateEnCours),  %on demande si il y a un vainqueur et de le mettre dans Qui
	%on compare si c'est notre Joueur
	%si c'est oui on donne un gros score positif

	(Qui = Joueur , Score = 100 , ! );

	%la on regarde si c'est l'adversaire qui a gagner
	%si c'est oui on donne un scrore negatif
	(not(Qui = Joueur),Score = -100 , ! ).

%eval(GamestateEnCours,Joueur,Score):-
%	solution(Qui,GamestateEnCours),
%	not(Qui = Joueur) ,
%	Score = -100 , ! .

eval(GamestateEnCours,Joueur,Score):-
	%supposons que solution renvoie true et le nom du vainqueur quand on lui demande et false sinon
	not(solution(Qui,GamestateEnCours)),
	%ici pas de vainqueur on calcul l'avantage
	%par exemple l'avantage est donné pour la difference du nombre de série de 3 pions aligné par rapport a l'adversaire
	%nbSerieDe3(Joueur, Nb1),
	%nbSerieDe3(Adversaire,Nb2),
	%Score = Nb1 - Nb2 , ! .
	Score = 0.
%comment gerer l'egalite ???


%Principe: L'IA (jaune) en fonction d'un certain nombre de CoupDAvance et en fonction de sa ListeDeCoup possible
% va chercher le meilleur coup a jouer et le jouera.
% Du coup cette regle recupere l'etat courant du jeu, et fais la liste des coup possible.
% Pour chaque coup possible l'IA devra simuler ce coup et verra le nouvel etat du jeu.
% C'est a partir de ce nouvel etat de jeu que l'adversaire devra jouer un coup. Il cherchera donc a minimiser notre score.
% Parmi tous les score min (proposé par l'adversaire) qui s'offrent à l'IA,
% faudra qu'il choisisse le plus élevé (car il veut maximiser son score).
iaMinMax(CoupDAvance):-
	gamestate(X),
	retract(gamestateTampon(_)),
	assert(gamestateTampon(X)),

	coupPossible(X,ListeDeCoup),

	% ici une regle recursive sur la liste de coupPossible.
	%Fais jouer un coup, regarde le poid du coup prochain et compare les deux poids et renvoie le meilleur poids
	%note : la recursion qui sera ici, sera la meme que celle dans max
	simul(m,CoupDAvance,ListeDeCoup,_,MeilleurCoup),
	jouer(m,MeilleurCoup,_).

%Principe de min: A un certain etat/configuration du jeu (GamestateEnCours) pour la profondeur d'arbre 'Profondeur'
% on renvoie le coup procurant un score Result minimum pour notre Joeur (en l'occurence l'IA) et correspondant au
% coup 'Coup' (Colonne jouee)
% NOTE: dans la realisation en s'en fout du Result c'est Coup qui sera interessant de recup pour la regle iaMinMax
min(GamestateEnCours,Joueur,Profondeur, Result, Coup):-
	% selon la configuration du jeu, on recupere la ListeDeCoup possible
	not(Profondeur = 0),
	coupPossible(GamestateEnCours,ListeDeCoup),

	% L'adversaire va simuler tout les coups possible et en prévoyant un nombre 'Profondeur'
	% de coup d'avance va donner dans la variable Result le pire score (poids) pour son adversaire associe au coup Coup
	simulAdversaire(Joueur,Profondeur,ListeDeCoup,Result,Coup).

%condition d'arret :
%lorsqu'on atteint la profondeur 0, on evalue la situation du jeu
min(GamestateEnCours,Joueur,0, Result,CoupAssocie):-
	eval(GamestateEnCours,Joueur,Result),
		CoupAssocie = 7.




%condition d'arret :
%-infini represente le pire poid possible pour commencer nos comparaison
simulAdversaire(_,_,[],PirePoids,4):-
	PirePoids = 100000000.

% recursion interne dans min ou l'adversaire teste tous les coup possible et donne le poid du coup et le coup associe
simulAdversaire(Joueur,ProfondeurEnCours,ListeDeCoup,PirePoids,PireCoup):-
	ListeDeCoup = [Colonne|Queue],
	%la c'est une regle comme jouer sauf qu'elle n'utilise pas la clause gamestate() qu'on a en dynamique mais un gamestate tampon
	simulationCoup(x,Colonne,NewGamestate), %adversaire de m (l'ia)
	ProfondeurSuivante is ProfondeurEnCours-1,
	%sur la profondeur suivante, ça sera a l'IA de jouer et bien sur il jouera le coup lui donnant le plus gros score
	max(NewGamestate,Joueur,ProfondeurSuivante,PoidsDuCoupActuel,CoupAssocie),

	%on revient a la configuration du jeu en cours:
	retract(gamestateTampon(_)),
	gamestate(X), assert(gamestateTampon(X)),

	%on simule le prochain coup possible
	simulAdversaire(Joueur,ProfondeurEnCours,Queue,PoidsDuCoupSuivant, CoupSuivantAssocie),

	balanceMin(PoidsDuCoupActuel,PoidsDuCoupSuivant,PirePoids),
	%regle tres moche pour juste renvoye le PireCoup associe au PirePoids
	pireCoup(PoidsDuCoupActuel,PoidsDuCoupSuivant,PirePoids,Colonne,CoupSuivantAssocie,PireCoup).

% recursion interne dans max ou l'ia teste tous les coup possible et donne le poid du coup
%-infini represente le pire poid possible pour commencer nos comparaison

simul(_,_,[],MeilleurPoids,4):-
	MeilleurPoids = -100000000.

simul(Joueur,ProfondeurEnCours,ListeDeCoup,MeilleurPoids,MeilleurCoup):-
	ListeDeCoup = [Colonne|Queue],
	simulationCoup(Joueur,Colonne,NewGamestate),
	%sur la profondeur suivante, ça sera a l'adversaire de jouer et bien sur il jouera le coup donnant à l'IA le plus pire score
	ProfondeurSuivante is ProfondeurEnCours-1,
	min(NewGamestate,Joueur,ProfondeurSuivante,PoidsDuCoupActuel,CoupAssocie),
	%on revient a la configuration du jeu en cours:
	retract(gamestateTampon(_)),
	gamestate(X), assert(gamestateTampon(X)),
	%on simule le prochain coup possible
	simul(Joueur,ProfondeurEnCours,Queue,PoidsDuCoupSuivant,CoupSuivantAssocie),

	balanceMax(PoidsDuCoupActuel,PoidsDuCoupSuivant,MeilleurPoids),
	meilleurCoup(PoidsDuCoupActuel,PoidsDuCoupSuivant,MeilleurPoids,Colonne,CoupSuivantAssocie,MeilleurCoup).

%condition d'arret
max(GamestateEnCours,Joueur,0, Result,CoupAssocie):-
	eval(GamestateEnCours,Joueur,Result),
	CoupAssocie = 7.

max(GamestateEnCours,Joueur,Profondeur, Result, Coup):-
	% selon la configuration du jeu, on recupere la ListeDeCoup possible
	not(Profondeur = 0),

	coupPossible(GamestateEnCours,ListeDeCoup),

	% L'IA va simuler tout les coups possible et en prévoyant un nombre 'Profondeur'
	% de coup d'avance va donner dans la variable Result le meilleur score (poids) pour son adversaire associe au coup 'Coup'
	simul(Joueur,Profondeur,ListeDeCoup,Result,Coup).



%Liste de regle fonctionnelle
meilleurCoup(PoidsDuCoupActuel,PoidsDuCoupSuivant,PirePoids,CoupAssocie,CoupSuivantAssocie,MeilleurCoup):-
	PoidsDuCoupActuel = PirePoids,
	MeilleurCoup = CoupAssocie , ! .

meilleurCoup(PoidsDuCoupActuel,PoidsDuCoupSuivant,PirePoids,CoupAssocie,CoupSuivantAssocie,MeilleurCoup):-
	PoidsDuCoupSuivant = PirePoids,
	MeilleurCoup = CoupSuivantAssocie, ! .

pireCoup(PoidsDuCoupActuel,PoidsDuCoupSuivant,MeilleurCoup,CoupAssocie,CoupSuivantAssocie,PireCoup):-
	PoidsDuCoupActuel = MeilleurCoup,
	PireCoup = CoupAssocie , ! .

pireCoup(PoidsDuCoupActuel,PoidsDuCoupSuivant,MeilleurCoup,CoupAssocie,CoupSuivantAssocie,PireCoup):-
	PoidsDuCoupSuivant = MeilleurCoup,
	PireCoup = CoupSuivantAssocie, ! .

balanceMin(PoidsDuCoupActuel,PoidsDuCoupSuivant,PirePoids):-
	PoidsDuCoupActuel =< PoidsDuCoupSuivant,
	PirePoids = PoidsDuCoupActuel, ! .

balanceMin(PoidsDuCoupActuel,PoidsDuCoupSuivant,PirePoids):-
	PoidsDuCoupActuel >= PoidsDuCoupSuivant,
	PirePoids = PoidsDuCoupSuivant, ! .

balanceMax(PoidsDuCoupActuel,PoidsDuCoupSuivant,PirePoids):-
	PoidsDuCoupActuel >= PoidsDuCoupSuivant,
	PirePoids = PoidsDuCoupActuel, ! .

balanceMax(PoidsDuCoupActuel,PoidsDuCoupSuivant,PirePoids):-
	PoidsDuCoupActuel =< PoidsDuCoupSuivant,
	PirePoids = PoidsDuCoupSuivant, ! .