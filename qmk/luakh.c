#include QMK_KEYBOARD_H

tap_dance_action_t tap_dance_actions[] = {
  [TD_GUI_SGUI] = ACTION_TAP_DANCE_DOUBLE(KC_RGUI, KC_RSFT),
  [TD_ENT_TAB] = ACTION_TAP_DANCE_DOUBLE(KC_ENT, KC_TAB),
  [TD_SPC_ALT] = ACTION_TAP_DANCE_DOUBLE(KC_SPC, KC_LALT),
};


bool process_record_kb(uint16_t keycode, keyrecord_t *record) {


  return true;

}

#include QMK_KEYBOARD_H

uint16_t get_tapping_term(uint16_t keycode, keyrecord_t *record) {
  switch (keycode) {
    case LGUI_T(KC_Z):
    case RGUI_T(KC_SLSH):
      return TAPPING_TERM + 60;
    case LT(SYMBOLS, KC_SPC):
      return TAPPING_TERM + 10 ;
    default:
      return TAPPING_TERM;
  }
}
