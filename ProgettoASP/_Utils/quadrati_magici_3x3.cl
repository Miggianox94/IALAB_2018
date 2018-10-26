
valore(1..9).
casella(a1;a2;a3;b1;b2;b3;c1;c2;c3).

1 {ha_valore(C,V) : valore(V)} 1 :- casella(C).

1 {ha_valore(C,V) : casella(C)} 1 :- valore(V).

soluzione :- valore(A1;A2;A3;B1;B2;B3;C1;C2;C3),
    ha_valore(a1,A1),ha_valore(a2,A2),ha_valore(a3,A3),
    ha_valore(b1,B1),ha_valore(b2,B2),ha_valore(b3,B3),
    ha_valore(c1,C1),ha_valore(c2,C2),ha_valore(c3,C3),
    A1+A2+A3==S,B1+B2+B3==S,C1+C2+C3==S,
    A1+B1+C1==S,A2+B2+C2==S,A3+B3+C3==S,
    A1+B2+C3==S,A3+B2+C1==S.
    
:- not soluzione.

#show ha_valore/2.