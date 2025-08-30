//
//  Pull in some header files
//
    #include <stdio.h>
    #include <dos.h>
    #include <conio.h>
    #include "keyboard.h"
//
//  Don't need flag in release version of program
//
#ifdef DEBUG
    int KeyboardFlag=1;  // set to true by default
#endif

//
//  Last keypress scancode.  Updated by custom int handler
//
    int volatile scanCode;
    KEYBOARD  keyBoard;
    int LastPressed = 0;

//
//  Pointer to save BIOS interrupt vector
//
    void (__interrupt __far *OldInt09)();

//
//  Acknowledge interrupt to 8259 PIC
//
    #define EOI() outp(0x20,0x20)

//
//  Define constant for the keyboard hardware interrupt
//
    #define KEYBOARD_INT 0x09

//
//  Scancode for Escape keypress
//
    #define ESC_PRESSED 1 //129

void keyCheck(void)
{
  if(scanCode==RIGHT_ARROW_PRESSED)keyBoard.right=1;
  if(scanCode==RIGHT_ARROW_RELEASED)keyBoard.right=0;
  if(scanCode==UP_ARROW_PRESSED)keyBoard.up=1;
  if(scanCode==UP_ARROW_RELEASED)keyBoard.up=0;
  if(scanCode==LEFT_ARROW_PRESSED)keyBoard.left=1;
  if(scanCode==LEFT_ARROW_RELEASED)keyBoard.left=0;
  if(scanCode==DOWN_ARROW_PRESSED)keyBoard.down=1;
  if(scanCode==DOWN_ARROW_RELEASED)keyBoard.down=0;
  if(scanCode==CONTROL_PRESSED)keyBoard.control=1;
  if(scanCode==CONTROL_RELEASED)keyBoard.control=0;
  if(scanCode==ESCAPE)keyBoard.escape=1;

  if(scanCode==N1_PRESSED)keyBoard.n1=1;
  if(scanCode==N1_RELEASED)keyBoard.n1=0;
  if(scanCode==N2_PRESSED)keyBoard.n2=1;
  if(scanCode==N2_RELEASED)keyBoard.n2=0;
  if(scanCode==N3_PRESSED)keyBoard.n3=1;
  if(scanCode==N3_RELEASED)keyBoard.n3=0;
  if(scanCode==N4_PRESSED)keyBoard.n4=1;
  if(scanCode==N4_RELEASED)keyBoard.n4=0;
  if(scanCode==N5_PRESSED)keyBoard.n5=1;
  if(scanCode==N5_RELEASED)keyBoard.n5=0;
  if(scanCode==N6_PRESSED)keyBoard.n6=1;
  if(scanCode==N6_RELEASED)keyBoard.n6=0;
  if(scanCode==N7_PRESSED)keyBoard.n7=1;
  if(scanCode==N7_RELEASED)keyBoard.n7=0;
  if(scanCode==N8_PRESSED)keyBoard.n8=1;
  if(scanCode==N8_RELEASED)keyBoard.n8=0;

  if(scanCode==PLUS_PRESSED)keyBoard.plus = 1;
  if(scanCode==PLUS_RELEASED)keyBoard.plus = 0;
  if(scanCode==MINUS_PRESSED)keyBoard.minus = 1;
  if(scanCode==MINUS_RELEASED)keyBoard.minus = 0;
  if(scanCode==LETTER_A_PRESSED)keyBoard.a = 1;
  if(scanCode==LETTER_A_RELEASED)keyBoard.a = 0;
  if(scanCode==LETTER_D_PRESSED)keyBoard.d = 1;
  if(scanCode==LETTER_D_RELEASED)keyBoard.d = 0;
  if(scanCode==LETTER_F_PRESSED)keyBoard.f = 1;
  if(scanCode==LETTER_F_RELEASED)keyBoard.f = 0;

  if(scanCode==LETTER_C_PRESSED)keyBoard.c = 1;
  if(scanCode==LETTER_C_RELEASED)keyBoard.c = 0;

  if(scanCode==LETTER_S_PRESSED)keyBoard.s = 1;
  if(scanCode==LETTER_S_RELEASED)keyBoard.s = 0;
  if(scanCode==LETTER_Z_PRESSED)keyBoard.z = 1;
  if(scanCode==LETTER_Z_RELEASED)keyBoard.z = 0;

  if(scanCode==HOME_PRESSED)keyBoard.home=1;
  if(scanCode==HOME_RELEASED)keyBoard.home=0;
  if(scanCode==END_PRESSED)keyBoard.end=1;
  if(scanCode==END_RELEASED)keyBoard.end=0;
  if(scanCode==PGUP_PRESSED)keyBoard.pgup=1;
  if(scanCode==PGUP_RELEASED)keyBoard.pgup=0;
  if(scanCode==PGDN_PRESSED)keyBoard.pgdn=1;
  if(scanCode==PGDN_RELEASED)keyBoard.pgdn=0;

}


//
// This is a stub for a hardware interrupt routine
//
    void __interrupt __far NewInt09()
    {
      register int x;

      scanCode=inp(0x60);       // read key code from keyboard
      x=inp(0x61);
      outp(0x61,(x|0x80));
      outp(0x61,x);
      keyCheck();
//      OldInt09();    /* call old int09 for debugging */
      EOI();  // acknowledge interrupt
    }

//
// Install our custom keyboard handler
//
    void InstallKeyboardInt(void)
    {
      // Save the original BIOS interrupt vector
      OldInt09=_dos_getvect(KEYBOARD_INT);

      // Install our own custom interrupt handler
      _dos_setvect(KEYBOARD_INT,NewInt09);
    }

//
// Restore the BIOS keyboard handler
//
void RestoreKeyboardInt(void)
    {
      _dos_setvect(KEYBOARD_INT,OldInt09);
    }

//
//  Perform required initialization
//
    void Initialize(void)
    {
#ifdef DEBUG
      if(KeyboardFlag)       // flag set from command line
#endif
	// install the custom interrupt handler.
	// note that this _always_ happens in the release version 
	InstallKeyboardInt();
    }

//
//  Clean up before program exit
//
    void CleanUp(void)
    {
#ifdef DEBUG
      if(KeyboardFlag)       // flag set from command line
#endif
	// Restore the BIOS interrupt handler.
	// note that this _always_ happens in the release version 
	RestoreKeyboardInt();
    }

//
//  Main game loop - processes all external events
//
     
