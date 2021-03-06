; Exercise 3.3.  Modify the make-account procedure so that it creates password-protected accounts. 
; That is, make-account should take a symbol as an additional argument

(define (make-account balance password) 
  (define (withdraw amount)
    (if (<= amount balance)
	(begin (set! balance (- balance amount))
	       balance)
	"insufficient balance"))
  (define (deposit amount)
    (if (> amount 0)
	(begin (set! balance (+ balance amount))
	       balance)
	"Insufficient funds"))
  (define (dispatch m entered-password)
    (cond ((and (eq? m 'withdraw) (eq? entered-password password)) withdraw)
	  ((and (eq? m 'deposit) (eq? entered-password password)) deposit)
	  (else (lambda (x) 'wrong-pass))))
  dispatch)


;; Usage
(define acc (make-account 500 'pass))
((acc 'withdraw 'pass) 100)
