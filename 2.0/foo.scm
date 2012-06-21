(define (filter proc seq)
  (define (iter seq)
    (cond ((null? seq) ())
	  ((proc (car seq)) 
	   (cons (car seq) 
		 (iter (cdr seq))))
	  (else (iter (cdr seq)))))
  (iter seq))

(filter pair? (list 1 2 pair? 5 6))



(define (enum-interval a n)
  (define (iter count)
    (if (> count n)
	()
	(cons count (iter (+ count 1)))))
  (iter a))

(define (flatmap proc seq)
  (accumulate append () (map proc seq)))
  
(define (accumulate op init seq)
  (cond ((null? seq) init)
	(else (op (car seq) (accumulate op init (cdr seq))))))

(define (uniq-pairs n)
  (flatmap (lambda (i) 
	     (map 
	      (lambda(j) (list j i))
	      (enum-interval 1 (- i 1))))
	   (enum-interval 1 n)))

(define (-uniq-3-pairs n)
  (flatmap (lambda (i) 
	 (map 
	  (lambda (j) (cons j i))
	  (enum-interval 1 (- (car i) 1))))
	   (uniq-pairs n)))

(define (uniq-3-pairs n no)
  (filter 
   (lambda (x) 
     (let ((a (car x)) (b (cadr x)) (c (caddr x)))
       (= (+ a b c) no)))
	  (-uniq-3-pairs n)))

(uniq-3-pairs 7 2)

;; 7-queen's problem 

(define (queens board-size)
  (define (queen-cols k)
    (if (= k 0)
	(list empty-board)
	(filter

	 ()

	 (flatmap
	  
	  (lambda (rest-of-queens)
	    (map (lambda (new-row)
		   (adjoin-position new-row k rest-of-queens))
		 (enumerate-interval 1 board-size)))

	  (queen-cols (- k 1)))))

  (queen-cols board-size))
	  
	    

;; part 1
(define (queen-cols k)
  (if (= k 0)
      (list (list 0 0) (list 0 0) (list 0 0) (list 0 0))
      (flatmap 
       (lambda (rest-of-queens)
	       (map (lambda (new-row)
		      (adjoin-position new-row k rest-of-queens))
		      (enum-interval 1 7)))
       (queen-cols (- k 1)))))

(define (element-at pos seq)
  (define (iter count seq)
    (if (= count pos)
	(car seq)
	(iter (+ 1 count) (cdr seq))))
  (iter 1 seq))

(define (safe? k seq)
  (define (iter count row seq)
    (cond ((null? (cdr seq)) #t)
	  ((check-if-mate? k row count (car seq)) #f)
	  (else (iter (+ count 1) row (cdr seq)))))
  (iter 1 (element-at k seq) seq))
	  
(safe? 3 (list 1 4 5))

;; (1, 2, 3, 5) is passed to filter which calls this method. 
;; col is 4
;; row is inserted value 5 
;; elem-queen(1, 2, 3) shud not be equal to row


(define (check-if-mate? col row pos elem-queen)
  (let ((base (- col pos)))
	(cond ((= (+ base 1) row) #t)
	      ((= (- base 1) row) #t)
	      ((= elem-queen row) #t)
	      (else #f))))


(define (insert-at-list pos elem seq)
  (define (iter count seq)
    (cond  ((null? seq) ())
	   ((= count pos) (cons elem 
				(iter (+ count 1) (cdr seq))))
	   (else (cons (car seq)
		       (iter (+ count 1) (cdr seq))))))
  (iter 0 seq))


(insert-at-list 5 2 (list 1 2 3 4 5 6))

;;; test for check 

(define (segment-painters list-seg)
  (lambda (frame)
    (for-each
     (lambda (seg)
       (draw-line 
	((frame-coord-map frame) (start-seg seg))
	((frame-coord-map frame) (end-seg seg))))
       )
     list-seg)))

;; specify points for a smile

list of line segments
;-  -
; \/

(define eye1-start (make-vect 0 1))
(define eye1-end (make-vect 0.3 1))
(define eye2-start (make-vect 0.7 1))
(define eye2-end (make-vect 1 1))
(define mouth1-st (make-vect 0.5 0))
(define mouth1-end (make-vect 0.4 0.5))
(define mouth2-st (make-vect 0.5 0))
(define mouth2-end (make-vect 0.4 0.5))


(define eye-seg1 (make-seg eye1-start eye1-end))
(define eye-seg2 (make-seg eye2-start eye2-end))
(define eye-

;;; 

; soln 2.52 - b

(define (corner-split painter n)
  (if (= n 0)
      painter
      (let ((up (up-split painter (- n 1)))
	    (right (right-split painter (- n 1))))
	(let ((corner (corner-split painter (- n 1))))
	  (beside (below painter up)
		  (below right corner))))))


;; square-limit using a square-of-four

(define (square-limit painter n)
  (let (z (square-of-four flip-horiz identity flip-vert identity flip-vert)))
  (z (square-limit painter n)))

(define (square-limit painter n)
  (let (combine (identity flip-horiz flip-vert identity)))
  (z (square-limit painter n)))

 

;;;;;;;; recursive jot
;;;;;;;; to get output a b c d e f g f e d c b a
;;;;;;;;;;;;;;;;;;;;;; a b c d e f   f e d c b a
;;;;;;;;;;;;;;;;;;;;;; a b c d e       e d c b a
;;;;;;;;;;;;;;;;;;;;;; a b c d           d c b a 
;;;;;;;;;;;;;;;;;;;;;; a b c               c b a
;;;;;;;;;;;;;;;;;;;;;; a b                   b a
;;;;;;;;;;;;;;;;;;;;;; a                       a
;; outer recurse using immutable list
;; inner recurse - print using muted list. 


;; Strip the last valid item and replace it with a '*
(define (strip items)
  (if (null? items)
      ()
      (if (or (null? (cdr items)) (eq? '* (cadr items)))
	  (cons '* (strip (cdr items)))
	  (cons (car items) (strip (cdr items))))))

(define (inner-iter items)
  (cond ((null? items) ())
	(#t (let ((z (display (car items))))
	      (cons (car-and-print items) (inner-iter (cdr items)))))))

;; Outer print loop  
(define (print-pattern iter-items mut-item)
  (cond ((null? iter-items) ())
	(#t (let ((z (newline)))
	      (print-pattern (cdr iter-items) (strip (inner-iter mut-item)))))))
	  
;; utils
(define (newline-ret z)
  (let ((y (newline)))
    z))
(define (disp-and-ret z)
  (let ((y (display z)))
    z))
(define (cons-and-print x y)
  (disp-and-ret (cons x y)))
(define (car-and-print x)
  (disp-and-ret (car x))) 
(define (cdr-and-print x)
  (disp-and-ret (cdr x)))




















