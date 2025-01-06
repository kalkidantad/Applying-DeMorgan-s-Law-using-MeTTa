 ; Define the transformation for boolean expressions using De Morgan's laws
(: transform (-> (Expr $t) (Expr $t)))

 ; Base case: Leaves (constants or variables) remain unchanged
(= (transform $leaf) $leaf)

 ; Simplify double negation: NOT (NOT A) → A
(= (transform ('NOT' ('NOT' $a))) (transform $a))

 ; Apply gDe Morgan's laws: NOT (AND A B) → OR (NOT A) (NOT B)
(= (transform ('NOT' ('AND' $a $b)))
    ('OR' (transform ('NOT' $a)) (transform ('NOT' $b))))

 ; Apply De Morgan's laws: NOT (OR A B) → AND (NOT A) (NOT B)
(= (transform ('NOT' ('OR' $a $b)))
    ('AND' (transform ('NOT' $a)) (transform ('NOT' $b))))

 ; Recursive case: Transform AND and OR expressions by processing their children
(= (transform ('AND' $a $b))
    ('AND' (transform $a) (transform $b)))

(= (transform ('OR' $a $b))
    ('OR' (transform $a) (transform $b)))

 ; Unary NOT: Push NOT down if no De Morgan's law applies
(= (transform ('NOT' $a))
    ('NOT' (transform $a)))

! (transform ('NOT' ('AND' 'x1' 'x2'))) ; ('OR' ('NOT' 'x1') ('NOT' 'x2'))
