;*************************************MODULO MAIN
(defmodule MAIN (export ?ALL))

 
(deftemplate maxdepth 
	(slot max)
)

(deffacts parameters
       (maxdepth (max 0))
	   (livelloCorrente 0)
)


(defrule gotSolution
	(declare (salience 1))
	(goalRaised)
	=>
	(printout t "SOLUZIONE TROVATA, BLOCCO L'ESECUZIONE" crlf)
	(assert (printSolution))
)

(defrule printSolutionFinish
	(declare (salience 11))
	(printSolution)
	(livelloCorrente -1)
	=>
	(halt)
)

(defrule printSolutionRule
	(declare (salience 10))
	(printSolution)
	?lev <-(livelloCorrente ?currentLevel)
	(printableAction ?currentLevel ?tempStr)
	=>
	(printout t " Passo al livello " ?currentLevel ":" ?tempStr crlf)
	(retract ?lev)
	(assert (livelloCorrente (- ?currentLevel 1)))
)

(defrule backtrack
	(livelloCorrente ?currentLevel)
	(not (goalRaised))
	(test (> ?currentLevel 0))
	=>
	(assert (retractIn))
	(assert (retractPresenteCitta))
	(assert (retractCostoTotal))
	(assert (retractPosizioneMezzo))
	(assert (retractDeleteIn))
	(assert (retractDeletePresenteCitta))
	(assert (retractDeletePosizioneMezzo))
	(assert (retractPrintableActions))
	(assert (retractDeleteCostoTotal))
	
	(assert (passToCheck))
	(assert (passToExpand)) ;mi serve per attivare allRetracted in CHECK
	
	(assert (backtracked)) ;mi serve in EXPAND
	(focus EXPAND)
)

(defrule no-solution 
	(not (goalRaised))
	(maxdepth (max ?d))
	=> 
	(reset)
    (assert (resetted ?d))
)

(defrule resetted
	?f <- (resetted ?d)
	?m <- (maxdepth (max ?))
	?lev <- (livelloCorrente ?currentLevel)
	=>
    (modify ?m (max (+ ?d 1))) 					;AUMENTO LA MAX DEPTH
	(retract ?lev)
	(assert (livelloCorrente 0))				;resetto il livello corrente
    (printout t "************************************************* fail with Maxdepth:" ?d crlf)
    (focus EXPAND)
    (retract ?f)
)

;non serve a niente. Solo per non far andare in errore di compilazione import/export conflict
(defrule dummy-rule (declare (salience 2))
       ?f1 <- (delete -1 op obj obj)
	   ?f2 <- (effettuataAzione  -1 $?)
=>
	(retract ?f1 ?f2)
)

;effettuataAzione serve per non far ripetere le stesse azioni nello stesso livello all'infinito
(defrule cleanEffettuataAzione
	(declare (salience 10))
	(livelloCorrente ?currentLevel)
	?effAz<- (effettuataAzione ?currentLevel $?)
	=>
	(printout ?*debug-print* "cleanEffettuataAzione| effettuataAzione " ?currentLevel crlf)
	(retract ?effAz)
)


;*************************************MODULO EXPAND

(defmodule EXPAND (import MAIN ?ALL) (export ?ALL))

(defrule passToCheck
	(declare (salience 10))
	?pass<- (passToCheck)
	?lev <- (livelloCorrente ?currentLevel)
	=>
	(retract ?pass)
	(assert (livelloCorrente (- ?currentLevel 1)))
	(retract ?lev)
	(printout ?*debug-print* "passToCheck| currentLevel " ?currentLevel crlf)
	(focus CHECK)
)

(defrule backTracked
	(declare (salience 9))
	?back<- (backtracked)
	(livelloCorrente ?currentLevel)
	;?currAct<- (effettuataAzione ?currentLevel $?)
	=>
	(printout ?*debug-print* "-------------------backTracked"  crlf)
	(retract ?back)
	;(retract ?currAct)
	(assert (popExpand)) ;questo mi serve perchè altrimenti non arriva mai a noSolution del MAIN
)

(defrule popExpand
	(declare (salience 20))
	?popFact <- (popExpand)
	(livelloCorrente ?currentLevel)
	(test (eq ?currentLevel 0))
	=>
	(retract ?popFact)
	(pop-focus)
)

(defrule popExpandRetract
	(declare (salience 19))
	?popFact <- (popExpand)
	(livelloCorrente ?currentLevel)
	(test (> ?currentLevel 0))
	=>
	(retract ?popFact)
	;in questo caso non faccio il pop-focus
)
	

;*************************************MODULO CHECK
(defmodule CHECK (import EXPAND ?ALL) (export ?ALL))

;mi serve per aumentare il livello al quale sto lavorando
(defrule increaseLevel
	(not (goalRaised))
	?lev<- (livelloCorrente ?currentLevel)
	(effettuataAzione ?currentLevel)
	=>
	(retract ?lev)
	(assert (livelloCorrente (+ ?currentLevel 1)))
	(printout ?*debug-print* "increaseLevel| currentLevel " ?currentLevel crlf)
	(assert (checkLevel))
)

;controlla se ho sforato la profondità massima. Se si porta al retract dei nuovi facts e ritorna al currentLevel precedente
(defrule checkLevel
	?check<- (checkLevel)
	?currLev<- (livelloCorrente ?currentLevel)
	(maxdepth (max ?maxDepth))
	(test(> ?currentLevel ?maxDepth))
	?currAct<- (effettuataAzione ?t&:(eq ?t (- ?currentLevel 1)))
	=>
	(retract ?check)
	(retract ?currLev)
	(retract ?currAct)
	
	(assert (retractIn))
	(assert (retractPresenteCitta))
	(assert (retractCostoTotal))
	(assert (retractPosizioneMezzo))
	(assert (livelloCorrente (- ?currentLevel 1)))
	(assert (retractDeleteIn))
	(assert (retractDeletePresenteCitta))
	(assert (retractDeletePosizioneMezzo))
	(assert (retractDeleteCostoTotal))
	
	(assert (passToExpand))
	
	(printout ?*debug-print* "checkLevel| currentLevel " ?currentLevel "maxDepth " ?maxDepth crlf)
	(assert (retractPrintableActions))
)

;in questo caso il livello non sfora
(defrule checkLevelOk
	(declare (salience -2))
	?check<- (checkLevel)
	(livelloCorrente ?currentLevel)
	?currAct<- (effettuataAzione ?t&:(eq ?t (- ?currentLevel 1)))
	=>
	(retract ?check)
	(retract ?currAct)
	(printout ?*debug-print* "checkLevelOk| currentLevel " ?currentLevel crlf)
	(focus PERSIST)
)

		;#####  REGOLE PER RETRACT #####

		
(defrule retractPrintableActionsRule
	(retractPrintableActions)
	(livelloCorrente ?currentLevel)
	?printFact<- (printableAction ?currentLevel $?)
	=>
	(retract ?printFact)
	(printout ?*debug-print* "retractPrintableActionsRule| currentLevel " ?currentLevel crlf)
)		

		
(defrule retractDeleteInRule
	(retractDeleteIn)
	(livelloCorrente ?currentLevel)
	?delInFact<- (delete ?t&:(eq ?t (+ ?currentLevel 1)) in $?)
	=>
	(retract ?delInFact)
	(printout ?*debug-print* "retractDeleteInRule| currentLevel " ?currentLevel crlf)
)

(defrule retractDeletePresenteCittaRule
	(retractDeletePresenteCitta)
	(livelloCorrente ?currentLevel)
	?delPresenteCittaFact<- (delete ?t&:(eq ?t (+ ?currentLevel 1)) presenteInCitta $?)
	=>
	(retract ?delPresenteCittaFact)
	(printout ?*debug-print* "retractDeletePresenteCittaRule| currentLevel " ?currentLevel crlf)
)	

(defrule retractDeletePosizioneMezzo
	(retractDeletePosizioneMezzo)
	(livelloCorrente ?currentLevel)
	?delPosizioneMezzoFact<- (delete ?t&:(eq ?t (+ ?currentLevel 1)) posizioneMezzo $?)
	=>
	(retract ?delPosizioneMezzoFact)
	(printout ?*debug-print* "retractDeletePosizioneMezzo| currentLevel " ?currentLevel crlf)
)		


(defrule retractDeleteCostoTotal
	(retractDeleteCostoTotal)
	(livelloCorrente ?currentLevel)
	?delCostoTotal<- (delete ?t&:(eq ?t (+ ?currentLevel 1)) costoTotal $?)
	=>
	(retract ?delCostoTotal)
	(printout ?*debug-print* "retractDeleteCostoTotal| currentLevel " ?currentLevel crlf)
)		
		
(defrule retractInRule
	(retractIn)
	(livelloCorrente ?currentLevel)
	?inFact<- (in (livello ?t&:(eq ?t (+ ?currentLevel 1))))
	=>
	(retract ?inFact)
	(printout ?*debug-print* "retractInRule| currentLevel " ?currentLevel crlf)
)
	
(defrule retractPresenteCittaRule
	(retractPresenteCitta)
	(livelloCorrente ?currentLevel)
	?presenteCittaFact<- (presenteInCitta (livello ?t&:(eq ?t (+ ?currentLevel 1))))
	=>
	(retract ?presenteCittaFact)
	(printout ?*debug-print* "retractPresenteCittaRule| currentLevel " ?currentLevel crlf)
)

(defrule retractCostoTotalRule
	(retractCostoTotal)
	(livelloCorrente ?currentLevel)
	?costoTotalFact<- (costoTotal ?t&:(eq ?t (+ ?currentLevel 1)) ?)
	=>
	(retract ?costoTotalFact)
	(printout ?*debug-print* "retractCostoTotalRule| currentLevel " ?currentLevel crlf)
)

(defrule retractPosizioneMezzoRule
	(retractPosizioneMezzo)
	(livelloCorrente ?currentLevel)
	?posizioneMezzoFact<- (posizioneMezzo (livello ?t&:(eq ?t (+ ?currentLevel 1))))
	=>
	(retract ?posizioneMezzoFact)
	(printout ?*debug-print* "retractPosizioneMezzoRule| currentLevel " ?currentLevel crlf)
)

(defrule allRetracted
	(declare (salience -1)) ;salience -1 perchè deve essere fatto dopo il retract di tutti
	?passExp<- (passToExpand)
	?ret1<- (retractPresenteCitta)
	?ret2<- (retractCostoTotal)
	?ret3<- (retractPosizioneMezzo)
	?ret4<- (retractIn)
	?ret5<- (retractPrintableActions)
	?ret6<- (retractDeleteIn)
	?ret7<- (retractDeletePresenteCitta)
	?ret8<- (retractDeletePosizioneMezzo)
	?ret9<- (retractDeleteCostoTotal)
	;?currLev<- (livelloCorrente ?currentLevel)
	=>
	(retract ?ret1 ?ret2 ?ret3 ?ret4 ?ret5 ?ret6 ?ret7 ?ret8 ?ret9 ?passExp)
	(printout ?*debug-print* "allRetracted|" crlf)
	;(assert (livelloCorrente (- ?currentLevel 1))) ;in modo tale che l'esecuzione riparta dal livello precedente (se ci sono ancora azioni applicabili)
	;(focus EXPAND)
)
		;###############################


;*************************************MODULO PERSIST

(defmodule PERSIST (import EXPAND ?ALL) (export ?ALL))

(defrule persistency-posizioneMezzo
    (livelloCorrente ?level)
	(posizioneMezzo (livello ?t&:(eq ?t (- ?level 1))) (name ?nameMezzo) (posizione ?position))
	(not (delete ?level posizioneMezzo ?t&:(eq ?t (- ?level 1)) ?nameMezzo))
	=> 
	(assert (posizioneMezzo (livello ?level) (name ?nameMezzo) (posizione ?position)))
	(printout ?*debug-print* "persistency-posizioneMezzo| currentLevel: " ?level " nameMezzo: " ?nameMezzo crlf)
)
	
(defrule persistency-presenteInCitta
    (livelloCorrente ?level)
	(presenteInCitta (livello ?t&:(eq ?t (- ?level 1))) (nomeCitta ?nomeCitta) (presenteInCittaQtyA ?qtyA) (presenteInCittaQtyB ?qtyB) (presenteInCittaQtyC ?qtyC))
	(not (delete ?level presenteInCitta ?t&:(eq ?t (- ?level 1)) ?nomeCitta))
	=> 
	(assert (presenteInCitta (livello ?level) (nomeCitta ?nomeCitta) (presenteInCittaQtyA ?qtyA) (presenteInCittaQtyB ?qtyB) (presenteInCittaQtyC ?qtyC)))
	(printout ?*debug-print* "persistency-presenteInCitta| currentLevel: " ?level " nomeCitta: " ?nomeCitta crlf)
)

(defrule persistency-in
    (livelloCorrente ?level)
	(in (livello ?t&:(eq ?t (- ?level 1))) (nomeMezzo ?nameMezzo) (quantityA ?qtyA) (quantityB ?qtyB) (quantityC ?qtyC))
	(not (delete ?level in ?t&:(eq ?t (- ?level 1)) ?nameMezzo))
	=> 
	(assert (in (livello ?level) (nomeMezzo ?nameMezzo) (quantityA ?qtyA) (quantityB ?qtyB) (quantityC ?qtyC)))
	(printout ?*debug-print* "persistency-in| currentLevel: " ?level " nomeMezzo: " ?nameMezzo crlf)
)

;questa viene chiamata dopo che le persist sono state tutte fatte
;(defrule passToExpandFromPersist
;	(declare (salience -1))
;	(livelloCorrente ?)
;	=>
;	(focus EXPAND)
;)
