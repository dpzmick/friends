#lang racket
(require eopl)
(require "taskman-message-type.scm")
(require "taskman.scm")
(require "worker.scm")

(define (fib n)
  (if (<= n 2)
    1
    (+ (fib (- n 1)) (fib (- n 2)))))

(define (work)
  (let
    ([f (fib 50)])
  (printf "done: ~a~n" f)))

(define (send-work limit i)
  (if (eqv? i limit)
    '()
    (begin
      #| (printf "sending work~n") |#
      (thread-send the-taskman
                   (do-task work))
      (send-work limit (+ 1 i)))))

; should see four cores in use at a time
(define the-workers (list (make-worker) (make-worker) (make-worker) (make-worker)))

(map (lambda (w) (thread-send the-taskman (add-worker w))) the-workers)
(send-work 5 0)
(sleep 100)
