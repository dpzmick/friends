#lang racket
(require eopl)
(require racket/string)
(require racket/match)

(provide read-file)

(define (handle-line line acc)
  (match (string-split line ":")
    [(list name remain)
     (let
       ([names (map string-trim (string-split remain))])
       (hash-set! acc (string-trim name) (drop-right names 1)))]))

(define (loop-over-file f acc)
  (let
    ([line (read-line f)])
    (if (eof-object? line)
      acc
      (begin
        (handle-line line acc)
        (loop-over-file f acc)))))

(define (read-file fname)
  (let
    ([f (open-input-file fname)])
    (loop-over-file f (make-hash))))
