;;######################################## STATO FINALE
(defrule CHECK::goalRaggiunto
	(declare (salience 1000))
	(forall (citta (name ?nomeCitta) (consumaQtyA ?qtyConsA) (consumaQtyB ?qtyConsB) (consumaQtyC ?qtyConsC))
			(presenteInCitta (livello ?lastLevel) (nomeCitta ?nomeCitta) (presenteInCittaQtyA ?qtyPresentA) (presenteInCittaQtyB ?qtyPresentB) (presenteInCittaQtyC ?qtyPresentC))
			(test (<= ?qtyConsA ?qtyPresentA))
			(test (<= ?qtyConsB ?qtyPresentB))
			(test (<= ?qtyConsC ?qtyPresentC))
	)
	(costoTotal ?lastLevel ?costoAttuale)
	=>
	(printout t "GOAL RAGGIUNTO!" crlf)
	(printout t "COSTO TOTALE: " ?costoAttuale crlf)
	(assert(goalRaised))
)




;;######################################## AZIONI

;aggiunge una unità di merce A dalla citta dove si trova il mezzo dentro il mezzo
(defrule EXPAND::loadA
	(mezzo (name ?nameMezzo) (capacita ?capacita))
	(posizioneMezzo (livello ?livello) (name ?nameMezzo) (posizione ?posizioneAttuale))
	?fIn <- (in (livello ?livello) (nomeMezzo ?nameMezzo) (quantityA ?qtyA) (quantityB ?qtyB) (quantityC ?qtyC))
	(test (> ?capacita (sumAll ?qtyA ?qtyB ?qtyC)))
	?fPresent <- (presenteInCitta (livello ?livello) (nomeCitta ?posizioneAttuale) (presenteInCittaQtyA ?qtyPresenteCittaA) (presenteInCittaQtyB ?qtyPresenteCittaB) (presenteInCittaQtyC ?qtyPresenteCittaC))
	(test (> ?qtyPresenteCittaA 0))
	?fCost <- (costoTotal ?livello ?costoAttuale)
	=>
	(assert (in (livello (+ ?livello 1)) (nomeMezzo ?nameMezzo) (quantityA (+ ?qtyA 1)) (quantityB ?qtyB) (quantityC ?qtyC)))
	(assert (presenteInCitta (livello (+ ?livello 1)) (nomeCitta ?posizioneAttuale) (presenteInCittaQtyA (- ?qtyPresenteCittaA 1)) (presenteInCittaQtyB ?qtyPresenteCittaB) (presenteInCittaQtyC ?qtyPresenteCittaC)))
	(assert (costoTotal (+ ?livello 1) (+ ?costoAttuale 10)))
	(assert (delete (+ ?livello 1) ?fIn))
	(assert (delete (+ ?livello 1) ?fPresent))
	(assert (delete (+ ?livello 1) ?fCost))
	(assert (current ?livello))
    (assert (news (+ ?livello 1)))
	(assert (apply ?livello))
)


;aggiunge una unità di merce B dalla citta dove si trova il mezzo dentro il mezzo
(defrule EXPAND::loadB
	(mezzo (name ?nameMezzo) (capacita ?capacita))
	(posizioneMezzo (livello ?livello) (name ?nameMezzo) (posizione ?posizioneAttuale))
	?fIn <- (in (livello ?livello) (nomeMezzo ?nameMezzo) (quantityA ?qtyA) (quantityB ?qtyB) (quantityC ?qtyC))
	(test (> ?capacita (sumAll ?qtyA ?qtyB ?qtyC)))
	?fPresent <- (presenteInCitta (livello ?livello) (nomeCitta ?posizioneAttuale) (presenteInCittaQtyA ?qtyPresenteCittaA) (presenteInCittaQtyB ?qtyPresenteCittaB) (presenteInCittaQtyC ?qtyPresenteCittaC))
	(test (> ?qtyPresenteCittaB 0))
	?fCost <- (costoTotal ?livello ?costoAttuale)
	=>
	(assert (in (livello (+ ?livello 1)) (nomeMezzo ?nameMezzo) (quantityA ?qtyA) (quantityB (+ ?qtyB 1)) (quantityC ?qtyC)))
	(assert (presenteInCitta (livello (+ ?livello 1)) (nomeCitta ?posizioneAttuale) (presenteInCittaQtyA ?qtyPresenteCittaA) (presenteInCittaQtyB (- ?qtyPresenteCittaB 1)) (presenteInCittaQtyC ?qtyPresenteCittaC)))
	(assert (costoTotal (+ ?livello 1) (+ ?costoAttuale 10)))
	(assert (delete (+ ?livello 1) ?fIn))
	(assert (delete (+ ?livello 1) ?fPresent))
	(assert (delete (+ ?livello 1) ?fCost))
	(assert (current ?livello))
    (assert (news (+ ?livello 1)))
	(assert (apply ?livello))
)

;aggiunge una unità di merce C dalla citta dove si trova il mezzo dentro il mezzo
(defrule EXPAND::loadC
	(mezzo (name ?nameMezzo) (capacita ?capacita))
	(posizioneMezzo (livello ?livello) (name ?nameMezzo) (posizione ?posizioneAttuale))
	?fIn <- (in (livello ?livello) (nomeMezzo ?nameMezzo) (quantityA ?qtyA) (quantityB ?qtyB) (quantityC ?qtyC))
	(test (> ?capacita (sumAll ?qtyA ?qtyB ?qtyC)))
	?fPresent <- (presenteInCitta (livello ?livello) (nomeCitta ?posizioneAttuale) (presenteInCittaQtyA ?qtyPresenteCittaA) (presenteInCittaQtyB ?qtyPresenteCittaB) (presenteInCittaQtyC ?qtyPresenteCittaC))
	(test (> ?qtyPresenteCittaC 0))
	?fCost <- (costoTotal ?livello ?costoAttuale)
	=>
	(assert (in (livello (+ ?livello 1)) (nomeMezzo ?nameMezzo) (quantityA ?qtyA) (quantityB ?qtyB) (quantityC (+ ?qtyC 1))))
	(assert (presenteInCitta (livello (+ ?livello 1)) (nomeCitta ?posizioneAttuale) (presenteInCittaQtyA ?qtyPresenteCittaA) (presenteInCittaQtyB ?qtyPresenteCittaB) (presenteInCittaQtyC (- ?qtyPresenteCittaC 1))))
	(assert (costoTotal (+ ?livello 1) (+ ?costoAttuale 10)))
	(assert (delete (+ ?livello 1) ?fIn))
	(assert (delete (+ ?livello 1) ?fPresent))
	(assert (delete (+ ?livello 1) ?fCost))
	(assert (current ?livello))
    (assert (news (+ ?livello 1)))
	(assert (apply ?livello))
)

;rimuove una unità di merce A dal mezzo e la deposita nella città dove si trova
(defrule EXPAND::unloadA
	(mezzo (name ?nameMezzo) (capacita ?capacita))
	(posizioneMezzo (livello ?livello) (name ?nameMezzo) (posizione ?posizioneAttuale))
	?fIn <- (in (livello ?livello) (nomeMezzo ?nameMezzo) (quantityA ?qtyA) (quantityB ?qtyB) (quantityC ?qtyC))
	?fPresent <- (presenteInCitta (livello ?livello) (nomeCitta ?posizioneAttuale) (presenteInCittaQtyA ?qtyPresenteCittaA) (presenteInCittaQtyB ?qtyPresenteCittaB) (presenteInCittaQtyC ?qtyPresenteCittaC))
	(test (> ?qtyA 0))
	?fCost <- (costoTotal ?livello ?costoAttuale)
	=>
	(assert (in (livello (+ ?livello 1)) (nomeMezzo ?nameMezzo) (quantityA (- ?qtyA 1)) (quantityB ?qtyB) (quantityC ?qtyC)))
	(assert (presenteInCitta (livello (+ ?livello 1)) (nomeCitta ?posizioneAttuale) (presenteInCittaQtyA (+ ?qtyPresenteCittaA 1)) (presenteInCittaQtyB ?qtyPresenteCittaB) (presenteInCittaQtyC ?qtyPresenteCittaC)))
	(assert (costoTotal (+ ?livello 1) (+ ?costoAttuale 10)))
	(assert (delete (+ ?livello 1) ?fIn))
	(assert (delete (+ ?livello 1) ?fPresent))
	(assert (delete (+ ?livello 1) ?fCost))
	(assert (current ?livello))
    (assert (news (+ ?livello 1)))
	(assert (apply ?livello))
)

;rimuove una unità di merce B dal mezzo e la deposita nella città dove si trova
(defrule EXPAND::unloadB
	(mezzo (name ?nameMezzo) (capacita ?capacita))
	(posizioneMezzo (livello ?livello) (name ?nameMezzo) (posizione ?posizioneAttuale))
	?fIn <- (in (livello ?livello) (nomeMezzo ?nameMezzo) (quantityA ?qtyA) (quantityB ?qtyB) (quantityC ?qtyC))
	?fPresent <- (presenteInCitta (livello ?livello) (nomeCitta ?posizioneAttuale) (presenteInCittaQtyA ?qtyPresenteCittaA) (presenteInCittaQtyB ?qtyPresenteCittaB) (presenteInCittaQtyC ?qtyPresenteCittaC))
	(test (> ?qtyB 0))
	?fCost <- (costoTotal ?livello ?costoAttuale)
	=>
	(assert (in (livello (+ ?livello 1)) (nomeMezzo ?nameMezzo) (quantityA ?qtyA) (quantityB (- ?qtyB 1)) (quantityC ?qtyC)))
	(assert (presenteInCitta (livello (+ ?livello 1)) (nomeCitta ?posizioneAttuale) (presenteInCittaQtyA ?qtyPresenteCittaA) (presenteInCittaQtyB (+ ?qtyPresenteCittaB 1)) (presenteInCittaQtyC ?qtyPresenteCittaC)))
	(assert (costoTotal (+ ?livello 1) (+ ?costoAttuale 10)))
	(assert (delete (+ ?livello 1) ?fIn))
	(assert (delete (+ ?livello 1) ?fPresent))
	(assert (delete (+ ?livello 1) ?fCost))
	(assert (current ?livello))
    (assert (news (+ ?livello 1)))
	(assert (apply ?livello))
)

;rimuove una unità di merce C dal mezzo e la deposita nella città dove si trova
(defrule EXPAND::unloadC
	(mezzo (name ?nameMezzo) (capacita ?capacita))
	(posizioneMezzo (livello ?livello) (name ?nameMezzo) (posizione ?posizioneAttuale))
	?fIn <- (in (livello ?livello) (nomeMezzo ?nameMezzo) (quantityA ?qtyA) (quantityB ?qtyB) (quantityC ?qtyC))
	?fPresent <- (presenteInCitta (livello ?livello) (nomeCitta ?posizioneAttuale) (presenteInCittaQtyA ?qtyPresenteCittaA) (presenteInCittaQtyB ?qtyPresenteCittaB) (presenteInCittaQtyC ?qtyPresenteCittaC))
	(test (> ?qtyC 0))
	?fCost <- (costoTotal ?livello ?costoAttuale)
	=>
	(assert (in (livello (+ ?livello 1)) (nomeMezzo ?nameMezzo) (quantityA ?qtyA) (quantityB ?qtyB) (quantityC (- ?qtyC 1))))
	(assert (presenteInCitta (livello (+ ?livello 1)) (nomeCitta ?posizioneAttuale) (presenteInCittaQtyA ?qtyPresenteCittaA) (presenteInCittaQtyB ?qtyPresenteCittaB) (presenteInCittaQtyC (+ ?qtyPresenteCittaC 1))))
	(assert (costoTotal (+ ?livello 1) (+ ?costoAttuale 10)))
	(assert (delete (+ ?livello 1) ?fIn))
	(assert (delete (+ ?livello 1) ?fPresent))
	(assert (delete (+ ?livello 1) ?fCost))
	(assert (current ?livello))
    (assert (news (+ ?livello 1)))
	(assert (apply ?livello))
)

;muove il mezzo da una citta ad un'altra
(defrule EXPAND::moveTo
	?f1 <- (posizioneMezzo (livello ?livello) (name ?nameMezzo) (posizione ?posizioneAttuale))
	(mezzo (name ?nameMezzo) (tipo ?tipoMezzo))
	(citta (name ?cittaDestinazione))
	(or
		(collegamento (citta1 ?posizioneAttuale) (citta2 ?cittaDestinazione) (tipo ?tipoMezzo) (distanza ?distanzaKm))
		(collegamento (citta1 ?cittaDestinazione) (citta2 ?posizioneAttuale) (tipo ?tipoMezzo) (distanza ?distanzaKm))
	)
	(test(neq ?posizioneAttuale ?cittaDestinazione))
	?fCost <- (costoTotal ?livello ?costoAttuale)
	;TODO: usare info tipo mezzo in modo da poter calcolare costo distanza
	=>
	(assert (delete (+ ?livello 1) ?f1))
	(assert (delete (+ ?livello 1) ?fCost))
	(assert (posizioneMezzo (livello (+ ?livello 1)) (name ?nameMezzo) (posizione ?cittaDestinazione)))
	(assert (costoTotal (+ ?livello 1) (+ ?costoAttuale 50))) ;50 fake. TODO
	(assert (current ?livello))
    (assert (news (+ ?livello 1)))
	(assert (apply ?livello))
)

