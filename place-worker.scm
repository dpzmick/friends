#lang racket
(require eopl)
(require racket/match)
(require "crawler.scm")

(provide loop)

(define (loop channel)
    (match (place-channel-get channel)
      [(list data name1 name2 depth to-who id)

       (begin
         (place-channel-put to-who
                            (list 'response-message
                                  (cons
                                    id
                                    (set->list (shared-friends data name1 name2 depth)))))
         (place-channel-put channel 'done)
         (loop channel))]))
