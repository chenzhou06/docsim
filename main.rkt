#!/usr/bin/env racket
#lang racket/base

(require racket/cmdline
         racket/match
         "similarity.rkt")


(define files
  (command-line
    #:program "docsim"
    #:ps "\nCopyright 2016 Chen Zhou"
    #:args (file0 file1)
    (cons file0 file1)))

(define (main)
  (match-let ([(cons file0 file1) files])
    (displayln (similarity-between-files file0 file1))))

(main)

