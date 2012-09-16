;; Exercise 3.9. In section 1.2.1 we used the substitution model to analyze 
;; two procedures for computing
;; factorials, a recursive version

(define (factorial n)
  (if (=  n 1)
      1
      (* n (factorial (- n 1)))))

(define (factorial n)
  (fact-iter 1 1 n))

(define (fact-iter product counter max-count)
  (if (> counter max-count)
      product
      (fact-iter (* counter product)
                 (+ counter 1)
                 max-count)))


;; (factorial 5) for linear iterative
;; Environments for Iterative factorial n
;; When applying factorial, lookup factorial in the global environment
;; Create enviroment E1, enclosed with global environment where n is bound to 5
;; check binding for fact-iter in E1,
;; check in enclosed global enviroment, if it exists. 
;; Global environment has the parameters product, counter, max-count and the body of fact-iter. 
;; Apply (fact-iter 1 1 n) in E1
;; bind n to 5
;; Changes the environment E1 parameter bindings to the following in every iteration
;; bind parameter product = 1, counter = 1, max-count = 5, after evaluating body
;; bind parameter product = 1, counter = 2, max-count = 5  after evaluating body
;; bind parameter product = 2, counter = 3, max-count = 5 after evaluating body
;; bind parameter product = 6, counter = 4, max-count = 5 after evaluating body
;; bind parameter product = 24, counter = 5, max-count = 5 after evaluating body
;; bind parameter product = 120, counter = 6, max-count = 5 after evaluating body
;; return 120. 


;; (factorial 5) for linear recursive
;; Environments for Recursive factorial n
;; When applying factorial, lookup factorial in the global environment
;; Create environment E1, enclosed with global environment where n is bound to 5
;; check binding for fact-iter in E1, find none
;; checking in enclosed global environment, exists. 
;; body of function is 5*(factorial 4)
;; check binding for factorial in E1, does not exist
;; check in global environment? exists. 
;; Create environment E2 to evaluate factorial 4, 
;; bind x to 4 in E2, 
;; apply 4*factorial(x-1)
;; check binding or factorial in E2, does not exist
;; check in global environment, exists;
;; bind x to 3 in E3, 
;; apply 3*factorial(x-1).
;; Repeat the above till you create enviroment E5. 
;; where x is bound to 1, and on applying the procedure 1 is returned. 
;; I don't know how return propagates back to the calling function. 
;; Assuming returning propagates in the regular way the frames were created. 
;; E4 resume execution and returns 2*factorial(1) = 2
;; E3 resume execution and returns 3*2 = 6
;; E4 resums execution and returns 4*6 = 24
;; E5 resumes exectuion and returns 5*24 = 120


