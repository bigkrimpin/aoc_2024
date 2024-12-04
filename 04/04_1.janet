(defn gridcheck
  [data x y char]
  (= (string/from-bytes ((data y) x)) char))

(def data @[])
(with [f (file/open "input.txt")]
  (while true
    (def line (file/read f :line))
    (if (= line nil) (break))
    (array/join data @[(string/trim line)])
    )
  )

(each line data
  (each char line
    (prin (string/from-bytes char))
    )
  (print)
  )

(print)

(def width (length (data 0)))
(def height (length data))

(var total 0)

(for y 0 (length data)
  (for x 0 (length (data 0))
    (if (gridcheck data x y "X")
      (do
        #(print x " " y)
        (prin "X")
        # Before midpoint
        (if (>= (- x 3) 0)
          (if (and (gridcheck data (- x 1) y "M") (gridcheck data (- x 2) y "A") (gridcheck data (- x 3) y "S"))
            (++ total))
          )
        # After midpoint
        (if (< (+ x 3) width)
          (if (and (gridcheck data (+ x 1) y "M") (gridcheck data (+ x 2) y "A") (gridcheck data (+ x 3) y "S"))
            (++ total))
          )
        # Above midpoint
        (if (>= (- y 3) 0)
          (if (and (gridcheck data x (- y 1) "M") (gridcheck data x (- y 2) "A") (gridcheck data x (- y 3) "S"))
            (++ total))
          )
        # Below midpoint
        (if (< (+ y 3) height)
          (if (and (gridcheck data x (+ y 1) "M") (gridcheck data x (+ y 2) "A") (gridcheck data x (+ y 3) "S"))
            (++ total))
          )

        ## Before-above midpoint
        (if (and (>= (- x 3) 0) (>= (- y 3) 0))
          (if (and (gridcheck data (- x 1) (- y 1) "M") (gridcheck data (- x 2) (- y 2) "A") (gridcheck data (- x 3) (- y 3) "S"))
            (++ total))
          )
        ## Before-below midpoint
        (if (and (>= (- x 3) 0) (< (+ y 3) height))
          (if (and (gridcheck data (- x 1) (+ y 1) "M") (gridcheck data (- x 2) (+ y 2) "A") (gridcheck data (- x 3) (+ y 3) "S"))
            (++ total))
          )
        ## After-above midpoint
        (if (and (>= (- y 3) 0) (< (+ x 3) width))
            (if (and (gridcheck data (+ x 1) (- y 1) "M") (gridcheck data (+ x 2) (- y 2) "A") (gridcheck data (+ x 3) (- y 3) "S"))
              (++ total))
          )
        # After-below midpoint
        (if (and (< (+ y 3) height) (< (+ x 3) width))
          (if (and (gridcheck data (+ x 1) (+ y 1) "M") (gridcheck data (+ x 2) (+ y 2) "A") (gridcheck data (+ x 3) (+ y 3) "S"))
            (++ total))
          )
        )
      (prin " ")
      )
    )
    (print)
  )

(print total)
