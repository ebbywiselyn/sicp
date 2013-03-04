; Exercise 3.22.  Instead of representing a queue as a pair of pointers, we can build a queue as a procedure with local state. The local state will consist of pointers to the beginning and the end of an ordinary list. Thus, the make-queue procedure will have the form

; (define (make-queue)
;  (let ((front-ptr ...)
;        (rear-ptr ...))
;    <definitions of internal procedures>
;    (define (dispatch m) ...)
;    dispatch))

; Complete the definition of make-queue and provide implementations of the queue operations using this representation.

(define (make-queue)
  (let ((front-ptr '())
        (rear-ptr '()))
  (define (empty-queue?)
    (null? front-ptr))
  (define (front-queue item)
    (bkpt)
    (if (empty-queue)
        (error "empty queue" '())
        (car (front-ptr))))
  (define (insert-queue! item)
    (let ((new-pair (cons item '())))
      (cond ((empty-queue?)
             (set! front-ptr new-pair)
             (set! rear-ptr new-pair))
            (else
             (set-cdr! rear-ptr new-pair)
             (set! rear-ptr new-pair)))))
  (define (delete-queue!)
    (cond ((empty-queue?)
           (error "empty queue" '()))
          (else
           (set! front-ptr (cdr front-ptr)))))
  (define (print-queue)
    (begin
      (display front-ptr)))
  (define (dispatch signal)
    (cond ((eq? signal 'insert-queue!) 
           insert-queue!)
          ((eq? signal 'delete-queue!)
           delete-queue!)
          ((eq? signal 'print-queue)
           print-queue)
          ((eq? signal 'front-queue)
           front-queue)))
  dispatch))

(define q (make-queue))
