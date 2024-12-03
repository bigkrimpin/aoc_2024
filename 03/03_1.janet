(def mul-peg
  '{:main (sequence "mul(" (capture :d+) "," (capture :d+) ")")})

(def lines @[])
(with [f (file/open "input.txt")]
  (while true
    (def line (file/read f :line))
    (if (= line nil)
      (break))
    (array/concat lines (string/trim line))))

(var result 0)
(each line lines
  (def indexes (peg/find-all mul-peg line))
  (each i indexes
    (def val (peg/match mul-peg line i))
    (+= result (* (int/to-number (int/s64 (val 0))) (int/to-number (int/s64 (val 1)))))))
(print result)
