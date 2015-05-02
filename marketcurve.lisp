(declaim (optimize (speed 0) (safety 3) (debug 3)))

;;;;
;;;; Create a Mark Curve store and retieveing system, with formula feature
;;;;

(defpackage :market-curve
  (:use :common-lisp)
  (:export :new-scale
	   :add-scale
	   :load-curve
	   :new-manual-curve
	   :first-scale-point
	   :last-scale-point
	   :valid-scale-point
	   :prev-scale-point
	   :next-scale-point))

(in-package :market-curve)

;;;
;;; Global variables
;;;
(defvar *market-curve* nil)
(defvar *curve-scales* nil)


;;;
;;; Scales
;;;
(defun new-scale (name sequence)
  (list :name name :seq sequence))
  
(defun add-scale (scale)
  (push scale *curve-scales*))

(defun first-scale-point (scale)
  (first (getf scale :seq)))

(defun last-scale-point (scale)
  (first (last (getf scale :seq))))

(defun valid-scale-point (scale point)
  (numberp (position point (getf scale :seq))))

(defun prev-scale-point (scale point)
  (let* ((scale-seq (getf scale :seq))
	(pos (position point scale-seq)))
    (and pos
	 (> pos 0)
	 (nth (- pos 1) scale-seq))))

(defun next-scale-point (scale point)
  (let* ((scale-seq (getf scale :seq))
	(pos (position point scale-seq)))
    (and pos
	 (nth (+ pos 1) scale-seq))))


;;;
;;; Curves Operation
;;;
(defun load-curve (name)
  "Load indiviual curve by name"
  (remove-if-not
   #'(lambda (curve) (equal (getf curve :name) name))
   *market-curve*))


(defun new-manual-curve (name scale start-point end-point)
  (list :name name :scale scale :start-point start-point :end-point end-point))


