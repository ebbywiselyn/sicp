(define (make-from-mag-ang x y)
  (define (dispatch op)
    (cond ((eq? op 'magnitude) x)
	  ((eq? op 'angle) y)
	  ((eq? op 'real-part) 
	   (* x (cos y)))
	  ((eq? op 'imag-part)
	   (* x (sin y)))))
  dispatch)


(define (apply-dipatch arg op)
  (op arg))


((make-from-mag-ang 5 2) 'imag-part)


;; message passing for operations
;; data directed for types. 
;; data directed = based on the type of data (tagged data)
;; message passing = based ont he type of operation. 	  
    