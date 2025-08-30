#ifndef _GLOBAL_INCLUDED
#define _GLOBAL_INCLUDED

#include <stdlib.h>
//#include <I86.h>
#include <dos.h>
#include <stdio.h>
#include <math.h>
#include <malloc.h>
#include <memory.h>
 
#define MAX_SHOOTSPEED 123
#define MAXINT                0x7FFFFFFF
#define MININT                0x80000000
//#define IDM_EXIT           106
#define CURRENT_VERSION         1               // version of program
#define MAX_ITEMS 100

extern long frames;
extern unsigned char *pcxtexture;
extern unsigned char *texturestart;
extern int linenumber;
extern int shooting;
#endif //_GLOBAL_INCLUDED
