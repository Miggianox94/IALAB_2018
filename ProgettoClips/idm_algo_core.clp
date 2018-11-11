;*************************************MODULO MAIN
(defmodule MAIN (export ?ALL))

(deftemplate solution 
	(slot value (default no))
)
 
(deftemplate maxdepth 
	(slot max)
)

(deffacts parameters
       (solution (value no)) 
       (maxdepth (max 0))
)

;---serve per stampare la soluzione
(defrule got-solution
	(declare (salience 100))
	(solution (value yes)) 
	(maxdepth (max ?n))
        => 
	(assert (stampa (- ?n 1)))
)

(defrule stampaSol
	(declare (salience 101))
	?f<-(stampa ?n)
	;(exec ?n ?k ?a ?b) ;TODO: sostiuire exec --> capire come stampare i passi
	=> 
	;(printout t " PASSO: "?n " " ?k " " ?a " " ?b crlf)
	(assert (stampa (- ?n 1)))
	(retract ?f)
)

(defrule stampaSol0
	(declare (salience 102))
	(stampa -1)
	=> 
	(halt)
)
;--------


(defrule no-solution 
	(declare (salience -1))
	(solution (value no))
	;(goal ?op ?x ?y) ;TODO: sostituire goal
	;(not (status 0 ?op ?x ?y)) ;TODO: sostuire status
	(not (goalRaised))
	?f <-  (maxdepth (max ?d))
	=> 
	(reset)
    (assert (resetted ?d))
)

(defrule resetted
	?f <- (resetted ?d)
	?m <- (maxdepth (max ?))
	=>
    (modify ?m (max (+ ?d 1))) 					;AUMENTO LA MAX DEPTH
    (printout t " fail with Maxdepth:" ?d crlf)
    (focus EXPAND)
    (retract ?f)
)

(defrule s0Sol 
	(declare (salience -2))
	?f<-(solution (value no))
	=>
    (printout t " PASSO: 0 do nothing" crlf)
    (modify ?f (value yes))
)


;(defrule no-solution (declare (salience -1))
;  (solution (value no))
;  (maxdepth (max ?d))
; => 
;  (reset)
;  (assert (resetted ?d))
;)

;questa regola non ha un compito attivo
;serve solo per consentire a CLIPS di creare dei
;template per i fatti ordinati di supporto
;Sarebbe meglio evitare regole di questo tipo
;usando fatti non ordinati anche i per i fatti di supporto
;MA 1) questo è un adattamento di un codice pensato per essere unico
;2) i fatti ordinati sono più immediati (non richiedono slot)
(defrule dummy-rule (declare (salience 2))
       ?f1 <- (delete -1 op obj obj)
       ?f2 <- (news -1)
       ?f3 <- (goal atom obj obj)
       ?f4 <- (status -1 atom obj obj)
=>
	(retract ?f1 ?f2 ?f3 ?f4)
)


;*************************************MODULO EXPAND

(defmodule EXPAND (import MAIN ?ALL) (export ?ALL))

;queste regole vengono controllate ogni volta che viene asserito apply. Notare salience
(defrule backtrack-0 (declare (salience 10))
	;?f<- (apply ?s ? ? ?)
	?f<- (apply ?s)
   	(maxdepth (max ?d))
   	(test (>= ?s ?d))
=> 
	(retract ?f)
)

(defrule backtrack-posizioneMezzo (declare (salience 10))
	;?f<- (apply ?s ? ? ?)
	?f<- (apply ?s)
	(not (current ?))
	?f1 <-	(posizioneMezzo (livello ?t&:(> ?t ?s)))
	=> 	
	(retract ?f1)
)

(defrule backtrack-presenteInCitta (declare (salience 10))
	;?f<- (apply ?s ? ? ?)
	?f<- (apply ?s)
	(not (current ?))
	?f1 <-	(presenteInCitta (livello ?t&:(> ?t ?s)))
	=> 	
	(retract ?f1)
)

(defrule backtrack-in (declare (salience 10))
	;?f<- (apply ?s ? ? ?)
	?f<- (apply ?s)
	(not (current ?))
	?f1 <-	(in (livello ?t&:(> ?t ?s)))
	=> 	
	(retract ?f1)
)

;(defrule backtrack-2 (declare (salience 10)) TODO: CAPIRE SE VA BENE TOGLIERE STA REGOLA
;	(apply ?s ? ? ?)
;	(not (current ?))
;	?f2 <-	(exec ?t&:(>= ?t ?s) ? ? ?)
;=> 	(retract ?f2))


(defrule pass-to-check (declare (salience 25))
	(current ?s)
=>
	(focus CHECK)
)


;*************************************MODULO CHECK

(defmodule CHECK (import EXPAND ?ALL) (export ?ALL))

(defrule persistency-posizioneMezzo
    (declare (salience 100))
    (current ?s)
    ;(status ?s ?op ?x ?y)
	(posizioneMezzo (livello ?level) (name ?nameMezzo) (posizione ?position))
    (not (delete (posizioneMezzo (livello ?t&:(eq ?t (+ ?level 1))) (name ?nameMezzo) (posizione ?position))))
	=> 
	(posizioneMezzo (livello (+ ?level 1)) (name ?nameMezzo) (posizione ?position))
)
	
(defrule persistency-presenteInCitta
    (declare (salience 100))
    (current ?s)
    ;(status ?s ?op ?x ?y)
	(presenteInCitta (livello ?level) (nomeCitta ?nomeCitta) (presenteInCittaQtyA ?qtyA) (presenteInCittaQtyB ?qtyB) (presenteInCittaQtyC ?qtyC))
    (not (delete (presenteInCitta (livello ?t&:(eq ?t (+ ?level 1))) (nomeCitta ?nomeCitta) (presenteInCittaQtyA ?qtyA) (presenteInCittaQtyB ?qtyB) (presenteInCittaQtyC ?qtyC))
	=> 
	(presenteInCitta (livello (+ ?level 1)) (nomeCitta ?nomeCitta) (presenteInCittaQtyA ?qtyA) (presenteInCittaQtyB ?qtyB) (presenteInCittaQtyC ?qtyC))
)

(defrule persistency-in
    (declare (salience 100))
    (current ?s)
    ;(status ?s ?op ?x ?y)
	(in (livello ?level) (nomeMezzo ?nameMezzo) (quantityA ?qtyA) (quantityB ?qtyB) (quantityC ?qtyC))
    (not (delete (in (livello ?t&:(eq ?t (+ ?level 1))) (nomeMezzo ?nameMezzo) (quantityA ?qtyA) (quantityB ?qtyB) (quantityC ?qtyC)))
	=> 
	(in (livello (+ ?level 1)) (nomeMezzo ?nameMezzo) (quantityA ?qtyA) (quantityB ?qtyB) (quantityC ?qtyC))
)

(defrule goal-not-yet
      (declare (salience 50))
      (news ?s)
      ;(goal ?op ?x ?y)
      ;(not (status ?s ?op ?x ?y))
	  (not (goalRaised))
      => (assert (task go-on)) 
         (assert (ancestor (- ?s 1)))
         (focus NEW))

(defrule solution-exist
 ?f <-  (solution (value no))
         => 
        (modify ?f (value yes))
        (pop-focus)
        (pop-focus)
)

;*************************************MODULO NEW

(defmodule NEW  (import CHECK ?ALL) (export ?ALL))


(defrule check-ancestor-posizioneMezzo
    (declare (salience 50))
	?f1 <- (ancestor ?a) 
    (or (test (> ?a 0)) (test (= ?a 0)))
    (news ?s)
    ;(status ?s ?op ?x ?y)
	(posizioneMezzo (livello ?s) (name ?mezzo) (posizione ?posizione))
    ;(not (status ?a ?op ?x ?y)) 
	(posizioneMezzo (livello ?a) (name ?mezzo) (posizione ?posizione))
    =>
    (assert (ancestor (- ?a 1)))
    (retract ?f1)
    (assert (diff ?a))
)


(defrule check-ancestor-presenteInCitta
    (declare (salience 50))
	?f1 <- (ancestor ?a) 
    (or (test (> ?a 0)) (test (= ?a 0)))
    (news ?s)
    ;(status ?s ?op ?x ?y)
	(presenteInCitta (livello ?s) (nomeCitta ?nomeCitta) (presenteInCittaQtyA ?qtyA) (presenteInCittaQtyB ?qtyB) (presenteInCittaQtyC ?qtyC))
    ;(not (status ?a ?op ?x ?y)) 
	(presenteInCitta (livello ?a) (nomeCitta ?nomeCitta) (presenteInCittaQtyA ?qtyA) (presenteInCittaQtyB ?qtyB) (presenteInCittaQtyC ?qtyC))
    =>
    (assert (ancestor (- ?a 1)))
    (retract ?f1)
    (assert (diff ?a))
)

(defrule check-ancestor-in
    (declare (salience 50))
	?f1 <- (ancestor ?a) 
    (or (test (> ?a 0)) (test (= ?a 0)))
    (news ?s)
    ;(status ?s ?op ?x ?y)
	(in (livello ?s) (nomeMezzo ?nameMezzo) (quantityA ?qtyA) (quantityB ?qtyB) (quantityC ?qtyC))
    ;(not (status ?a ?op ?x ?y)) 
	(in (livello ?a) (nomeMezzo ?nameMezzo) (quantityA ?qtyA) (quantityB ?qtyB) (quantityC ?qtyC))
    =>
    (assert (ancestor (- ?a 1)))
    (retract ?f1)
    (assert (diff ?a))
)

(defrule all-checked
       (declare (salience 25))
       (diff 0) 
?f2 <- (news ?n)
?f3 <- (task go-on) 
=>
       (retract ?f2)
       (retract ?f3)
       (focus DEL))

(defrule already-exist
?f <- (task go-on)
      => 
	(retract ?f)
    (assert (remove newstate))
    (focus DEL))


;*************************************MODULO DEL		
		
(defmodule DEL (import NEW ?ALL))          
       
(defrule del1
	(declare (salience 50))
	?f <- (delete $?)
	=> (retract ?f)
)

(defrule del2
	(declare (salience 100))
	?f <- (diff ?)
	=> (retract ?f)
)

(defrule del3-posizioneMezzo
	(declare (salience 25))
    (remove newstate)
    (news ?n)
	?f <- (posizioneMezzo (livello ?n))
	=> 
	(retract ?f)
)

(defrule del3-presenteInCitta
	(declare (salience 25))
    (remove newstate)
    (news ?n)
	?f <- (presenteInCitta (livello ?n))
	=> 
	(retract ?f)
)

(defrule del3-in
	(declare (salience 25))
    (remove newstate)
    (news ?n)
	?f <- (in (livello ?n))
	=> 
	(retract ?f)
)

(defrule del4
	(declare (salience 10))
	?f1 <- (remove newstate)
	?f2 <- (news ?n)
	=> (retract ?f1)
	   (retract ?f2)
)

(defrule done
	 ?f <- (current ?x) 
	 => 
	(retract ?f)
	(pop-focus)
	(pop-focus)
	(pop-focus)
)


