(def left @[])
(def right @[])
(var distance 0)
(var similarity 0)

(var len 0)
(with [f (file/open "input.txt")]
  (while true
    (def l (file/read f :line))
    (if (= l nil)
      (break))
    (def n (string/split "   " (string/trim l)))
    #(printf "%s %s" (n 0) (n 1))
    (def left (array/concat left (int/to-number (int/s64 (n 0)))))
    (def right (array/concat right (int/to-number (int/s64 (n 1)))))
    (++ len)))

(sort left)
(sort right)

(var i 0)
(while (< i len)
  (+= distance (math/abs (- (right i) (left i))))
  (++ i))
(printf "distance: %d" distance)

(var i 0)
(while (< i len)
  (def index (find-index |(= $ (left i)) right))
  (if index
    (do
      (var x 0)
      (while (= (left i) (right (+ index x)))
        (++ x))
      (+= similarity (* (left i) x))))
  (++ i))
(printf "similarity: %d" similarity)
