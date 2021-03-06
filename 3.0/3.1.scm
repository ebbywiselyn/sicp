; Exercise 3.1.  An accumulator is a procedure that is called repeatedly with a single numeric argument and accumulates its arguments into a sum. 
; Each time it is called, it returns the currently accumulated sum. 
; Write a procedure make-accumulator that generates accumulators, each maintaining an independent sum. 
; The input to make-accumulator should specify the initial value of the sum; for example


(define (make-accumulator initsum)
  (accumulator initsum))
(define (accumulator sum)
  (lambda (count)
    (set! sum (+ count sum))
  sum))

;;Usage
(define A (make-accumulator 5))
(A 10)
(A 10)
