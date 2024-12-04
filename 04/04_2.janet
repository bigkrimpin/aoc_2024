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
    (if (gridcheck data x y "A")
      (do
        #(print x " " y)
        (prin "A")
        ## Before-above midpoint
        (if (and (>= (- x 1) 0) (>= (- y 1) 0) (< (+ y 1) height) (< (+ x 1) width))
          (do
            # bottom-left top-right
            (def diag_bl_tr
              (or
                (and (gridcheck data (- x 1) (+ y 1) "M") (gridcheck data (+ x 1) (- y 1) "S"))
                (and (gridcheck data (- x 1) (+ y 1) "S") (gridcheck data (+ x 1) (- y 1) "M"))))
            # top-left bottom-right
            (def diag_tl_br
              (or
                (and (gridcheck data (- x 1) (- y 1) "M") (gridcheck data (+ x 1) (+ y 1) "S"))
                (and (gridcheck data (- x 1) (- y 1) "S") (gridcheck data (+ x 1) (+ y 1) "M"))))

            (if (and diag_bl_tr diag_tl_br)
              (++ total))
            )
          )
        )
      (prin " ")
      )
    )
    (print)
  )

(print total)
