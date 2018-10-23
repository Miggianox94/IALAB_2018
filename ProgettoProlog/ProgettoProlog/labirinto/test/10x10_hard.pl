:- consult('../labirinto').
:- consult('../../main').


num_col(10).
num_righe(10).

occupata(pos(1,7)).
occupata(pos(2,7)).
occupata(pos(3,7)).
occupata(pos(4,7)).

occupata(pos(6,1)).
occupata(pos(6,2)).
occupata(pos(6,3)).
occupata(pos(6,4)).
occupata(pos(6,5)).
occupata(pos(6,6)).
occupata(pos(6,7)).
occupata(pos(6,8)).
occupata(pos(6,9)).

costo(0,0,0,0,0).

iniziale(pos(1,1)).
finale(pos(8,8)).
