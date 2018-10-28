% Problema del trasporto aereo merci Russel e Norvig

% I livelli sono rappresentati con gli interi da 0 a lastlev
% Lo stato finale e' lastlev+1

#const lastlev=1.

livello(0..lastlev).
state(0..lastlev+1).


% STATO INIZIALE

aeroporto(jfk;sfo).  

merce(c1;c2).

aereo(p1;p2).

holds(posizione(c1,sfo),0).
holds(posizione(c2,jfk),0).
holds(posizione(p1,sfo),0).
holds(posizione(p2,jfk),0).

% GOAL

goal:- holds(posizione(c1,jfk),lastlev+1), holds(posizione(c2,sfo),lastlev+1).
:- not goal.



% AZIONI (possono essere eseguite in parallelo)

action(carica(Merce,Aereo,Aereoporto)):- merce(Merce),aereo(Aereo),aeroporto(Aereoporto).
action(scarica(Merce,Aereo,Aereoporto)):- merce(Merce),aereo(Aereo),aeroporto(Aereoporto).
action(vola(Aereo,AereoportoDa,AereoportoA)):- aereo(Aereo),aeroporto(AereoportoDa),aeroporto(AereoportoA).


1{occurs(A,S): action(A)}:- livello(S).	

% FLUENTI

fluent(posizione(X,Y)):- aeroporto(Y), merce(X).
fluent(posizione(X,Y)):- aeroporto(Y), aereo(X).
fluent(in(X,Y)):- merce(X), aereo(Y).

	
% EFFETTI
	
holds(in(Merce,Aereo),Livello+1) :- occurs(carica(Merce,Aereo,Aereoporto),Livello), livello(Livello).
holds(posizione(Merce,Aereoporto),Livello+1) :- occurs(scarica(Merce,Aereo,Aereoporto),Livello), livello(Livello).
holds(posizione(Aereo,AereoportoA),Livello+1) :- occurs(vola(Aereo,AereoportoDa,AereoportoA),Livello), livello(Livello).
	
% PRECONDIZIONI

:- occurs(carica(Merce,Aereo,Aereoporto),Livello), not holds(posizione(Merce,Aereoporto),Livello).
:- occurs(carica(Merce,Aereo,Aereoporto),Livello), not holds(posizione(Aereo,Aereoporto),Livello).

:- occurs(scarica(Merce,Aereo,Aereoporto),Livello), not holds(in(Merce,Aereo),Livello).
:- occurs(scarica(Merce,Aereo,Aereoporto),Livello), not holds(posizione(Aereo,Aereoporto),Livello).

:- occurs(vola(Aereo,AereoportoDa,AereoportoA),Livello), not holds(posizione(Aereo,AereoportoDa),Livello), AereoportoDa == AereoportoA.


% PERSISTENZA

holds(posizione(X,Y),S+1):-
	fluent(posizione(X,Y)),holds(posizione(X,Y),S), livello(S),
	not -holds(posizione(X,Y),S+1).

holds(in(X,Y),S+1):-
	fluent(in(X,Y)),holds(in(X,Y),S), livello(S),
	not -holds(in(X,Y),S+1).
	
	
	
% REGOLE CAUSALI

-holds(posizione(X,Aereoporto1),Stato):- 
	fluent(posizione(X,Aereoporto1)),state(Stato),holds(posizione(X,Aereoporto2),Stato), aeroporto(Aereoporto2), Aereoporto1!=Aereoporto2, not holds(posizione(X,Aereoporto1),Stato).
-holds(in(Merce,Aereo),Stato):- 
	fluent(in(Merce,Aereo)),state(Stato), holds(in(Merce,Aereo1),Stato),aereo(Aereo1), Aereo1!=Aereo, not holds(in(Merce,Aereo),Stato).
-holds(in(Merce,Aereo),Stato):- 
	fluent(in(Merce,Aereo)),state(Stato), holds(posizione(Merce,Aereoporto),Stato), aeroporto(Aereoporto), not holds(in(Merce,Aereo),Stato).


#show occurs/2.