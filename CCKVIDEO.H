#ifndef _CCKVIDEO
#define _CCKVIDEO

/* cckvideo.h
*/

#define MAXVBEMODES 100

/* flag if VBE can be used or not */
extern bool ignoreVBE;
extern VBE_modeInfo coockieModeInfo;
extern int modeMenu[MAXVBEMODES];
extern int currentMode ;
extern int lastMode ;

/* dimensions of screen, and window */
extern int INITIAL_DIB_WIDTH;
extern int INITIAL_DIB_HEIGHT;
extern int INITIAL_WINDOW_WIDTH;
extern int INITIAL_WINDOW_HEIGHT;
extern int BYTES_PER_SCANLINE;

/* pointers to screenmemory */
extern char           *screenbuffer;
extern unsigned char           *VideoOffset;

extern int coockieGS;

/**********************************************************************
        INIT/Query the VESA CARD 
**********************************************************************/
void cckVBE_INIT(void);
/**********************************************************************
        Set a VIDEO MODE (VGA/SVGA) (3dfx added later) 
**********************************************************************/
void cckSetMode (int VBEMode);
/**********************************************************************
        Set the VGA/SVGA Palette (256 colors)
**********************************************************************/
void SetVGAPalette(char *Palette);
/************************************************************************
        Set the selector to VESA linear framebuffer
*************************************************************************/
void cckInitGS(void);
/************************************************************************
 Query/Return the selector to VESA linear framebuffer
*************************************************************************/
ushort coockie_getLinearSelector(VBE_modeInfo *mi);

#endif  /* _CCKVIDEO */


