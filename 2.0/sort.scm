;; wishful thinkig
(define (inc x) (+ x 1))
(define (dec x) (- x 1))

(define (switch lst x y)
  (define (iter items count)
     (cond ((null? (cdr items)) items)
	   ((= count x) (cons 
			 (elem-at lst y) 
			 (iter (cdr items) (inc count))))
	   ((= count y) (cons 
			 (elem-at lst x)
			 (iter (cdr items) (inc count))))
	   (else (cons (car items) 
		       (iter (cdr items) (inc count))))))
  (iter lst 1))

(define (elem-at lst pos)
  (define (iter lst count)
    (cond ((null? lst) -1)
	  ((= count pos) (car lst))
	  (else (iter (cdr lst) (inc count)))))
  (iter lst 1))


(define (partition items p r)
  (define (iter x i j)
    (cond ((> j (dec r))
	      (let ((z (switch items (inc i) r)))
		(inc i)))
	  ((<= (elem-at items j) x)
	   (let (((z (switch items (inc i) j)))
		 (iter x (inc i) (inc j)))))
	  (else (iter x (inc i) (inc j))))))
(iter (elem-at items r) (- p 1) p))

(define (quick-sort items p r)
  (if (< p r)
      (let ((q (partition items p r)))
	(quick-sort items p (dec q))
	(quick-sort items (inc q) r))
	items))

(partition (list 5 1 6 2 7 3) 1 6) 


(quick-sort (list 5 1 6 2 7 3) 0 5)









