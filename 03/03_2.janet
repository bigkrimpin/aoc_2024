(def mul-peg
  '{:main (sequence "mul(" (capture :d+) "," (capture :d+) ")")})

(def lines @[])
(with [f (file/open "input.txt")]
  (while true
    (def line (file/read f :line))
    (if (= line nil)
      (break))
    (array/concat lines (string/trim line))))
(def data (string/join lines))

(var result 0)

(var index_mul (peg/find mul-peg data))
(var index_do (peg/find "do()" data))
(var index_dont (peg/find "don't()" data))
(while index_mul
  (if (< index_mul index_dont)
    (do
      (def val (peg/match mul-peg data index_mul))
      (+= result (* (int/to-number (int/s64 (val 0))) (int/to-number (int/s64 (val 1)))))
      (set index_mul (peg/find mul-peg data (+ index_mul 1)))
      )
    (do
      (set index_do (peg/find "do()" data index_dont))
      (set index_dont (peg/find "don't()" data index_do))
      (set index_mul (peg/find mul-peg data index_do))
      (if (= index_dont nil)
        (set index_dont (length data))
        )
      )
    )
  )
(print result)
