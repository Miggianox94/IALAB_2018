:- consult('../labirinto').
:- consult('../../main').

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

costo(0,0,0,0,0).

costo(4,2,3,2,40).
costo(2,4,1,4,10).
costo(9,8,8,8,67).
costo(8,9,7,9,100).
costo(7,8,7,9,100).

iniziale(pos(4,2)).

finale(pos(7,9)).
