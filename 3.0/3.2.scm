;; In software-testing applications, it is useful to be able to count the number of times a given procedure is called during the course of a computation. 
;; Write a procedure make-monitored that takes as input a procedure, f, that itself takes one input. 
;; The result returned by make-monitored is a third procedure, say mf, that keeps track of the number of times it has been called by maintaining an internal
;; counter. If the input to mf is the special symbol how-many-calls?, then mf returns the value of the counter. If the input is the special symbol reset-count, 
;; then mf resets the counter to zero. For any other input, mf returns the result of calling f on that input and increments the counter. For instance, we could
;; make a monitored version of the sqrt procedure:

(define (make-m count f)
  (define (inc-counter)
    (set! count (+ 1 count)))
  (define (reset)
    (set! count 0))
  (define (how-many-calls)
    count)
  (define (dispatch msg) 
    (cond ((eq? msg 'reset) (reset))
	  ((eq? msg 'how-many-calls) (how-many-calls))
	  (else (begin (inc-counter) (f msg)))))
  dispatch)
(define (make-monitored f)
  (make-m 0 f))


;;; Usage

(define monitored-square (make-monitored square))
(monitored-square 2) ;; Outputs 4
(monitored-square 3) ;; Outputs 9

(monitored-square 'how-many-calls) ;; Outputs 2