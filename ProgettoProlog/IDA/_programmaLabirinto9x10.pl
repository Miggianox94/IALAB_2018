
% Esempio 10 x 10

num_col(10).
num_righe(10).

occupata(pos(2,5)).
occupata(pos(3,5)).
occupata(pos(4,5)).
occupata(pos(5,5)).
occupata(pos(6,5)).
occupata(pos(7,5)).
occupata(pos(7,1)).
occupata(pos(7,2)).
occupata(pos(7,3)).
occupata(pos(7,4)).
occupata(pos(5,7)).
occupata(pos(6,7)).
occupata(pos(7,7)).
occupata(pos(8,7)).
occupata(pos(4,7)).
occupata(pos(4,8)).
occupata(pos(4,9)).
occupata(pos(4,10)).

iniziale(pos(4,2)).

finale(pos(7,9)).

applicabile(nord,pos(R,C)) :-
	R>1,
	R1 is R-1,
	\+ occupata(pos(R1,C)).

applicabile(sud,pos(R,C)) :-
	num_righe(NR), R<NR,
	R1 is R+1,
	\+ occupata(pos(R1,C)).
	
applicabile(ovest,pos(R,C)) :-
	C>1,
	C1 is C-1,
	\+ occupata(pos(R,C1)).
	
applicabile(est,pos(R,C)) :-
	num_col(NC), C<NC,
	C1 is C+1,
	\+ occupata(pos(R,C1)).
	
trasforma(est,pos(R,C),pos(R,C1)) :- C1 is C+1.
trasforma(ovest,pos(R,C),pos(R,C1)) :- C1 is C-1.
trasforma(sud,pos(R,C),pos(R1,C)) :- R1 is R+1.
trasforma(nord,pos(R,C),pos(R1,C)) :- R1 is R-1.


/*############

Da qui inizia la parte necessaria per l'algoritmo IDA*

############*/
	
h(pos(X,Y),H):-
	finale(pos(Xlast,Ylast)),
	H is abs(X-Xlast) + abs(Y-Ylast).

g(pos(_,_),[],0).
	
g(pos(X,Y),[pos(Xprec,Yprec)|AltrePosizioni],G):-
	Total is abs(X-Xprec) + abs(Y-Yprec),
	g(pos(Xprec,Yprec),AltrePosizioni,G1),
	G is Total+G1.
	
%chiamato solo per i nodi che superano la profondità massima
f(pos(X,Y),Cammino,RemainingDepth):-
	(RemainingDepth < 0 ; RemainingDepth = 0),
	h(pos(X,Y),H),
	g(pos(X,Y),Cammino,G),
	F is H+G,
	%faccio l'append della lista dei valori di f(n) che superano maxdepth
	currentListOver(CurrentListOver),
	append(CurrentListOver,[F],NewCurrentListOver),
	abolish(currentListOver/1),
	assertz(currentListOver(NewCurrentListOver)).

%chiamato quando RemainingDepth > 0 o quando f(n) < currentLimit inferiore
f(_,_,_):- true.

?- consult(ida).
