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
            ((:mt LALT SPACE)   (:mo SYMBOLS) (:kp RGUI) (:na) (:na)))))

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
    :right (((:to ZMK) (:bt BT_PRV) (:trans)     (:bt BT_NXT) (:kp DEL))
            ((:bt BT_SEL 0) (:bt BT_SEL 1) (:bt BT_SEL 2) (:bt BT_SEL 3) (:kp INS))
            ((:bt BT_CLR) (:trans) (:trans) (:trans) (:kp ESC))
            ((:kp LALT) (:kp RSHFT) (:kp RCTRL) (:na) (:na)))))

(defvar kh-zmk
  '(:left (((:to DEFAULT) (:bt BT_PRV) (:bt BT_CLR) (:bt BT_NXT) (:soft-off))
           ((:bt BT_SEL 0) (:bt BT_SEL 1) (:bt BT_SEL 2) (:bt BT_SEL 3) (:bt BT_SEL 4))
           ((:trans) (:trans) (:trans) (:trans) (:kp K_POWER))
           ((:na) (:na) (:trans) (:trans) (:trans)))
    :right (((:to DEFAULT) (:trans) (:trans) (:trans) (:trans))
            ((:trans) (:trans) (:trans) (:trans) (:trans))
            ((:trans) (:trans) (:trans) (:trans) (:trans))
            ((:trans) (:trans) (:trans) (:na) (:na)))))


(defvar kh-keymap
  `(("DEFAULT" . ,kh-default)
    ("SYMBOLS" . ,kh-symbols)
    ("MOVEMENT" . ,kh-movement)
    ("ZMK" . ,kh-zmk)))

(defvar kh-combos
  '((:name power-off
     :timeout-ms 25
     :keys ((Q P))
     :bindings (:kp K_POWER))
    (:name esc
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
    (:name ctl-r
     :timeout-ms 25
     :slow-release t
     :keys ((K L))
     :bindings (:kp RCTRL))
    (:name ctl-l
     :timeout-ms 25
     :slow-release t
     :keys ((S D))
     :bindings (:kp LCTRL))
    (:name alt
     :timeout-ms 25
     :slow-release t
     :keys ((COMMA DOT)
            (X C))
     :bindings (:kp LALT))
    (:name gui-r
     :timeout-ms 25
     :slow-release t
     :keys ((I O))
     :bindings (:kp RGUI))
    (:name gui-l
     :timeout-ms 25
     :slow-release t
     :keys ((W E))
     :bindings (:kp LGUI))
    ;; alt ctrl
    (:name alt-ctrl
     :timeout-ms 25
     :slow-release t
     :keys ((R T)
            (Y U)
            (J K L)
            (S D F))
     :bindings (:kp (:l-alt LCTRL)))
    (:name to-zmk
     :timeout-ms 25
     :keys ((Z X C))
     :bindings (:mo ZMK))
    (:name shift-alt
     :timeout-ms 25
     :slow-release t
     :keys ((M COMMA DOT)
            (X C V))
     :bindings (:kp "RS(LALT)"))
    (:name shift-gui
     :timeout-ms 25
     :slow-release t
     :keys ((U I O)
            (W E R))
     :bindings (:kp "RS(LGUI)"))
    (:name shift-alt-ctrl
     :timeout-ms 25
     :slow-release t
     :keys ((N M)
            (V B))
     ;; TODO: do it with macros
     :bindings (:kp (:l-alt "RS(LCTRL)")))
    (:name shift-ctrl
     :timeout-ms 25
     :slow-release t
     :keys ((J K L SEMI)
            (A S D F))
     :bindings (:kp "RS(LCTRL)"))
    (:name shift
     :timeout-ms 25
     :slow-release t
     :bindings (:kp RSHFT)
     :keys ((L SEMI)
            (A S)))))


(defun kh-check-combos (combos)
  (let ((keys (cl-reduce #'append (mapcar (lambda (x) (plist-get x :keys))
                                          combos))))
    (dolist (key keys)
      (when (< 1 (cl-count key keys :test #'equal))
        (error "Key combination %s is duplicated in combos" key)))))


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

(defun kh-render-zmk-key (key)
  (pcase key
    (`(:kp (:l-alt ,keyname))
      (kh-render-zmk-key `(:kp ,(format "LA(%s)" keyname))))
    (`(:kp ,keyname) (format "&kp %s" keyname))
    (`(:soft-off) "&soft_off")
    (`(:mo ,keyname) (format "&mo %s" keyname))
    (`(:to ,keyname) (format "&to %s" keyname))
    (`(:trans) "&trans")
    (`(:na) "")
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
          (cl-destructuring-bind (&key name timeout-ms keys bindings slow-release)
              combo
            (let ((i 0))
              (dolist (key keys)
                (insert (replace-regexp-in-string "-"
                                                  "_"
                                                  (format "combo_%s_%s {\n" name (cl-incf i))))
                (insert (format "timeout-ms = <%s>;\n" timeout-ms))
                (when slow-release
                  (insert (format "slow-release;\n")))
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

(defun kh-render-layers-defines (layers-alist)
  (with-temp-buffer
    (cl-loop for (name . _) in layers-alist
          for i from 0
          do (insert (format "#define %s %s\n" name i)))
    (buffer-string)))

(defun kh-render-zmk-keymap-file (combos layers-alist &optional outfile)
  (with-temp-buffer
    (insert "
#include <behaviors.dtsi>
#include <dt-bindings/zmk/keys.h>
#include <dt-bindings/zmk/bt.h>
#include <dt-bindings/zmk/outputs.h>

&soft_off {
  hold-time-ms = <5000>;
};
")

    (insert (kh-render-layers-defines layers-alist))
    (insert "/ {")
    (newline)
    (kh-check-combos combos)
    (insert (kh-render-zmk-combos combos (cdar layers-alist)))
    (newline)
    (insert (kh-render-zmk-keymap layers-alist))
    (newline)
    (insert "};")
    (let ((code (buffer-string)))
      (when outfile
        (with-current-buffer (find-file-noselect outfile)
          (erase-buffer)
          (c-mode)
          (insert code)
          (indent-region (point-min)
                         (point-max))
          (save-buffer)))
      code)))




(provide 'kh)
