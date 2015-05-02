(declaim (optimize (speed 0) (safety 3) (debug 3)))

;;;;
;;;; Tests for Marketbus
;;;;

(defpackage :market-curve-test
  (:use :common-lisp
	:market-curve
	:lisp-unit))

(in-package :market-curve-test)


;;; Global variables

;;;
;;; Tests
;;;

(define-test test-integer-scale
  (let ((scale (new-scale "~a" '(1 2 3 4 5))))
    (assert-equal t   (valid-scale-point scale 1))
    (assert-equal nil (valid-scale-point scale 9))
    (assert-equal nil (valid-scale-point scale "a"))
    (assert-equal 3   (prev-scale-point scale 4))
    (assert-equal 2   (next-scale-point scale 1))
    (assert-equal 1   (first-scale-point scale))
    (assert-equal 5   (last-scale-point scale))
    (assert-equal nil (prev-scale-point scale 1))
    (assert-equal nil (next-scale-point scale 5))))

(define-test test-symbol-scale
  (let ((scale (new-scale "~a" '(F G H J K M N Q U V X Z))))
    (assert-equal t   (valid-scale-point scale 'F))
    (assert-equal nil (valid-scale-point scale 9))
    (assert-equal nil (valid-scale-point scale "a"))
    (assert-equal 'F  (prev-scale-point scale 'G))
    (assert-equal 'X  (next-scale-point scale 'V))
    (assert-equal 'F  (first-scale-point scale))
    (assert-equal 'Z  (last-scale-point scale))
    (assert-equal nil (prev-scale-point scale 'F))
    (assert-equal nil (next-scale-point scale 'Z))))

(define-test test-2-level-symbol-scale)
(let ((scale (new-scale "??"
			'(F G H J K M N Q U V X Z)
			'(10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25)))
    (assert-equal t   (valid-scale-point scale 'F))
    (assert-equal nil (valid-scale-point scale 9))
    (assert-equal nil (valid-scale-point scale "a"))
    (assert-equal 'F  (prev-scale-point scale 'G))
    (assert-equal 'X  (next-scale-point scale 'V))
    (assert-equal 'F  (first-scale-point scale))
    (assert-equal 'Z  (last-scale-point scale))
    (assert-equal nil (prev-scale-point scale 'F))
    (assert-equal nil (next-scale-point scale 'Z))))
  
;;;
;;; Run all test
;;;
(run-tests :all)

