;It is useful to be able to reset a random-number generator to produce a sequence starting from a given value. Design a new rand procedure that is called with an argument that is either the symbol generate or the symbol reset and behaves as follows: (rand 'generate) produces a new random number; ((rand 'reset) <new-value>) resets the internal state variable to the designated <new-value>. Thus, by resetting the state, one can generate repeatable sequences. These are very handy to have when testing and debugging programs that use random numbers.

;; Problem faced. 

;; (define rand (let ((x 0)) (lambda () (set! x (+ x 1)))))
;; applies let once when rand is evaluated , and is assigned
;; to lambda, when rand is called again n again, lambda is getting
;; called again and again and NOT so rand should be a state inside
;; which keeps getting called again n again


(define rand (let ((x 0)) 
               (lambda () (set! x (+ x 1)))))

(define random (let ((r 0))
                 (lambda (msg)
                   (cond ((eq? msg 'generate) (rand))
                         ((eq? msg 'reset) (lambda (val)
                                             (set! rand (let ((x val))
                                                          (lambda () (set! x (+ x 1)))))))))))

        
  