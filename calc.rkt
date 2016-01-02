#lang racket/base
(require racket/math
         math/array)

(define (array-norm arr)
  (sqrt (array-all-sum (array-sqr arr))))

(define (array-mean arr)
  (/ (array-all-sum arr) (array-count (lambda (a) #t) arr)))

(define (array-inner-product arr0 arr1)
  (array-all-sum (array-map (lambda (a b)
                              (* a b))
                            arr0 arr1)))

(define (array-angle-between arr0 arr1)
  (let ([inner-product (array-inner-product arr0 arr1)]
        [product-of-norm (* (array-norm arr0) (array-norm arr1))])
    (radians->degrees (acos (/ inner-product product-of-norm)))))

(provide array-mean
         array-norm
         array-inner-product
         array-angle-between)

