% --------------------------------------------------------
% Ricerca in profondità con massima profondità limitata iterativamente
% --------------------------------------------------------
init :- 
	retractall(livello(_)), 
	retractall(livelloCorrente(_)),
	retractall(trovataSoluzione(_)),
	assert(livelloCorrente(0)),
	assert(livello(1)),
	assert(trovataSoluzione(1)).

:- dynamic livello/1.
:- dynamic livelloCorrente/1.
:- dynamic trovataSoluzione/1.

iterativeDeeping(Soluzione):-
	init,
	profonditaLimitataDEP(Soluzione),
	!, %non appena trovo il primo risultato mi fermo
	trovataSoluzione(Trovata),
	Trovata is 1,
	write('soluzione trovata: '),write(Soluzione).


profonditaLimitataDEP(Soluzione):-
  livello(MaxDepth),
  iniziale(S),
  ric_prof_MaxDepthDEP(S,[S],MaxDepth,Soluzione).
  
profonditaLimitataDEP(_):-
  trovataSoluzione(Trovata),
  Trovata = -1,
  write('NON ESISTE UNA SOLUZIONE'),nl,
  %questo farà fallire le altre chiamate
  retractall(livello(_)), 
  retractall(livelloCorrente(_)),
  fail.
  
  
profonditaLimitataDEP(Soluzione):-
  livello(MaxDepth),
  retractall(livello(_)),
  retractall(livelloCorrente(_)),
  assert(livelloCorrente(0)),
  MaxDepth1 is MaxDepth + 1,
  assert(livello(MaxDepth1)),
  write('Provo con MaxDepth: '),write(MaxDepth1),nl,
  profonditaLimitataDEP(Soluzione).

ric_prof_MaxDepthDEP(S,_,_,[]):-finale(S),!.
ric_prof_MaxDepthDEP(S,Visitati,MaxDepth,[Azione|AltreAzioni]):-
  MaxDepth>0,
  applicabile(Azione,S),
  retractall(trovataSoluzione(_)),
  assert(trovataSoluzione(1)),
  trasforma(Azione,S,SNuovo),
  \+member(SNuovo,Visitati),
  MaxDepth1 is MaxDepth-1,
  retractall(livelloCorrente(_)),
  assert(livelloCorrente(MaxDepth1)),
  ric_prof_MaxDepthDEP(SNuovo,[SNuovo|Visitati],MaxDepth1,AltreAzioni).

  
ric_prof_MaxDepthDEP(S,_,_,_):-
  livelloCorrente(CurrentLevel),
  CurrentLevel > 0 , %significa che prima è uscito per qualche altro motivo
  \+finale(S),
  retractall(trovataSoluzione(_)),
  assert(trovataSoluzione(-1)),
  fail.