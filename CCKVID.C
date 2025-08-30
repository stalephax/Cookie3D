/********************************************************************
 * VIDEOCARD STUFF (S)VGA, (c) 1997 Erwin Coumans, coockie@stack.nl
 ********************************************************************/

#include "svga.h"		/* vbe routines (from svgakit) #include
				 * "cckfile.h"                    /* file io
				 * handling */
#include "cckvideo.h"		/* header for this file */
#include "debug.h"		/* types like bool, ushort */
#include "CCKFILE.H"
/********************************************************************
 * public vars
 ********************************************************************/
bool            ignoreVBE = false;	/* if TRUE then VBE is NOT used */
VBE_modeInfo    coockieModeInfo; /* VESA ModeInfo about current mode */
int             modeMenu[MAXVBEMODES];	/* array of all available modes */
int             currentMode = 0; /* points in modeMenu to current mode */
int             lastMode = 0;    /* points to last mode in modeMenu */
int             INITIAL_DIB_WIDTH = 320;	/* dimensions of cur.
						 * screenmode */
int             INITIAL_DIB_HEIGHT = 200;
int             INITIAL_WINDOW_WIDTH = 320;	/* dimensions of window */
int             INITIAL_WINDOW_HEIGHT = 200;
int             BYTES_PER_SCANLINE = 320;	/* obvious */
unsigned char  *screenbuffer;	/* pointer to screenmemory */
unsigned char  *VideoOffset;	/* vbe offset in screenmemory */

/* private variables */
PRIVATE int     VBEVersion;	/* VESA version number (0x0200?) */
int             coockieOffset = 0;


/**********************************************************************
   INIT/Query the VESA CARD (linear framebuffer (lfb) modes)
**********************************************************************/

void 
cckVBE_INIT(void)
{
   ushort         *modes;	/* videomode number */
   ushort          vesamode;	/* lfb. videomode number */
   VBE_modeInfo    mi;          /* info about VBE mode */

   /* always add normal VGA mode 13 (320x200) 1st in modetable */
   currentMode = 0;
   lastMode = 0;
   modeMenu[currentMode] = -1;
   if (ignoreVBE)
      return;			/* don't use VBE lfb. */

   /* is lfb available ? */
   SV_setMode(getValidGraphicsMode());
   SV_restoreMode();
   if (linearAddr) {
      /* look which available modes have lfb. */
      for (modes = modeList; *modes != 0xFFFF; modes++) {
	 /* force lfb */
	 vesamode = *modes | vbeLinearBuffer;

	 if (!VBE_getModeInfo(vesamode, &mi))
	    /* is mode available ? */
	    continue;
	 if (mi.BitsPerPixel != 8 || mi.XResolution == 0)
	    /* is mode 256 color (8bit) */
	    continue;
	 if (!(mi.ModeAttributes & vbeMdLinear))
            /* is lfb available for this mode ? */
            continue;
         /* set dimensions of screen, and drawwindow */
	 INITIAL_DIB_WIDTH = mi.XResolution;
	 INITIAL_DIB_HEIGHT = mi.YResolution;
	 INITIAL_WINDOW_WIDTH = mi.XResolution;
	 INITIAL_WINDOW_HEIGHT = mi.YResolution;
	 screenbuffer = linearAddr;
	 coockieModeInfo = mi;
         /* add mode in globalarray */
	 if (lastMode < MAXVBEMODES) {
	    lastMode++;
	    modeMenu[lastMode] = vesamode;
	 }
      }
   } else {
      /* sorry dude, use univbe, or buy better videocard */
      printf("No Linear Framebuffer.\n");
   }

};

/**********************************************************************
   Set a VIDEO MODE (VGA/SVGA) (3dfx added later)
**********************************************************************/
void 
cckSetMode(int VBEMode)
{
   VBE_modeInfo    mi;

   if (VBEMode == -1) {
      INITIAL_DIB_WIDTH = 320;
      INITIAL_DIB_HEIGHT = 200;
      INITIAL_WINDOW_WIDTH = 320;
      INITIAL_WINDOW_HEIGHT = 200;
      BYTES_PER_SCANLINE = 320;
      screenbuffer = 0;
      VBE_getModeInfo(0x13, &mi);
      coockieModeInfo = mi;
      VideoOffset = 0xa0000;
      _setvideomode(19);
      SetVGAPalette(globalpalette);
   } else {
      VBE_getModeInfo(VBEMode, &mi);
      SV_setMode(VBEMode);

      INITIAL_DIB_WIDTH = mi.XResolution;
      INITIAL_DIB_HEIGHT = mi.YResolution;
      INITIAL_WINDOW_WIDTH = mi.XResolution;
      INITIAL_WINDOW_HEIGHT = mi.YResolution;
      BYTES_PER_SCANLINE = mi.BytesPerScanLine;
      screenbuffer = 0;
      coockieModeInfo = mi;
      VideoOffset = 0;

      SetVGAPalette(globalpalette);


   };

};


/**********************************************************************
   Set the VGA/SVGA Palette (256 colors)
**********************************************************************/
void
SetVGAPalette(char *Palette)
{
   char            temppalette[768];
   short int       i;
   char far       *p;

   for (i = 0; i < 768; i++)
      temppalette[i] = Palette[i] >> 2;

   p = temppalette;

   outp(0x3c6, 0xff);
   for (i = 0; i <= 255; i++) {
      outp(0x3c8, i);
      outp(0x3c9, *p++);
      outp(0x3c9, *p++);
      outp(0x3c9, *p++);
   }

   return;

}

void            setGS();
#pragma aux setGS = \
               "mov   eax,coockieGS" \
               "mov   gs,ax" \
          modify [eax];
/************************************************************************
 Set the selector to VESA linear framebuffer
*************************************************************************/
void 
cckInitGS(void)
{
   setGS();
}

/************************************************************************
 Query/Return the selector to VESA linear framebuffer
*************************************************************************/
ushort 
coockie_getLinearSelector(VBE_modeInfo * mi)
{
   static ushort   linSel = 0;

   linSel = VBE_getLinearSelector(mi);
   return (linSel);

};

/************************************************************************
 General VBE Error-handling routine
*************************************************************************/
void _cdecl 
VBE_fatalError(char *msg)
{
   fprintf(stderr, "%s\n", msg);
   exit(1);
}
/************************************************************************
 Query VIDEO hardware to get first valid videomode
*************************************************************************/
int 
getValidGraphicsMode(void)
{
   ushort         *modes;
   VBE_modeInfo    mi;
   for (modes = modeList; *modes != 0xFFFF; modes++) {
      if (!VBE_getModeInfo(*modes, &mi))
	 continue;
      if (mi.ModeAttributes & vbeMdGraphMode)
	 return *modes;
   }
   printf("Could not find valid video mode!!!\n");
   return -1;

}
