;Exercise 3.13.  Consider the following make-cycle procedure, which uses the last-pair procedure defined in exercise 3.12:


;;; last-pair
(define (last-pair x) 
  (if (null? (cdr x))
         x
         (last-pair (cdr x))))

;;; make-cycle
(define (make-cycle x)
  (set-cdr! (last-pair x) x)
  x)

;;; z
(define z (make-cycle (list 'a 'b 'c)))

;;; last-pair z
;(last-pair z)

;; Box and pointer Representation

;;; x -> (a . (b . (c . '())))
;;; (make-cycle x) -> (a. (b. (c . (a . (b . (c . (a . (b . (c ...)))))))))
;;; Infinite list




