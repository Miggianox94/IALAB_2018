% ampiezza(Soluzione)
% stato rappresentato da nodo(S,ListaAzioniPerS)

ampiezza(Soluzione):-
  iniziale(S),
  depth([nodo(S,[])],[],Soluzione).

% depth(CodaNodiDaEsplorare,NodiEspansi,Soluzione)
depth([nodo(S,ListaAzioniPerS)|_],_,ListaAzioniPerS):-
  finale(S).
depth([nodo(S,ListaAzioniPerS)|Frontiera],
	NodiEspansi,Soluzione):-
  findall(Az,applicabile(Az,S),ListaApplicabili),
  visitati([nodo(S,ListaAzioniPerS)|Frontiera],
  	NodiEspansi,ListaStatiVisitati),
  generateSons(nodo(S,ListaAzioniPerS),ListaApplicabili,
  	ListaStatiVisitati,ListaFigliS),
  append(Frontiera,ListaFigliS,NuovaFrontiera),
  depth(NuovaFrontiera,[S|NodiEspansi],Soluzione).

% visitati(Frontiera,NodiEspansi,ListaStatiVisitati) 
visitati(Frontiera,NodiEspansi,ListaStatiVisitati):-
  estraiStato(Frontiera,StatiFrontiera),
  append(StatiFrontiera,NodiEspansi,ListaStatiVisitati).

% estraiStato(Frontiera,ListaDiStati)
estraiStato([],[]).
estraiStato([nodo(S,_)|Frontiera],[S|StatiFrontiera]):-
  estraiStato(Frontiera,StatiFrontiera). 

% generateSons(Nodo,ListaApplicabili,
%	  ListaStatiVisitati,ListaNodiFigli)
generateSons(_,[],_,[]).
generateSons(nodo(S,ListaAzioniPerS),[Azione|AltreAzioni],
	  ListaStatiVisitati,
	  [nodo(SNuovo,[Azione|ListaAzioniPerS])|AltriFigli]):-
   trasforma(Azione,S,SNuovo),
   \+member(SNuovo,ListaStatiVisitati),!,
   generateSons(nodo(S,ListaAzioniPerS),AltreAzioni,
   	  ListaStatiVisitati,AltriFigli).
generateSons(Nodo,[_|AltreAzioni],
	  ListaStatiVisitati,ListaNodiFigli):-
   generateSons(Nodo,AltreAzioni,
   	  ListaStatiVisitati,ListaNodiFigli).






