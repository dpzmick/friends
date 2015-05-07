#lang racket
(require eopl)
(require racket/match)
(require "taskman-message-type.scm")
(require "crawler.scm")

; would have liked to have hidden any underlying details of the work being done
; from the task manager system, but you can't pass functions into places

(provide loop)

(define (loopaux channel count)
  (begin
    (match (place-channel-get channel)
      [
       (list 'response-message res)
       (printf "~a : ~a~n" (car res) (cdr res))])
       ; (printf "~a~n" (car res))])
    (if (eqv? count 10)
      (place-channel-put channel 'done)
      (loopaux channel (+ count 1)))))

(define (loop channel) (loopaux channel 1))
