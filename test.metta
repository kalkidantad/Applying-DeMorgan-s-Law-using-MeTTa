 ; Define the transformation for boolean expressions using De Morgan's laws
(: transform (-> (Expr $t) (Expr $t)))

 ; Base case: Return the leaf unchanged if it's a symbol
(= (transform $leaf)
    (if (== (get-metatype $leaf) Symbol)
        $leaf
        (transforms $leaf)
    )
)

 ; Simplify double negation: NOT (NOT A) → A
(= (transforms ('NOT' ('NOT' $a))) (transform $a))

 ; Apply De Morgan's laws: NOT (AND ...) → OR (NOT ...)
(= (transforms ('NOT' ('AND' $a $b)))
    (let* (
            ($notA (transforms ('NOT' $a))) ; Transform NOT A
            ($notB (transforms ('NOT' $b))) ; Transform NOT B
        )
    ('OR' $notA $notB) ; Combine transformed results into OR
)
)

 ; Apply De Morgan's laws: NOT (OR ...) → AND (NOT ...)
(= (transforms ('NOT' ('OR' $a $b)))
    (let* (
            ($notA (transforms ('NOT' $a))) ; Transform NOT A
            ($notB (transforms ('NOT' $b))) ; Transform NOT B
        )
    ('AND' $notA $notB) ; Combine transformed results into AND
)
)

 ; Recursive case: Transform AND expressions by processing their children
(= (transforms ('AND' $a $b))
    (let* (
            ($left (transforms $a)) ; Transform the left child
            ($right (transforms $b)) ; Transform the right child
        )
    ('AND' $left $right) ; Combine transformed results into AND
)
)

 ; Recursive case: Transform OR expressions by processing their children
(= (transforms ('OR' $a $b))
    (let* (
            ($left (transforms $a)) ; Transform the left child
            ($right (transforms $b)) ; Transform the right child
        )
    ('OR' $left $right) ; Combine transformed results into OR
)
)
