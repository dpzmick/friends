#lang racket
(require eopl)
(require "parallel-mp6-1.scm")
(require "message-type.scm")

(define the-thing (dynamic-place "tester-place.scm" 'loop))

(thread-send the-recipient (filename-msg "dataset"))

(define (one)
  (begin
    (define id 1)
    (define level 1)
    (define names (cons "Minas" "Sihan"))
    (thread-send the-recipient (query-msg names level id the-thing))))

(define (two)
  (begin
   (define id 2)
   (define level 2)
   (define names (cons "Minas" "Sihan"))
   (thread-send the-recipient (query-msg names level id the-thing))))

(define (three)
  (begin
   (define id 3)
   (define level 3)
   (define names (cons "Sihan" "Peter"))
   (thread-send the-recipient (query-msg names level id the-thing))))

(one)
(two)
(three)
(place-channel-get the-thing)
