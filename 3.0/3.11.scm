
;; Exercise 3.11.  In section 3.2.3 we saw how the environment model described the behavior of procedures with local state. Now we have seen how internal definitions work. A typical message-passing procedure contains both of these aspects. Consider the bank account procedure of section 3.1.1:

;; (define (make-account balance)
;;   (define (withdraw amount)
;;     (if (>= balance amount)
;;         (begin (set! balance (- balance amount))
;;                balance)
;;         "Insufficient funds"))
;;   (define (deposit amount)
;;     (set! balance (+ balance amount))
;;     balance)
;;   (define (dispatch m)
;;     (cond ((eq? m 'withdraw) withdraw)
;;           ((eq? m 'deposit) deposit)
;;           (else (error "Unknown request -- MAKE-ACCOUNT"
;;                        m))))
;;   dispatch)


;; Show the environment structure generated by the sequence of interactions

;; (define acc (make-account 50))

;; ((acc 'deposit) 40)
;; 90

;; ((acc 'withdraw) 60)
;; 30

;; Where is the local state for acc kept? Suppose we define another account

;; (define acc2 (make-account 100))

;; How are the local states for the two accounts kept distinct? Which parts of the environment structure are shared between acc and acc2?



make-account creates an procedure object, in the global environment, with
parameter:balance
body: (define (withdraw amount)
        rest
        (define (deposit amount)
          rest)
        (define (dispatch m)
          rest))

;;acc1

(define acc (make-account 50)) creates a acc object in the global environment which points to the newly created environment (say E1). 
        
E1 consists of the parameter balance of value 50, with procedure objects deposit and withdraw pointing to the parent procedure object. 

Call to ((acc 'deposit) 40) creates a new environment E2, with amount parameter as 40, and sets the balance in E1 as 90

Call to ((acc 'withdraw) 60) creates a new environment E3, with amount parameter as 60 and sets the balance in E3 as 30

;; acc2

(define acc2 (make-account 100)) creates a acc object in the global environment which points to the newly created environment (say E4). 
      
Local state for account is kept in E2, and E3, balance is shared between the environment E2, and E3 for the account 'acc'. 

The local states for two accounts 'acc' and 'acc2' are kept different by environment E2, E3 created for 'acc' and environments E4, and others created by 'acc2'. 

The procedure object is shared between 'acc' and 'acc2'