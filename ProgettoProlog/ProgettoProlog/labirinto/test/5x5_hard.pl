:- consult('../labirinto').
:- consult('../../main').

% Esempio 5 x 5

num_col(5).
num_righe(5).

occupata(pos(1,2)).
occupata(pos(1,3)).
occupata(pos(1,5)).
occupata(pos(2,2)).
occupata(pos(3,2)).
occupata(pos(5,1)).
occupata(pos(3,4)).
occupata(pos(4,4)).
occupata(pos(5,4)).
occupata(pos(1,5)).

costo(0,0,0,0,0).

iniziale(pos(1,1)).

finale(pos(5,5)).
