location(table).
location(X) :- block(X).

#const lastlev=5.

level(0..lastlev).
state(0..lastlev+1).


% AZIONI

action(move(X,Y)):- block(X), location(Y), X!=Y.

1{occurs(A,S): action(A)}:- level(S).

% FLUENTI

fluent(on(X,Y)):- block(X), location(Y), X!=Y.

% EFFETTI

holds(on(X,Y),S+1) :- occurs(move(X,Y),S), level(S).

% PRECONDIZIONI

:- occurs(move(X,Y),S),
    1 { holds(on(A,X),S); holds(on(B,Y),S) : Y != table }.

:- occurs(move(X,Y),S), occurs(move(_,X),S).


% PERSISTENZA

holds(on(X,Y),S+1):-
    fluent(on(X,Y)), holds(on(X,Y),S),
    level(S), not -holds(on(X,Y),S+1).

% REGOLE CAUSALI

-holds(on(X,Y),S):-
    fluent(on(X,Y)), holds(on(X,L),S), state(S),
    location(L), L!=Y.

-holds(on(X,Y),S):-
    fluent(on(X,Y)), holds(on(B,Y),S), state(S),
    block(B), Y!=table, B!=X.

% GOAL

:- not goal.



% % ESEMPIO
%
% block(a). block(b). block(c). block(d). block(e).
% block(f). block(g). block(h). block(i).
%
% holds(on(a,b),0).
% holds(on(b,c),0).
% holds(on(c,table),0).
% holds(on(d,e),0).
% holds(on(e,table),0).
% holds(on(f,table),0).
% holds(on(g,h),0).
% holds(on(h,i),0).
% holds(on(i,table),0).
%
%
% goal:- holds(on(a,b),lastlev+1),
% 	holds(on(b,c),lastlev+1),
% 	holds(on(c,g),lastlev+1),
% 	holds(on(g,table),lastlev+1),
% 	holds(on(d,e),lastlev+1),
% 	holds(on(e,f),lastlev+1),
% 	holds(on(f,table),lastlev+1),
% 	holds(on(h,i),lastlev+1),
% 	holds(on(i,table),lastlev+1).
%
%
% #show occurs/2.


block(a). block(b). block(c). block(d). block(e).
block(f). block(g). block(h). block(i).

holds(on(e,table),0).
holds(on(f,table),0).
holds(on(i,table),0).
holds(on(a,e),0).
holds(on(d,a),0).
holds(on(b,f),0).
holds(on(g,i),0).
holds(on(h,g),0).
holds(on(c,h),0).


goal:-
    holds(on(a,table),lastlev+1),
    holds(on(f,table),lastlev+1),
    holds(on(g,table),lastlev+1),
    holds(on(b,a),lastlev+1),
    holds(on(c,b),lastlev+1),
    holds(on(d,c),lastlev+1),
    holds(on(e,d),lastlev+1),
    holds(on(h,g),lastlev+1),
    holds(on(i,h),lastlev+1).


#show occurs/2.
