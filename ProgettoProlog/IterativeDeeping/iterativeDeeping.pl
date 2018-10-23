% --------------------------------------------------------
% Ricerca in profondità con massima profondità limitata iterativamente
% --------------------------------------------------------

iterativeDeeping(Soluzione):-
	profonditaLimitata(1,Soluzione),
	!, %non appena trovo il primo risultato mi fermo
	write('soluzione trovata: '),write(Soluzione).

profonditaLimitata(MaxDepth,Soluzione):-
  iniziale(S),
  ric_prof_MaxDepth(S,[S],MaxDepth,Soluzione).
  
profonditaLimitata(MaxDepth,Soluzione):-
  MaxDepth1 is MaxDepth + 1,
  write('Provo con MaxDepth: '),write(MaxDepth1),nl,
  profonditaLimitata(MaxDepth1,Soluzione).

ric_prof_MaxDepth(S,_,_,[]):-finale(S),!.
ric_prof_MaxDepth(S,Visitati,MaxDepth,[Azione|AltreAzioni]):-
  MaxDepth>0,
  applicabile(Azione,S),
  %write('Provo con MaxDepth/Azione: '),write(MaxDepth),write(Azione),nl,
  trasforma(Azione,S,SNuovo),
  \+member(SNuovo,Visitati),
  MaxDepth1 is MaxDepth-1,
  ric_prof_MaxDepth(SNuovo,[SNuovo|Visitati],MaxDepth1,AltreAzioni).