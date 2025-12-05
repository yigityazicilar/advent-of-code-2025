(defun get-file (filename)
    (with-open-file (stream filename)
        (loop for line = (read-line stream nil)
            while line
            collect line
)))

(defun split-list (l split-el)
    (let ((result nil))
    (let ((sublist nil))
    (loop for el in l
        if (equal el split-el)
            collect sublist and do (push sublist result) and do (setf sublist nil)
        else 
            do (push el sublist))
    (push sublist result)
    (reverse result)
)))

(defun split-string (str delim)
    (let ((result nil))
    (let ((substr ""))
    (loop for c across str
        if (equal c delim) do (push substr result) and do (setf substr "")
        else do (setf substr (concatenate 'string substr (list c))))   
    (push substr result)
    (reverse result)
)))

(defun part1 (ranges ids)
    (let ((valid-ids nil))
    (loop for id in ids
        do (loop for range in ranges
            if (and (>= id (first range)) (<= id (second range))) do (push id valid-ids) and do (return)))
    valid-ids
))

(defun range-ord (a b)
    (if (equal (first a) (first b))
        (< (second a) (second b))
    (< (first a) (first b)))
)

(defun combine-ranges (ranges)
    (let ((len (length ranges)))
    (let ((result nil))
    (let ((i 0))
    (let ((start 0))
    (let ((end 0))
    (let ((next-i 0))
    (loop while (< i len)
        do (setq start (first (nth i ranges)) end (second (nth i ranges)) next-i (+ i 1))
        do (loop for j from (+ i 1) to (- len 1)
            if (and (>= (first (nth j ranges)) start) (<= (first (nth j ranges)) end)) 
                do (setq end (max (second (nth j ranges)) end) next-i (+ next-i 1)))
        do (push (list start end) result)
        do (setq i next-i))
    (reverse result)
)))))))

(defun part2 (ranges)
    (if (eq (cdr ranges) nil) 
        (+ (- (second (car ranges)) (first (car ranges))) 1)
        (+ (+ (- (second (car ranges)) (first (car ranges))) 1) (part2 (cdr ranges)))))

(
    let ((lines (get-file (nth 1 sb-ext:*posix-argv*))))
    (let ((split (funcall #'split-list lines "")))
    (let ((ranges-str (first split)))
    (let ((ranges (mapcar (lambda (str) (mapcar (lambda (strnum) (parse-integer strnum)) (funcall #'split-string str #\-))) ranges-str)))
    (let ((ids (mapcar (lambda (str) (parse-integer str)) (second split))))
    (format t "Day 5 Part 1: ~D~%" (length (funcall #'part1 ranges ids)))
    (let ((sorted-ranges (stable-sort (copy-list ranges) #'range-ord)))
    (let ((combined-ranges (combine-ranges sorted-ranges)))
    (format t "Day 5 Part 2: ~D~%" (part2 combined-ranges)) 
)))))))
