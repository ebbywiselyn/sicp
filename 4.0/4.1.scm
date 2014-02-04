;;Write a version of list-of-values that evaluates operands from left to right regardless of the order of evaluation in the underlying Lisp. Also write a version of list-of-values that evaluates operands from right to left.

;; given procedure
(define (list-of-values exps env)
  (if (no-operands? exps)
      '()
      (cons (eval (first-operand exps) env)
            (list-of-values (rest-operands exps) env))))
;; 
(define (list-of-values exps env)
  (let ((rest (list-of-values (rest-operands exps) env)))
    (let ((first (first-operand exps)))
      (cons (eval first) rest))))
      
    
    
     

                                             
      
                    
        





      
      
      