#lang racket/base


(define (make-table-updator word-table)
  (lambda (word)
    (let ([origin (hash-ref! word-table word 0)])
      (hash-update! word-table word add1))))

(provide make-table-updator)
