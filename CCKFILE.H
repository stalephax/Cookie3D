#ifndef _CCKFILE
#define _CCKFILE

#include <stdlib.h>
#include <stdio.h>
#include <memory.h>
#include <conio.h>
#include "bsp.h"

#define MAX_TEXTURES 20
#define MAX_BUFFER 80

#define DHeight 256
#define DWidth  256

extern unsigned char globalpalette[768];
extern unsigned char  *texturestart;


typedef struct {
	char manufacturer;
	char version;
	char encoding;
	char BitsPerPixel;
	short int x1, y1;
	short int x2, y2;
	short int hres;
	short int vres;
	char palette[48];
	char reserved;
	char colour_planes;
	short int BytesPerLine;
	short int PaletteType;
	char dummy[58];
} PCXHEADER;

/***********************************************************************
* Reads a scenefile 
************************************************************************/
void getScene(const char *fileName, OLDPOINT * position, FACE ** fList);

#endif /* _CCKFILE */
