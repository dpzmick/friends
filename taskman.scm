#lang racket
(require eopl)
(require data/queue)
(require "taskman-message-type.scm")

(provide the-taskman taskman-send-work taskman-add-worker)

(define (taskman-send-work work)
  (thread-send the-taskman (do-task work)))

(define (taskman-add-worker worker)
  (thread-send the-taskman (add-worker worker)))

(struct state ([all-workers #:mutable] [idle-workers] [tasks]))

; checks if anyone is availiable to run new work, if there is someone,
; dequeue some work and let let them run
(define (schedule my-state)
  (begin
   (if
       (and
        (not (eqv? 0 (queue-length (state-idle-workers my-state))))
        (not (eqv? 0 (queue-length (state-tasks        my-state)))))
       (let
           ([worker (dequeue! (state-idle-workers my-state))]
            [task   (dequeue! (state-tasks        my-state))])
           (thread-send worker (do-work (current-thread) task)))
     '())))

(define (add-worker! my-state worker)
  (begin
    (set-state-all-workers! my-state (cons worker (state-all-workers  my-state)))
    (task-has-finished! my-state worker)))

(define (add-task! my-state task)
  (begin
    (enqueue! (state-tasks my-state) task)))

(define (task-has-finished! my-state from-who)
    (enqueue! (state-idle-workers my-state) from-who))

(define (loop my-state)
  (begin
    (cases taskman-message (thread-receive)
           (add-worker (worker)
                       (add-worker! my-state worker))

           (do-task (task)
                    (add-task! my-state task))

           (task-done (from-who)
                      (task-has-finished! my-state from-who)))

    (schedule my-state)
    (loop my-state)))

(define the-taskman (thread (lambda () (loop (state '() (make-queue) (make-queue))))))
