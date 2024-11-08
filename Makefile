all: $(shell find config -name '*.keymap')

./config/boards/shields/corne/corne.keymap: keymap.el crkbd.el
	emacs -Q --batch --load keymap.el --load crkbd.el

./config/boards/shields/khonsu/khonsu.keymap: keymap.el khonsu.el
	emacs -Q --batch --load keymap.el --load khonsu.el

