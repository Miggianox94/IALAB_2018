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

Da qui inizia la parte necessaria per le ricerche informate

############*/
	
h(pos(X,Y),H):-
	finale(pos(Xlast,Ylast)),
	H is abs(X-Xlast) + abs(Y-Ylast).

% g_funct(G,CostoCammino,G1):- G1 is G + CostoCammino.
g_funct(G,pos(X1,Y1),pos(X2,Y2),G1):-
    costo(X1,Y1,X2,Y2,C),!,
    G1 is G + C.
g_funct(G,_,_,G1):-
    costo_default(C),
    G1 is G + C.

costo_default(1).
