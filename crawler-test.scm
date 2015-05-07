#lang racket
(require eopl)
(require "crawler.scm")
(require "file-reader.scm")

(define the-data (read-file "dataset"))

(set-empty? (set-subtract
              (shared-friends the-data "Minas" "Sihan" 1)
              (set "Steven")))

(set-empty? (set-subtract
              (shared-friends the-data "Minas" "Sihan" 2)
              (set "Steven" "Mario" "Peter" "Alex")))

(set-empty? (set-subtract
              (shared-friends the-data "Sinah" "Peter" 3)
              (set "Minas" "Steven" "Mario" "Alex" "John")))
