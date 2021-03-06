;; Exercise 3.12.  The following procedure for appending lists was introduced in section 2.2.1:

(define (append x y)
  (if (null? x)
      y
      (cons (car x) (append (cdr x) y))))

;; Append forms a new list by successively consing the elements of x onto y. 
;; The procedure append! is similar to append, but it is a mutator rather than a constructor. 
;; It appends the lists by splicing them together, modifying the final pair of x so that its cdr is now y. 
;; (It is an error to call append! with an empty x.)

(define (append! x y)
  (set-cdr! (last-pair x) y)
  x)

; Here last-pair is a procedure that returns the last pair in its argument:

(define (last-pair x)
  (if (null? (cdr x))
      x
      (last-pair (cdr x))))

;; Consider the interaction

(define x (list 'a 'b))
(define y (list 'c 'd))
;;(define z (append x y))
;; z
;; (a b c d)
;; (cdr x)
;; <response>
(define w (append! x y))
;; w
;; (a b c d)
;; (cdr x)
;; <response>

;; What are the missing <response>s? Draw box-and-pointer diagrams to explain your answer.

;; Answer
;; The missing response are (b) and (b c d)
;; (x -> (list 'a 'b))
;; (append x y) -> (a b c d)
;; With (x -> (a b))
;; and  (y -> (c d)) 
;; So (cdr x) -> (b)
;; 
;; (append! x y -> (a b c d))
; With (x -> ('a 'b 'c 'd))
;; and (y -> ('c 'd))
;; Hence (cdr x) -> (b c d)