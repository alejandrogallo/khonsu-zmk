(require 'kh)


(defun kh-crkbd-pad-layer (layer)
  (pcase layer
    (`(:left (,row1-l ,row2-l ,row3-l ,row4-l)
             :right (,row1-r ,row2-r ,row3-r ,row4-r))
      (list :left (list (cons '(:trans) row1-l)
                        (cons '(:trans) row2-l)
                        (cons '(:trans) row3-l)
                        (cons '(:na) row4-l))
            :right (list (cons '(:trans) row1-r)
                         (cons '(:trans) row2-r)
                         (cons '(:trans) row3-r)
                         (cons '(:na) row4-r))))))

(defun kh-crkbd-pad-keymap (keymap-alist)
  (cl-loop for (name . layer) in keymap-alist
        collect (cons name (kh-crkbd-pad-layer layer))))

(defvar kh-crkbd-keymap-alist (kh-crkbd-pad-keymap kh-keymap ))

(kh-render-zmk-keymap-file kh-combos
                           kh-keymap
                           "./config/boards/shields/khorne/khorne.keymap")
