(list 4 (list 3 (list 2 1)))


(cons 1 (cons 2 (list 3 4)))
(cons 1 (cons 2 (cons 3 (cons 4 ()))))

(cons (list 1 2) (list 3 4))
(append (list 1 2) (list 3 4))


(cons 2 ())

(cons (list 1 2) (list 3 4))

(define x (list 1 3 (list 5 7) 9))

(cdr x)


(define x (cons (cons 7 ()) ()))
(car (car x))

(cons 1 (cons (cons 6 7) ()))


(cons 1 (cons 2 ( cons 3 ())))

(cons 3 (cons (cons 1 (cons (cons 3 (cons 4 ())) ())) ()))




(define lot (cons 1 (cons (cons 2 (cons (cons 3 (cons (cons 4 (cons (cons 5 (cons (cons 6 (cons 7 ())) ())) ())) ())) ())) ())))

(cons 1 (cons 2 (cons 3 (cons 4 ()))))


(cdr (car (cdr (car (cdr (car (cdr (car (cdr (car (cdr lot)))))))))))

(define x (list 1 2 3))
(define y (list 4 5 6))

(append x y)
(cons x y)
(list x y)


(cons (cons 1 (cons 2 (cons 3 ()))) (cons 6 (cons 7 (cons 8 ()))))

;; exercise 2.27

(reverse (list (list 1 2 3) (list 4 5 6)))


(define (reverse items)
  (cond ((null? items) ())
	((not (pair? items)) items)
	(else (append (reverse (cdr items)) (list (car items))))))
	
	
	   
(cons (cons 1 (cons 2 (cons 3 ())) ()) (cons (cons 4 (cons 5 (cons 6 ()))) ())




