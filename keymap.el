(let (kh-defines)
  (defun kh-define-key (newkey oldkey)
    (push `(,newkey . oldkey)
          kh-defines)))

(defvar kh-default
  '(:left (((:kp Q)     (:kp W)     (:kp E)     (:kp R)     (:kp T))
           ((:kp A)     (:kp S)     (:kp D)     (:kp F)     (:kp G))
           ((:kp Z)     (:kp X)     (:kp C)     (:kp V)     (:kp B))
           ((:na)        (:na)      (:mo MOVEMENT)  (:mt RSHFT RET) (:mt RCTRL ESC)))
    :right (((:kp Y)     (:kp U)     (:kp I)     (:kp O)    (:kp P))
            ((:kp H)     (:kp J)     (:kp K)     (:kp L)    (:kp SEMI))
            ((:kp N)     (:kp M)     (:kp COMMA) (:kp DOT)  (:kp FSLH))
            ((:kp SPACE)   (:mo SYMBOLS) (:kp RGUI) (:na) (:na)))))

(defvar kh-symbols
  '(:left (((:kp EXCL) (:kp AT) (:kp HASH) (:kp DOLLAR) (:kp PIPE))
           ((:kp LBRC) (:kp RBRC) (:kp SQT) (:kp GRAVE) (:kp BSLH))
           ((:kp LBKT) (:kp RBKT) (:kp LPAR) (:kp RPAR) (:kp AMPS))
           ((:na) (:na)    (:trans)  (:trans) (:trans)))
    :right (((:kp LANG1) (:kp N7) (:kp N8) (:kp N9) (:kp DOT))
            ((:kp BSPC) (:kp N4) (:kp N5) (:kp N6) (:kp EQUAL))
            ((:kp N0) (:kp N1) (:kp N2) (:kp N3) (:kp MINUS))
            ((:trans) (:trans) (:trans) (:na) (:na)))))

(defvar kh-movement
  '(:left (((:kp HOME) (:trans) (:kp PG_DN) (:kp PG_UP) (:trans))
           ((:kp END) (:kp LEFT) (:kp DOWN) (:kp UP) (:kp RIGHT))
           ((:kp F1) (:kp F2) (:kp F3) (:kp F4) (:kp F5))
           ((:na) (:na) ( :trans)  (:trans) (:trans)))
    :right (((:kp RET) (:bt BT_PRV) (:trans)     (:bt BT_NXT) (:kp DEL))
            ((:bt BT_SEL 0) (:bt BT_SEL 1) (:bt BT_SEL 2) (:bt BT_SEL 3) (:kp INS))
            ((:bt BT_CLR) (:trans) (:trans) (:trans) (:kp ESC))
            ((:kp LALT) (:kp RSHFT) (:kp RCTRL) (:na) (:na)))))


(defvar kh-keymap
  `(("default" . ,kh-default)
    ("symbols" . ,kh-symbols)
    ("movement" . ,kh-movement)))

(defun kh-render-zmk-layer (name layer)
  (cl-destructuring-bind (&key left right) layer
    (with-temp-buffer
      (insert (format "%s_layer {\n" (downcase (format "%s" name))))
      (insert "bindings = <\n")
      (cl-loop for row in (cl-mapcar #'append left right)
            do (progn
                 (dolist (key row)
                   (insert (kh-render-zmk-key key))
                   (insert " "))
                 (insert "\n")))
      (insert "\n>;\n")
      (insert "};\n")
      (buffer-string))))


(defvar kh-combos
  '((:name esc
     :timeout-ms 25
     :keys ((U I)
            (R E))
     :bindings (:kp ESC))
    (:name enter
     :timeout-ms 25
     :keys ((J K)
            (D F))
     :bindings (:kp RET))
    (:name tab
     :timeout-ms 25
     :keys ((M COMMA)
            (C V))
     :bindings (:kp TAB))
    ;;
    (:name bkspc
     :timeout-ms 25
     :keys ((H J)
            (F G))
     :bindings (:kp BSPC))
    ;; modifier combos
    (:name ctl_r
     :timeout-ms 25
     :keys ((K L))
     :bindings (:kp RCTRL))
    (:name ctl_l
     :timeout-ms 25
     :keys ((S D))
     :bindings (:kp LCTRL))
    (:name alt
     :timeout-ms 25
     :keys ((COMMA DOT)
            (SYMBOLS RSHFT)
            (X C))
     :bindings (:kp LALT))
    (:name gui_r
     :timeout-ms 25
     :keys ((I O))
     :bindings (:kp RGUI))
    (:name gui_l
     :timeout-ms 25
     :keys ((W E))
     :bindings (:kp LGUI))
    ;; alt ctrl
    (:name alt_ctrl
     :timeout-ms 25
     :keys ((R T)
            (Y U)
            (RCTRL SPACE)
            (J K L)
            (S D F))
     :bindings (:kp (:l-alt LCTRL)))
    (:name shift_alt_ctrl
     :timeout-ms 25
     :keys ((N M)
            (V B))
     ;; TODO: generalize
     :bindings (:kp (:l-alt "RS(LCTRL)")))))

(defun kh-render-zmk-key (key)
  (pcase key
    (`(:kp (:l-alt ,keyname))
      (kh-render-zmk-key `(:kp ,(format "LA(%s)" keyname))))
    (`(:kp ,keyname)
      (format "&kp %s" keyname))
    (`(:mo ,keyname)
      (format "&mo %s" keyname))
    (`(:trans)
      "&trans")
    (`(:na)
      "")
    (`(:bt . ,rest)
      (format "&bt %s"
              (string-join (mapcar (lambda (x) (format "%s" x))
                                   rest)
                           " ")))
    (`(:mt . ,rest)
      (format "&mt %s"
              (string-join (mapcar (lambda (x) (format "%s" x))
                                   rest)
                           " ")))
    (_ (error "Could not parse key %s" key))))


(defun kh-render-zmk-combos (combos default-layer)
  (cl-destructuring-bind (&key left right) default-layer
    (let* ((full-layer (cl-mapcar #'append left right))
           (flat-layer (cl-reduce #'append full-layer)))
      (with-temp-buffer
        (insert "combos {\n")
        (insert "compatible = \"zmk,combos\";\n")
        (dolist (combo combos)
          (cl-destructuring-bind (&key name timeout-ms keys bindings) combo
            (let ((i 0))
              (dolist (key keys)
                (insert (format "combo_%s_%s {\n" name (cl-incf i)))
                (insert (format "timeout-ms = <%s>;\n" timeout-ms))
                (insert (format "bindings = <%s>;\n"
                                (kh-render-zmk-key bindings)))
                (let (key-positions)
                  (dolist (k key)
                    (let ((pos -1))
                      (dolist (layer-key flat-layer)
                        (cl-incf pos)
                        (when (member k layer-key)
                          (push pos key-positions)))))
                  (insert (format "key-positions = <%s>;\n"
                                  (string-join (mapcar
                                                (lambda (x) (format "%s" x))
                                                (reverse key-positions))
                                               " "))))
                (insert "};\n")) )))
        (insert "};\n")
        (buffer-string)))))



(defun kh-render-zmk-keymap (layers-alist)
  (with-temp-buffer
    (insert "keymap {\n")
    (insert "compatible = \"zmk,keymap\";\n\n")
    (dolist (layer layers-alist)
      (cl-destructuring-bind (name . layer) layer
        (insert (kh-render-zmk-layer name layer))))
    (insert "\n};\n")
    (buffer-string)))

(kh-render-zmk-combos kh-combos kh-default)
(kh-render-zmk-layer "default" kh-default)
(kh-render-zmk-layer "symbols" kh-symbols)
(kh-render-zmk-layer "movement" kh-movement)


(kh-render-zmk-keymap kh-keymap)

(defun kh-render-zmk-keymap-file (combos layers-alist &optional outfile)
  (with-temp-buffer
    (insert "
#include <behaviors.dtsi>
#include <dt-bindings/zmk/keys.h>
#include <dt-bindings/zmk/bt.h>
#include <dt-bindings/zmk/outputs.h>

#define SYMBOLS 1
#define MOVEMENT 2
")
    (insert "/ {")
    (newline)
    (insert (kh-render-zmk-combos combos (cdar layers-alist)))
    (newline)
    (insert (kh-render-zmk-keymap layers-alist))
    (newline)
    (insert "};")
    (let ((code (buffer-string)))
      (when outfile
        (with-current-buffer (find-file-noselect outfile)
          (erase-buffer)
          (insert code)
          (save-buffer)))
      code)))




(provide 'kh)
