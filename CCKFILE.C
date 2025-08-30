/*
 * FILE IO routines, like loading/extracting a pcx file, and level file (c)
 * 1997 Erwin Coumans, coockie@stack.nl
 */
#include <stdio.h>
#include "cckfile.h"
#include "3d.h"			/* for startpos */
#include "object.h"
#include <memory.h>
 /*
 * now obsolete ? char           *vgabuf = (char *) 0xA0000;
 */

/* texture array */
char            pcxtextures[2*40*256*256];
/* start in texture array (on 64k boundary in memory) */
char           *texturestart;
unsigned char            globalpalette[768];
PCXHEADER       Header;
char           fname[1024];// max filenamelength ?

/***********************************************************************
* Extracts a PCX file to a buffer
************************************************************************/

void 
UnpackPCX(FILE * fh, char *Buffer, int Width, int Height)
{

   /*
    * Note that this is NOT a properly robust PCX reader - it's for the
    * purposes of this example only, and it makes a lot of assumptions, so
    * it's easy to fool
    */

   unsigned char           *wbuf, *wptr, c, l;
   int             j, k, WHeight;

   
   /* Read and set the palette */
   fseek(fh, -768L, SEEK_END);
   fread(globalpalette, 768, 1, fh);

   /* Reposition to the start of the image data, and continue */
   fseek(fh, sizeof(PCXHEADER), SEEK_SET);
   wptr = wbuf = malloc(Width);

   /* if (DHeight > Height) */
   if (Height < DHeight)
      WHeight = Height;
   else
      WHeight = DHeight;

   for (j = 0; j < WHeight; j++) {
      for (k = 0; k < Width;) {
	 c = fgetc(fh);
	 if (c > 191) {
	    l = c - 192;
	    c = fgetc(fh);
	    memset(wptr, c, l);
	    wptr += l;
	    k += l;
	 } else {
	    *wptr = c;
	    wptr++;
	    k++;
	 }
      }
      if (Width >= DWidth)
	 memcpy(Buffer + (j * DWidth), wbuf, Width);
      else
	 memcpy(Buffer + (j * DWidth), wbuf, DWidth);

      wptr = wbuf;
   }

   return;
}
extern unsigned char* hoer;
extern point_t	gravitationvec;
/***********************************************************************
* Reads a scenefile
************************************************************************/
void
getScene(const char *fileName, OLDPOINT * position, FACE ** fList)
{

	  int             x, y, TGAwidth, TGAheight;
//  unsigned char   buf3[3];
//  unsigned char   buf4[4];
	  unsigned char* pp;
  unsigned char* buf5;
  unsigned char* buf6;
	
  unsigned char   header[18];
  FILE           *filep;

   OLDPOINT           center;
   char           *texadres1;
   auto div_t      min_sec;
   FILE           *fh;
   int             Width, Height;
   char           *PCXBuffer;
   int             aantaltextures;

   FACE           *movingfList;

   FACE           *fListTail = NULL_FACE;
   FACE           *movingfListTail = NULL_FACE;
   VERTEX          tryyy;
   VERTEX          movingtryyy;
   VERTEX         *vList = NULL_VERTEX, *vListTail = NULL_VERTEX;
   VERTEX         *movingvList = NULL_VERTEX, *movingvListTail = NULL_VERTEX;

   static char     buffer[MAX_BUFFER];
   COLOR           color;
   PLANE           plane;
   COLOR           movingcolor;
   PLANE           movingplane;
   int             objectsread;
   int             movingspecial;
   FILE           *fp = fopen(fileName, "r");
   if (fp == NULL) {
      fprintf(stderr, "?Unable to open %s \n", fileName);
      exit(1);
   }
   printf("File: %s\n", fileName);
   startpos.v[0] = 0.0;
   startpos.v[1] = 0.0;
   startpos.v[2] = 0.0;
   center.xx = 0;
   center.yy = 0;
   center.zz = 0;

   position->xx = 0.0;
   position->yy = 0.0;
   position->zz = 0.0;
   NumberOfObjects = 0;
   objectsread = 0;
   *fList = NULL_FACE;
   movingfList = NULL_FACE;
	pp=NULL;

   /* trick to get textures aligned in memory on 65536 boundaries...  */
	
	

   texadres1 = (char *) pcxtextures;
   min_sec = div((int) texadres1, 65536);
   texturestart = (char *) ((min_sec.quot + 1) * 65536);
//	texturestart = (char *) pcxtextures;//((min_sec.quot + 1) * 65536);

   memset(pcxtextures,0,256*256*MAX_TEXTURES);
   aantaltextures = 0;
   linenumber = -1;

   while (fgets(buffer, MAX_BUFFER, fp)) {
      linenumber++;
      /* if ((linenumber & 255) == 0) */
      /* printf("\nParsing line %i\n",linenumber);  */

      if (buffer[0] == 'P') {	/* start of face */
	 if (vList != NULL_VERTEX) {	/* previous face? */
	    appendVertex(&vList, &vListTail,	/* append duplicate 1st
						 * vertex  */
			 allocVertex(vList->xx, vList->yy, vList->zz,
				     vList->uu, vList->vv));
	    computePlane(vList->xx, vList->yy, vList->zz,
		       vList->vnext->xx, vList->vnext->yy, vList->vnext->zz,
			 vList->vnext->vnext->xx,
			 vList->vnext->vnext->yy,
			 vList->vnext->vnext->zz, &plane);
	    appendFace(fList, &fListTail, allocFace(&tryyy, &tryyy, &tryyy, &color, vList, &plane));
	 }
	 sscanf(buffer, "%*s %i ", &color);

	 /* save vars for this face and start new vertex list */
	 /* printf("f %i",color); */
	 vList = vListTail = NULL_VERTEX;
      } else if (buffer[0] == 'V') {	/* read in vertex */
	 float           xx, yy, zz;
	 float           uu, vv;
	 uu=0;
	 vv=0;
	 sscanf(buffer, "%*s %f %f %f %f %f", &xx, &yy, &zz, &uu, &vv);
	 uu*=64;
	 vv*=64;
	 //uu = 0;
	 //vv = 0;
	 /* printf("v (%f,%f,%f)(%f,%f)\n",xx,yy,zz,uu,vv); */
	 appendVertex(&vList, &vListTail, allocVertex(xx, yy, zz, uu, vv));
      } else if (buffer[0] == 'S') {	/* read in startposition */
	 float           xx, yy, zz;
	 sscanf(buffer, "%*s %f %f %f %f %f", &xx, &yy, &zz);
	 startpos.v[0] = xx;
	 startpos.v[1] = zz;
	 startpos.v[2] = yy;

      } else if (buffer[0] == 'M') {	/* read in vertex */
	 float           xx, yy, zz;
	 float           uu, vv;
	 sscanf(buffer, "%*s %f %f %f %f %f", &xx, &yy, &zz, &uu, &vv);
	 /* test, force texmap coords autocalculated */
	 /* printf("v (%f,%f,%f)(%f,%f)\n",xx,yy,zz,uu,vv); */
	 appendVertex(&movingvList, &movingvListTail, allocVertex(xx, yy, zz, uu, vv));
      } else if (buffer[0] == 'G') {	/* read in gravitation */
	 float           xx, yy, zz;
	 sscanf(buffer, "%*s %f %f %f %f %f", &xx, &yy, &zz);
	 gravitationvec.v[0] = xx;
	 gravitationvec.v[1] = yy;
	 gravitationvec.v[2] = zz;

      } else if (buffer[0] == 'X') {	/* read in speed */
	 float           xx;

	 
	 sscanf(buffer, "%*s %f ", &xx);
		MAX_MOVEMENT_SPEED = xx;
	 
      } else if (buffer[0] == 'T') {	/* read in texture */
	 sscanf(buffer, "%*s %s", fname);

	 
	 if ((fh = fopen(fname, "rb")) == NULL) {
	    printf("\nFile %s not found in line %i\n\n", fname, linenumber);
	    exit(0);
	 }
	 fread(&Header, sizeof(PCXHEADER), 1, fh);

	 Width = (Header.x2 - Header.x1) + 1;
	 Height = (Header.y2 - Header.y1) + 1;
	 if ((Width != 256) || (Height != 256)) {
	    printf("Width or Height of pcx %s not 256", fname);
	    exit(0);
	 }
	 PCXBuffer = texturestart;
	 PCXBuffer += aantaltextures * 65536;
	 UnpackPCX(fh, PCXBuffer, Width, Height);
	 fclose(fh);


  //filep = fopen(fname, "rb");



	 aantaltextures++;
	 if (aantaltextures > (MAX_TEXTURES - 1)) {	/* -1 because first
							 * texture is to align
							 * on 64k border! */
	    printf("Error:Too many textures defined, only %i allowed!", MAX_TEXTURES);
	    exit(-1);
	 }
      }
      /* addon for moving things */
      else if (buffer[0] == 'O') {	/* start of object */
	 if (NumberOfObjects >= MAX_OBJECTS) {
	    printf("Error: too many objects defined, only %i allowed!", MAX_OBJECTS);
	    exit(-1);
	 };
	 if (movingvList != NULL_VERTEX) {	/* previous face? */
	    appendVertex(&movingvList, &movingvListTail,	/* append duplicate 1st
								 * vertex  */
	      allocVertex(movingvList->xx, movingvList->yy, movingvList->zz,
			  movingvList->uu, movingvList->vv));
	    computePlane(movingvList->xx, movingvList->yy, movingvList->zz,
			 movingvList->vnext->xx, movingvList->vnext->yy, movingvList->vnext->zz,
			 movingvList->vnext->vnext->xx,
			 movingvList->vnext->vnext->yy,
			 movingvList->vnext->vnext->zz, &movingplane);
	    appendFace(&movingfList, &movingfListTail, allocmovingFace(&movingtryyy, &movingtryyy, &movingtryyy, &movingcolor, movingvList, &movingplane));
	    if (objectsread == 0) {
	       printf("Error: object definitions before 'Object' declaration in line %i", linenumber);
	       exit(-1);
	    } else {
	       /* add previous object */
	       AddObject(center, movingfList, movingspecial);
	    };
	    NumberOfObjects++;
	 }
	 objectsread++;
	 sscanf(buffer, "%*s %i %i ", &movingspecial);
	 /* save vars for this face and start new vertex list */
	 /* printf("f %i",color); */
	 movingvList = movingvListTail = NULL_VERTEX;
      } else if (buffer[0] == 'Q') {	/* start of face */
	 if (movingvList != NULL_VERTEX) {	/* previous face? */
	    appendVertex(&movingvList, &movingvListTail,	/* append duplicate 1st
								 * vertex  */
	      allocVertex(movingvList->xx, movingvList->yy, movingvList->zz,
			  movingvList->uu, movingvList->vv));
	    computePlane(movingvList->xx, movingvList->yy, movingvList->zz,
			 movingvList->vnext->xx, movingvList->vnext->yy, movingvList->vnext->zz,
			 movingvList->vnext->vnext->xx,
			 movingvList->vnext->vnext->yy,
			 movingvList->vnext->vnext->zz, &movingplane);
	    appendFace(&movingfList, &movingfListTail, allocmovingFace(&movingtryyy, &movingtryyy, &movingtryyy, &movingcolor, movingvList, &movingplane));
	 }
	 sscanf(buffer, "%*s %i ", &movingcolor);

	 /* save vars for this face and start new vertex list */
	 /* printf("f %i",color); */
	 movingvList = movingvListTail = NULL_VERTEX;
      } else if (buffer[0] == COMMENT) {
      }
      /* comment */
      else
	 fprintf(stderr, "?Illegal command: '%c'\n", buffer[0]);
   }				/* while */

   if (vList != NULL_VERTEX) {	/* process last face (or only) */
      appendVertex(&vList, &vListTail,	/* append duplicate 1st vertex */
		   allocVertex(vList->xx, vList->yy, vList->zz, vList->uu,
			       vList->vv));
      computePlane(vList->xx, vList->yy, vList->zz,
		   vList->vnext->xx, vList->vnext->yy, vList->vnext->zz,
		   vList->vnext->vnext->xx,
		   vList->vnext->vnext->yy, vList->vnext->vnext->zz, &plane);
      appendFace(fList, &fListTail, allocFace(&tryyy, &tryyy, &tryyy, &color, vList, &plane));
   }
   if (movingvList != NULL_VERTEX) {	/* process last face (or only) */
      if (NumberOfObjects >= MAX_OBJECTS) {
	 printf("Error: too many objects defined, only %i allowed!", MAX_OBJECTS);
	 exit(-1);
      };


      appendVertex(&movingvList, &movingvListTail,	/* append duplicate 1st
							 * vertex */
		   allocVertex(movingvList->xx, movingvList->yy, movingvList->zz, movingvList->uu,
			       movingvList->vv));
      computePlane(movingvList->xx, movingvList->yy, movingvList->zz,
      movingvList->vnext->xx, movingvList->vnext->yy, movingvList->vnext->zz,
		   movingvList->vnext->vnext->xx,
		   movingvList->vnext->vnext->yy, movingvList->vnext->vnext->zz, &movingplane);
      appendFace(&movingfList, &movingfListTail, allocmovingFace(&movingtryyy, &movingtryyy, &movingtryyy, &movingcolor, movingvList, &movingplane));
      if (objectsread == 0) {
	 printf("Error: object definitions before 'Object' declaration in line %i", linenumber);
	 exit(-1);
      } else {
	 /* add previous object */
	 AddObject(center, movingfList, movingspecial);
	 NumberOfObjects++;
      };

   }
   fclose(fp);
}				/* getScene() */
