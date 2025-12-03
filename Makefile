all: $(shell find config -name '*.keymap')

./config/boards/shields/khorne/khorne.keymap: keymap.el crkbd.el
	emacs -Q --batch --load keymap.el --load crkbd.el

./config/boards/shields/khonsu/khonsu.keymap: keymap.el khonsu.el
	emacs -Q --batch --load keymap.el --load khonsu.el

./config/boards/shields/khonsu/khonsu_curve.keymap: keymap.el khonsu-curve.el
	emacs -Q --batch --load keymap.el --load khonsu-curve.el
