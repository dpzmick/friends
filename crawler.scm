#lang racket
(require eopl)
(require data/queue)

(provide shared-friends)

(define (crawl data name depth)
  (letrec
   ([queue (make-queue)]
    [aux
     (lambda (acc currdepth)
       (if (or (null? queue) (eqv? currdepth (+ 1 depth)))
           acc
         (let*
             ([el (dequeue! queue)])
           (if (eqv? 'depth el)
               (begin
                ; (printf "depth ~n")
                (enqueue! queue 'depth)
                (aux acc (+ 1 currdepth)))

             (let
                 ([found (if (hash-has-key? data el)
                             (hash-ref data el)
                             '())])
               (begin
                (map (lambda (e) (if (set-member? acc e)
                                     ; (printf "ignored ~a~n" el)
                                     '()
                                     (enqueue! queue e))) found)

                (aux (set-union acc (list->set found)) currdepth)))))))])
   (begin
    (enqueue! queue 'depth)
    (enqueue! queue name)
    (aux (set name) 0))))

(define (shared-friends data name1 name2 depth)
  (set-subtract (set-intersect
                  (crawl data name1 depth)
                  (crawl data name2 depth))
                (set name1 name2)))
