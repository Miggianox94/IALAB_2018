(deftemplate mezzo
	(slot name (type STRING))
	(slot tipo (allowed-values furgone aereo nave))
	(slot capacita (type NUMBER))
	(slot unitaDisponibili (type NUMBER)) ;sarà sempre uguale per tutte le istanze di un certo tipo
)

(deftemplate posizioneMezzo
	(slot livello (type NUMBER) (default 0))
	(slot name (type STRING))
	(slot posizione (type STRING))
)

(deftemplate citta
	(slot name (type STRING))
	(slot produceTipo (type STRING))
	(slot produceQty (type NUMBER))
	(slot consumaQtyA (type NUMBER) (default 0))
	(slot consumaQtyB (type NUMBER) (default 0))
	(slot consumaQtyC (type NUMBER) (default 0))
)

deftemplate presenteInCitta
	(slot livello (type NUMBER) (default 0))
	(slot nomeCitta (type STRING))
	(slot presenteInCittaQtyA (type NUMBER) (default 0))
	(slot presenteInCittaQtyB (type NUMBER) (default 0))
	(slot presenteInCittaQtyC (type NUMBER) (default 0))
)

(deftemplate collegamento
	(slot citta1 (type STRING))
	(slot citta2 (type STRING))
	(slot tipo (allowed-values furgone aereo nave) (default terra))
	(slot distanza (type NUMBER))
)

(deftemplate in
	(slot livello (type NUMBER) (default 0))
	(slot nomeMezzo (type STRING))
	(slot quantityA (type NUMBER) (default 0))
	(slot quantityB (type NUMBER) (default 0))
	(slot quantityC (type NUMBER) (default 0))
)


;;######################################## STATO INIZIALE

(deffacts mezzi
	(mezzo (name Furgone1) (tipo furgone) (capacita 4) (unitaDisponibili 5))
	(mezzo (name Furgone2) (tipo furgone) (capacita 4) (unitaDisponibili 5))
	(mezzo (name Furgone3) (tipo furgone) (capacita 4) (unitaDisponibili 5))
	(mezzo (name Furgone4) (tipo furgone) (capacita 4) (unitaDisponibili 5))
	(mezzo (name Furgone5) (tipo furgone) (capacita 4) (unitaDisponibili 5))
	(mezzo (name Aereo1) (tipo aereo) (capacita 7) (unitaDisponibili 2))
	(mezzo (name Aereo2) (tipo aereo) (capacita 7) (unitaDisponibili 2))
	(mezzo (name Nave1) (tipo nave) (capacita 11) (unitaDisponibili 2))
	(mezzo (name Nave2) (tipo nave) (capacita 11) (unitaDisponibili 2))
	(posizioneMezzo (livello 0) (name Furgone1) (posizione BO))
	(posizioneMezzo (livello 0) (name Furgone2) (posizione BO))
	(posizioneMezzo (livello 0) (name Furgone3) (posizione BO))
	(posizioneMezzo (livello 0) (name Furgone4) (posizione RM))
	(posizioneMezzo (livello 0) (name Furgone5) (posizione RM))
	(posizioneMezzo (livello 0) (name Aereo1) (posizione MI))
	(posizioneMezzo (livello 0) (name Aereo2) (posizione PA))
	(posizioneMezzo (livello 0) (name Nave1) (posizione GE))
	(posizioneMezzo (livello 0) (name Nave2) (posizione VE))
)

(deffacts mezziIn
	(in (nomeMezzo Furgone1))
	(in (nomeMezzo Furgone2))
	(in (nomeMezzo Furgone3))
	(in (nomeMezzo Furgone4))
	(in (nomeMezzo Furgone5))
	(in (nomeMezzo Aereo1))
	(in (nomeMezzo Aereo2))
	(in (nomeMezzo Nave1))
	(in (nomeMezzo Nave2))
)


(deffacts citta
	(citta (name TO) (produceTipo B) (produceQty 10) (consumaQtyA 20))
	(citta (name MI) (produceTipo C) (produceQty 5) (consumaQtyA 30))
	(citta (name VE) (produceTipo C) (produceQty 10) (consumaQtyB 5))
	(citta (name GE) (produceTipo C) (produceQty 10) (consumaQtyB 5))
	(citta (name BO) (produceTipo B) (produceQty 10) (consumaQtyC 10))
	(citta (name RM) (produceTipo A) (produceQty 10) (consumaQtyC 5))
	(citta (name NA) (produceTipo B) (produceQty 5) (consumaQtyC 5))
	(citta (name BA) (produceTipo A) (produceQty 10) (consumaQtyB 5))
	(citta (name RC) (produceTipo A) (produceQty 20) (consumaQtyB 5))
	(citta (name PA) (produceTipo A) (produceQty 10) (consumaQtyB 5))
	(presenteInCitta (livello 0) (nomeCitta TO) (presenteInCittaQtyA 0) (presenteInCittaQtyB 10) (presenteInCittaQtyC 0))
	(presenteInCitta (livello 0) (nomeCitta MI) (presenteInCittaQtyA 0) (presenteInCittaQtyB 0) (presenteInCittaQtyC 5))
	(presenteInCitta (livello 0) (nomeCitta VE) (presenteInCittaQtyA 0) (presenteInCittaQtyB 0) (presenteInCittaQtyC 10))
	(presenteInCitta (livello 0) (nomeCitta GE) (presenteInCittaQtyA 0) (presenteInCittaQtyB 0) (presenteInCittaQtyC 10))
	(presenteInCitta (livello 0) (nomeCitta BO) (presenteInCittaQtyA 0) (presenteInCittaQtyB 10) (presenteInCittaQtyC 0))
	(presenteInCitta (livello 0) (nomeCitta RM) (presenteInCittaQtyA 10) (presenteInCittaQtyB 0) (presenteInCittaQtyC 0))
	(presenteInCitta (livello 0) (nomeCitta NA) (presenteInCittaQtyA 0) (presenteInCittaQtyB 5) (presenteInCittaQtyC 0))
	(presenteInCitta (livello 0) (nomeCitta BA) (presenteInCittaQtyA 10) (presenteInCittaQtyB 0) (presenteInCittaQtyC 0))
	(presenteInCitta (livello 0) (nomeCitta RC) (presenteInCittaQtyA 20) (presenteInCittaQtyB 0) (presenteInCittaQtyC 0))
	(presenteInCitta (livello 0) (nomeCitta PA) (presenteInCittaQtyA 10) (presenteInCittaQtyB 0) (presenteInCittaQtyC 0))
)

(deffacts collegamenti
	(collegamento (citta1 TO) (citta2 MI) (tipo furgone) (distanza 138))
	(collegamento (citta1 TO) (citta2 GE) (tipo furgone) (distanza 170))
	(collegamento (citta1 MI) (citta2 VE) (tipo furgone) (distanza 276))
	(collegamento (citta1 MI) (citta2 BO) (tipo furgone) (distanza 206))
	(collegamento (citta1 VE) (citta2 BO) (tipo furgone) (distanza 158))
	(collegamento (citta1 BO) (citta2 FI) (tipo furgone) (distanza 101))
	(collegamento (citta1 GE) (citta2 FI) (tipo furgone) (distanza 230))
	(collegamento (citta1 FI) (citta2 RM) (tipo furgone) (distanza 268))
	(collegamento (citta1 RM) (citta2 NA) (tipo furgone) (distanza 219))
	(collegamento (citta1 NA) (citta2 BA) (tipo furgone) (distanza 255))
	(collegamento (citta1 NA) (citta2 RC) (tipo furgone) (distanza 462))
	(collegamento (citta1 GE) (citta2 PA) (tipo nave) (distanza 1412))
	(collegamento (citta1 PA) (citta2 NA) (tipo nave) (distanza 740))
	(collegamento (citta1 VE) (citta2 BA) (tipo nave) (distanza 754))
	(collegamento (citta1 BA) (citta2 MI) (tipo aereo) (distanza 711))
	(collegamento (citta1 MI) (citta2 NA) (tipo aereo) (distanza 764))
	(collegamento (citta1 TO) (citta2 RM) (tipo aereo) (distanza 669))
	(collegamento (citta1 TO) (citta2 PA) (tipo aereo) (distanza 1596))
)

(deffacts costoIniziale
	(costoTotal 0 0)
)


;;######################################## FUNZIONI
(deffunction sumAll (?a ?b ?c)
	(bind ?temp (+ ?a ?b))
	(bind ?temp (+ ?temp ?c))
	(return ?temp)
)

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
	(test (> ?capacita (sumAll(?qtyA ?qtyB ?qtyC))))
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
)

;aggiunge una unità di merce B dalla citta dove si trova il mezzo dentro il mezzo
(defrule EXPAND::loadB
	(mezzo (name ?nameMezzo) (capacita ?capacita))
	(posizioneMezzo (livello ?livello) (name ?nameMezzo) (posizione ?posizioneAttuale))
	?fIn <- (in (livello ?livello) (nomeMezzo ?nameMezzo) (quantityA ?qtyA) (quantityB ?qtyB) (quantityC ?qtyC))
	(test (> ?capacita (sumAll(?qtyA ?qtyB ?qtyC))))
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
)

;aggiunge una unità di merce C dalla citta dove si trova il mezzo dentro il mezzo
(defrule EXPAND::loadC
	(mezzo (name ?nameMezzo) (capacita ?capacita))
	(posizioneMezzo (livello ?livello) (name ?nameMezzo) (posizione ?posizioneAttuale))
	?fIn <- (in (livello ?livello) (nomeMezzo ?nameMezzo) (quantityA ?qtyA) (quantityB ?qtyB) (quantityC ?qtyC))
	(test (> ?capacita (sumAll(?qtyA ?qtyB ?qtyC))))
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
)

