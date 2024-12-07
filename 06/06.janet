(defn get-grid-pos
  [arr x y]
  (if (and (>= x 0) (< x (length (arr 0))) (>= y 0) (< y (length arr)))
    (string/from-bytes ((arr y) x))
    nil))

(defn walk-grid
  [g start_x start_y]
  (var pos_x start_x)
  (var pos_y start_y)
  (var direction :up)
  (def visited @[])
  (var i 0)
  (while (< i 10000)
    #(print "X: " pos_x " Y: " pos_y)
    (if (= (get-grid-pos g pos_x pos_y) nil)
      (break))

    (if (= (find-index |(= $ [pos_x pos_y]) visited) nil)
      (array/concat visited @[[pos_x pos_y]]))

    (case direction
      :up (if (= (get-grid-pos g pos_x (- pos_y 1)) "#")
            (set direction :right)
            (-- pos_y ))
      :right (if (= (get-grid-pos g (+ pos_x 1) pos_y) "#")
               (set direction :down)
               (++ pos_x ))
      :down (if (= (get-grid-pos g pos_x (+ pos_y 1)) "#")
              (set direction :left)
              (++ pos_y))
      :left (if (= (get-grid-pos g (- pos_x 1) pos_y) "#")
              (set direction :up)
              (-- pos_x ))
      (error "invalid direction"))
    (++ i))
  [(< i 10000) visited])

(var initial_x 0)
(var initial_y 0)
(def grid @[])
(with [f (file/open "input.txt")]
  (while true
    (def line (file/read f :line))
    (if (= line nil) (break))
    (if (def x (peg/find "^" line))
      (do
        (set initial_x x)
        (set initial_y (length grid))))
    (array/concat grid (string/trim line))))

(def result (walk-grid grid initial_x initial_y))
(def visited (result 1))
(array/remove visited 0)

(var total 0)
(var step 1)
(each visit visited
  (prin step "/" (length visited))
  (print "    " (visit 0) " " (visit 1))
  (++ step)
  (def barrier_x (visit 0))
  (def barrier_y (visit 1))
  (def old_strip (grid barrier_y))
  (var new_strip "")
  (for i 0 (length old_strip)
    (if (= i barrier_x)
      (set new_strip (string/join [new_strip "#"]))
      (set new_strip (string/join [new_strip (string/from-bytes(old_strip i))]))))
  (put grid barrier_y new_strip)
  (def tested_grid (walk-grid grid initial_x initial_y))
  (if (= (tested_grid 0) false)
    (++ total))
  (put grid barrier_y old_strip))
(print "Total Visited: " (length (result 1)))
(print "Barrier positions: " total)
