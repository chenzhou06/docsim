#!/usr/bin/env racket
#lang racket/base

(require rackunit
         racket/math
         math/array)
(require "wordcount.rkt"
         "readtotable.rkt"
         "calc.rkt")

(test-case
  "Test word counter"
  (let* ([word-table (make-hash (list (cons "apple" 1)
                                      (cons "banana" 2)
                                      (cons "cherry" 10)))]
        [fruit-counter (make-table-updator word-table)])
    (fruit-counter "apple")
    (fruit-counter "banana")
    (fruit-counter "chicken")
    (check-equal? (hash-ref word-table "apple") 2)
    (check-equal? (hash-ref word-table "banana") 3)
    (check-equal? (hash-ref word-table "chicken") 1)
    (check-equal? (hash-ref word-table "cherry") 10)
    (fruit-counter "apple")
    (check-equal? (hash-ref word-table "apple") 3)))


(test-case
  "Test read word"
  (let ([inport (open-input-string "hello world\tbaby\nyeah\n\tcool! !!")]
        [inportutf (open-input-string "你好，世界！ hello world")])
    (check-equal? (read-word->list inport)
                  (list "cool" "yeah" "baby" "world" "hello"))
    (check-equal? (read-word->list inportutf)
                  (list "world" "hello" "世界" "你好"))))

(test-case
  "Test read to table"
  (let* ([word-list-simple (list "apple" "banana" "cherry")]
         [word-list (list "huge" "big" "large" "long" "wide" "small" "huge" "huge" "long" "long" "long" "long")]
         [table-1 (count-list-to-table word-list-simple)]
         [table-2 (count-list-to-table word-list)]
         [table-2-expect (make-hash (list (cons "huge" 3)
                                    (cons "big" 1)
                                    (cons "large" 1)
                                    (cons "long" 5)
                                    (cons "wide" 1)
                                    (cons "small" 1)))]
         [table-1-expect (make-hash (list (cons "apple" 1)
                                    (cons "banana" 1)
                                    (cons "cherry" 1)))])
    (check-pred hash-equal? table-1 table-1-expect)
    (check-pred hash-equal? table-2 table-2-expect)))

(define word-table1 (make-hash (list (cons "apple" 1)
                                     (cons "banana" 2)
                                     (cons "cherry" 10))))

(define word-table2 (make-hash (list (cons "banana" 3)
                                     (cons "apple" 3)
                                     (cons "bear" 1)
                                     (cons "blackcherry" 3))))

(test-case
  "Test merge-tables, extract-arrays"
  (let ([expect (make-hash (list (cons "apple" (cons 1 3))
                                 (cons "banana" (cons 2 3))
                                 (cons "bear" (cons 0 1))
                                 (cons "blackcherry" (cons 0 3))
                                 (cons "cherry" (cons 10 0))))]
        [actual (merge-tables word-table1 word-table2)])
    (check-pred hash-equal? expect actual)
    (let-values ([(expect-array1 expect-array2) (extract-arrays expect)]
                 [(actual-array1 actual-array2) (extract-arrays actual)])
      (check-equal? expect-array1 actual-array1)
      (check-equal? expect-array2 actual-array2))))

(test-case
 "Test array-norm"
 (let ([arr1 (array #[1])]
       [arr2 (array #[3 3])]
       [arr3 (array #[3 4])])
   (check-equal? (array-norm arr1) 1)
   (check-equal? (array-norm arr2) (sqrt 18))
   (check-equal? (array-norm arr3) 5)))

(test-case
"Test array-mean"
(let ([arr (array #[2 4 6])])
  (check-equal? (array-mean arr) 4)))

(test-case
  "Test array-inner-product"
  (let ([arr1 (array #[3 2 1 2 9])]
        [arr2 (array #[2 3 9 2 9])])
    (check-equal? (array-inner-product arr1 arr2) 106)))

(test-case
  "Test array-angle-between"
  (let ([arr1 (array #[0 0 1])]
        [arr2 (array #[0 1 0])])
    (check-equal? (array-angle-between arr1 arr2) (/ pi 2))))

