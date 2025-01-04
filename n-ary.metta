(: Demorgans (-> (Expr $t) (Expr $t)))

 ; Base case: If the input is a symbol, return it unchanged
(= (Demorgans $leaf)
    (if (== (get-metatype $leaf) Symbol)
        $leaf
        (empty) ; Stop recursion for invalid inputs
    )
)

 ; Simplify double negation: NOT (NOT A) → A
(= (Demorgans (NOT (NOT $a))) (Demorgans $a))

 ; Apply De Morgan’s Laws for NOT (AND ...) or NOT (OR ...)
(= (Demorgans (NOT $expr))
    (let* ( ($op (car-atom $expr))
            ($args (cdr-atom $expr)))
        (if (== $op AND)
            (cons-atom OR (maps ( $args)))
            (if (== $op OR)
                (cons-atom AND (maps NOT $args))
                (NOT (Demorgans $expr)) ; Push NOT down
            )
    )
)
)

 ; Process AND operator: Recursively process all operands
 ;(= (Demorgans ('AND' $expr))
 ;(cons-atom 'AND (process-list $expr 'Demorgans)))

 ; Process OR operator: Recursively process all operands
 ;(= (Demorgans ('OR' $expr))
 ;(cons-atom 'OR (process-list $expr 'Demorgans)))

 ; Handle invalid cases gracefully
 ;(= (Demorgans $expr)
 ;(empty))

(= (map NOT ()) ()) ; defining for the base case if the function got an nil its return nil
(= (maps NOT $list) ; defining the map function if it gets a list
    ( (NOT (car-atom $list) (maps NOT (cdr-atom $list))) ; apply the function to the head of the list and call the map recursivley and applying the function to the tail
    ))

! (Demorgans (NOT (AND x1 x2 x3 )))
