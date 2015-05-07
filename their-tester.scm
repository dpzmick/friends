#lang racket
(require eopl)
(require "parallel-mp6-1.scm")
(require "message-type.scm")

(define the-thing (dynamic-place "tester-place.scm" 'loop))

(thread-send the-recipient (filename-msg "220620.txt"))

(define messages
  (list
   (thread-send the-recipient (query-msg (cons "Name1364" "Name1533") 16  0  the-thing))
   (thread-send the-recipient (query-msg (cons "Name2250" "Name2121") 13  1  the-thing))
   (thread-send the-recipient (query-msg (cons "Name1117" "Name566")  8   2  the-thing))
   (thread-send the-recipient (query-msg (cons "Name221"  "Name1911") 19  3  the-thing))
   (thread-send the-recipient (query-msg (cons "Name2282" "Name1795") 12  4  the-thing))
   (thread-send the-recipient (query-msg (cons "Name550"  "Name1788") 11  5  the-thing))
   (thread-send the-recipient (query-msg (cons "Name2417" "Name2151") 12  6  the-thing))
   (thread-send the-recipient (query-msg (cons "Name691"  "Name1296") 10  7  the-thing))
   (thread-send the-recipient (query-msg (cons "Name626"  "Name2387") 8   8  the-thing))
   (thread-send the-recipient (query-msg (cons "Name1999" "Name1026") 13  9  the-thing))))

(place-channel-get the-thing)
