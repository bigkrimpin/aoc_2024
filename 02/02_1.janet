(def reports @[])
(var safe_reports 0)

(var len 0)
(with [f (file/open "input.txt")]
  (while true
    (def l (file/read f :line))
    (if (= l nil)
      (break))
    (def nums_str (string/split " " (string/trim l)))
    (def nums @[])
    (for i 0 (length nums_str) (put nums i (int/to-number (int/s64 (nums_str i)))))
    (put reports len nums)
    (++ len)
    ))

(each report reports
  (var safe true)
  (var descending nil)
  (var biggest_difference 0)
  (var previous nil)

  (if (= (= (>= (splice report)) false) (= (<= (splice report)) false))
    (set safe false)
    )

  (each level report
    (if previous
      (if (= previous level)
        (set safe false)))
    (var difference 0)
    (if previous
      (set difference (if (< previous level) (- level previous) (- previous level)))
      )
    (print difference)
    (if (< biggest_difference difference)
      (set biggest_difference difference))

    (set previous level)
    )
  (if (> biggest_difference 3) (set safe false))
  (print biggest_difference)

  (if safe (++ safe_reports))
  (printf "%s\n" (if safe "safe" "unsafe"))
  )

(print safe_reports)
