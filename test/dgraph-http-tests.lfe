(defmodule dgraph-http-tests
  (behaviour ltest-unit)
  (export all))

(include-lib "ltest/include/ltest-macros.lfe")
(include-lib "include/http.lfe")

;;; -----------
;;; Tests
;;; -----------

(deftest one-header
  (let ((req (dgraph-http:add-header (make-request) #"Content-Type" #"application/json")))
    (is-equal '(#(#"Content-Type" #"application/json"))
              (request-headers req))))

(deftest multiple-headers
  (let ((req (dgraph-http:add-header
              (make-request headers '(#(#"A" #"B")
                                      #(#"C" #"D")))
              #"Content-Type" #"application/json")))
    (is-equal '(#(#"Content-Type" #"application/json")
                #(#"A" #"B")
                #(#"C" #"D"))
              (request-headers req))))

(deftest payload-data
  (let ((payload (dgraph-http:payload #"bytes" #"")))
    (is-equal #"bytes"
              payload)))

(deftest payload-file
  (let ((payload (dgraph-http:payload #"" #"priv/testing/movies.rdf")))
    (is-equal 1577
              (size payload))))
