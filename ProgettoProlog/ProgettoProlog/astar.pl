% astar(-Soluzione).
astar(Soluzione):-
    iniziale(S),
    empty_heap(Coda),
    h(S,Priorita),
	
	%ogni nodo della coda è formato da stato-listaAzioniPerArrivareAlNodo-GcostoPerArrivareAQuelNodo
    add_to_heap(Coda,Priorita,nodo(S,[],0),CodaAggiornata),
    startAstar(CodaAggiornata,[],Soluzione),
	!, %non appena trovo il primo risultato mi fermo
	write('soluzione trovata: '),write(Soluzione).

% 	startAstar(+Coda,_,_).
startAstar(Coda,_,_):-
    empty_heap(Coda),!,
    write('NESSUNA SOLUZIONE TROVATA'),nl.

%controllo che il minimo della coda sia lo stato finale. Se si ho finito	
% startAstar(+Coda,_,+ListaAzioni).
startAstar(Coda,_,ListaAzioni):-
    min_of_heap(Coda,_,nodo(S,ListaAzioni,_)),
    finale(S),!.

% startAstar(+Coda,+Esplorati,+ListaAzioni).	
startAstar(CodaIniziale,Esplorati,Soluzione):-
	%estraggo dalla coda il minimo in priorità
    get_from_heap(CodaIniziale,_,nodo(S,ListaAzioni,G),Coda),
	write("Espando S= "),write(S),nl,
	
	%aggiungo i suoi figli alla coda
    addChildren(nodo(S,ListaAzioni,G),Esplorati,Coda,Coda1),
	
    startAstar(Coda1,[S|Esplorati],Soluzione).	
	
	

% addChildren(+S,+Esplorati,+Coda0,-Coda)
% trovo i figli dello stato S e li aggiungo alla coda Coda0, salvo la nuova coda in Coda
addChildren(nodo(S,ListaAzioni,G),Esplorati,Coda0,Coda):-
    findall(Az,applicabile(Az,S),ListaApplicabili),
    findChildren(nodo(S,ListaAzioni,G),ListaApplicabili,Esplorati,Coda0,Coda).	

%Se la ListaApplicabili è vuota significa che non ci sono altre azioni applicabili. Quindi copio Coda0 in Coda1	
% findChildren(_,_,_,Coda0,Coda1).
findChildren(_,[],_,Coda,Coda):- 
	!.

% findChildren(+nodo(S,ListaAzioni,G),+ListaApplicabili,+Esplorati,+Coda0,-Coda1).
findChildren(nodo(S,ListaAzioni,G),[Az|AltreAzioniApplicabili],Esplorati,Coda0,Coda1):-
    trasforma(Az,S,SNuovo),
    \+member(SNuovo,Esplorati),!,
	g_funct(G,S,SNuovo,GNuovo),
	append(ListaAzioni,[Az],ListaAzioniNuova),
	aggiungiAdHeap(nodo(SNuovo,ListaAzioniNuova,GNuovo),Coda0,Codatmp),
    findChildren(nodo(S,ListaAzioni,G),AltreAzioniApplicabili,Esplorati,Codatmp,Coda1).
	
% findChildren(+nodo(S,ListaAzioni,G),+ListaApplicabili,+Esplorati,+Coda0,-Coda1).	
findChildren(nodo(S,ListaAzioni,G),[_|AltreAzioniApplicabili],Esplorati,Coda0,Coda1):-
    findChildren(nodo(S,ListaAzioni,G),AltreAzioniApplicabili,Esplorati,Coda0,Coda1).
	
	
	

% aggiungiAdHeap(+nodo(S,ListaAzioni,G),+Coda0,-Coda).
aggiungiAdHeap(nodo(S,ListaAzioni,G),Coda0,Coda1):-
    getFromHeap(S,Coda0,nodo(SCorrente,ListaAzioniCorrente,GCorrente),Coda),!,
    confrontaEInserisci(Coda,nodo(S,ListaAzioni,G),nodo(SCorrente,ListaAzioniCorrente,GCorrente),Coda1).
	
%richiamato quando non viene trovato l'elemento S nello heap attuale.	
% aggiungiAdHeap(+nodo(S,ListaAzioni,G),+Coda0,-Coda).	
aggiungiAdHeap(nodo(S,ListaAzioni,G),Coda0,Coda):-
    h(S,H),
	Priorita is H + G,
    add_to_heap(Coda0,Priorita,nodo(S,ListaAzioni,G),Coda).


% confrontaEInserisci(+Coda0,+nodo(S1,ListaAzioni1,G1),+nodo(S2,ListaAzioni2,G2),-Coda)
confrontaEInserisci(Coda0,nodo(S1,ListaAzioni1,G1),nodo(_,_,G2),Coda):-
	G1 < G2,!,
    h(S1,H),
    Priorita is G1 + H,
    add_to_heap(Coda0,Priorita,nodo(S1,ListaAzioni1,G1),Coda).

%questa viene richiamata quando G1 >= G2	
% confrontaEInserisci(+Coda0,+nodo(S1,ListaAzioni1,G1),+nodo(S2,ListaAzioni2,G2),-Coda)	
confrontaEInserisci(Coda0,_,nodo(S2,ListaAzioni2),Coda):-
	h(S2,H),
    Priorita is G2 + H,
    add_to_heap(Coda0,Priorita,nodo(S2,ListaAzioni2,G2),Coda).


%estrae ed elimina dallo heap l'elemento S. Prima lo salva in SCorrente. La nuova heap è salvata in Heap1
% getFromHeap(+S,+Heap,-nodo(SCorrente,ListaAzioniCorrente,GCorrente),-Heap1)
getFromHeap(S0,Heap,nodo(S,ListaAzioni,G),Heap1):-
    heap_to_list(Heap,List),
    getElem(S0,List,nodo(S,ListaAzioni,G)),
    delete_from_heap(Heap,_,nodo(S,ListaAzioni,G),Heap1).

% getElem(S0,[nodo(S,ListaAzioni,G)|AltriNodi],nodo(S,ListaAzioni,G)):-
getElem(S0,[nodo(S,ListaAzioni,G)|_],nodo(S,ListaAzioni,G)):-
    S0==S,!.
getElem(S0,[_|AltriNodi],nodo(S,ListaAzioni,G)):-
    getElem(S0,AltriNodi,nodo(S,ListaAzioni,G)).
	