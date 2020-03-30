(defun --- () (princ "\n") (princ (multi "-" 80)))

(defun c:ve ()
  (setq ee (entget (car (entsel))))
  (---)
  (princ (strcat "\n;; ee: " (str ee)))
  (---)
  (princ)
  )

(defun eztools_vee( ent / key view runing)
  ;;      +----------+
  ;;      |0 entsel  |
  ;;      +----+-----+
  ;;           |
  ;;      +----v-----+
  ;;      |1print e  <------+
  ;;      +----+-----+      |
  ;;           |            |
  ;;      +----v-----+ +----+----+
  ;; +----+2getint k | |set e e.k|5
  ;; |    +----------+ +----+----+
  ;; |k is     |k in e      |
  ;; |nil +----v-----+      |e.k is ent
  ;; |or  |3print e.k+------+
  ;; |not +----+-----+
  ;; |in e     | e.k is not ent
  ;; |    +----v-----+
  ;; +--->+4  End    |
  ;;      +----------+
  (setq  view 1 runing t)
  (while runing
         (cond
           ((= view 1) (progn (---) 
                              (setq view 2 )
                              (princ (strcat "\n;; ee: " 
                                             (str (setq ee (entget ent)))))))
           ((= view 2) (progn (---)
                              (setq key (getint "\nPress key number, [space] exit: "))
                              (if (in key (entget ent))
                                  (setq view 3) (setq view 4))))
           ((= view 3) (progn (---) 
                              (princ "\n;; ee: ")
                              (princ (setq ee (dot (entget ent) key)))
                              (if (= 'ename (type (dot (entget ent) key)))
                                  (setq view 5) (setq view 4))))
           ((= view 4) (setq runing nil))
           ((= view 5) (setq ent (dot (entget ent) key) view 1))
           ))
  (princ)
  )

(defun c:vee ( / ent)
  (setq ent  (car (entsel "\nSelect ent for DXF codes: ")))
  (eztools_vee ent)
  )