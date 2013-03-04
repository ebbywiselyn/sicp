;;;;;
;;;;; TODO check for failure cases.
;;;;;
(define (cycle? plist)
  (define (iterate p1 p2)
    (cond ((or (null? p1) (null? p2)) #f)
          ((eq? p1 p2) #t)
          (else (iterate (cdr p1) (cddr p2)))))
  (cond ((null? plist) #f)
        ((not (pair? plist)) #f)
        (else (iterate plist (cddr plist)))))
         

