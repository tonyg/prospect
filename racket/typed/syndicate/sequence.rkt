#lang turnstile

(provide Sequence
         (for-syntax ~Sequence)
         empty-sequence
         sequence->list
         sequence-length
         sequence-ref
         sequence-tail
         sequence-append
         sequence-map
         sequence-andmap
         sequence-ormap
         sequence-fold
         sequence-count
         sequence-filter
         sequence-add-between
         in-list
         in-set
         in-hash-keys
         in-hash-values
         in-range
         )

(require "core-types.rkt")
(require (only-in "list.rkt" List))
(require (only-in "set.rkt" Set))
(require (only-in "hash.rkt" Hash))
(require (only-in "prim.rkt" Int Bool))
#;(require (postfix-in - racket/sequence))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Sequences
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define-container-type Sequence #:arity = 1)

(require/typed racket/sequence
  [empty-sequence : (Sequence (U))]
  [sequence->list : (∀ (X) (→fn (Sequence X) (List X)))]
  [sequence-length : (∀ (X) (→fn (Sequence X) Int))]
  [sequence-ref : (∀ (X) (→fn (Sequence X) Int Int))]
  [sequence-tail : (∀ (X) (→fn (Sequence X) Int (Sequence X)))]
  [sequence-append : (∀ (X) (→fn (Sequence X) (Sequence X) (Sequence X)))]
  [sequence-map : (∀ (A B) (→fn (→fn A B) (Sequence A) (Sequence B)))]
  [sequence-andmap : (∀ (X) (→fn (→fn X Bool) (Sequence X) Bool))]
  [sequence-ormap : (∀ (X) (→fn (→fn X Bool) (Sequence X) Bool))]
  ;; sequence-for-each omitted until a better accounting of effects (TODO)
  [sequence-fold : (∀ (A B) (→fn (→fn A B A) (Sequence B) A))]
  [sequence-count : (∀ (X) (→fn (→fn X Bool) (Sequence X) Int))]
  [sequence-filter : (∀ (X) (→fn (→fn X Bool) (Sequence X) (Sequence X)))]
  [sequence-add-between : (∀ (X) (→fn (Sequence X) X (Sequence X)))])

(require/typed racket/base
  [in-list : (∀ (X) (→fn (List X) (Sequence X)))]
  [in-hash-keys : (∀ (K V) (→fn (Hash K V) (Sequence K)))]
  [in-hash-values : (∀ (K V) (→fn (Hash K V) (Sequence V)))]
  [in-range : (→fn Int (Sequence Int))])
(require/typed racket/set
  [in-set : (∀ (X) (→fn (Set X) (Sequence X)))])
