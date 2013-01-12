;;; TODO not completed

;;; Exercise 3.17.  Devise a correct version of the count-pairs procedure of exercise 3.16 that returns the number of distinct pairs 
;;; in any structure. (Hint: Traverse the structure, maintaining an auxiliary data structure that is used to keep track of which pairs
;;;  have already been counted.)

(define (append! plist value)
  (set-cdr! (last-pair plist) value)
  plist)

(define (last-pair x)
  (if (null? (cdr x))
      x
      (last-pair (cdr x))))

(define (in-list? l e)
  (cond ((null? l) #f)
        ((eq? (cdr l) e) #t)
        (else (in-list? (cdr l) e))))

(define (make-pair-list plist)
  (define (append value)
    (append! plist value))
  (define (in-list value)
    (in-list? plist value))
  (define (dir-plist) plist)
  (define (dispatch m)
    (cond ((eq? m 'append) append)
          ((eq? m 'in-list) in-list)
          ((eq? m 'state) dir-plist)
          (else (error "unknown request -- make-list-pair"
                       m))))
  dispatch)

(define pair-list (make-pair-list (list 'head)))