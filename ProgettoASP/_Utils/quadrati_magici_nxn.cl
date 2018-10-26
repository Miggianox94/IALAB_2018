valore(1..n*n).
coordinata(1..n).
somma(n*((n*n)+1)/2).

1 {ha_valore(X,Y,V) : valore(V)} 1 :- coordinata(X),coordinata(Y).

1 {ha_valore(X,Y,V) : coordinata(X),coordinata(Y)} 1 :- valore(V).

somma_riga(Y,Somma):-Somma=#sum{V:ha_valore(X,Y,V),coordinata(X)},coordinata(Y).
somma_col(X,Somma):-Somma=#sum{V:ha_valore(X,Y,V),coordinata(Y)},coordinata(X).
somma_diag_1(Somma):-Somma=#sum{V:ha_valore(Z,Z,V),coordinata(Z)}.
somma_diag_2(Somma):-Somma=#sum{V:ha_valore(Z,n-Z+1,V),coordinata(Z)}.

:- somma_riga(Y,Somma),coordinata(Y),somma(S),Somma!=S.
:- somma_col(X,Somma),coordinata(X),somma(S),Somma!=S.
:- somma_diag_1(Somma),somma(S),Somma!=S.
:- somma_diag_2(Somma),somma(S),Somma!=S.
    

#show ha_valore/3.