#lang racket
(require eopl)
(require "message-type.scm")
(require "taskman.scm")
(require "taskman-message-type.scm")
(require "worker.scm")
(require "file-reader.scm")
(require "crawler.scm")

(provide the-recipient)

(define (loop the-file)
  (begin
   ; (printf "looping~n")
   (cases message-type (thread-receive)
          (query-msg (names depth id reply-to)
                     (let
                         ([work
                            (task
                              (car names)
                              (cdr names)
                              depth
                              the-file
                              reply-to
                              id)])
                       (begin
                        (taskman-send-work work)
                        (loop the-file))))

          (filename-msg (filename)
                        (loop (read-file filename)))

          (response-msg (id res)
                        (printf "error~n")))))


; create and add some workers to our task manager
(define garbage
  (map (lambda (w) (taskman-add-worker w))
       (list
        (make-worker)
        (make-worker)
        (make-worker)
        (make-worker)
        (make-worker)
        (make-worker)
        (make-worker)
        (make-worker))))

; start up the recipient thread
(define the-recipient
  (thread (lambda () (loop 'undefined))))
