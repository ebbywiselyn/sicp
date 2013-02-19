;;; (expressions (x) )

;;; procedure which returns itself
(define (foo x) x)

;; (procedure which operates on a procedure)
;; list operations

(define (repeat-proc proc iter no)
  (if (= iter 0)
      no
      (proc (repeat-proc proc (- iter 1) no))))

;; meta list of 4
(repeat-proc 
 (lambda (x) (list x)) 4 5)

;; walk thru the list back 
(define x 
  (repeat-proc 
   (lambda (x) (list x)) 4 5))

(repeat-proc 
 (lambda (x) (car x)) 4 x)









