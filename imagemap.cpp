
// CameraClass.cpp: implementation of the CameraClass class.
//
//////////////////////////////////////////////////////////////////////

#include "StdAfx.h"
#include <stdlib.h>
#include <malloc.h>
#include "imagemap.h"

//////////////////////////////////////////////////////////////////////
// Construction/Destruction
//////////////////////////////////////////////////////////////////////

ImageMapClass::ImageMapClass()
{ width=0;
  height=0;
  pp=NULL;
}

// ========================================================================================================================

ImageMapClass::~ImageMapClass()
{ width=0;
  height=0;
  if (pp!=NULL) free(pp);	
}

// ========================================================================================================================

void ImageMapClass::Create(int w, int h)
{ int totalsize;

  width  = w;
  height = h;
  
  totalsize=width*height*4;
  
  pp = (unsigned char *) calloc(totalsize, 1); /* alloceer totalsize bytes */
  
  if (pp==NULL)
  { printf("Couldn't allocate memory for bitmap pixels\n");
    exit(1);
  }
}

// ========================================================================================================================

void ImageMapClass::LoadTGA(char *filename)
{
  int             x, y, TGAwidth, TGAheight;
//  unsigned char   buf3[3];
//  unsigned char   buf4[4];
  unsigned char* buf5;
  unsigned char* buf6;
	
  unsigned char   header[18];
  FILE           *fp;

  fp = fopen(filename, "rb");
  if (fp==NULL)
  { printf(" Cannot read file %s...\n",filename); exit(1); }

  fread(header, 18, 1, fp);

  TGAwidth  = header[13]*256+header[12];
  TGAheight = header[15]*256+header[14];

  if (TGAwidth!=width || TGAheight!=height)
  { if (pp!=NULL) free(pp);
    this->Create(TGAwidth, TGAheight);
  }
  
  if (header[16]==24) /* no alpha channel */
  { /* read pixels and convert...*/

	buf6 = new unsigned char[width*height*3];  
	fread(buf6,width*height*3,1,fp);
	
    for (y=0; y<height; y++)
    { for (x=0; x<width; x++)
      { 
      //fread(buf3,3,1,fp);  
	    pp[(y*width*4)+(x*4)+2] = buf6[y*width*3+x*3+0]; /* blue  */
        pp[(y*width*4)+(x*4)+1] = buf6[y*width*3+x*3+1]; /* green */
        pp[(y*width*4)+(x*4)+0] = buf6[y*width*3+x*3+2]; /* red   */
        pp[(y*width*4)+(x*4)+3] = 255;     /* alpha */
      }  
    } 
    delete buf6;
    buf6=NULL;  
  }
  else
  if (header[16]==32) /* alpha channel */
  { /* read pixels and convert...*/
  	buf5 = new unsigned char[width*height*4];
  	fread(buf5,width*height*4,1,fp);
    for (y=0; y<height; y++)
    { for (x=0; x<width; x++)
      { //fread(buf4,4,1,fp);
        
	    pp[(y*width*4)+(x*4)+2] = buf5[y*width*4+x*4+0]; /* blue  */
        pp[(y*width*4)+(x*4)+1] = buf5[y*width*4+x*4+1]; /* green */
        pp[(y*width*4)+(x*4)+0] = buf5[y*width*4+x*4+2]; /* red   */
        pp[(y*width*4)+(x*4)+3] = buf5[y*width*4+x*4+3]; /* alpha */
      }  
    }   
	delete buf5;
	buf5=NULL;
  }

  fclose(fp);
}

// ========================================================================================================================
