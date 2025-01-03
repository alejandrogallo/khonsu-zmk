#pragma once
#include QMK_KEYBOARD_H

#define MASTER_LEFT

// JOYSTICK CONFIGURATION =====================================================
#ifdef WITH_JOYSTICK
#  define JOYSTICK_BUTTON_COUNT 0
#  define JOYSTICK_AXES_COUNT 2
#endif

// RGB ========================================================================
#define RGBLED_NUM 54
#define RGBLED_SPLIT { 27, 27 }
//TODO: SET RGB
#ifndef RGBLIGHT_ENABLE
#  define RGBLIGHT_ENABLE
#endif
#undef RGBLIGHT_ENABLE

// I2C/SERIAL =================================================================
//#define USE_I2C
#define USE_SERIAL
#define SERIAL_USE_MULTI_TRANSACTION
//#endif

#undef SERIAL_USE_MULTI_TRANSACTION
#define SERIAL_SLAVE_BUFFER_LENGTH MATRIX_ROWS/2
#define SERIAL_MASTER_BUFFER_LENGTH MATRIX_ROWS/2

/* Set 0 if debouncing isn't needed */
#define DEBOUNCE 5

// LAYOUT =================================================================


//
/* #define _LAYOUT(                                                         \ */
/* L00, L01, L02, L03, L04, L05,           R00, R01, R02, R03, R04, R05, \ */
/* L10, L11, L12, L13, L14, L15,           R10, R11, R12, R13, R14, R15, \ */
/* L20, L21, L22, L23, L24, L25,           R20, R21, R22, R23, R24, R25, \ */
/*                     L30, L31, L32, R30, R31, R32                            \ */
/*                 )                                                       \ */
/*   {                                                                     \ */
/*     { L00, L01, L02, L03, L04, L05 },                                   \ */
/*     { L10, L11, L12, L13, L14, L15 },                                   \ */
/*     { L20, L21, L22, L23, L24, L25 },                                   \ */
/*     { KC_NO, KC_NO, KC_NO, L30, L31, L32 },                             \ */
/*     { R05, R04, R03, R02, R01, R00 },                                   \ */
/*     { R15, R14, R13, R12, R11, R10 },                                   \ */
/*     { R25, R24, R23, R22, R21, R20 },                                   \ */
/*     { KC_NO, KC_NO, KC_NO, R32, R31, R30 }                              \ */
/*   } */

#define LAYOUT_kc( \
  L00, L01, L02, L03, L04, L05,           R00, R01, R02, R03, R04, R05, \
  L10, L11, L12, L13, L14, L15,           R10, R11, R12, R13, R14, R15, \
  L20, L21, L22, L23, L24, L25,           R20, R21, R22, R23, R24, R25, \
                      L30, L31, L32, R30, R31, R32 \
  ) \
  LAYOUT( \
    KC_##L00, KC_##L01, KC_##L02, KC_##L03, KC_##L04, KC_##L05,                     KC_##R00, KC_##R01, KC_##R02, KC_##R03, KC_##R04, KC_##R05, \
    KC_##L10, KC_##L11, KC_##L12, KC_##L13, KC_##L14, KC_##L15,                     KC_##R10, KC_##R11, KC_##R12, KC_##R13, KC_##R14, KC_##R15, \
    KC_##L20, KC_##L21, KC_##L22, KC_##L23, KC_##L24, KC_##L25,                     KC_##R20, KC_##R21, KC_##R22, KC_##R23, KC_##R24, KC_##R25, \
                                            KC_##L30, KC_##L31, KC_##L32, KC_##R30, KC_##R31, KC_##R32 \
  )
// LUAKH LAYOUT ===========================================================


#define LUAKH_kc(LUAKH_NAME,               \
  L1, R1,                                  \
  L2, R2,                                  \
  L3, R3                                   \
  )                                        \
  LUAKH_APP(                               \
    LAYOUT_kc,                             \
    L1, LUAKH_GET_NAME(LUAKH_NAME, 1), R1, \
    L2, LUAKH_GET_NAME(LUAKH_NAME, 2), R2, \
    L3, LUAKH_GET_NAME(LUAKH_NAME, 3), R3, \
        LUAKH_GET_NAME(LUAKH_NAME, 4)      \
  )
