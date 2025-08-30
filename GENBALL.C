
#include <stdio.h>
#include <conio.h>
#include <math.h>
#include <string.h>
#include "polygon.h"
#include "bsp.h"
#include "object.h"
//#define PI  3.14159265358979323846
//#define DOUBLE_TO_FIXED(x) ((long) (x * 65536.0 + 0.5))

void Print4Indexes(int, int, int, int, int);
void Print5Indexes(int, int, int, int, int, int);

/* Used to rotate around the Y axis by one band's width */
double YXform[4][4]; 

/* Used to rotate around the Z axis by one band's width */
double ZXform[4][4]; 

Point444 Pointlist[1000];
int NumPoints = 0;

static FILE *OutputFile;   /* where we'll write to */

int FirstUnitNormalIndex;
   FACE *movingfList;
   
   float           xx, yy, zz;
   float           uu, vv;
   VERTEX          movingtryyy;
   
   COLOR           movingcolor;
   PLANE           movingplane;
   VERTEX         *movingvList = NULL_VERTEX, *movingvListTail = NULL_VERTEX;
   
   FACE           *movingfListTail = NULL_FACE;


void MakeSphere(OLDPOINT center,int Radius,int Bands)
{
   int movingspecial = 2; //1 = roterend 2 = moving
   //int Radius, Bands 
   int i, j, LastIndex, BandsX2, LastBandStartIndex;
   int TopBandStartIndex, BottomBandStartIndex, FaceNum;
   Point444 BaseVec, BandVec, WorkingVec, TempVec;
   //char OutputFilename[130];
   //char Description[130];
   



   movingvList = NULL_VERTEX;
   movingfList = NULL_FACE;
   movingcolor = 8;
   /* start new vertex list */
   movingvList = movingvListTail = NULL_VERTEX;
   movingvListTail = NULL_VERTEX;
   
   movingfListTail = NULL_FACE ;
   
   BandsX2 = Bands*2;
   NumPoints = 0;
   
   for (i = 0 ; i < 4 ; i++) 
     for (j = 0; j < 4 ; j++) {
     YXform[i][j] = 0;
     ZXform[i][j] = 0;
     }
   YXform [0][0] = 1;
   YXform [1][1] = 1;
   YXform [2][2] = 1;
   YXform [3][3] = 1;
   ZXform [0][0] = 1;
   ZXform [1][1] = 1;
   ZXform [2][2] = 1;
   ZXform [3][3] = 1;




   /*
   for (i = 0 ; i < 1000 ; i++) {
   Pointlist[i].X = 111110;
   Pointlist[i].Y = 111110;
   Pointlist[i].Z = 111110;
   Pointlist[i].W = 111110;

   };
   */
   /* Descriptive comments */
  // fprintf(OutputFile, "/* %s */\n", &Description[2]);
  // fprintf(OutputFile, "/* Created with radius = %d, bands = %d */\n",
  //       Radius, Bands);

   /* Defines for # of faces and vertices */
 //  fprintf(OutputFile, "#define NUM_FACES %d\n", BandsX2*Bands);
 //  fprintf(OutputFile, "#define NUM_VERTS %d\n\n",
 //        2+1+BandsX2*(Bands-1)+1+ (BandsX2*Bands));
   /* # of vertices excluding unit normal endpoints */
 //  fprintf(OutputFile, "#define NUM_REAL_VERTS %d\n\n",
 //        2+1+BandsX2*(Bands-1)+1);

   /* Do the polygon vertices */
 //  fprintf(OutputFile, "Point3 Verts[] = {\n");

	/* Generate the rotation matrices */
   AppendRotationY(YXform, PI / Bands);
   AppendRotationZ(ZXform, PI / Bands);

   /* Do the point at the top */
   BaseVec.X = 0.0;
   BaseVec.Y = Radius;
   BaseVec.Z = 0.0;
   BaseVec.W = 1.0;
   //PrintVertex(&BaseVec);
   Pointlist[NumPoints++] = BaseVec; //*Vec; /* remember this point */


   BandVec = BaseVec;

   /* Do the vertices in each band in turn */
   for (i=1; i<Bands; i++) {
      /* Rotate around Z to the next band's latitude */
      XformVec(ZXform, (double *)&BandVec, (double *)&TempVec);
      WorkingVec = BandVec = TempVec;
		/* Do the vertices in this band */
      for (j=0; j<BandsX2; j++) {
	 WorkingVec = TempVec;
	 //PrintVertex(&WorkingVec);
   Pointlist[NumPoints++] = WorkingVec;//*Vec; /* remember this point */

	 
	 /* Now rotate around Y to the next vertex's longitude */
	 XformVec(YXform, (double *)&WorkingVec, (double *)&TempVec);
      }
   }

   /* Do the point at the bottom */
   BaseVec.Y = -Radius;
   //PrintVertex(&BaseVec);
   Pointlist[NumPoints++] = BaseVec;//*Vec; /* remember this point */


   /* Done generating points, including both polygon vertices and unit
      normals */

   /* Do the vertex indexes for each face in each band */
   FaceNum = 0;
   /* Vertex indexes in top band, with unit normal endpoint first */
   for (i=0; i<BandsX2; i++) {
      Print4Indexes(FaceNum++, FirstUnitNormalIndex++, 0,
	    ((i+1)%BandsX2)+1, i+1);
   }

   /* Vertex indexes in middle bands, with unit normal endpoints first */
   for (j=0; j<(Bands-2); j++) {
      TopBandStartIndex = j*BandsX2 + 1;
      BottomBandStartIndex = (j+1)*BandsX2 + 1;
		/* Indexes in this band */
      for (i=0; i<BandsX2; i++) {
	 Print5Indexes(FaceNum++, FirstUnitNormalIndex++,
	       i+TopBandStartIndex,
	       ((i+1)%BandsX2)+TopBandStartIndex,
	       ((i+1)%BandsX2)+BottomBandStartIndex,
	       i+BottomBandStartIndex);
      
      }
   }
   movingcolor+=128;
   /* Vertex indexes in bottom band, with unit normal endpoint first */
   LastIndex = BandsX2*(Bands-1)+1;
   LastBandStartIndex = BandsX2*(Bands-2)+1;
   for (i=0; i<BandsX2; i++) {
      Print4Indexes(FaceNum++, FirstUnitNormalIndex++,
	    LastIndex,
	    LastBandStartIndex+i,
	    LastBandStartIndex+((i+1)%BandsX2)
	    );
   }

AddObject (center,movingfList,movingspecial);

}

/*
Add 4-vertex face
*/
void Print5Indexes(int FaceNum, int V1, int V2, int V3, int V4, int V5)
{

   xx = Pointlist[V2].X; yy = Pointlist[V2].Y; zz = Pointlist[V2].Z;
   uu = 0; vv = 0;
   appendVertex(&movingvList, &movingvListTail, allocVertex(xx, yy, zz, uu, vv));
   xx = Pointlist[V3].X; yy = Pointlist[V3].Y; zz = Pointlist[V3].Z;
   uu = 31; vv = 0;
   appendVertex(&movingvList, &movingvListTail, allocVertex(xx, yy, zz, uu, vv));
   xx = Pointlist[V4].X; yy = Pointlist[V4].Y; zz = Pointlist[V4].Z;
   uu = 31; vv = 31;
   appendVertex(&movingvList, &movingvListTail, allocVertex(xx, yy, zz, uu, vv));
   xx = Pointlist[V5].X; yy = Pointlist[V5].Y; zz = Pointlist[V5].Z;
   uu = 0; vv = 31;
   appendVertex(&movingvList, &movingvListTail, allocVertex(xx, yy, zz, uu, vv));
      
      appendVertex(&movingvList, &movingvListTail,      /* append duplicate 1st
							 * vertex */
		   allocVertex(movingvList->xx, movingvList->yy, movingvList->zz, movingvList->uu,
			       movingvList->vv));
      computePlane(movingvList->xx, movingvList->yy, movingvList->zz,
      movingvList->vnext->xx, movingvList->vnext->yy, movingvList->vnext->zz,
		   movingvList->vnext->vnext->xx,
		   movingvList->vnext->vnext->yy, movingvList->vnext->vnext->zz, &movingplane);
      appendFace(&movingfList, &movingfListTail, allocmovingFace(&movingtryyy, &movingtryyy, &movingtryyy, &movingcolor, movingvList, &movingplane));
	    /* add previous object */

      movingvList = movingvListTail = NULL_VERTEX;
     

}

/* Adds 3-vertex face */

void Print4Indexes(int FaceNum, int V1, int V2, int V3, int V4)

{

   xx = Pointlist[V2].X; yy = Pointlist[V2].Y; zz = Pointlist[V2].Z;
   uu = 15; vv = 0;
   appendVertex(&movingvList, &movingvListTail, allocVertex(xx, yy, zz, uu, vv));
   xx = Pointlist[V3].X; yy = Pointlist[V3].Y; zz = Pointlist[V3].Z;
   uu = 31; vv = 31;
   appendVertex(&movingvList, &movingvListTail, allocVertex(xx, yy, zz, uu, vv));
   xx = Pointlist[V4].X; yy = Pointlist[V4].Y; zz = Pointlist[V4].Z;
   uu = 0; vv = 31;
   appendVertex(&movingvList, &movingvListTail, allocVertex(xx, yy, zz, uu, vv));
      
      appendVertex(&movingvList, &movingvListTail,      /* append duplicate 1st
							 * vertex */
		   allocVertex(movingvList->xx, movingvList->yy, movingvList->zz, movingvList->uu,
			       movingvList->vv));
      computePlane(movingvList->xx, movingvList->yy, movingvList->zz,
      movingvList->vnext->xx, movingvList->vnext->yy, movingvList->vnext->zz,
		   movingvList->vnext->vnext->xx,
		   movingvList->vnext->vnext->yy, movingvList->vnext->vnext->zz, &movingplane);
      appendFace(&movingfList, &movingfListTail, allocmovingFace(&movingtryyy, &movingtryyy, &movingtryyy, &movingcolor, movingvList, &movingplane));
	    /* add previous object */
      movingvList = movingvListTail = NULL_VERTEX;
      

}

   
	   
   
   

