#ifndef __KEY_H
#define __KEY_H

#define RIGHT_ARROW_PRESSED   77
#define RIGHT_ARROW_RELEASED  205
#define UP_ARROW_PRESSED      72
#define UP_ARROW_RELEASED     200
#define LEFT_ARROW_PRESSED    75
#define LEFT_ARROW_RELEASED   203
#define DOWN_ARROW_PRESSED    80
#define DOWN_ARROW_RELEASED   208
#define CONTROL_PRESSED	      29
#define CONTROL_RELEASED      157
#define ESCAPE		      1
#define N1_PRESSED            59
#define N1_RELEASED           59+128
#define N2_PRESSED            60
#define N2_RELEASED           60+128
#define N3_PRESSED            61
#define N3_RELEASED           61+128
#define N4_PRESSED            62
#define N4_RELEASED           62+128
#define N5_PRESSED            63
#define N5_RELEASED           63+128
#define N6_PRESSED            64
#define N6_RELEASED           64+128
#define N7_PRESSED            65
#define N7_RELEASED           65+128
#define N8_PRESSED            66
#define N8_RELEASED           66+128

#define HOME_PRESSED	      71
#define HOME_RELEASED	      199
#define PGUP_PRESSED	      73
#define PGUP_RELEASED	      201
#define PGDN_PRESSED	      81
#define PGDN_RELEASED	      209
#define END_PRESSED	      79
#define END_RELEASED	      207
#define PLUS_PRESSED	      78
#define PLUS_RELEASED	      206
#define MINUS_PRESSED	      74
#define MINUS_RELEASED	      202
#define LETTER_A_PRESSED      30
#define LETTER_A_RELEASED     158
#define LETTER_S_PRESSED      31
#define LETTER_S_RELEASED     159

#define LETTER_D_PRESSED      32
#define LETTER_D_RELEASED     160
#define LETTER_F_PRESSED      33
#define LETTER_F_RELEASED     161

#define LETTER_Z_PRESSED      0x2c
#define LETTER_Z_RELEASED     0x2c+128
#define LETTER_C_PRESSED      0x2e
#define LETTER_C_RELEASED     0x2e+128


// key make codes
typedef struct {		/* Keyboard structure. Each key that can */
    int right;             /* be pressed is represented here.       */
    int left;
    int up;
    int down;
    int home;
    int pgup;
    int pgdn;
    int end;
    int control;
    int alt;
    int plus;
    int minus;
    int escape;
    int n1;
    int n2;
    int n3;
    int n4;
    int n5;
    int n6;
    int n7;
    int n8;
    int a;
    int d;
    int f;
    int c;
    int s;
    int z;
} KEYBOARD;

extern KEYBOARD  keyBoard;

void InstallKeyboardInt(void);
void RestoreKeyboardInt(void);
void Initialize(void);
void CleanUp(void);

#endif

