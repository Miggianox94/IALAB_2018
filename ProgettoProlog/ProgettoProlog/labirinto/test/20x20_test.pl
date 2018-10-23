:- consult('../labirinto').
:- consult('../../main').

% Esempio 20 x 20

num_col(20).
num_righe(20).

occupata(pos(1,15)).
occupata(pos(2,15)).
occupata(pos(3,15)).
occupata(pos(4,15)).
occupata(pos(5,15)).

occupata(pos(4,9)).
occupata(pos(5,9)).
occupata(pos(6,9)).
occupata(pos(7,9)).
occupata(pos(8,9)).
occupata(pos(9,9)).
occupata(pos(10,9)).
occupata(pos(11,9)).
occupata(pos(12,9)).
occupata(pos(13,9)).
occupata(pos(14,9)).
occupata(pos(15,9)).
occupata(pos(16,9)).

occupata(pos(6,3)).
occupata(pos(6,4)).
occupata(pos(6,5)).

occupata(pos(11,13)).
occupata(pos(11,14)).
occupata(pos(11,15)).
occupata(pos(11,16)).
occupata(pos(11,17)).


occupata(pos(16,1)).
occupata(pos(16,2)).
occupata(pos(16,3)).
occupata(pos(16,4)).
occupata(pos(16,5)).
occupata(pos(16,6)).
occupata(pos(16,7)).
occupata(pos(16,8)).

costo(0,0,0,0,0).

iniziale(pos(9,5)).

finale(pos(12,13)).
