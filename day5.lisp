(defun get-file (filename)
    (with-open-file (stream filename)
        (loop for line = (read-line stream nil)
            while line
            collect line
)))

(defun split-list (l split-el)
    (let ((result nil) (sublist nil))
    (loop for el in l
        if (equal el split-el)
            collect sublist and do (push sublist result) and do (setf sublist nil)
        else 
            do (push el sublist))
    (push sublist result)
    (reverse result)
))

(defun split-string (str delim)
    (let ((result nil) (substr ""))
    (loop for c across str
        if (equal c delim) do (push substr result) and do (setf substr "")
        else do (setf substr (concatenate 'string substr (list c))))   
    (push substr result)
    (reverse result)
))

(defun range-ord (a b)
    (if (equal (first a) (first b))
        (< (second a) (second b))
        (< (first a) (first b)))
)

(defun merge-range (r1 r2)
    (list (car r1) (max (second r1) (second r2)))
)

(defun merge-ranges (ranges &optional res)
    (if (equal ranges nil)
        (reverse res)
        (if (and (not (equal res nil)) (and (>= (first (car ranges)) (first (car res))) (<= (first (car ranges)) (second (car res)))))
            (merge-ranges (cdr ranges) (cons (merge-range (car res) (car ranges)) (cdr res)))
            (merge-ranges (cdr ranges) (cons (car ranges) res))
        )
    )
)

(defun valid-id (ranges id)
    (if (equal ranges nil)
        nil
        (if (and (<= (first (car ranges)) id) (>= (second (car ranges)) id))
            id
            (valid-id (cdr ranges) id)
        )        
    )
)

(defun range-value-count (range)
    (1+ (- (second range) (first range)))
)

(
    let ((lines (get-file (nth 1 sb-ext:*posix-argv*))))
    (let ((split (split-list lines "")))
    (let ((ranges-str (first split)))
    (let ((ranges (mapcar (lambda (str) (mapcar (lambda (strnum) (parse-integer strnum)) (split-string str #\-))) ranges-str)))
    (setq ranges (merge-ranges (stable-sort (copy-list ranges) #'range-ord)))
    (let ((ids (mapcar (lambda (str) (parse-integer str)) (second split))))
    (format t "Day 5 Part 1: ~D~%" (length (remove-if-not (lambda (id) (valid-id ranges id)) ids))) 
    (format t "Day 5 Part 2: ~D~%" (reduce #'+ (mapcar #'range-value-count ranges)))
)))))
