;;Consider the bank account objects created by make-account, with the password
;;modification described in exercise 3.3. Suppose that our banking system requires the ability to make joint
;;accounts. Define a procedure make-joint that accomplishes this. Make-joint should take three
;;arguments. The first is a password-protected account. The second argument must match the password with
;;which the account was defined in order for the make-joint operation to proceed. The third argument is
;;a new password. Make-joint is to create an additional access to the original account using the new
;;password. For example, if peter-acc is a bank account with password open-sesame, then
;;
;; (define paul-acc
;;  (make-joint peter-acc 'open-sesame 'rosebud))
;;
;;will allow one to make transactions on peter-acc using the name paul-acc and the password
;;rosebud. You may wish to modify your solution to exercise 3.3 to accommodate this new feature.

(define (make-account balance pass1)
  (make-acc balance pass1 pass1))

(define (make-acc balance pass1 pass2)
  (define (check-password p1) 
    (eq? p1 pass1))
  (define (set-joint-pass p2)
    (set! pass2 p2))
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
  (define (dispatch m e-pass)
    (cond ((and (eq? m 'withdraw) (or (eq? e-pass pass1) (eq? e-pass pass2))) withdraw)
          ((and (eq? m 'deposit) (or (eq? e-pass pass1) (eq? e-pass pass2))) deposit)
          ((eq? m 'check-password) (check-password e-pass))
          ((eq? m 'set-joint-pass) set-joint-pass)
          (else (lambda (x) 'wrong-pass))))
  (set! pass2 pass1)
  dispatch)

(define (make-join acc pass1 pass2)
  (cond ((acc 'check-password pass1) 
         (begin ((acc 'set-joint-pass pass1) pass2)
                acc))
        (else ("Wrong password"))))


;; Usage
(define alysa-hacker (make-account 500 'nopeek))
;; alysa uses her account
((alysa-hacker 'withdraw 'nopeek) 50)
;; Joint account
(define eval-vator (make-join alysa-hacker 'nopeek 'peek))
;;Sir eval uses his account
((eval-vator 'withdraw 'peek) 5)
    