(deffacts MAIN::S0
      (status 0 clear a NA) (status 0 on a b ) (status 0 ontable b NA)
      (status 0 ontable c NA) (status 0 clear c NA)
      (status 0 handempty NA NA))


;;(deffacts S0
;;      (status 0 clear a NA) (status 0 on a b ) (status 0 ontable b NA) 
;;      (status 0 ontable c NA) (status 0 clear c NA)
;;      (status 0 ontable d NA) (status 0 clear d NA)
;;      (status 0 ontable e NA) (status 0 clear e NA)
;;      (status 0 ontable f NA) (status 0 clear f NA)
;;      (status 0 ontable g NA) (status 0 clear g NA)
;;      (status 0 ontable h NA) (status 0 clear h NA)
;;      (status 0 handempty NA NA))

(deffacts MAIN::final
      (goal on  a b) (goal ontable c NA) (goal on b c)

;;	(goal on b a)
;;      (goal on f g) 
;;      (goal on g h) (goal ontable h NA)


;;	(goal on a b) (goal on b c) (goal on c e) (goal ontable e NA)
;;	(goal ontable a NA) (goal on e d) (goal on b c) (goal ontable c NA)
)



