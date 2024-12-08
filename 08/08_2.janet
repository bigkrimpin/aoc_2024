
(def grid @[])
(def antennas @{})
(with [f (file/open "input.txt")]
  (while true
    (def line (file/read f :line))
    (if (= line nil) (break))
    (def current_antennas (peg/find-all :w line))
    (each antenna current_antennas
      (if (= (get antennas (string/from-bytes (line antenna))) nil)
        (put antennas (string/from-bytes (line antenna)) @[])
        )
      (array/concat (antennas (string/from-bytes (line antenna))) @[[antenna (length grid)]])
      )
    (array/concat grid (string/trim line))))
(def grid_width (length (grid 0)))
(def grid_height (length grid))

(def antinodes @[])
(loop [[antenna locations] :in (pairs antennas)]
  (each node locations
    (if (= (find-index |(= $ [(node 0) (node 1)]) antinodes) nil)
      (array/concat antinodes @[[(node 0) (node 1)]])
      )
    (each other_node locations
      (if (not (= node other_node))
        (do
          (def difference_x (- (other_node 0) (node 0)))
          (def difference_y (- (other_node 1) (node 1)))
          (var antinode_x (- (node 0) difference_x))
          (var antinode_y (- (node 1) difference_y))
          (while (and (>= antinode_x 0) (>= antinode_y 0) (< antinode_x grid_width) (< antinode_y grid_height))
            (if (= (find-index |(= $ [antinode_x antinode_y]) antinodes) nil)
              (array/concat antinodes @[[antinode_x antinode_y]])
              )
            (-= antinode_x difference_x)
            (-= antinode_y difference_y)
            )
          )
        )
      )
    )
  )

(for y 0 grid_height
  (for x 0 grid_width
    (if (= (find-index |(= $ [x y]) antinodes) nil)
      (prin (string/from-bytes ((grid y) x)))
      (prin "#")
      )
    )
  (print)
  )
(print "Anti-Nodes:" (length antinodes))
