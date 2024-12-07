(defn to-num
  [str]
  (int/to-number (int/s64 str)))

(def equations @[])
(with [f (file/open "input.txt")]
  (while true
    (def line (file/read f :line))
    (if (= line nil) (break))
    (def line (string/split ":" line))
    (array/concat equations @[[(to-num (line 0)) (map to-num (string/split " " (string/trim (line 1))))]])
    ))

(var total 0)
(each equation equations
  (var equation_good false)
  (for i 0 (math/exp2 (- (length (equation 1)) 1))
    (var result_current_attempt ((equation 1) 0))
    (prin (equation 0) "\t" ((equation 1) 0))
    (for n 1 (length (equation 1))
      (if (= (band (brshift i (- n 1)) 1) 1)
        (do
          (*= result_current_attempt ((equation 1) n))
          (prin "*" ((equation 1) n))
          )
        (do
          (+= result_current_attempt ((equation 1) n))
          (prin "+" ((equation 1) n))
          )
        )
      )
    (if (= result_current_attempt (equation 0))
      (do
        (set equation_good true)
        (print " correct!")
        (break)
        )
      (print)
      )
    )
  (if equation_good (+= total (equation 0)))
  )
(print "Total: " total)
