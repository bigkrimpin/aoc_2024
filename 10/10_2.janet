(defn to-num
  [str]
  (int/to-number (int/s64 str)))

(defn grid-get
  [arr x y]
  (if (and (>= x 0) (>= y 0) (< x (length (arr 0))) (< y (length arr)))
    ((arr y) x)
    nil)
  )

(defn trail-walk
  [arr x y]
  (var trail_score 0)
  (def current (grid-get arr x y))
  (if (= current 9)
    (break 1)
    )
  (if (= (grid-get arr (- x 1) y) (+ current 1))
    (+= trail_score (trail-walk arr (- x 1) y))
    )
  (if (= (grid-get arr (+ x 1) y) (+ current 1))
    (+= trail_score (trail-walk arr (+ x 1) y))
    )
  (if (= (grid-get arr x (- y 1)) (+ current 1))
    (+= trail_score (trail-walk arr x (- y 1)))
    )
  (if (= (grid-get arr x (+ y 1)) (+ current 1))
    (+= trail_score (trail-walk arr x (+ y 1)))
    )
  trail_score
  )

(def grid @[])
(def trailheads @[])
(with [f (file/open "input.txt")]
  (while true
    (def line (file/read f :line))
    (if (= line nil) (break))
    (def current_trailheads (peg/find-all "0" line))
    (each trailhead current_trailheads
      (array/concat trailheads @[[trailhead (length grid)]])
      )
    (array/concat grid [(map to-num (map string/from-bytes (string/trim line)))])))

(pp grid)
(pp trailheads)

(var total_score 0)
(each trailhead trailheads
  (var pos_x (trailhead 0))
  (var pos_y (trailhead 1))
  (var current_num 0)
  (+= total_score (trail-walk grid pos_x pos_y))
  )

(print "Total Score: " total_score)
