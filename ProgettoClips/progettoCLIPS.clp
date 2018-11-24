;;######################################## STATO FINALE
(defrule PERSIST::goalRaggiunto
	(declare (salience 1000))
	(not (goalRaised))
	(forall (citta (name ?nomeCitta) (consumaQtyA ?qtyConsA) (consumaQtyB ?qtyConsB) (consumaQtyC ?qtyConsC))
			(presenteInCitta (livello ?lastLevel) (nomeCitta ?nomeCitta) (presenteInCittaQtyA ?qtyPresentA) (presenteInCittaQtyB ?qtyPresentB) (presenteInCittaQtyC ?qtyPresentC))
			(test (<= ?qtyConsA ?qtyPresentA))
			(test (<= ?qtyConsB ?qtyPresentB))
			(test (<= ?qtyConsC ?qtyPresentC))
	)
	?costo<- (costoTotal ?lastLevel ?costoAttuale)
	=>
	(printout t "GOAL RAGGIUNTO!" crlf)
	(printout t "COSTO TOTALE: " ?costoAttuale crlf)
	(assert(goalRaised))
	(retract ?costo)
	(focus MAIN)
)


(defrule CHECK::goalRaggiunto
	(declare (salience 1000))
	(not (goalRaised))
	(forall (citta (name ?nomeCitta) (consumaQtyA ?qtyConsA) (consumaQtyB ?qtyConsB) (consumaQtyC ?qtyConsC))
			(presenteInCitta (livello ?lastLevel) (nomeCitta ?nomeCitta) (presenteInCittaQtyA ?qtyPresentA) (presenteInCittaQtyB ?qtyPresentB) (presenteInCittaQtyC ?qtyPresentC))
			(test (<= ?qtyConsA ?qtyPresentA))
			(test (<= ?qtyConsB ?qtyPresentB))
			(test (<= ?qtyConsC ?qtyPresentC))
	)
	?costo<- (costoTotal ?lastLevel ?costoAttuale)
	=>
	(printout t "GOAL RAGGIUNTO!" crlf)
	(printout t "COSTO TOTALE: " ?costoAttuale crlf)
	(assert(goalRaised))
	(retract ?costo)
	(focus MAIN)
)




;;######################################## AZIONI

;aggiunge una unità di merce A dalla citta dove si trova il mezzo dentro il mezzo
(defrule EXPAND::loadA
	(livelloCorrente ?livello)
	(not (effettuataAzione ?livello))
	(not (effettuataAzione ?livello loadA))
	
	(mezzo (name ?nameMezzo) (capacita ?capacita))
	(posizioneMezzo (livello ?livello) (name ?nameMezzo) (posizione ?posizioneAttuale))
	(in (livello ?livello) (nomeMezzo ?nameMezzo) (quantityA ?qtyA) (quantityB ?qtyB) (quantityC ?qtyC))
	(test (> ?capacita (sumAll ?qtyA ?qtyB ?qtyC)))
	(presenteInCitta (livello ?livello) (nomeCitta ?posizioneAttuale) (presenteInCittaQtyA ?qtyPresenteCittaA) (presenteInCittaQtyB ?qtyPresenteCittaB) (presenteInCittaQtyC ?qtyPresenteCittaC))
	(test (> ?qtyPresenteCittaA 0))
	(costoTotal ?livello ?costoAttuale)
	=>
	(assert (in (livello (+ ?livello 1)) (nomeMezzo ?nameMezzo) (quantityA (+ ?qtyA 1)) (quantityB ?qtyB) (quantityC ?qtyC)))
	(assert (presenteInCitta (livello (+ ?livello 1)) (nomeCitta ?posizioneAttuale) (presenteInCittaQtyA (- ?qtyPresenteCittaA 1)) (presenteInCittaQtyB ?qtyPresenteCittaB) (presenteInCittaQtyC ?qtyPresenteCittaC)))
	(assert (costoTotal (+ ?livello 1) (+ ?costoAttuale 10)))
	
	(assert (delete (+ ?livello 1) in ?livello ?nameMezzo)) 
	(assert (delete (+ ?livello 1) presenteInCitta ?livello ?posizioneAttuale))
	
    (assert (effettuataAzione ?livello loadA))
	(assert (effettuataAzione ?livello))
	
	(bind ?tempStr (str-cat "Load A in mezzo " ?nameMezzo " in city " ?posizioneAttuale))
	(assert (printableAction ?livello ?tempStr))
	
	(printout ?*debug-print* ?livello ?tempStr crlf)
	(focus CHECK)
)


;aggiunge una unità di merce B dalla citta dove si trova il mezzo dentro il mezzo
(defrule EXPAND::loadB
	(livelloCorrente ?livello)
	(not (effettuataAzione ?livello))
	(not (effettuataAzione ?livello loadB))
	
	(mezzo (name ?nameMezzo) (capacita ?capacita))
	(posizioneMezzo (livello ?livello) (name ?nameMezzo) (posizione ?posizioneAttuale))
	(in (livello ?livello) (nomeMezzo ?nameMezzo) (quantityA ?qtyA) (quantityB ?qtyB) (quantityC ?qtyC))
	(test (> ?capacita (sumAll ?qtyA ?qtyB ?qtyC)))
	(presenteInCitta (livello ?livello) (nomeCitta ?posizioneAttuale) (presenteInCittaQtyA ?qtyPresenteCittaA) (presenteInCittaQtyB ?qtyPresenteCittaB) (presenteInCittaQtyC ?qtyPresenteCittaC))
	(test (> ?qtyPresenteCittaB 0))
	(costoTotal ?livello ?costoAttuale)
	=>
	(assert (in (livello (+ ?livello 1)) (nomeMezzo ?nameMezzo) (quantityA ?qtyA) (quantityB (+ ?qtyB 1)) (quantityC ?qtyC)))
	(assert (presenteInCitta (livello (+ ?livello 1)) (nomeCitta ?posizioneAttuale) (presenteInCittaQtyA ?qtyPresenteCittaA) (presenteInCittaQtyB (- ?qtyPresenteCittaB 1)) (presenteInCittaQtyC ?qtyPresenteCittaC)))
	(assert (costoTotal (+ ?livello 1) (+ ?costoAttuale 10)))

	(assert (delete (+ ?livello 1) in ?livello ?nameMezzo))
	(assert (delete (+ ?livello 1) presenteInCitta ?livello ?posizioneAttuale))

    (assert (effettuataAzione ?livello loadB))
	(assert (effettuataAzione ?livello))
	
	(bind ?tempStr (str-cat "Load B in mezzo " ?nameMezzo " in city " ?posizioneAttuale))
	(assert (printableAction ?livello ?tempStr))
	
	(printout ?*debug-print* ?livello ?tempStr crlf)
	(focus CHECK)

)

;aggiunge una unità di merce C dalla citta dove si trova il mezzo dentro il mezzo
(defrule EXPAND::loadC
	(livelloCorrente ?livello)
	(not (effettuataAzione ?livello))
	(not (effettuataAzione ?livello loadC))

	(mezzo (name ?nameMezzo) (capacita ?capacita))
	(posizioneMezzo (livello ?livello) (name ?nameMezzo) (posizione ?posizioneAttuale))
	(in (livello ?livello) (nomeMezzo ?nameMezzo) (quantityA ?qtyA) (quantityB ?qtyB) (quantityC ?qtyC))
	(test (> ?capacita (sumAll ?qtyA ?qtyB ?qtyC)))
	(presenteInCitta (livello ?livello) (nomeCitta ?posizioneAttuale) (presenteInCittaQtyA ?qtyPresenteCittaA) (presenteInCittaQtyB ?qtyPresenteCittaB) (presenteInCittaQtyC ?qtyPresenteCittaC))
	(test (> ?qtyPresenteCittaC 0))
	(costoTotal ?livello ?costoAttuale)
	=>
	(assert (in (livello (+ ?livello 1)) (nomeMezzo ?nameMezzo) (quantityA ?qtyA) (quantityB ?qtyB) (quantityC (+ ?qtyC 1))))
	(assert (presenteInCitta (livello (+ ?livello 1)) (nomeCitta ?posizioneAttuale) (presenteInCittaQtyA ?qtyPresenteCittaA) (presenteInCittaQtyB ?qtyPresenteCittaB) (presenteInCittaQtyC (- ?qtyPresenteCittaC 1))))
	(assert (costoTotal (+ ?livello 1) (+ ?costoAttuale 10)))

	(assert (delete (+ ?livello 1) in ?livello ?nameMezzo))
	(assert (delete (+ ?livello 1) presenteInCitta ?livello ?posizioneAttuale))

    (assert (effettuataAzione ?livello loadC))
	(assert (effettuataAzione ?livello))
	
	(bind ?tempStr (str-cat "Load C in mezzo " ?nameMezzo " in city " ?posizioneAttuale))
	(assert (printableAction ?livello ?tempStr))
	
	(printout ?*debug-print* ?livello ?tempStr crlf)
	
	(focus CHECK)
)

;rimuove una unità di merce A dal mezzo e la deposita nella città dove si trova
(defrule EXPAND::unloadA
	(livelloCorrente ?livello)
	(not (effettuataAzione ?livello))
	(not (effettuataAzione ?livello unloadA))
	
	(mezzo (name ?nameMezzo) (capacita ?capacita))
	(posizioneMezzo (livello ?livello) (name ?nameMezzo) (posizione ?posizioneAttuale))
	(in (livello ?livello) (nomeMezzo ?nameMezzo) (quantityA ?qtyA) (quantityB ?qtyB) (quantityC ?qtyC))
	(presenteInCitta (livello ?livello) (nomeCitta ?posizioneAttuale) (presenteInCittaQtyA ?qtyPresenteCittaA) (presenteInCittaQtyB ?qtyPresenteCittaB) (presenteInCittaQtyC ?qtyPresenteCittaC))
	(test (> ?qtyA 0))
	(costoTotal ?livello ?costoAttuale)
	=>
	(assert (in (livello (+ ?livello 1)) (nomeMezzo ?nameMezzo) (quantityA (- ?qtyA 1)) (quantityB ?qtyB) (quantityC ?qtyC)))
	(assert (presenteInCitta (livello (+ ?livello 1)) (nomeCitta ?posizioneAttuale) (presenteInCittaQtyA (+ ?qtyPresenteCittaA 1)) (presenteInCittaQtyB ?qtyPresenteCittaB) (presenteInCittaQtyC ?qtyPresenteCittaC)))
	(assert (costoTotal (+ ?livello 1) (+ ?costoAttuale 10)))
	
	(assert (delete (+ ?livello 1) in ?livello ?nameMezzo)) 
	(assert (delete (+ ?livello 1) presenteInCitta ?livello ?posizioneAttuale))
	
	(assert (effettuataAzione ?livello unloadA))
	(assert (effettuataAzione ?livello))
	
	(bind ?tempStr (str-cat "Unload A in mezzo " ?nameMezzo " in city " ?posizioneAttuale))
	(assert (printableAction ?livello ?tempStr))
	
	(printout ?*debug-print* ?livello ?tempStr crlf)
	(focus CHECK)
)

;rimuove una unità di merce B dal mezzo e la deposita nella città dove si trova
(defrule EXPAND::unloadB
	(livelloCorrente ?livello)
	(not (effettuataAzione ?livello))
	(not (effettuataAzione ?livello unloadB))
	
	(mezzo (name ?nameMezzo) (capacita ?capacita))
	(posizioneMezzo (livello ?livello) (name ?nameMezzo) (posizione ?posizioneAttuale))
	(in (livello ?livello) (nomeMezzo ?nameMezzo) (quantityA ?qtyA) (quantityB ?qtyB) (quantityC ?qtyC))
	(presenteInCitta (livello ?livello) (nomeCitta ?posizioneAttuale) (presenteInCittaQtyA ?qtyPresenteCittaA) (presenteInCittaQtyB ?qtyPresenteCittaB) (presenteInCittaQtyC ?qtyPresenteCittaC))
	(test (> ?qtyB 0))
	(costoTotal ?livello ?costoAttuale)
	=>
	(assert (in (livello (+ ?livello 1)) (nomeMezzo ?nameMezzo) (quantityA ?qtyA) (quantityB (- ?qtyB 1)) (quantityC ?qtyC)))
	(assert (presenteInCitta (livello (+ ?livello 1)) (nomeCitta ?posizioneAttuale) (presenteInCittaQtyA ?qtyPresenteCittaA) (presenteInCittaQtyB (+ ?qtyPresenteCittaB 1)) (presenteInCittaQtyC ?qtyPresenteCittaC)))
	(assert (costoTotal (+ ?livello 1) (+ ?costoAttuale 10)))

	(assert (delete (+ ?livello 1) in ?livello ?nameMezzo)) 
	(assert (delete (+ ?livello 1) presenteInCitta ?livello ?posizioneAttuale))

	(assert (effettuataAzione ?livello unloadB))
	(assert (effettuataAzione ?livello))
	
	(bind ?tempStr (str-cat "Unload B in mezzo " ?nameMezzo " in city " ?posizioneAttuale))
	(assert (printableAction ?livello ?tempStr))
	
	(printout ?*debug-print* ?livello ?tempStr crlf)
	(focus CHECK)

)

;rimuove una unità di merce C dal mezzo e la deposita nella città dove si trova
(defrule EXPAND::unloadC
	(livelloCorrente ?livello)
	(not (effettuataAzione ?livello))
	(not (effettuataAzione ?livello unloadC))
	
	(mezzo (name ?nameMezzo) (capacita ?capacita))
	(posizioneMezzo (livello ?livello) (name ?nameMezzo) (posizione ?posizioneAttuale))
	(in (livello ?livello) (nomeMezzo ?nameMezzo) (quantityA ?qtyA) (quantityB ?qtyB) (quantityC ?qtyC))
	(presenteInCitta (livello ?livello) (nomeCitta ?posizioneAttuale) (presenteInCittaQtyA ?qtyPresenteCittaA) (presenteInCittaQtyB ?qtyPresenteCittaB) (presenteInCittaQtyC ?qtyPresenteCittaC))
	(test (> ?qtyC 0))
	(costoTotal ?livello ?costoAttuale)
	=>
	(assert (in (livello (+ ?livello 1)) (nomeMezzo ?nameMezzo) (quantityA ?qtyA) (quantityB ?qtyB) (quantityC (- ?qtyC 1))))
	(assert (presenteInCitta (livello (+ ?livello 1)) (nomeCitta ?posizioneAttuale) (presenteInCittaQtyA ?qtyPresenteCittaA) (presenteInCittaQtyB ?qtyPresenteCittaB) (presenteInCittaQtyC (+ ?qtyPresenteCittaC 1))))
	(assert (costoTotal (+ ?livello 1) (+ ?costoAttuale 10)))
	
	(assert (delete (+ ?livello 1) in ?livello ?nameMezzo))
	(assert (delete (+ ?livello 1) presenteInCitta ?livello ?posizioneAttuale))
	(assert (delete (+ ?livello 1) costoTotal ?livello ?costoAttuale))

	(assert (effettuataAzione ?livello unloadC))
	(assert (effettuataAzione ?livello))
	
	(bind ?tempStr (str-cat "Unload C in mezzo " ?nameMezzo " in city " ?posizioneAttuale))
	(assert (printableAction ?livello ?tempStr))
	
	(printout ?*debug-print* ?livello ?tempStr crlf)
	(focus CHECK)
)

;muove il mezzo da una citta ad un'altra
(defrule EXPAND::moveTo
	(livelloCorrente ?livello)
	(not (effettuataAzione ?livello))
	(not (effettuataAzione ?livello moveTo ?posizioneAttuale ?cittaDestinazione ?nameMezzo))
	
	(posizioneMezzo (livello ?livello) (name ?nameMezzo) (posizione ?posizioneAttuale))
	(mezzo (name ?nameMezzo) (tipo ?tipoMezzo))
	(citta (name ?cittaDestinazione))
	(or
		(collegamento (citta1 ?posizioneAttuale) (citta2 ?cittaDestinazione) (tipo ?tipoMezzo) (distanza ?distanzaKm))
		(collegamento (citta1 ?cittaDestinazione) (citta2 ?posizioneAttuale) (tipo ?tipoMezzo) (distanza ?distanzaKm))
	)
	(test(neq ?posizioneAttuale ?cittaDestinazione))
	(costoTotal ?livello ?costoAttuale)
	;TODO: usare info tipo mezzo in modo da poter calcolare costo distanza
	=>

	(assert (delete (+ ?livello 1) posizioneMezzo ?livello ?nameMezzo)) 
	(assert (delete (+ ?livello 1) costoTotal ?livello ?costoAttuale))
	(assert (posizioneMezzo (livello (+ ?livello 1)) (name ?nameMezzo) (posizione ?cittaDestinazione)))
	(assert (costoTotal (+ ?livello 1) (+ ?costoAttuale 50))) ;50 fake. TODO

	(assert (effettuataAzione ?livello moveTo ?posizioneAttuale ?cittaDestinazione ?nameMezzo))
	(assert (effettuataAzione ?livello))
	
	(bind ?tempStr (str-cat "Move to: mezzo " ?nameMezzo " from " ?posizioneAttuale " to " ?cittaDestinazione))
	(assert (printableAction ?livello ?tempStr))
	
	(printout ?*debug-print* ?livello ?tempStr crlf)
	(focus CHECK)
)

