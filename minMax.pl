%on a besoin d'une regle d'evaluation de l'etat du jeu
%en fonction de si on a gagner, perdu, qu'on ai un avantage
%ou un desavantage, la regle renvoie un certain score
eval(GamestateEnCours,Joueur,Score):-
	solution(Qui,GamestateEnCours),  %on demande si il y a un vainqueur et de le mettre dans Qui
	(
	%on compare si c'est notre Joueur
	%si c'est oui on donne un gros score positif
	(Qui = Joueur , Score = 100 , ! );

	%la on regarde si c'est l'adversaire qui a gagner
	%si c'est oui on donne un scrore negatif
	(not(Qui = Joueur),Score = -100 , ! )).

eval(GamestateEnCours,_,Score):-
	%supposons que solution renvoie true et le nom du vainqueur quand on lui demande et false sinon
	not(solution(_,GamestateEnCours)),

	%ici pas de vainqueur on calcul l'avantage
	%par exemple l'avantage est donné pour la difference du nombre de série de 3 pions aligné par rapport a l'adversaire
	%nbSerieDe3(Joueur, Nb1),
	%nbSerieDe3(Adversaire,Nb2),
	%Score = Nb1 - Nb2 , ! .
	Score = 0.

%Principe: L'IA (joueur m) en fonction d'un certain nombre de CoupDAvance et en fonction de sa ListeDeCoup possible
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

	retract(gamestateTampon2(_)),
	assert(gamestateTampon2(X)),

	retract(gamestateTampon3(_)),
	assert(gamestateTampon3(X)),

	coupPossible(X,ListeDeCoup),

	% ici une regle recursive sur la liste de coupPossible.
	%Fais jouer un coup, regarde le poid du coup prochain et compare les deux poids et renvoie le meilleur poids
	simul(m,CoupDAvance,ListeDeCoup,_,MeilleurCoup),
	jouer(m,MeilleurCoup,_).


%condition d'arret:
%Lorsqu'il n'y a plus de coup possible a jouer -> [].
%On choisit des valeur par defaut pour 'Poids' et 'Coup'.
%Le Poids sera comparé à un vrai poids calculé à partir d'un coup de l'adversaire
simul(_,_,[],Poids,Coup):-
	Poids = -100000000,
	Coup = 4.


simul(Joueur,ProfondeurEnCours,ListeDeCoup,MeilleurPoids,MeilleurCoup):-
	ListeDeCoup = [Colonne|Queue],
	simulationCoup(Joueur,Colonne,NewGamestate),

	%sur la profondeur suivante, ça sera a l'adversaire de jouer et bien sur il jouera le coup donnant à l'IA le pire score
	ProfondeurSuivante is ProfondeurEnCours-1,
	min(NewGamestate,Joueur,ProfondeurSuivante,PoidsDuCoupActuel,_),
	%ici en gros: sur le prochain tour de jeu ou l'etat de la grille sera NewGamestate, CoupEnnemi represente le pire coup contre
	%l'ia que pourra jouer son adversaire et il aura un poids egal a PoidsDuCoupActuel

	%on revient a la configuration du jeu en cours pour simuler un prochain coup:
	retract(gamestateTampon(_)),
	gamestateTampon3(X), assert(gamestateTampon(X)),

	CoupActuel = Colonne,

	%on simule le prochain coup possible
	simul(Joueur,ProfondeurEnCours,Queue,PoidsDuCoupSuivant,CoupSuivantAssocie),

	balanceMax(PoidsDuCoupActuel,PoidsDuCoupSuivant,MeilleurPoids),
	meilleurCoup(PoidsDuCoupActuel,PoidsDuCoupSuivant,MeilleurPoids,CoupActuel,CoupSuivantAssocie,MeilleurCoup).

%Principe de min: A un certain etat/configuration du jeu (GamestateEnCours) pour la profondeur d'arbre 'Profondeur'
% on renvoie le coup procurant un score Result minimum pour notre Joueur (en l'occurence l'IA) et correspondant au
% coup 'Coup' pour l'adversaire (Colonne jouee)
% NOTE: dans la realisation en s'en fout du Result c'est Coup qui sera interessant de recup pour la regle iaMinMax
min(GamestateEnCours,Joueur,Profondeur, Result, Coup):-
	not(Profondeur = 0),

	% selon la configuration du jeu, on recupere la ListeDeCoup possible
	coupPossible(GamestateEnCours,ListeDeCoup),
	retract(gamestateTampon2(_)),
	assert(gamestateTampon2(GamestateEnCours)),
	% L'adversaire va simuler tout les coups possible et en prévoyant un nombre 'Profondeur'
	% de coup d'avance va donner dans la variable Result le pire score (poids) pour son adversaire associe au coup Coup
	simulAdversaire(Joueur,Profondeur,ListeDeCoup,Result,Coup).

%condition d'arret :
%lorsqu'on atteint la profondeur 0, on evalue la situation du jeu
min(GamestateEnCours,Joueur,0, Result, _ ):-
	eval(GamestateEnCours,Joueur,Result).

%condition d'arret :
%-infini represente le pire poid possible pour commencer nos comparaison
simulAdversaire(_,_,[],PirePoids,4):-
	PirePoids = 100000000.

% recursion interne dans min ou l'adversaire teste tous les coup possible et donne le poid du coup et le coup associe
simulAdversaire(Joueur,ProfondeurEnCours,ListeDeCoup,PirePoids,PireCoup):-
	ListeDeCoup = [Colonne|Queue],
	%la c'est une regle comme jouer sauf qu'elle n'utilise pas la clause gamestate() qu'on a en dynamique mais un gamestate tampon
	simulationCoup(x,Colonne,NewGamestate), %adversaire de m (l'ia)

	%sur la profondeur suivante, ça sera a l'IA de jouer et bien sur il jouera le coup lui donnant le plus gros score
	ProfondeurSuivante is ProfondeurEnCours-1,
	max(NewGamestate,Joueur,ProfondeurSuivante,PoidsDuCoupActuel,_),

	%on revient a la configuration du jeu en cours:
	retract(gamestateTampon(_)),
	gamestateTampon2(X), assert(gamestateTampon(X)),

	CoupActuel = Colonne,

	%on simule le prochain coup possible
	simulAdversaire(Joueur,ProfondeurEnCours,Queue,PoidsDuCoupSuivant, CoupSuivantAssocie),

	balanceMin(PoidsDuCoupActuel,PoidsDuCoupSuivant,PirePoids),
	%regle tres moche pour juste renvoye le PireCoup associe au PirePoids
	pireCoup(PoidsDuCoupActuel,PoidsDuCoupSuivant,PirePoids,CoupActuel,CoupSuivantAssocie,PireCoup).


max(GamestateEnCours,Joueur,Profondeur, Result, Coup):-
	not(Profondeur = 0),

	% selon la configuration du jeu, on recupere la ListeDeCoup possible
	coupPossible(GamestateEnCours,ListeDeCoup),

	retract(gamestateTampon3(_)),
	assert(gamestateTampon3(GamestateEnCours)),

	% L'IA va simuler tout les coups possible et en prévoyant un nombre 'Profondeur'
	% de coup d'avance va donner dans la variable Result le meilleur score (poids) associe au coup 'Coup'
	simul(Joueur,Profondeur,ListeDeCoup,Result,Coup).

%condition d'arret: lorsque max recoit en parametre la profondeur 0 c'est que l'adversaire ne doit plus regarder ce
% que pourrait jouer l'ia et evalue pour lui même le score qu'il effectuerais pour ce(son) dernier tour de jeu prémédité
max(GamestateEnCours,Joueur,0, Result,_):-
	eval(GamestateEnCours,Joueur,Result).


%Liste de regle fonctionnelle
meilleurCoup(PoidsDuCoupActuel,_,PirePoids,CoupAssocie,_,MeilleurCoup):-
	PoidsDuCoupActuel = PirePoids,
	MeilleurCoup = CoupAssocie , ! .

meilleurCoup(_,PoidsDuCoupSuivant,PirePoids,_,CoupSuivantAssocie,MeilleurCoup):-
	PoidsDuCoupSuivant = PirePoids,
	MeilleurCoup = CoupSuivantAssocie, ! .

pireCoup(PoidsDuCoupActuel,_,MeilleurCoup,CoupAssocie,_,PireCoup):-
	PoidsDuCoupActuel = MeilleurCoup,
	PireCoup = CoupAssocie , ! .

pireCoup(_,PoidsDuCoupSuivant,MeilleurCoup,_,CoupSuivantAssocie,PireCoup):-
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