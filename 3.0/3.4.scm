; Exercise 3.3.  Modify the make-account procedure so that it creates password-protected accounts. 
; That is, make-account should take a symbol as an additional argument

(define (make-acc balance password)
  (make-account balance password 0))
  
(define (make-account balance password attempts) 
  (define (call-the-cops x)
    'calling-cops)
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
    (cond ((>= attempts 7) call-the-cops)
          ((and (eq? m 'withdraw) (eq? entered-password password)) (begin (set! attempts 0) withdraw))
	  ((and (eq? m 'deposit) (eq? entered-password password)) (begin (set! attempts 0) deposit))
	  ((eq? entered-password password) (lambda(x) 'wrong-option))
	  (else (begin (set! attempts (+ 1 attempts)) (lambda(x) 'wrong-pass)))))
  dispatch)

;; Usage
(define acc (make-account 500 'password 3))
((acc 'withdraw 'password) 100)
((acc 'deposit 'password) 20)


;; Usage
((acc 'withdraw 'wrong) 200)
((acc 'withdraw 'wrong) 200)
((acc 'withdraw 'wrong) 200)
((acc 'withdraw 'wrong) 200)
((acc 'withdraw 'wrong) 200)
((acc 'withdraw 'wrong) 200)
((acc 'withdraw 'wrong) 200)
((acc 'withdraw 'wrong) 200)



