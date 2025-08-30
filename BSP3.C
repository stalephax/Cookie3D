
/* bspMemory.c: module to allocate and free memory and also to count them.
 * Copyright (c) Norman Chin 
 */
#include "bsp.h"                
#include "global.h"
#define MAX_CANDIDATES 50

BSPNODE        *root;

static long memoryCount= 0L;

/* Allocates memory of num bytes */
char *MYMALLOC(unsigned num)
{
   char *memory= malloc(num);   /* checked for null by caller */

   ++memoryCount;               /* increment memory counter for debugging */
   return(memory);
} /* myMalloc() */

/* Frees memory pointed to by ptr */
void MYFREE(char *ptr) 
{
   --memoryCount;               /* decrement memory counter for debugging */
   free(ptr);
} /* myFree() */

/* Returns how many memory blocks are still allocated up to this point */
long MYMEMORYCOUNT(void)
{
   return(memoryCount);
} /* myMemoryCount() */

/*** bspMemory.c ***/

/* partition.c: module to partition 3D convex face with an arbitrary plane.
 * Copyright (c) Norman Chin
 */ 
#include "bsp.h"

#define PREPEND_FACE(f,fl) (f->fnext= fl, fl= f)
#define ISVERTEX_EQ(v1,v2) \
			  (IS_EQ((v1)->xx,(v2)->xx) && \
			   IS_EQ((v1)->yy,(v2)->yy) && \
			   IS_EQ((v1)->zz,(v2)->zz))

/* local functions */
static VERTEX *findNextIntersection(VERTEX *vstart, const PLANE *plane,
				    float *ixx, float *iyy, float *izz,
				    float *iuu,float *ivv,
				    SIGN *sign);
static FACE *createOtherFace(FACE *face, VERTEX *v1, float ixx1, 
			     float iyy1, float izz1,
			     float iuu1,float ivv1,VERTEX *v2,
			     float ixx2, float iyy2, float izz2,
			     float iuu2,float ivv2
			     );
static SIGN whichSideIsFaceWRTplane(FACE *face, const PLANE *plane); 

/* Partitions a 3D convex polygon (face) with an arbitrary plane into its 
 * negative and positive fragments, if any, w.r.t. the partitioning plane.
 * Note that faceList is unusable afterwards since its vertex list has been
 * parceled out to the other faces. It's set to null to avoid dangling
 * pointer problem. Faces embedded in the plane are separated into two lists,
 * one facing the same direction as the partitioning plane, faceSameDir, and 
 * the other facing the opposite direction, faceOppDir.
 */
void BSPpartitionFaceListWithPlane(const PLANE *plane,FACE **faceList,
				   FACE **faceNeg, FACE **facePos,
				   FACE **faceSameDir, FACE **faceOppDir)
{
FACE *ftrav= *faceList;

*faceSameDir= *faceOppDir = *faceNeg= *facePos= NULL_FACE;

while (ftrav != NULL_FACE) {
   VERTEX *v1, *v2; FACE *nextFtrav;
   float ixx1,iyy1,izz1, ixx2,iyy2,izz2;
   float iuu1,ivv1,iuu2,ivv2;
   SIGN signV1, signV2;

   nextFtrav= ftrav->fnext;     /* unchain current face from list */
   ftrav->fnext= NULL_FACE;

   /* find first intersection */
   v1= findNextIntersection(ftrav->vhead,plane,&ixx1,&iyy1,&izz1,&iuu1,
				&ivv1,&signV1);
   if (v1 != NULL_VERTEX) {
      assert(signV1 != ZERO);

      /* first one found, find the 2nd one, if any */
      v2= findNextIntersection(v1->vnext,plane,&ixx2,&iyy2,&izz2,
				&iuu2,&ivv2,&signV2);

      /* Due to numerical instabilities, both intersection points may
       * have the same sign such as in the case when splitting very close
       * to a vertex. This should not count as a split.
       */
      if (v2 != NULL_VERTEX && signV1 == signV2) v2= NULL_VERTEX; 

   }
   else v2= NULL_VERTEX;        /* No first intersection found,
				 * therefore no second intersection.
				 */
				
   /* an intersection? */
   if (v1 != NULL_VERTEX && v2 != NULL_VERTEX) { /* yes, intersection */
      FACE *newOtherFace;

      /* ftrav's vertex list will be modified */
      newOtherFace= createOtherFace(ftrav,v1,ixx1,iyy1,izz1,
				    iuu1,ivv1,    
				    v2,ixx2,iyy2,izz2,
				    iuu2,ivv2
				    );

      /* return split faces on appropriate lists */
      if (signV1 == NEGATIVE) { 
	 PREPEND_FACE(ftrav,*faceNeg);
	 PREPEND_FACE(newOtherFace,*facePos);
      }
      else {
	 assert(signV1 == POSITIVE);
	 PREPEND_FACE(newOtherFace,*faceNeg);
	 PREPEND_FACE(ftrav,*facePos);
      }
				    
   }
   else {                       /* no intersection  */
      SIGN side;

      /* Face is embedded or wholly to one side of partitioning plane. */
      side= whichSideIsFaceWRTplane(ftrav,plane);
      if (side == NEGATIVE) 
	 PREPEND_FACE(ftrav,*faceNeg);
      else if (side == POSITIVE) 
	 PREPEND_FACE(ftrav,*facePos);
      else {
	 assert(side == ZERO);
	 if (IS_EQ(ftrav->plane.aa,plane->aa) && 
	     IS_EQ(ftrav->plane.bb,plane->bb) &&
	     IS_EQ(ftrav->plane.cc,plane->cc)) 
	    PREPEND_FACE(ftrav,*faceSameDir);
	 else PREPEND_FACE(ftrav,*faceOppDir);
      }
   }
   ftrav= nextFtrav;            /* get next */
} /* while ftrav != NULL_FACE */

   /* faceList's vertex list has been parceled out to other lists so
    * set this to null.
    */
   *faceList= NULL_FACE;                
#if 0 /* only true for BSPconstructTree() */
   /* there's at least one face embedded in the partitioning plane */
   assert(*faceSameDir != NULL_FACE); 
#endif
} /* BSPpartitionFaceListWithPlane() */
			    
/* Finds next intersection on or after vstart. 
 * 
 * If an intersection is found, 
 *    a pointer to first vertex of the edge is returned, 
 *    the intersection point (ixx,iyy,izz) and its sign is updated. 
 * Otherwise a null pointer is returned.
 */
static VERTEX *findNextIntersection(VERTEX *vstart,const PLANE *plane,
				    float *ixx,float *iyy,float *izz,
				    float *iuu,float *ivv,
				    SIGN *sign)
{
   VERTEX *vtrav;

   /* for all edges starting from vstart ... */
   for (vtrav= vstart; vtrav->vnext != NULL_VERTEX; vtrav= vtrav->vnext) {
      if ((*sign= anyEdgeIntersectWithPlane(vtrav->xx,vtrav->yy,vtrav->zz,
					    vtrav->uu,vtrav->vv,
					    vtrav->vnext->xx,vtrav->vnext->yy,
					    vtrav->vnext->zz,
					    vtrav->vnext->uu,vtrav->vnext->vv,
					    plane,
					    ixx,iyy,izz,iuu,ivv))) {
	 return(vtrav);
      }
   }

   return(NULL_VERTEX);
} /* findNextIntersection() */

/* Memory allocated for split face's vertices and pointers tediously updated.
 *
 * face - face to be split
 * v1   - 1st vertex of edge of where 1st intersection was found 
 * (ixx1,iyy1,izz1) - 1st intersection
 * v2   - 1st vertex of edge of where 2nd intersection was found 
 * (ixx2,iyy2,izz2) - 2nd intersection
 */
static FACE *createOtherFace(FACE *face, 
			     VERTEX *v1,
			     float ixx1, float iyy1, float izz1,
			     float iuu1,float ivv1,
			     VERTEX *v2, float ixx2, float iyy2, float izz2,
			     float iuu2,float ivv2
			     )
{
   VERTEX *i1p1, *i2p1;         /* new vertices for original face  */
   VERTEX *i1p2, *i2p2;         /* new vertices for new face */
   VERTEX *p2end;               /* new vertex for end of new face */
   VERTEX *vtemp;               /* place holders */
   register VERTEX *beforeV2;   /* place holders */
   FACE *newFace;               /* newly allocated face */

   /* new intersection vertices */
   i1p1= allocVertex(ixx1,iyy1,izz1,iuu1,ivv1); 
   i2p1= allocVertex(ixx2,iyy2,izz2,iuu2,ivv2);
   i1p2= allocVertex(ixx1,iyy1,izz1,iuu1,ivv1);
   i2p2= allocVertex(ixx2,iyy2,izz2,iuu2,ivv2); 

   /* duplicate 1st vertex of 2nd list to close it up */
   p2end= allocVertex(v2->xx,v2->yy,v2->zz,v2->uu,v2->vv);

   vtemp= v1->vnext;

   /* merge both intersection vertices i1p1 & i2p1 into 1st list */
   if (ISVERTEX_EQ(i2p1,v2->vnext)) { /* intersection vertex coincident? */
      assert(i2p1->vnext == NULL_VERTEX);
      freeVertexList(&i2p1);    /* yes, so free it */
      i1p1->vnext= v2->vnext;
   }
   else {
      i2p1->vnext= v2->vnext;   /* attach intersection list onto 1st list */
      i1p1->vnext= i2p1;        /* attach both intersection vertices */
   }
   v1->vnext= i1p1; /* attach front of 1st list to intersection vertices */

   /* merge intersection vertices i1p2, i2p2 & p2end into second list */
   i2p2->vnext= i1p2;           /* attach both intersection vertices */
   v2->vnext= i2p2;             /* attach 2nd list to interection vertices */
   if (vtemp == v2) {
      i1p2->vnext= p2end;       /* close up 2nd list */
   }
   else {
      if (ISVERTEX_EQ(i1p2,vtemp)) { /* intersection vertex coincident? */
	 assert(i1p2->vnext == NULL_VERTEX);
	 freeVertexList(&i1p2); /* yes, so free it */
	 i2p2->vnext= vtemp;    /* attach intersection vertex to 2nd list */
      }
      else {
	 i1p2->vnext= vtemp;    /* attach intersection list to 2nd list */
      }
      /* find previous vertex to v2 */
      for (beforeV2= vtemp; beforeV2->vnext != v2; beforeV2= beforeV2->vnext)
	 ;                      /* lone semi-colon */
      beforeV2->vnext= p2end;   /* and attach it to complete the 2nd list */
   }

   /* copy original face info but with new vertex list */
   newFace= allocFace(&face->P,&face->M,&face->N,&face->color,v2,&face->plane);

   return(newFace);
} /* createOtherFace() */

/* Determines which side a face is with respect to a plane.
 *
 * However, due to numerical problems, when a face is very close to the plane,
 * some vertices may be misclassified. 
 * There are several solutions, two of which are mentioned here:
 *    1- classify the one vertex furthest away from the plane, (note that
 *       one need not compute the actual distance) and use that side.
 *    2- count how many vertices lie on either side and pick the side
 *       with the maximum. (this is the one implemented).
 */
static SIGN whichSideIsFaceWRTplane(FACE *face, const PLANE *plane)
{
   register VERTEX *vtrav;
   float value;
   myboolean isNeg, isPos;

   isNeg= isPos= FALSE;
   
   for (vtrav= face->vhead; vtrav->vnext != NULL_VERTEX; vtrav= vtrav->vnext){
      value= (plane->aa*vtrav->xx) + (plane->bb*vtrav->yy) + 
	     (plane->cc*vtrav->zz) + plane->dd;
      if (value < -TOLER) 
	 isNeg= TRUE;
      else if (value > TOLER)
	 isPos= TRUE;
      else assert(IS_EQ(value,0.0));
   } /* for vtrav */ 

   /* in the very rare case that some vertices slipped thru to other side of
    * plane due to round-off errors, execute the above again but count the 
    * vertices on each side instead and pick the maximum.
    */
   if (isNeg && isPos) {        /* yes so handle this numerical problem */
      int countNeg, countPos;
      
      /* count how many vertices are on either side */
      countNeg= countPos= 0;
      for (vtrav= face->vhead; vtrav->vnext != NULL_VERTEX; 
	   vtrav= vtrav->vnext) {
	 value= (plane->aa*vtrav->xx) + (plane->bb*vtrav->yy) + 
		(plane->cc*vtrav->zz) + plane->dd;
	 if (value < -TOLER)
	    countNeg++;
	 else if (value > TOLER)
	    countPos++;
	 else assert(IS_EQ(value,0.0));
      } /* for */

      /* return the side corresponding to the maximum */
      if (countNeg > countPos) return(NEGATIVE);
      else if (countPos > countNeg) return(POSITIVE);
      else return(ZERO);
   }
   else {                       /* this is the usual case */
      if (isNeg) return(NEGATIVE);
      else if (isPos) return(POSITIVE);
      else return(ZERO);
   }
} /* whichSideIsFaceWRTplane() */

/* Determines if an edge bounded by (x1,y1,z1)->(x2,y2,z2) intersects
 * the plane.
 * 
 * If there's an intersection, 
 *    the sign of (x1,y1,z1), NEGATIVE or POSITIVE, w.r.t. the plane is
 *    returned with the intersection (ixx,iyy,izz) updated.
 * Otherwise ZERO is returned.    
 */
SIGN anyEdgeIntersectWithPlane(float x1,float y1,float z1,
			       float u1,float v1,
			       float x2,float y2,float z2,
			       float u2,float v2,
			       const PLANE *plane,
			       float *ixx, float *iyy, float *izz,
			       float *iuu,float *ivv
			       )
{
   float temp1, temp2;
   int sign1, sign2;            /* must be int since gonna do a bitwise ^ */
   float aa= plane->aa; float bb= plane->bb; float cc= plane->cc;
   float dd= plane->dd;

   /* get signs */
   temp1= (aa*x1) + (bb*y1) + (cc*z1) + dd;
   if (temp1 < -TOLER)
      sign1= -1;
   else if (temp1 > TOLER)
      sign1= 1;
   else {
      /* edges beginning with a 0 sign are not considered valid intersections
       * case 1 & 6 & 7, see Gems III.
       */
      assert(IS_EQ(temp1,0.0));
      return(ZERO);
   }

   temp2= (aa*x2) + (bb*y2) + (cc*z2) + dd;
   if (temp2 < -TOLER)
      sign2= -1;
   else if (temp2 > TOLER)
      sign2= 1;
   else {                       /* case 8 & 9, see Gems III */
      assert(IS_EQ(temp2,0.0));
      *ixx= x2;
      *iyy= y2;
      *izz= z2;
      *iuu= u2;
      *ivv= v2;

      return( (sign1 == -1) ? NEGATIVE : POSITIVE);
   }

   /* signs different? 
    * recall: -1^1 == 1^-1 ==> 1    case 4 & 5, see Gems III
    *         -1^-1 == 1^1 ==> 0    case 2 & 3, see Gems III
    */
   if (sign1 ^ sign2) {
      float dx,dy,dz;
      float du,dv;

      float denom, tt;

      /* compute intersection point */
      dx= x2-x1;
      dy= y2-y1;
      dz= z2-z1;
      du= u2-u1;
      dv= v2-v1;
      
      denom= (aa*dx) + (bb*dy) + (cc*dz);
      
      tt= - ((aa*x1) + (bb*y1) + (cc*z1) + dd) / denom;

      *ixx= x1 + (tt * dx);
      *iyy= y1 + (tt * dy);
      *izz= z1 + (tt * dz);
      *iuu= u1 + (tt * du);
      *ivv= v1 + (tt * dv);

      assert(sign1 == 1 || sign1 == -1);

      return( (sign1 == -1) ? NEGATIVE : POSITIVE );
   }
   else return(ZERO);

} /* anyEdgeIntersectWithPlane() */
/*** bspPartition.c ***/
/* bspUtility.c: module to compute plane equation, normalize a vector and 
 * perform cross products. 
 * Copyright (c) Norman Chin 
 */
#include "bsp.h"

/* local functions */
static void crossProduct(float ii,float jj,float kk,
			 float ii2,float jj2,float kk2,
			 float *iicp,float *jjcp,float *kkcp);

/* Computes plane equation.
 *
 * xx0,yy0,zz0, xx1,yy1,zz1, xx2,yy2,zz2 - 3 non-collinear vertices 
 * plane                                 - plane equation returned
 */
void computePlane(float xx0,float yy0,float zz0,float xx1,float yy1,float zz1,
		  float xx2,float yy2,float zz2, PLANE *plane)
{
   float ii1= xx1 - xx0; float jj1= yy1 - yy0; float kk1= zz1 - zz0;
   float ii2= xx2 - xx0; float jj2= yy2 - yy0; float kk2= zz2 - zz0;
   float iicp, jjcp, kkcp;

   crossProduct(ii1,jj1,kk1,ii2,jj2,kk2,&iicp,&jjcp,&kkcp);
   assert(!(IS_EQ(iicp,0.0) && IS_EQ(jjcp,0.0) && IS_EQ(kkcp,0.0)));

   /* normalize plane equation */
   normalizeVector(iicp,jjcp,kkcp,&plane->aa,&plane->bb,&plane->cc);

   /* compute D of plane equation */
   plane->dd= - (plane->aa * xx0) - (plane->bb * yy0) - (plane->cc * zz0); 
} /* computePlane() */

/* Performs cross product.
 *
 * ii1,jj1,kk1, ii2,j2,kk2 - two vectors
 * iicp,jjcp,kkcp          - cross product
 */
static void crossProduct(float ii1,float jj1,float kk1,
			 float ii2,float jj2,float kk2,
			 float *iicp,float *jjcp,float *kkcp)
{
 *iicp= jj1*kk2 - jj2*kk1 ;
 *jjcp= ii2*kk1 - ii1*kk2  ;
 *kkcp= ii1*jj2 - ii2*jj1  ;
} /* crossProduct() */

/* Normalize a vector.
 *
 * ii,jj,kk    - vector to be normalized  
 * ii2,jj2,kk2 - vector normalized
 */
void normalizeVector(float ii,float jj,float kk,
			    float *ii2,float *jj2,float *kk2)
{  float         magnitude ,dfactor;
   magnitude= sqrt((float)ii*ii + (float)jj*jj + (float)kk*kk);
   dfactor= 1.0 / magnitude;

   *ii2= (float) (ii * dfactor);
   *jj2= (float) (jj * dfactor);
   *kk2= (float) (kk * dfactor);
} /* normalizeVector() */ 
/*** bspUtility.c ***/
/* bspAlloc.c: module to allocate, free and append vertices and faces.
 * Copyright (c) Norman Chin 
 */
#include "bsp.h"

/* Allocates a vertex with position (xx,yy,zz) */
VERTEX *allocVertex(float xx,float yy,float zz,float uu,float vv)
{
   VERTEX *newVertex;

   if ((newVertex= (VERTEX *) MYMALLOC(sizeof(VERTEX))) == NULL_VERTEX) {
      fprintf(stderr,"?Unable to malloc vertex, linenumber %i\n",linenumber);
      exit(-1);
   }
   newVertex->xx= xx; newVertex->yy= yy; newVertex->zz= zz;
   newVertex->uu= uu; newVertex->vv= vv; 

   newVertex->vnext= NULL_VERTEX;

   return(newVertex);
} /* allocVertex() */

/* Allocates a face with color, a list of vertices, a plane equation.
 */
FACE *allocFace(const VERTEX *P,const VERTEX *M,const VERTEX *N,const COLOR *color,VERTEX *vlist,const PLANE *plane)
{
   FACE *newFace;

   if ((newFace= (FACE *) MYMALLOC(sizeof(FACE))) == NULL_FACE) {
      fprintf(stderr,"?Unable to alloc face.\n");
      exit(1);
   }
   newFace->color= *color;
   newFace->P = *P;
   newFace->M = *M;
   newFace->N = *N;

   newFace->vhead= vlist;
   newFace->plane= *plane;
   newFace->fnext= NULL_FACE;

   return(newFace);
} /* allocFace() */
FACE *allocmovingFace(const VERTEX *P,const VERTEX *M,const VERTEX *N,const COLOR *color,VERTEX *vlist,const PLANE *plane)
{
   FACE *newFace;

   if ((newFace= (FACE *) MYMALLOC(sizeof(FACE))) == NULL_FACE) {
      fprintf(stderr,"?Unable to alloc face.\n");
      exit(-1);
   }
   newFace->color= *color;
   newFace->P = *P;
   newFace->M = *M;
   newFace->N = *N;

   newFace->vhead= vlist;
   newFace->plane= *plane;
   newFace->fnext= NULL_FACE;

   return(newFace);
} /* allocFace() */

/* Append a vertex to a list. */
void appendVertex(VERTEX **vhead,VERTEX **vtail,VERTEX *vertex)
{
   assert( (*vhead == NULL_VERTEX) ? (*vtail == NULL_VERTEX) : 1 );
   assert(vertex != NULL_VERTEX);

   if (*vhead == NULL_VERTEX)
      *vhead= vertex;
   else (*vtail)->vnext= vertex;

   *vtail= vertex;              /* update tail */
} /* appendVertex() */

/* Append a face to a list. */
void appendFace(FACE **fhead,FACE **ftail,FACE *face)
{
   assert( (*fhead == NULL_FACE) ? (*ftail == NULL_FACE) : 1 );
   assert(face != NULL_FACE);

   if (*fhead == NULL_FACE)
      *fhead= face;
   else (*ftail)->fnext= face;

   *ftail= face;                /* update tail */
} /* appendFace() */

/* Frees list of vertices. */
void freeVertexList(VERTEX **vlist)
{
   VERTEX *vtrav= *vlist, *vdel;
   while (vtrav != NULL_VERTEX) {
      vdel= vtrav; vtrav= vtrav->vnext;

      MYFREE((char *) vdel);
   }
   *vlist= NULL_VERTEX;
} /* freeVertexList() */

/* Frees list of faces. */
void freeFaceList(FACE **flist) 
{
   FACE *ftrav= *flist, *fdel;
   while (ftrav != NULL_FACE) {
      fdel= ftrav; ftrav= ftrav->fnext; freeVertexList(&fdel->vhead); 

      MYFREE((char *)fdel);

   }
   *flist= NULL_FACE;
} /* freeFaceList() */
/*** bspAlloc.c ***/
/* bspTree.c: module to construct and traverse a BSP tree.
 * Copyright (c) Norman Chin 
 */
#include "bsp.h"

/* local functions */
static void BSPchoosePlane(FACE *faceList,PLANE *plane);
static myboolean doesFaceStraddlePlane(const FACE *face,const PLANE *plane);
static BSPNODE *allocBspNode(NODE_TYPE kind,FACE *sameDir,FACE *oppDir);
static PARTITIONNODE *allocPartitionNode(FACE *sameDir,FACE *oppDir);
static void freePartitionNode(PARTITIONNODE **partitionNode);

/* Returns a BSP tree of scene from a list of convex faces.
 * These faces' vertices are oriented in counterclockwise order where the last 
 * vertex is a duplicate of the first, i.e., a square has five vertices. 
 *
 * faceList - list of faces
 */
BSPNODE *BSPconstructTree(FACE **faceList)
{
   BSPNODE *newBspNode; PLANE plane; 
   FACE *sameDirList,*oppDirList, *faceNegList,*facePosList;

   /* choose plane to split scene with */
   BSPchoosePlane(*faceList,&plane); 
   BSPpartitionFaceListWithPlane(&plane,faceList,&faceNegList,&facePosList,
				 &sameDirList,&oppDirList);

   assert(*faceList == NULL_FACE);

   //can do problems!!! assert(sameDirList != NULL_FACE);

   /* construct the tree */
   newBspNode= allocBspNode(PARTITION_NODE,sameDirList,oppDirList);

   /* construct tree's "-" branch */
   if (faceNegList == NULL_FACE) 
    newBspNode->node->negativeSide= allocBspNode(IN_NODE,NULL_FACE,NULL_FACE);
   else newBspNode->node->negativeSide= BSPconstructTree(&faceNegList);

   /* construct tree's "+" branch */
   if (facePosList == NULL_FACE) 
    newBspNode->node->positiveSide=allocBspNode(OUT_NODE,NULL_FACE,NULL_FACE);
   else newBspNode->node->positiveSide= BSPconstructTree(&facePosList);
   printf(".");
   return(newBspNode);
} /* BSPconstructTree() */

/* Traverses BSP tree to render scene back-to-front based on viewer position.
 *
 * bspNode  - a node in BSP tree
 * position - position of viewer
 */
/* Frees a BSP tree and sets pointer to it to null
 *
 * bspNode - a pointer to a node in BSP tree, set to null upon exit 
 */
void BSPfreeTree(BSPNODE **bspNode)
{
   if (*bspNode == NULL_BSPNODE) return;

   if ((*bspNode)->kind == PARTITION_NODE) 
      freePartitionNode(&(*bspNode)->node);

   MYFREE((char *) *bspNode); *bspNode= NULL_BSPNODE;

} /* BSPfreeTree() */

/* Chooses plane with which to partition. 
 * The algorithm is to examine the first MAX_CANDIDATES on face list. For
 * each candidate, count how many splits it would make against the scene.
 * Then return the one with the minimum amount of splits as the 
 * partitioning plane.
 *
 * faceList - list of faces
 * plane    - plane equation returned
 */
static void BSPchoosePlane(FACE *faceList,PLANE *plane)
{
   FACE *rootrav; int ii;
   int minCount= MAXINT; 
   FACE *chosenRoot= faceList;  /* pick first face for now */

   assert(faceList != NULL_FACE);
   /* for all candidates... */
   for (rootrav= faceList, ii= 0; rootrav != NULL_FACE && ii< MAX_CANDIDATES;
	rootrav= rootrav->fnext, ii++) {
      FACE *ftrav; int count= 0;
      /* for all faces in scene other than itself... */
      for (ftrav= faceList; ftrav != NULL_FACE; ftrav= ftrav->fnext) {
	 if (ftrav != rootrav) 
	    if (doesFaceStraddlePlane(ftrav,&rootrav->plane)) count++;
      }
      /* remember minimum count and its corresponding face */
      if (count < minCount) { minCount= count; chosenRoot= rootrav; }
      if (count == 0) break; /* can't do better than 0 so return this plane */
   }
   *plane= chosenRoot->plane;   /* return partitioning plane */
} /* BSPchoosePlane() */

/* Returns a myboolean to indicate whether the face straddles the plane
 *
 * face  - face to check 
 * plane - plane 
 */
static myboolean doesFaceStraddlePlane(const FACE *face, const PLANE *plane)
{
   myboolean anyNegative= 0, anyPositive= 0;
   VERTEX *vtrav; 

   assert(face->vhead != NULL_VERTEX);
   /* for all vertices... */
   for (vtrav= face->vhead; vtrav->vnext !=NULL_VERTEX; vtrav= vtrav->vnext) {
      float value= plane->aa*vtrav->xx + plane->bb*vtrav->yy +
		   plane->cc*vtrav->zz + plane->dd;
      /* check which side vertex is on relative to plane */
      SIGN sign= FSIGN(value);
      if (sign == NEGATIVE) anyNegative= 1; 
      else if (sign == POSITIVE) anyPositive= 1;

      /* if vertices on both sides of plane then face straddles else it no */  
      if (anyNegative && anyPositive) return(1);
   }
   return(0);
} /* doesFaceStraddlePlane() */

/* Returns a myboolean to indicate whether or not point is in + side of plane.
 * 
 * plane    - plane 
 * position - position of point
 */
myboolean BSPisViewerInPositiveSideOfPlane(const PLANE *plane,const OLDPOINT *position)
{
   float dp= plane->aa*position->xx + plane->bb*position->yy +
	     plane->cc*position->zz + plane->dd;
   return( (dp > 0.0) ? 1 : 0 );
} /* BSPisViewerInPositiveSideOfPlane() */

/* Allocates a BSP node.
 *
 * kind            - type of BSP node
 * sameDir, oppDir - list of faces to be embedded in this node 
 */
static BSPNODE *allocBspNode(NODE_TYPE kind,FACE *sameDir,FACE *oppDir)
{
   BSPNODE *newBspNode;
   if ((newBspNode= (BSPNODE *) MYMALLOC(sizeof(BSPNODE))) == NULL_BSPNODE) {
      fprintf(stderr,"?Unable to malloc bspnode.\n");
      exit(-1);
   }
   newBspNode->kind= kind;

   if (newBspNode->kind == PARTITION_NODE) 
      newBspNode->node= allocPartitionNode(sameDir,oppDir);
   else { assert(kind == IN_NODE || kind == OUT_NODE);
      assert(sameDir == NULL_FACE && oppDir == NULL_FACE);
      newBspNode->node= NULL_PARTITIONNODE;
   }
   return(newBspNode);
} /* allocBspNode() */

/* Allocates a partition node.
 * 
 * sameDir, oppDir - list of faces embedded in partition node
 */
static PARTITIONNODE *allocPartitionNode(FACE *sameDir,FACE *oppDir)
{
   PARTITIONNODE *newPartitionNode;
   if ((newPartitionNode= (PARTITIONNODE *) MYMALLOC(sizeof(PARTITIONNODE)))==
       NULL_PARTITIONNODE) {
      fprintf(stderr,"?Unable to malloc partitionnode.\n");
      exit(-1);
   }
   newPartitionNode->sameDir= sameDir; newPartitionNode->oppDir= oppDir;
   newPartitionNode->negativeSide= NULL_BSPNODE;
   newPartitionNode->positiveSide= NULL_BSPNODE;

   return(newPartitionNode);
} /* allocPartitionNode() */

/* Frees partition node and sets pointer to it to null.
 *
 * partitonNode - partition node to be freed, pointer is set to null
 */
static void freePartitionNode(PARTITIONNODE **partitionNode)
{
   freeFaceList(&(*partitionNode)->sameDir);
   freeFaceList(&(*partitionNode)->oppDir);
   BSPfreeTree(&(*partitionNode)->negativeSide);
   BSPfreeTree(&(*partitionNode)->positiveSide);

   MYFREE((char *) *partitionNode); *partitionNode= NULL_PARTITIONNODE;
} /* freePartitionNode() */

/* Dumps information on faces. This should be replaced with user-supplied    
 * polygon scan converter.
 */
/*** bspTree.c ***/ 
/* mainBsp.c: main driver of BSP application
 * Copyright (c) Norman Chin 
 */
#include "bsp.h"

#define MAXBUFFER 80
#define NOBLOCK 'n'
#define COMMENT ';'

/* local functions */
//int main(int argc,char *argv[]);
//void getScene(const char *fileName,OLDPOINT *position,FACE **faceList);
#define dumpPosition(p) (printf("Position: (%f,%f,%f)\n",p.xx,p.yy,p.zz))

/* Main driver */

/* Reads from fileName a list of convex planar faces oriented counter-clockwise
 * of at least 3 vertices each where the first three vertices are not 
 * collinear. The last vertex of each face will automatically be duplicated. 
 * This list of faces is returned.
 * 
 */ 
/*** mainBsp.c ***/
/* Main driver */
