#lang racket
(require eopl)
(require racket/place)

(provide (all-defined-out))

(define-datatype work-task work-task?
                 (task
                   (name1 string?)
                   (name2 string?)
                   (depth number?)
                   (data hash?)
                   (after place-channel?)
                   (id number?)))

(define-datatype taskman-message taskman-message?
                 (add-worker
                   (worker thread?))

                 (do-task
                   (task work-task?))

                 (task-done
                   (who thread?)))

(define-datatype worker-message worker-message?
                 (do-work
                   (manager thread?)
                   (work work-task?)))
