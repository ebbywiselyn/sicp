(eq? 'a 'a)
(define (memq item x)
  (cond ((null? x) #f)
	((eq? item (car x)) x)
	(else (memq item (cdr x)))))

(define (equal? list1 list2)
  (cond ((and (null? list1) (null? list2)) #t)
	((or (null? list1) (null? list2)) #f)
	((and (pair? (car list1)) (pair? (car list2)))
	 (equal? (car list1) (car list2)))
	((eq? (car list1) (car list2))
	 (equal? (cdr list1) (cdr list2)))
	(else #f)))

;; improved equal? 
(define (equal? list1 list2)
  (cond ((and (null? list1) (null? list2)) #t)
	((and (pair? list1) (pair? list2))
	 (and (equal? (car list1) (car list2))
	      (equal? (cdr list1) (cdr list2))))
	((or (pair? list1) (pair? list2)) #f)
	((or (null? list1) (null? list2)) #f)
	(else (eq? list1 list2))))

;; optimised equal? 
(define (equal? list1 list2)
  (cond ((and (null? list1) (null? list2)) #t)
	((and (pair? list1) (pair? list2))
	 (and (equal? (car list1) (car list2))
	      (equal? (cdr list1) (cdr list2))))
	((eq? list1 list2) #t)
	(else #f)))

(define (equal? list1 list2)
  (cond ((and (pair? list1) (pair? list2))
	 (and (equal? (car list1) (car list2))
	      (equal? (cdr list1) (cdr list2))))
	((and (null? list1) (null? list2) #f))
	((eq? list1 list2) #t)
	(else #f)))
	      
(equal? '(a b (c a)) '(a b (c a)))
(equal? '(a b c) '(a b c))
(equal? '(a b c) '(a b))
(cddr '(a b (c a)))
(memq 'a '(a b c))
(memq 'f '(a b c))
(memq 'red '(red shoes blue socks))
(list '+ 4 5)

;; derivation
(define (variable? x)
  (symbol? x))

(define (same-variable? x y)
  (and (symbol? x) (symbol? y) (eq? x y)))

(define (sum? x)
  (and (pair? x) (eq? (car x) '+)))

(define (addend s) (cadr s))
(define (augend s)
  (if (not (null? (cdddr s)))
      (append (list '+) (cddr s))
      (caddr s)))

(augend '(+ a b c))

;; fix augend everything else is fine. 

(define (product? x)
  (and (pair? x) (eq? (car x) '*)))

(define (multiplier p) (cadr p))
(define (multiplicand p)
  (if (not (null? (cdddr p)))
      (append (list '*) (cddr p))
      (caddr p)))

;; if numbers then add to product
;; else append to product
(define (make-sum a1 a2)
     (cond ((=number? a1 0) a2)
	  ((=number? a2 0) a1)
	  ((and (number? a1) (number? a2)) (+ a1 a2))
	  (else (list '+ a1 a2))))

(define (negate no)
  (cond ((number? no) (- 0 no))
	(else (list '-no))))

(define (make-diff a1 a2)
  (cond ((=number? a1 0) (negate a2))
	((=number? a2 0) a1)
	((and (number? a1) (number? a2)) (- a1 a2))
	(else (list '- a1 a2))))

(define (=number? exp num)
  (and (number? exp) (= exp num)))

(define (make-product m1 m2)
  (cond ((or (=number? m1 0) (=number? m2 0)) 0)
	((=number? m1 1) m2)
	((=number? m2 1) m1)
	((and (number? m1) (number? m2)) (* m1 m2))
	(else (list '* m1 m2))))

(define (pow base exponent)
  (define (iter product count)
    (if (= count exponent)
	product
	(iter (* product base) (+ count 1))))
  (iter base 1))

(define (make-exponent base exponent)
  (cond ((and (number? exponent) (= exponent 1)) base)
	((and (number? base) (= base 1)) 1)
	((and (number? exponent) (= exponent 0)) 1)
	((and (number? base) (= base 0)) 0)
	((and (number? base) (number? exponent)) (pow base exponent))
	(else (list '** base exponent))))

(define (base-val exp)
  (cadr exp))

(define (expo-val exp)
  (caddr exp))

(define (exponent? exp)
  (eq? (car exp) '**))

(define (deriv exp var)
  (cond ((number? exp) 0)
	((variable? exp) 
	 (if (same-variable? exp var) 1 0))
	((sum? exp)
	 (make-sum (deriv (addend exp) var)
		   (deriv (augend exp) var)))
	((product? exp)
	 (make-sum
	  (make-product (multiplier exp)
			(deriv (multiplicand exp) var))
	  (make-product (deriv (multiplier exp) var)
			(multiplicand exp))))
	((exponent? exp)
	 (make-sum
	  (make-product (expo-val exp)
			(make-exponent (base-val exp)
				       (make-diff (expo-val exp) 1)))
	  (deriv (base-val exp) var)))))
	  


(define expr '(** x y))

(deriv '(+ x 3) 'x)
(deriv '(+ x x x x) 'x)
(deriv '(* x y z) 'x)
(deriv '(* (* x  y) (+ x 3)) 'x)
(deriv '(* (** x y) 5) 'x)
(deriv '(* x y (+ x 3)) 'x)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define (same-variable? x y)
  (and (symbol? x) (symbol? y) (eq? x y)))

(define (deriv exp var)
  (cond ((number? exp) 0)
	((symbol? exp)
	 (if (same-variable? exp var) 1 0))
	 ((sum? exp)
	  (make-sum (deriv (addend exp) var)
		    (deriv (augend exp) var)))
	 ((product? exp)
	  (make-sum
	   (make-product (multiplier exp)
			 (deriv (multiplicand exp) var))
	   (make-product (deriv (multiplier exp) var)
			 (multiplicand exp))))))

(define (make-sum a1 a2)
  (cond ((and (number? a1) (number? a2)) 
	 (+ a1 a2))
	(else (list a1 '+ a2))))
(define (addend expr)
  (car expr))
(define (augend expr)
  (caddr expr))
(define (multiplier expr)
  (car expr))
(define (multiplicand expr)
  (caddr expr))
(define (make-product a1 a2)
  (cond ((and (number? a1) (number? a2))
	 (* a1 a2))
	(else (list a1 '* a2))))
(define (sum? expr)
  (and (pair? expr) (eq? (cadr expr) '+)))

z(define (product? expr)
  (and (pair? expr) (eq? (cadr expr) '*)))

(deriv '(x + 1) 'x)
(deriv '(x + x) 'x)
(deriv '(x + (x * x)) 'x)
(deriv '(x + 3 * (x + y + 2)) 'x)

;;; exer 2.58-b
(define (augend exp)
  (if (not (null? (cdddr exp)))
      (cddr exp)
      (caddr exp)))

(deriv '(x + 3 + x + y + 2) 'x)
(multiplicand '(3 * x + y + 2))

(sum? '(x + 3 * x + y + 2))

;;;;;;;;;;;;;;;;;;

;; exer 2.59
;; union-set


(define (element-of-set? elem set)
  (cond ((null? set) false)
	((equal? elem (car set)) true)
	(else (element-of-set? elem (cdr set)))))

(define (union-set set1 set2)
  (cond ((or (null? set1) (null? set2)) set2)
	((not (element-of-set? (car set1) set2))
	 (cons (car set1) (union-set (cdr set1) set2)))
	(else (union-set (cdr set1) set2))))
	 
; o_n_2
(union-set (list 2 2 3 3 4 4 5 5) (list 3 4 5 6 7 8 9))

(define (element-of-set elem set)
  (cond ((null? set) ())
	((< elem  (car set)) false)
	((= elem (car set)) true)
	(else (element-of-set elem (cdr set)))))
	

(define (adjoin elem set)
  (if (element-of-set? elem set)
      set
      (cons elem set)))

;; o_n implementation of union sets

(define (union-set set1 set2)
  (cond ((null? set1) set2)
	((null? set2) set1)
	((= (car set1) (car set2))
	 (cons (car set1) (union-set (cdr set1) (cdr set2))))
	((< (car set1) (car set2))
	 (cons (car set1) (union-set (cdr set1) set2)))
	(else
	 (cons (car set2) (union-set set1 (cdr set2))))))
	 

(define (adjoin set elem)
  (cond ((null? (cdr set)) ())
	((= elem (car set)) set)
	((> elem (car set)) (cons (car set) (adjoin (cdr set) elem)))
	((< elem (car set)) (cons elem set))))

(adjoin (list 1 2 3 4 6 7 8 9) 0)

(union-set (list 3 5 7 9) (list 4 6 8 9))

(define (union-set-from-tree set-tree1 set-tree2)
  (let ((tree1 (tree->list-1 set-tree1))
	(tree2 (tree->list-1 set-tree2))
	)(union-set tree1 tree2)))

(list->tree 
 (union-set-from-tree 
  (make-tree 5 
             (make-tree 1 () ()) 
             (make-tree 3 () ()))
  (make-tree 7
             (make-tree 2 () ())
             (make-tree 4 () ()))
  ))

;; tree
(define (make-tree entry left right) 
  (list entry left right))

(define (entry tree) (car tree))
(define (left-branch tree) (cadr tree))
(define (right-branch tree) (caddr tree))

(define (tree->list-1 tree)
  (if (null? tree)
      '()
      (append (tree->list-1 (left-branch tree))
	      (cons (entry tree)
		    (tree->list-1 (right-branch tree))))))

;;;
(define (list->tree elements)
  (car (partial-tree elements (length elements))))

(define (partial-tree elts n)
  (if (= n 0)
      (cons '() elts)
      (let ((left-size (quotient (- n 1) 2)))
        (let ((left-result (partial-tree elts left-size)))
          (let ((left-tree (car left-result))
                (non-left-elts (cdr left-result))
                (right-size (- n (+ left-size 1))))
            (let ((this-entry (car non-left-elts))
                  (right-result (partial-tree (cdr non-left-elts)
                                              right-size)))
              (let ((right-tree (car right-result))
                    (remaining-elts (cdr right-result)))
                (cons (make-tree this-entry left-tree right-tree)
                      remaining-elts))))))))

  
(list->tree (list 1 3 5 7 9 11))


(define (key record)
  (car record))

(define (lookup-tree given-key set-of-rec)
  (cond ((null? set-of-rec) false)
	((= given-key (key (entry set-of-rec))) set-of-rec)
	((< given-key (key (entry set-of-rec))) 
	 (lookup-tree given-key (left-branch set-of-rec)))
	((> given-key (key (entry set-of-rec)))
	 (lookup-tree given-key (right-branch set-of-rec)))))
		    

(define r1 (cons 1 'a))
(define r2 (cons 2 'b))
(define r3 (cons 3 'c))
(define r4 (cons 4 'd))
(define r5 (cons 5 'e))
(define r6 (cons 6 'f))


(list->tree (list 1 2 3 4 5 6))
(define db_record (list->tree (list r1 r2 r3 r4 r5 r6)))
(lookup-tree 8 db_record)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; huffman encoding and decoding

(define (make-leaf symbol weight)
  (list 'leaf symbol weight))
(define (leaf? object)
  (eq? (car object) 'leaf))
(define (symbol-leaf x) (cadr x))
(define (weight-leaf x) (caddr x))
(define (make-code-tree left right)
  (list left
	right
	(append (symbols left) (symbols right))
	(+ (weight left) (weight right))))
(define (left-branch tree) (car tree))
(define (right-branch tree) (cadr tree))
(define (symbols tree)
  (if (leaf? tree)
      (list (symbol-leaf tree))
      (caddr tree)))
(define (weight tree)
  (if (leaf? tree)
      (weight-leaf tree)
      (cadddr tree)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Decode ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (decode bits tree)
  (define (decode-1 bits current-branch)
    (if (null? bits)
	'()
	(let ((next-branch
	       (choose-branch (car bits) current-branch)))
	  (if (leaf? next-branch)
	      (cons (symbol-leaf next-branch)
		    (decode-1 (cdr bits) tree))
	      (decode-1 (cdr bits) next-branch)))))
  (decode-1 bits tree))
(define (choose-branch bit branch)
  (cond ((= bit 0) (left-branch branch))
	((= bit 1) (right-branch branch))
	(else (error "asdf" bit))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Misc ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define (adjoin-set x set)
  (cond ((null? set) (list x))
	((< (weight x) (weight (car set))) (cons x set))
	(else (cons (car set)
		    (adjoin-set x (cdr set))))))

(define (make-leaf-set pairs)
  (if (null? pairs)
      '()
      (let ((pair (car pairs)))
	(adjoin-set (make-leaf (car pair);symbol
			       (cadr pair));freq
		    (make-leaf-set (cdr pairs))))))
		  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Encode ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define (encode message tree)
  (if (null? message)
      '()
      (append (encode-symbol (car message) tree)
	      (encode (cdr message) tree))))

(define (encode-symbol message tree)
  (define (traverse tree code)
    (cond ((null? tree) '())
	  ((and (leaf? tree) 
		(eq? message (symbol-leaf tree)))
	   code)
	  ((leaf? tree) ())	  
	  (else (append (traverse (left-branch tree) (append code (list 0)))
			(traverse (right-branch tree) (append code (list 1)))))))
  (traverse tree ()))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Huffman Generate ;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (generate-huffman-tree pairs)
  (succ-merge (make-leaf-set pairs)))

(define (succ-merge pairs)
  (cond ((null? (cdr pairs)) (car pairs))
	((= (weight (car pairs)) (weight (cadr pairs)))
	 (succ-merge (adjoin-set (make-code-tree (car pairs)
					    (cadr pairs))
			    (cddr pairs))))
	(else
	 (succ-merge (adjoin-set (make-code-tree (car pairs)
					    (cadr pairs))
			    (cddr pairs))))))

define (succ-merge pairs)
  (if (null? (cdr pairs))
      (car pairs)
      (succ-merge (adjoin-set (make-code-tree (car pairs)
					      (cadr pairs))
			      (cddr pairs)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; test ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(make-code-tree (make-leaf 'A 4)
		(make-code-tree
		 (make-leaf 'B 2)
		 (make-code-tree (make-leaf 'D 1)
				 (make-leaf 'C 1))))


;;test huffman
(define sample-tree (generate-huffman-tree '((A 4) (B 2) (D 1) (C 1))))
(define rock-song-tree (generate-huffman-tree '((NA 16) (YIP 9) (SHA 3) (WAH 1)
							(A 2) (BOOM 1) (GET 2) (JOB 2))))
(define rock-song-bits (encode '(SHA NA NA NA NA NA NA NA NA) rock-song-tree))
(define rock-song-bits (encode '(get a job) rock-song-tree))

(decode rock-song-bits rock-song-tree)
(encode '(job) rock-song-tree)


  















