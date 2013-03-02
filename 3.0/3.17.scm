(define (count-pairs p)
  (if (unvisited-pair? p)
      (let (
            (tmp (+ (count-pairs (car p))
                    (count-pairs (cdr p))
                   1))
            ;; more init
            )
        (begin 
          ((ds 'append) p)
          tmp))
      0))

(define (unvisited-pair? p)
  (if (and (pair? p) 
           (not ((ds 'in-list) p)))
           #t
           #f))
           
(define (append! plist value)
  (cond ((null? value) plist)
        ((not (pair? value)) plist)
        ((eq? (last-pair plist) null?) plist)
        (else (begin 
                (set-cdr! (last-pair plist) value)
                plist))))

(define (last-pair x)
  (cond ((null? x) x)
        ((null? (cdr x)) x)
        (else (last-pair (cdr x)))))
        
(define (in-list? l e)
  (cond ((null? l) #f)
        ((eq? (car l) e) #t)
        (else (in-list? (cdr l) e))))

(define (make-pair-list plist)
  (define (append value)
    (append! plist (list value)))
  (define (in-list value)
    (in-list? plist value))
  (define (dir-plist) plist)
  (define (dispatch m)
    (cond ((eq? m 'append) append)
          ((eq? m 'in-list) in-list)
          ((eq? m 'state) dir-plist)
          (else (error "unknown request -- make-list-pair" m))))
  dispatch)

(define ds (make-pair-list (list (list 'head))))    
(define x (cons 'a ()))
(define z (cons x (cons x ()))) 

;; (count-pairs z) outputs 3

(define x (cons 'a ()))
(define y (cons x x))
(define z (cons y y))

;; (count-pairs z) outputs 3







  