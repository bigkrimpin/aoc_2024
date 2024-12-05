(defn to_num
  [str]
  (int/to-number (int/s64 str)))

(def page_rules @[])
(def updates @[])

(var second_input false)
(with [f (file/open "input.txt")]
  (while true
    (def line (file/read f :line))
    (if (= line nil) (break))

    (def line (string/trim line))
    (if (= line "")
      (set second_input true)
      (do
        (if second_input
          (array/join updates @[(map to_num (string/split "," line))])
          (array/join page_rules @[(map to_num (string/split "|" line))]))))))

(var total 0)
(def bad_updates @[])

(each u updates
  (var update_good true)

  (def update_rules @[])
  (each r page_rules
    (if (and (find |(= $ (r 0)) u) (find |(= $ (r 1)) u))
      (array/join update_rules @[r])))

  (for i 0 (length u)
    (def current_before_rules @[])
    (each r page_rules
      (if (= (r 0) (u i))
        (array/concat current_before_rules (r 1))))

    (def current_after_rules @[])
    (each r page_rules
      (if (= (r 1) (u i))
        (array/concat current_after_rules (r 0))))

    (for b 0 i
      (if (= (find |(= $ (u b)) current_after_rules) nil)
        (set update_good false)))
    (for a (+ i 1) (length u)
      (if (= (find |(= $ (u a)) current_before_rules) nil)
        (set update_good false))))
  (if update_good
    (+= total (u (math/floor (/ (length u) 2))))
    (array/join bad_updates @[u])))
(print "Total: " total)

(var total 0)
(each u bad_updates
  (def corrected_update @[])
  (def update_rules @[])
  (each r page_rules
    (if (and (find |(= $ (r 0)) u) (find |(= $ (r 1)) u))
      (array/join update_rules @[r])))
  (for i 0 (length u)
    (var found_page 0)
    (each n u
      (if (= (find |(= ($ 1) n) update_rules) nil)
        (do
          (set found_page n)
          (break))))
    (array/remove u (find-index |(= $ found_page) u))
    (array/concat corrected_update found_page)
    (while (def rule_idx (find-index |(or (= ($ 0) found_page) (= ($ 1) found_page)) update_rules))
      (array/remove update_rules rule_idx)))
  (+= total (corrected_update (math/floor (/ (length corrected_update) 2)))))
(print "Total: " total)
