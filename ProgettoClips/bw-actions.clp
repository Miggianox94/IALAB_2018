
(defrule EXPAND::pick (declare (salience 2))
   (status ?s on ?x ?y)
   (status ?s clear ?x ?)
   (status ?s handempty NA NA)
   => (assert (apply ?s pick ?x ?y)))

(defrule EXPAND::apply-pick3 (declare (salience 5))
?f <- (apply ?s pick ?x ?y)
 =>    (retract ?f)
      (assert (delete (+ ?s 1) on ?x ?y))
      (assert (delete (+ ?s 1) clear ?x NA))
      (assert (delete (+ ?s 1) handempty NA NA))
      (assert (status (+ ?s 1) clear ?y NA))
      (assert (status (+ ?s 1) holding ?x NA))
      (assert (current ?s))
      (assert (news (+ ?s 1)))
      (assert (exec ?s pick ?x ?y )))

(defrule EXPAND::picktable (declare (salience 2))
   (status ?s ontable ?x ?)
   (status ?s clear ?x ?)
   (status ?s handempty NA NA)
   => (assert (apply ?s picktable ?x NA)))


(defrule EXPAND::apply-picktable3 (declare (salience 2))
?f <- (apply ?s picktable ?x ?y)
 =>   (retract ?f)
      (assert (delete (+ ?s 1) ontable ?x NA))
      (assert (delete (+ ?s 1) clear ?x NA))
      (assert (delete (+ ?s 1) handempty NA NA))
      (assert (status (+ ?s 1) holding ?x NA))
      (assert (current ?s))
      (assert (news (+ ?s 1)))
      (assert (exec ?s picktable ?x NA)))



(defrule EXPAND::put (declare (salience 2))
   (status ?s holding ?x ?)
   (status ?s clear ?y ?)
   => (assert (apply ?s put ?x ?y)))

(defrule EXPAND::apply-put3 (declare (salience 5))
?f <- (apply ?s put ?x ?y)
 =>   (retract ?f)
      (assert (delete  (+ ?s 1) holding ?x NA))
      (assert (delete  (+ ?s 1) clear ?y NA))
      (assert (status (+ ?s 1) on ?x ?y))
      (assert (status (+ ?s 1) clear ?x NA))
      (assert (status (+ ?s 1) handempty NA NA))
      (assert (current ?s))
      (assert (news (+ ?s 1)))
      (assert (exec ?s put ?x ?y)))

(defrule EXPAND::puttable (declare (salience 2))
   (status ?s holding ?x ?)
   => (assert (apply ?s puttable ?x NA)))

(defrule EXPAND::apply-puttable3 (declare (salience 5))
?f <- (apply ?s puttable ?x ?y)
 =>   (retract ?f)
      (assert (delete (+ ?s 1) holding ?x NA))
      (assert (status (+ ?s 1) ontable ?x NA))
      (assert (status (+ ?s 1) clear ?x NA))
      (assert (status (+ ?s 1) handempty NA NA))
      (assert (current ?s))
      (assert (news (+ ?s 1)))
      (assert (exec ?s puttable ?x NA)))


