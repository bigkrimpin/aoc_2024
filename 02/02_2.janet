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
    (++ len)))

(each report reports
  #(print (+ (length report)) 1)
  (for i 0 (+ (length report) 0)
    (def current_report (array (splice report)))
    (array/remove current_report i)

    # (each n current_report (prinf "%d " n))
    # (print)

    (var safe true)
    (var biggest_difference 0)
    (var previous nil)

    (if (= (= (>= (splice current_report)) false) (= (<= (splice current_report)) false))
      (set safe false))

    (each level current_report
      (if previous
        (if (= previous level)
          (set safe false)))
      (var difference 0)
      (if previous
        (set difference (if (< previous level) (- level previous) (- previous level))))
      #(print difference)
      (if (< biggest_difference difference)
        (set biggest_difference difference))

      (set previous level))
    (if (> biggest_difference 3) (set safe false))
    #(print biggest_difference)

    #(printf "%s" (if safe "safe" "unsafe"))
    (if safe
      (do
        (++ safe_reports)
        (break)))))

(print safe_reports)
