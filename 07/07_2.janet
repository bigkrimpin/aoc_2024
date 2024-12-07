(defn to-num
  [str]
  (int/to-number (int/s64 str)))

(def equations @[])
(with [f (file/open "input.txt")]
  (while true
    (def line (file/read f :line))
    (if (= line nil) (break))
    (def line (string/split ":" line))
    (array/concat equations @[[(to-num (line 0)) (map to-num (string/split " " (string/trim (line 1))))]])))

(var total 0)
(each equation equations
  (print (equation 0))
  (var equation_good false)
  (for i 0 (math/pow 4 (- (length (equation 1)) 1))
    (prompt :top
            (var result_current_attempt ((equation 1) 0))
            (for n 1 (length (equation 1))
              (case (band (brshift i (* 2 (- n 1))) 3)
                0 (set result_current_attempt
                       (to-num (string/format "%d%d" result_current_attempt ((equation 1) n))))
                1 (*= result_current_attempt ((equation 1) n))
                2 (+= result_current_attempt ((equation 1) n))
                (return :top)))
            (if (= result_current_attempt (equation 0))
              (do
                (set equation_good true)
                (return :top))))
    (if equation_good (break)))
  (if equation_good
    (do
      (+= total (equation 0)))))

(print "Total: " total)
