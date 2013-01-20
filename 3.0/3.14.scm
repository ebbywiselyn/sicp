;; Exercise 3.14.  The following procedure is quite useful, although obscure:

(define (mystery x)
  (define (loop x y)
    (if (null? x)
        y
        (let ((temp (cdr x)))
          (set-cdr! x y)
          (loop temp x))))
  (loop x '()))

;; Loop uses the ``temporary'' variable temp to hold the old value of the cdr of x, 
;; since the set-cdr! on the next line destroys the cdr. Explain what mystery does in general. 
;; Suppose v is defined by (define v (list 'a 'b 'c 'd)). Draw the box-and-pointer diagram that
;; represents the list to which v is bound. Suppose that we now evaluate (define w (mystery v)). 
;; Draw box-and-pointer diagrams that show the structures v and w after evaluating this expression. 
;; What would be printed as the values of v and w ?

(define v (list 'a 'b 'c 'd))
(define w (mystery v)) 

;;;; Initilization 
;;;; v -> [a][]->[b][]->[c][]->[d][]->null
;;;; w (mystery v);

;;;; recursive iteration 0
;;;; x -> [a][] -> [b][] -> [c][] -> [d][] -> [][]
;;;; y -> [][]
;;;; tmp [b][] -> [c][] -> [d][] -> [][]
;;;; x -> [a][] -> [][] 
;;;; loop(tmp, x)

;;;; recursive iteration 1
;;;; x -> [b][] -> [c][] -> [d][] -> [][]
;;;; y -> [a][]
;;;; tmp -> [c][] -> [d][] -> [][]
;;;; x -> [b][] -> [a][] -> [][]
;;;; loop(tmp, x)

;;;; recursive iteration 2
;;;; x -> [c][] -> [d][] -> [][]
;;;; y -> [b][] -> [a][] -> [][]
;;;; tmp -> [d][] -> [][]
;;;; x -> [c][] -> [b][] -> [a][] -> [][]
;;;; loop(tmp, x)

;;;; recursive iteration 3
;;;; x -> [d][] -> [][]
;;;; y -> [c][] -> [b][] -> [a][] -> [][]
;;;; tmp -> [][]
;;;; x -> [d][] -> [c][] -> [b][] -> [a][] -> [][]
;;;; loop(tmp, x)

;;;; recursive iteration 4
;;;; x -> [][]
;;;; return [d][] -> [c][] -> [b][] -> [a][] -> [][]

;;;; v -> [a][] -> [][]
;;;; w -> [d][] -> [c][] -> [b][] -> [a][] -> [][]

