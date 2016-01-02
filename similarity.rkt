#lang racket/base
(require "calc.rkt"
         "readtotable.rkt")

(define (similarity-between-files file0 file1)
  (let* ([inport0 (open-input-file file0)]
         [inport1 (open-input-file file1)]
         [word-list0 (read-word->list inport0)]
         [word-list1 (read-word->list inport1)]
         [word-table0 (count-list-to-table word-list0)]
         [word-table1 (count-list-to-table word-list1)])
    (let-values ([(arr0 arr1) (extract-arrays (merge-tables word-table0 word-table1))])
      (array-angle-between arr0 arr1))))


(provide similarity-between-files)
