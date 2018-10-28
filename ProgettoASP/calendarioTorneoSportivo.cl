%calendario di un torneo sportivo, in cui n squadre devono
%affrontare due volte (nelle rispettive città) tutte le altre. Si
%ipotizzi la presenza di:
%	- almeno 8 squadre
%	- almeno 2 coppie di squadre della stessa città
%	- una buona alternanza tra incontri disputati nella propria
%		città e incontri disputati in trasferta, ossia non è in linea
%		di massima consentito ad una squadra di disputare più
%		di due partite consecutive nella propria città o in
%		trasferta.


#const numteam=15.

giornata(1..numteam*(numteam-1)).

% ###### ESEMPIO CON 8 SQUADRE

%* squadra(arezzoTeam1;romaTeam1;salernoTeam;torinoTeam;milanoTeam;arezzoTeam2;romaTeam2;veneziaTeam).
 citta(arezzo;roma;salerno;torino;milano;venezia).
 squadraLocation(arezzoTeam1,arezzo).
 squadraLocation(romaTeam1,roma).
 squadraLocation(salernoTeam,salerno).
 squadraLocation(torinoTeam,torino).
 squadraLocation(milanoTeam,milano).
 squadraLocation(arezzoTeam2,arezzo).
 squadraLocation(romaTeam2,roma).
 squadraLocation(veneziaTeam,venezia).
*%

% ###### ESEMPIO CON 15 SQUADRE

 squadra(arezzoTeam1;romaTeam1;salernoTeam;torinoTeam;milanoTeam;arezzoTeam2;romaTeam2;veneziaTeam;cuneoTeam;genovaTeam;grossetoTeam;firenzeTeam;andriaTeam;lecceTeam;foggiaTeam).
 citta(arezzo;roma;salerno;torino;milano;venezia;cuneo;genova;grosseto;firenze;andria;lecce;foggia).
 squadraLocation(arezzoTeam1,arezzo).
 squadraLocation(romaTeam1,roma).
 squadraLocation(salernoTeam,salerno).
 squadraLocation(torinoTeam,torino).
 squadraLocation(milanoTeam,milano).
 squadraLocation(arezzoTeam2,arezzo).
 squadraLocation(romaTeam2,roma).
 squadraLocation(veneziaTeam,venezia).
 squadraLocation(cuneoTeam,cuneo).
 squadraLocation(genovaTeam,genova).
 squadraLocation(grossetoTeam,grosseto).
 squadraLocation(firenzeTeam,firenze).
 squadraLocation(andriaTeam,andria).
 squadraLocation(lecceTeam,lecce).
 squadraLocation(foggiaTeam,foggia).
 


% ###### ESEMPIO CON 2 SQUADRE

%* squadra(arezzoTeam1;romaTeam1).
 citta(arezzo;roma).
 squadraLocation(arezzoTeam1,arezzo).
 squadraLocation(romaTeam1,roma).
*%

% ###### ESEMPIO CON 3 SQUADRE
%*
 squadra(arezzoTeam1;romaTeam1;salernoTeam).
 citta(arezzo;roma;salerno).
 squadraLocation(arezzoTeam1,arezzo).
 squadraLocation(romaTeam1,roma).
 squadraLocation(salernoTeam,salerno).
*%
 
% ###### ESEMPIO CON 3 SQUADRE STESSA CITTA
%*
 squadra(arezzoTeam1;romaTeam1;arezzoTeam2).
 citta(arezzo;roma).
 squadraLocation(arezzoTeam1,arezzo).
 squadraLocation(romaTeam1,roma).
 squadraLocation(arezzoTeam2,arezzo).
*%


% In ogni giornata ci deve essere una sola partita
1 {match(S1,S2,C,G) : squadra(S1),squadra(S2),citta(C)} 1 :- giornata(G).

% Ogni squadra deve affrontare una volta in casa ogni altra squadra
numteam-1 {match(S1,S2,C,G) : squadra(S2),citta(C),giornata(G)} numteam-1 :- squadra(S1).

% Ogni squadra deve affrontare una volta in trasferta ogni altra squadra
numteam-1 {match(S1,S2,C,G) : squadra(S1),citta(C),giornata(G)} numteam-1 :- squadra(S2).

% Non ci possono essere due match uguali
:- match(S1,S2,C,G), squadra(S1), squadra(S2), giornata(G), citta(C), match(S3,S4,C1,G1), squadra(S3), squadra(S4), giornata(G1), citta(C1), G1 != G,  S3 == S1, S4 == S2 .

% Una squadra non può giocare con se stessa
:- match(S1,S2,C,G), squadra(S1), squadra(S2), S1 == S2.

% Una squadra non può giocare tre partite consecutive in casa
:- match(S1,S2,C,G), squadra(S1), squadra(S2), giornata(G), citta(C), match(S3,S4,C1,G1), squadra(S3), squadra(S4), giornata(G1), citta(C1), G1 == (G+1),  S3 == S1,  match(S5,S6,C2,G2), squadra(S5), squadra(S6), giornata(G2), citta(C2),G2 == (G+2), S5 == S1  .

% Una squadra non può giocare tre partite consecutive in trasferta
:- match(S1,S2,C,G), squadra(S1), squadra(S2), giornata(G), citta(C), match(S3,S4,C1,G1), squadra(S3), squadra(S4), giornata(G1), citta(C1), G1 == (G+1),  S4 == S2, match(S5,S6,C2,G2), squadra(S5), squadra(S6), giornata(G2), citta(C2), G2 == (G+2),  S6 == S2.

% Una squadra che gioca in casa deve giocare sempre nella sua città
:- match(S1,S2,C,G), squadra(S1), squadra(S2), giornata(G), citta(C), squadraLocation(S1,L1), L1 != C.

#show match/4.