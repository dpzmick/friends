#lang racket
(require eopl)
(require racket/future)
(require "taskman-message-type.scm")

(provide make-worker)

(define (make-place) (dynamic-place "place-worker.scm" 'loop))

(define (make-worker) (thread (lambda () (loop (make-place)))))

(define (send-place-work worker work)
  (place-channel-put worker work))

(define (work-helper work channel)
  (cases work-task work
         (task (name1 name2 depth data to-who id)
               (begin
                 (place-channel-put channel (list data name1 name2 depth to-who id))
                 (place-channel-get channel)))))

(define (loop channel)
  (begin
   (cases worker-message (thread-receive)
          (do-work (manager work)
                   (begin
                     (work-helper work channel)
                     (thread-send manager (task-done (current-thread))))))
   (loop channel)))
