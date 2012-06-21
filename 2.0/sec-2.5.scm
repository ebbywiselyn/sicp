;;
;; existing 
(define (type-tag datum)
  (if (pair? datum)
      (car datum)
      (error "Bad tagged data..")))


;; redefining type-tag to handle scheme numbers
;; without scheme-number tag 
;; using number? 

(define (rd-type-tag datum)
  (cond ((number? datum) 'scheme-number)
	((pair? datum) (car datum))
	(else (error "Bad tagged data"))))
;;existing      
(define (contents datum)
  (if (pair? datum)
      (cdr datum)
      (error "bad tagged datum..")))

(define (rd-contents datum)
  (cond ((number? datum) datum)
	((pair? datum) (cdr datum))
	(else (error "Bad tagged data"))))

(define b (cons 'data (cons 5 ())))
(rd-contents b)

(define (attach-tag type-tag contents)
  (cons type-tag contents))



;; generic equality
(define (eq-real-imag? x y) (and (= (real-part x) (real-part y))
				 (= (imag-part x) (imag-part y))))
								
(define (eq-mag-pol? x y) (and (= (mag x) (mag y))
			       (= (ang x) (ang y))))

(define (eq-rational? x y) (and (= (denom x) (denom y))
				(= (numer x) (numer y))))
;;(define (= x y)) inbuilt

;;;;;;;;;;;;;;;

(define (equ z)
  (apply-generic 'equ z))


(define (equ-complex? z)
  (if (eq? (tag z) 'rectangular)
      (equ-rect z)
      (equ-polar z)))

;;;;;;;;;;;;;;

(put 'equ '(complex) equ-complex)
(put 'equ '(rational) eq-rational?)



