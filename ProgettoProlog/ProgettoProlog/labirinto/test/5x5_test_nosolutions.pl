:- consult('../labirinto').
:- consult('../../main').

% Esempio 5 x 5

num_col(5).
num_righe(5).

occupata(pos(1,4)).
occupata(pos(3,1)).
occupata(pos(3,2)).
occupata(pos(3,3)).
occupata(pos(4,5)).
occupata(pos(5,4)).

costo(0,0,0,0,0).

iniziale(pos(1,1)).

finale(pos(5,5)).
