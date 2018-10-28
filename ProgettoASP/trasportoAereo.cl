% Problema del trasporto aereo merci Russel e Norvig

% I livelli sono rappresentati con gli interi da 0 a lastlev
% Lo stato finale e' lastlev+1

#const lastlev=7.

%livello(0..lastlev).
state(0..lastlev+1).


% STATO INIZIALE
%*
	% ESEMPIO 2 AEREOPORTI - 1 MERCI - 1 AEREI

	aeroporto(jfk;sfo).  

	merce(c1).

	aereo(p1).

	holds(posizione(c1,sfo),0).
	holds(posizione(p1,sfo),0).

	% GOAL

	goal:- holds(posizione(c1,jfk),lastlev+1).
	:- not goal.
*%

%*
	% ESEMPIO 2 AEREOPORTI - 2 MERCI - 2 AEREI

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
*%

%*

	% ESEMPIO 4 AEREOPORTI - 4 MERCI - 2 AEREI

	aeroporto(jfk;sfo;air1;air2).  

	merce(c1;c2;c3;c4).

	aereo(p1;p2).

	holds(posizione(c1,sfo),0).
	holds(posizione(c2,jfk),0).
	holds(posizione(c3,sfo),0).
	holds(posizione(c4,air2),0).
	holds(posizione(p1,sfo),0).
	holds(posizione(p2,jfk),0).

	% GOAL

	goal:- holds(posizione(c1,jfk),lastlev+1), holds(posizione(c2,sfo),lastlev+1), holds(posizione(c3,air1),lastlev+1), holds(posizione(c4,jfk),lastlev+1).
	:- not goal.
*%



	% ESEMPIO 8 AEREOPORTI - 8 MERCI - 2 AEREI

	aeroporto(jfk;sfo;air1;air2;air3;air4;air5;air6).  

	merce(c1;c2;c3;c4;c5;c6;c7;c8).

	aereo(p1;p2).

	holds(posizione(c1,sfo),0).
	holds(posizione(c2,jfk),0).
	holds(posizione(c3,sfo),0).
	holds(posizione(c4,air2),0).
	holds(posizione(c5,air3),0).
	holds(posizione(c6,air4),0).
	holds(posizione(c7,air4),0).
	holds(posizione(c8,air4),0).
	
	holds(posizione(p1,sfo),0).
	holds(posizione(p2,jfk),0).

	% GOAL

	goal:- 
		holds(posizione(c1,jfk),lastlev+1), 
		holds(posizione(c2,sfo),lastlev+1), 
		holds(posizione(c3,air1),lastlev+1), 
		holds(posizione(c4,jfk),lastlev+1),
		holds(posizione(c5,air4),lastlev+1),
		holds(posizione(c6,sfo),lastlev+1),
		holds(posizione(c7,jfk),lastlev+1),
		holds(posizione(c8,air2),lastlev+1).
	:- not goal.






% AZIONI (possono essere eseguite in parallelo)

action(carica(Merce,Aereo,Aereoporto)):- merce(Merce),aereo(Aereo),aeroporto(Aereoporto).
action(scarica(Merce,Aereo,Aereoporto)):- merce(Merce),aereo(Aereo),aeroporto(Aereoporto).
action(vola(Aereo,AereoportoDa,AereoportoA)):- aereo(Aereo),aeroporto(AereoportoDa),aeroporto(AereoportoA).


1{occurs(A,S): action(A)}:- state(S).	
{occurs(carica(Merce,Aereo,Aereoporto),S): merce(Merce),aeroporto(Aereoporto)}1:- state(S),aereo(Aereo).	

% FLUENTI

fluent(posizione(X,Y)):- aeroporto(Y), merce(X).
fluent(posizione(X,Y)):- aeroporto(Y), aereo(X).
fluent(in(X,Y)):- merce(X), aereo(Y).

	
% EFFETTI
	
holds(in(Merce,Aereo),Stato+1), not holds(posizione(Merce,Aereoporto),Stato) :- occurs(carica(Merce,Aereo,Aereoporto),Stato), state(Stato).
holds(posizione(Merce,Aereoporto),Stato+1), not holds(in(Merce,Aereo),Stato)  :- occurs(scarica(Merce,Aereo,Aereoporto),Stato), state(Stato).
holds(posizione(Aereo,AereoportoA),Stato+1), not holds(posizione(Aereo,AereoportoDa),Stato) :- occurs(vola(Aereo,AereoportoDa,AereoportoA),Stato), state(Stato).
	
% PRECONDIZIONI

:- occurs(carica(Merce,Aereo,Aereoporto),Stato), not holds(posizione(Merce,Aereoporto),Stato).
:- occurs(carica(Merce,Aereo,Aereoporto),Stato), not holds(posizione(Aereo,Aereoporto),Stato).
:- occurs(carica(Merce,Aereo,Aereoporto),Stato), occurs(carica(Merce1,Aereo,Aereoporto),Stato), Merce1 != Merce.
:- occurs(carica(Merce,Aereo,Aereoporto),Stato), holds(in(Merce1,Aereo),Stato), Merce1 != Merce.

:- occurs(scarica(Merce,Aereo,Aereoporto),Stato), not holds(in(Merce,Aereo),Stato).
:- occurs(scarica(Merce,Aereo,Aereoporto),Stato), not holds(posizione(Aereo,Aereoporto),Stato).
:- occurs(scarica(Merce,Aereo,Aereoporto),Stato), occurs(scarica(Merce1,Aereo,Aereoporto),Stato), Merce1 != Merce.

:- occurs(vola(Aereo,AereoportoDa,AereoportoA),Stato), not holds(posizione(Aereo,AereoportoDa),Stato).
:- occurs(vola(Aereo,AereoportoDa,AereoportoA),Stato), AereoportoDa == AereoportoA.
:- occurs(vola(Aereo,AereoportoDa,AereoportoA),Stato), occurs(vola(Aereo,AereoportoDa,AereoportoA1),Stato), AereoportoA1 != AereoportoA.
:- occurs(vola(Aereo,AereoportoDa,AereoportoA),Stato), holds(posizione(Aereo,Aereoporto),Stato), Aereoporto != AereoportoDa.

:- holds(posizione(Aereo,Aereoporto),Stato),holds(posizione(Aereo,Aereoporto1),Stato), Aereoporto!=Aereoporto1.

% PERSISTENZA

holds(F,S+1):-
	fluent(F),
	state(S),
	holds(F,S),
	not -holds(F,S+1).

-holds(F,S+1):-
	fluent(F),state(S),-holds(F,S),not holds(F,S+1).
	

% REGOLE CAUSALI


-holds(posizione(X,Aereoporto1),Stato):- 
	fluent(posizione(X,Aereoporto1)),state(Stato), aereo(X), holds(posizione(X,Aereoporto2),Stato), aeroporto(Aereoporto2), Aereoporto1!=Aereoporto2, not holds(posizione(X,Aereoporto1),Stato).
-holds(posizione(X,Aereoporto1),Stato):- 
	fluent(posizione(X,Aereoporto1)),state(Stato),merce(X),holds(in(X,Aereo),Stato), aereo(Aereo), not holds(posizione(X,Aereoporto1),Stato).
-holds(in(Merce,Aereo),Stato):- 
	fluent(in(Merce,Aereo)),state(Stato), holds(in(Merce,Aereo1),Stato),aereo(Aereo1), Aereo1!=Aereo, not holds(in(Merce,Aereo),Stato).
-holds(in(Merce,Aereo),Stato):- 
	fluent(in(Merce,Aereo)),state(Stato), holds(posizione(Merce,Aereoporto),Stato), aeroporto(Aereoporto), not holds(in(Merce,Aereo),Stato).
	


#show occurs/2.
%#show holds/2.
%#show -holds/2.