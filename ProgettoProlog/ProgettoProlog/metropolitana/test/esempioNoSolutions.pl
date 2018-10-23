:- consult('../metropolitana').
:- consult('../../main').

costo(0,0,0).

% percorso(Linea, Dir, ListaFermate).

percorso(piccadilly,0,['Kings Cross','Holborn','Covent Garden',
	'Leicester Square','Piccadilly Circus','Green Park','South Kensington',
	'Gloucester Road','Earls Court']).
percorso(jubilee,0,['Baker Street','Bond Street','Green Park',   
	'Westminster','Waterloo','London Bridge']).
percorso(central,0,['Notting Hill Gate','Bond Street','Oxford Circus',
	'Tottenham Court Road','Holborn','Bank']).
percorso(victoria,0,['Kings Cross','Euston','Warren Street',
	'Oxford Circus','Green Park','Victoria']).
percorso(bakerloo,0,['Paddington','Baker Street','Oxford Circus',
	'Piccadilly Circus','Embankment','Waterloo']).
percorso(circle,0,['Embankment','Westminster','Victoria','South Kensington',
	'Gloucester Road','Notting Hill Gate','Bayswater','Paddington',
	'Baker Street','Kings Cross']).
	
percorso(testCircuit,0,['Earls Court','Piccadilly Circus','Tottenham Court Road','Euston']).
percorso(testCircuit2,0,['Other station','Test Station','Final test station']).


% stazione(Stazione, Coord1, Coord2)

stazione('Baker Street',4.5,5.6).
stazione('Bank',12,4).
stazione('Bayswater',1,3.7).
stazione('Bond Street',5.4,4.1).
stazione('Covent Garden',8,4).
stazione('Earls Court',0,0).
stazione('Embankment',9.2,9).
stazione('Euston',7.1,6.6).
stazione('Gloucester Road',1.6,0.6).
stazione('Green Park',6,2.8).
stazione('Holborn',8.6,4.8).
stazione('Kings Cross',8.2,7.1).
stazione('Leicester Square',7.6,3.6).
stazione('London Bridge',0,0).
stazione('Notting Hill Gate',0,3.2).
stazione('Oxford Circus',6.2,4.3).
stazione('Paddington',2.4,4.2).
stazione('Piccadilly Circus',7,3.3).
stazione('South Kensington',2.6,0.5).
stazione('Tottenham Court Road',7.4,4.5).
stazione('Victoria',5.8,1).
stazione('Warren Street',6.5,6).
stazione('Waterloo',9.2,2.4).
stazione('Westminster',8,1.8).

stazione('Test Station',9.6,0.7).
stazione('Final test station',10.6,2.7).
stazione('Other station',10.0,0.8).


fermata(Stazione,Linea):- percorso(Linea,0,P), member(Stazione,P).


iniziale([at('Embankment'),ground]).

finale([at('Final test station'),ground]).