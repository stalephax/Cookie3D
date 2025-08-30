/* bsp.h: header file for BSP tree algorithm
 * Copyright (c) Norman Chin 
 */
#ifndef _BSP_INCLUDED
#define _BSP_INCLUDED
#define NDEBUG 1
#define NODEBUG 1

#include <stdio.h>              
#include <stdlib.h>             /* exit() */
#include <assert.h>             /* assert() */
#include <math.h>               /* fabs() */
#include <malloc.h>
#include "global.h"
#include "ggems.h"
typedef int COLOR;
typedef struct { float xx,yy,zz; } OLDPOINT;
typedef struct { float aa,bb,cc,dd; } PLANE;

typedef struct vertexTag {
   float xx,yy,zz;              /* vertex position */
   float uu,vv;                 /* texture coordinates */
   struct vertexTag *vnext;     /* pointer to next vertex in CCW order */
   PLANE plane;                 /* plane equation of bounding face */
} VERTEX;
#define NULL_VERTEX ((VERTEX *) NULL)
#define dumpPosition(p) (printf("Position: (%f,%f,%f)\n",p.xx,p.yy,p.zz))

typedef struct faceTag {
//   int special;
//   int texoffset;
   COLOR color;                 /* color of face */
   VERTEX P,M,N;
   int bspdepth;                /* orientation of face for depthsort */
   VERTEX *vhead;               /* head of list of vertices */
   PLANE plane;                 /* plane equation of face */
   struct faceTag *fnext;       /* pointer to next face */
} FACE;
#define NULL_FACE ((FACE *) NULL)

typedef enum {PARTITION_NODE= 'p', IN_NODE= 'i', OUT_NODE= 'o'} NODE_TYPE; 

typedef struct partitionnodeTag {
   FACE *sameDir, *oppDir;      /* pointers to faces embedded in node */

   struct bspnodeTag *negativeSide, *positiveSide; /* "-" & "+" branches */
} PARTITIONNODE;
#define NULL_PARTITIONNODE ((PARTITIONNODE *) NULL)

typedef struct bspnodeTag {
   NODE_TYPE kind;              /* kind of BSP node */

   PARTITIONNODE *node; /* if kind == (IN_NODE || OUT_NODE) then NULL */
} BSPNODE;
#define NULL_BSPNODE ((BSPNODE *) NULL)

#define TOLER 0.0076

//#define TOLER 0.01

#define IS_EQ(a,b) ((fabs((float)(a)-(b)) >= (float) TOLER) ? 0 : 1)
typedef enum {NEGATIVE= -1, ZERO= 0, POSITIVE= 1} SIGN;
#define FSIGN(f) (((f) < -TOLER) ? NEGATIVE : ((f) > TOLER ? POSITIVE : ZERO))

/* external functions */
void normalizeVector(float ii,float jj,float kk,
			    float *ii2,float *jj2,float *kk2);

BSPNODE *BSPconstructTree(FACE **faceList);
myboolean BSPisViewerInPositiveSideOfPlane(const PLANE *plane,const OLDPOINT *position);
/* void BSPtraverseTreeAndRender(const BSPNODE *bspNode,const OLDPOINT *position);
   */
void BSPfreeTree(BSPNODE **bspNode);

myboolean BSPdidViewerCollideWithScene(const OLDPOINT *from, const OLDPOINT *to,
				     const BSPNODE *bspTree);

VERTEX *allocVertex(float xx,float yy,float zz,float uu,float vv);
FACE *allocFace(const VERTEX *P,const VERTEX *M,const VERTEX *N,const COLOR *color, VERTEX *vlist,const PLANE *plane);
FACE *allocmovingFace(const VERTEX *P,const VERTEX *M,const VERTEX *N,const COLOR *color, VERTEX *vlist,const PLANE *plane);

void appendVertex(VERTEX **vhead,VERTEX **vtail,VERTEX *vertex);
void appendFace(FACE **fhead,FACE **ftail,FACE *face);
void appendFace(FACE **fhead,FACE **ftail,FACE *face);

void freeVertexList(VERTEX **vlist);
void freeFaceList(FACE **flist);

void computePlane(float xx0,float yy0,float zz0,float xx1,float yy1,float zz1,
		  float xx2,float yy2,float zz2, PLANE *plane);

SIGN anyEdgeIntersectWithPlane(float x1, float y1, float z1,
			       float u1,float v1,  
			       float x2, float y2, float z2,
			       float u2,float v2,
			       const PLANE *plane,
			       float *ixx, float *iyy, float *izz,
			       float *iuu,float *ivv
			       );
void BSPpartitionFaceListWithPlane(const PLANE *plane,FACE **faceList,
				   FACE **faceNeg, FACE **facePos,
				   FACE **faceSameDir, FACE **faceOppDir);

char *MYMALLOC(unsigned num);
void MYFREE(char *ptr);
long MYMEMORYCOUNT(void);
extern BSPNODE        *root;

#endif  /* _BSP_INCLUDED */
