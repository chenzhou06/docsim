#lang racket/base
(require racket/set
         math/array
         racket/match
         "wordcount.rkt")


(define (read-word->list in-ports)
  (define (helper char word word-list)
    (cond
      [(eof-object? char) (if (eq? word '())
                            word-list
                            (cons (list->string (reverse word)) word-list))]
      [(char-alphabetic? char) (helper (read-char in-ports)
                                       (cons char word)
                                       word-list)]
      [else (helper (read-char in-ports)
                    '()
                    (if (eq? word '())
                      word-list
                      (cons (list->string (reverse word)) word-list)))]))
  (helper (read-char in-ports) '() '()))

(define (count-list-to-table word-list)
  (let*([word-table (make-hash)]
        [updator (make-table-updator word-table)])
    (define (iter word-list)
      (if (eq? word-list '())
        word-table
        (begin (updator (car word-list))
               (iter (cdr word-list)))))
    (iter word-list)))

(define (merge-tables table1 table2)
  (let* ([table1-keys (hash-keys table1)]
         [table2-keys (hash-keys table2)]
         [all-keys (set-union (list->set table1-keys)
                              (list->set table2-keys))]
         [table-out (make-hash)])
    (define (merge table1 table2)
      (lambda (key)
        (hash-set! table-out key (cons (hash-ref table1 key 0)
                                       (hash-ref table2 key 0)))))
    (set-for-each all-keys (merge table1 table2))
    table-out))

(define (extract-arrays table)
  (define (unzip/values list-of-pairs)
    (match list-of-pairs
      ['() (values '() '())]
      [(cons (cons a b) tail)
       (define-values (a-tail b-tail) (unzip/values tail))
       (values (cons a a-tail) (cons b b-tail))]))
  (let-values ([(list-a list-b) (unzip/values (hash-values table))])
    (values (list->array list-a) (list->array list-b))))


(provide read-word->list
         count-list-to-table
         merge-tables
         extract-arrays)
