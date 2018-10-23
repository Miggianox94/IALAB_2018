% stato: [at(Stazione), Location]
% Location può essere in(NomeLinea, Dir) o
%  'ground' se l'agente non è su nessun treno
% Dir può esere 0 o 1


% Azioni:
%  sali(Linea, Dir)
%  scendi(Stazione)
%  vai(Linea, Dir, StazionePartenza, StazioneArrivo)

applicabile(sali(Linea,Dir),[at(Stazione),ground]):-
	fermata(Stazione,Linea), member(Dir,[0,1]).
applicabile(scendi(Stazione),[at(Stazione),in(_,_)]).
applicabile(vai(Linea,Dir,SP,SA),[at(SP),in(Linea,Dir)]):-
	tratta(Linea,Dir,SP,SA).

trasforma(sali(Linea,Dir),[at(Stazione),ground],[at(Stazione),in(Linea,Dir)]).
trasforma(scendi(Stazione),[at(Stazione),in(_,_)],[at(Stazione),ground]).
trasforma(vai(Linea,Dir,SP,SA),[at(SP),in(Linea,Dir)],[at(SA),in(Linea,Dir)]):-
	tratta(Linea,Dir,SP,SA).
	
uguale(S,S).

percorso(Linea,1,LR):- percorso(Linea,0,L), reverse(L,LR).


% tratta(NomeLinea, Dir, StazionePartenza, StazioneArrivo)

tratta(Linea,Dir,SP,SA):- percorso(Linea,Dir,LF), member_pair(SP,SA,LF).

member_pair(X,Y,[X,Y|_]).
member_pair(X,Y,[_,Z|Rest]):- member_pair(X,Y,[Z|Rest]).


/*############

Da qui inizia la parte necessaria per le ricerche informate

############*/


h([at(NomeStazione),_],H):-
	stazione(NomeStazione,X,Y),
	finale([at(NomeFin),_]),
	stazione(NomeFin,Xfin,Yfin),
	H is abs(X-Xfin) + abs(Y-Yfin).

	
% g_funct(G,CostoCammino,G1):- G1 is G + CostoCammino.
g_funct(G,[at(NomeStazione1),_],[at(NomeStazione2),_],G1):-
	NomeStazione1 = NomeStazione2,
	G1 is G + 0.

g_funct(G,[at(NomeStazione1),_],[at(NomeStazione2),_],G1):-
    costo(NomeStazione1,NomeStazione2,C),!,
	stazione(NomeStazione1,X,Y),
	stazione(NomeStazione2,Xlast,Ylast),
	Total is abs(X-Xlast) + abs(Y-Ylast),
    G1 is G + Total + C.
g_funct(G,[at(NomeStazione1),_],[at(NomeStazione2),_],G1):-
	stazione(NomeStazione1,X,Y),
	stazione(NomeStazione2,Xlast,Ylast),
	Total is abs(X-Xlast) + abs(Y-Ylast),
    G1 is G + Total.

costo_default(1).	
