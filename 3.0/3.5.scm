; Exercise 3.5.  Monte Carlo integration is a method of estimating definite integrals by means of Monte Carlo simulation. 
; Consider computing the area of a region of space described by a predicate P(x, y) that is true for points (x, y) in the region
; and false for points not in the region. For example, the region contained within a circle of radius 3 centered at (5, 7) is 
; described by the predicate that tests whether (x - 5)2 + (y - 7)2 < 32. To estimate the area of the region described by such a predicate,
; begin by choosing a rectangle that contains the region. For example, a rectangle with diagonally opposite corners at (2, 4) and (8, 10)
; contains the circle above. The desired integral is the area of that portion of the rectangle that lies in the region. 
; We can estimate the integral by picking, at random, points (x,y) that lie in the rectangle, and testing P(x, y) for each point 
; to determine whether the point lies in the region. If we try this with many points, then the fraction of points that fall in 
; the region should give an estimate of the proportion of the rectangle that lies in the region. 
; Hence, multiplying this fraction by the area of the entire rectangle should produce an estimate of the integral.

; Implement Monte Carlo integration as a procedure estimate-integral that takes as arguments a predicate P, 
; upper and lower bounds x1, x2, y1, and y2 for the rectangle, and the number of trials to perform in order to produce the estimate. 
; Your procedure should use the same monte-carlo procedure that was used above to estimate . Use your estimate-integral to produce an 
; estimate of  by measuring the area of a unit circle.

;;fraction-count
(define (fraction-count P x1 y1 x2 y2)
  (lambda () (P (random-in-range x1 x2) 
                (random-in-range y1 y2))))
          

(define (random-in-range low high)
  (let ((range (- high low)))
    (+ low (random range))))

;;;; estimating pi
;;;; area = 9.0
;;;;
(define (estimate-integral P x1 y1 x2 y2 trials) 
  (/ (* (area-of-rect x1 y1 x2 y2) (monte-carlo trials (fraction-count P x1 y1 x2 y2))) 9.0))

(define (area-of-rect x1 y1 x2 y2) 
  (* (- x2 x1) (- y2 y1)))
  
(define (monte-carlo trials experiment)
  (define (iter trials-remaining trials-passed)
    (cond ((= trials-remaining 0)
           (/ trials-passed trials))
          ((experiment)
           (iter (- trials-remaining 1) (+ trials-passed 1)))
          (else
           (iter (- trials-remaining 1) trials-passed))))
  (iter trials 0))

;; Predicate
(define (predicate x y)
  (< (+ (square (- x 5)) (square (- y 7))) (square 3)))
     
      
;;; Usage
;;; Use fractional notation for numbers.
(estimate-integral predicate 2.0 4.0 8.0 10.0 5000)