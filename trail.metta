(: Demorgans (-> (Expr $t) (Expr $t)))

 ; Base case: If the input is a symbol, return it unchanged

 ; Simplify double negation: NOT (NOT A) → A
(= (Demorgans (NOT (NOT $a))) (Demorgans $a))

 ; Apply De Morgan’s Laws for NOT (AND ...) or NOT (OR ...)
(= (Demorgans (NOT $expr) $prev)
    (let* ( ($op (car-atom $expr))
            ($args (cdr-atom $expr))
            ($ts ( superpose $args)))
        (if (== $op AND)
            (cons-atom OR ( (if (== (get-metatype $ts) Symbol)
                        (NOT $ts)
                        (let $t (cdr-atom $ts)
                            (car-atom $t)
                        )
                )
        )
    (if (== $op OR)
        (cons-atom AND (NOT (superpose ($args))))
        (NOT (Demorgans $expr)) ; Push NOT down
    )
)
)
))
(= (maps $f ()) ()) ; defining for the base case if the function got an nil its return nil
(= (maps NOT $list) (NOT $list) ; defining the map function if it gets a list
     ; / ( (/) ; apply the function to the head of the list and call the map recursivley and applying the function to the tail
)

! (Demorgans    and  ( (NOT (AaND x1 x2 x3 ))))
