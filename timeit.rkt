#!/usr/bin/env racket
#lang racket/base
(require "similarity.rkt")

(time (similarity-between-files "file0.txt" "file1.txt"))
