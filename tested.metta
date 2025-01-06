(: Demorgans (-> (Expr $prev) (Expr $expr) (Expr $result)))
(= (Demorgans $prev $expr)
    (if (== $expr ())
        () ; Base case: Empty input
        (let* ( ($op (car-atom $expr)) ; Get the operator
                ($args (cdr-atom $expr)) ; Get the operands
                (if (== $prev NOT) ; Check if previous operator is NOT
                    (case ($op)
                        ( (OR) ; Apply De Morgan's laws: NOT (OR ...) → AND (NOT ...)
                            (AND (collapse (Demorgans NOT (superpose $args)))))
                        ( (AND) ; Apply De Morgan's laws: NOT (AND ...) → OR (NOT ...)
                            (OR (collapse (Demorgans NOT (superpose $args)))))
                        ( (NOT) ; Double negation: NOT (NOT A) → A
                            (collapse (Demorgans () (superpose $args))))
                    ) ; End case
                (case ($op) ; No NOT, process recursively
                    ( (OR) (OR (collapse (Demorgans () (superpose $args)))))
                    ( (AND) (AND (collapse (Demorgans () (superpose $args)))))
                    ( (NOT) (NOT (collapse (Demorgans NOT (superpose $args)))))
                ) ; End case
        )
)) ; End let*
)
)
! (Demorgans NOT (AND x1 x2 x4))