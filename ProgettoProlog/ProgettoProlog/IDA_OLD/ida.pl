% --------------------------------------------------------
% Ricerca in profondità con massima profondità limitata iterativamente
% --------------------------------------------------------

%lista degli f(n) degli n che hanno superato il depthlimit
currentListOver([]).

ida(Soluzione):-
	iniziale(S),
	h(S,MaxDepth),
	assertz(currentMax(MaxDepth)),
	profonditaLimitata(MaxDepth,Soluzione),
	!, %non appena trovo il primo risultato mi fermo
	write('soluzione trovata: '),write(Soluzione).

profonditaLimitata(MaxDepth,Soluzione):-
  iniziale(S),
  write('Provo con MaxDepth: '),write(MaxDepth),nl,
  ric_prof_MaxDepth(S,[S],MaxDepth,Soluzione).
  
profonditaLimitata(_,Soluzione):-
  currentListOver(CurrentListOver),
  %trovo il minimo tra quelli che hanno superato la soglia
  min_list(CurrentListOver,NexDepth),
  abolish(currentListOver/1),
  assertz(currentListOver([])),
  profonditaLimitata(NexDepth,Soluzione).


ric_prof_MaxDepth(S,_,_,[]):-finale(S),!.
ric_prof_MaxDepth(S,Visitati,MaxDepth,[Azione|AltreAzioni]):-
  MaxDepth>0,
  applicabile(Azione,S),
  trasforma(Azione,S,SNuovo),
  \+member(SNuovo,Visitati),
  MaxDepth1 is MaxDepth-1,
  f(SNuovo,Visitati,MaxDepth1),
  ric_prof_MaxDepth(SNuovo,[SNuovo|Visitati],MaxDepth1,AltreAzioni).