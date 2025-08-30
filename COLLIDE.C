#include "global.h"
#include "bsp.h"		/* for structures PLANE,FACE,VERTEX */
#include "ggems.h"		/* for myboolean type */
#include "3dmath.h"		/* for pointadd, pointscalar */
#include "collide.h"
myboolean         stuck;
float           GlobalDistance;
int             GlobalLastHit;
int             tempGlobalLastHit;
PLANE           GlobalHitPlaneNormal;
float           PlayerRadius;
float           testdelta = 0.0;

float
IntersectLinePlane(OLDPOINT * pos, OLDPOINT * dir, PLANE * plane)
{
   /* calculate intersection of line and plane */
   double          distance, d1, d2;
   d1 = -
      (plane->aa * pos->xx + plane->bb * pos->yy + plane->cc * pos->zz + plane->dd);
   d2 =
      (plane->aa * dir->xx + plane->bb * dir->yy + plane->cc * dir->zz);

   distance = d1 / d2;
   return ((float) distance);
}
float
DistancePointPlane(OLDPOINT * pos, PLANE * plane)
{
   /* calculate intersection of line and plane */
   /* if < 0 behind plane, else in front of plane */
   float           distance;
   distance = -
      (plane->aa * pos->xx + plane->bb * pos->yy + plane->cc * pos->zz + plane->dd);

   return ((float) distance);
}

float
IntersectRaySphere(OLDPOINT raybase, OLDPOINT raycos, OLDPOINT center, float radius)
{
   int             hit;		/* True if ray intersects sphere */
   float           result;
   float           dx, dy, dz;	/* Ray base to sphere center    */
   float           bsq, u, disc;
   float           root;
   dx = raybase.xx - center.xx;
   dy = raybase.yy - center.yy;
   dz = raybase.zz - center.zz;
   bsq = dx * raycos.xx + dy * raycos.yy + dz * raycos.zz;
   u = dx * dx + dy * dy + dz * dz - radius * radius;
   disc = bsq * bsq - u;
   hit = (disc > 0.0);

   if (hit) {			/* If ray hits sphere    */
      root = sqrt(disc);
      /* -bsq - root                    entering distance */
      /* -bsq + root                   leaving distance  */
      result = -bsq - radius;
   } else
      result = 0;

   return (result);
}

static void
trycrossProduct(float ii1, float jj1, float kk1,
		float ii2, float jj2, float kk2,
		float *iicp, float *jjcp, float *kkcp)
{
   *iicp = jj1 * kk2 - jj2 * kk1;
   *jjcp = ii2 * kk1 - ii1 * kk2;
   *kkcp = ii1 * jj2 - ii2 * jj1;
}				/* crossProduct() */

myboolean
trycomputePlane(float xx0, float yy0, float zz0, float xx1, float yy1, float zz1,
		float xx2, float yy2, float zz2, PLANE * plane)
{
   float           ii1 = xx1 - xx0;
   float           jj1 = yy1 - yy0;
   float           kk1 = zz1 - zz0;
   float           ii2 = xx2 - xx0;
   float           jj2 = yy2 - yy0;
   float           kk2 = zz2 - zz0;
   float           iicp, jjcp, kkcp;

   trycrossProduct(ii1, jj1, kk1, ii2, jj2, kk2, &iicp, &jjcp, &kkcp);
   if (IS_EQ(iicp, 0.0) && IS_EQ(jjcp, 0.0) && IS_EQ(kkcp, 0.0)) {
      return (FALSE);
   };
   assert(!(IS_EQ(iicp, 0.0) && IS_EQ(jjcp, 0.0) && IS_EQ(kkcp, 0.0)));

   /* normalize plane equation */
   normalizeVector(iicp, jjcp, kkcp, &plane->aa, &plane->bb, &plane->cc);

   /* compute D of plane equation */
   plane->dd = -(plane->aa * xx0) - (plane->bb * yy0) - (plane->cc * zz0);
   return (TRUE);
}				/* computePlane() */


void
CalculateBoundingPlanes(FACE * faceList)
{
   float           x0, x1, x2, y0, y1, y2, z0, z1, z2;
   FACE           *ftrav;

   for (ftrav = faceList; ftrav != NULL_FACE; ftrav = ftrav->fnext) {
      VERTEX         *firstvertex;
      VERTEX         *secondvertex;
      firstvertex = ftrav->vhead;

      for (secondvertex = ftrav->vhead->vnext; secondvertex != NULL_VERTEX;
	   secondvertex = secondvertex->vnext) {
	 x0 = firstvertex->xx;
	 x1 = firstvertex->xx - 10 * ftrav->plane.aa;
	 x2 = secondvertex->xx;
	 y0 = firstvertex->yy;
	 y1 = firstvertex->yy - 10 * ftrav->plane.bb;
	 y2 = secondvertex->yy;
	 z0 = firstvertex->zz;
	 z1 = firstvertex->zz - 10 * ftrav->plane.cc;
	 z2 = secondvertex->zz;
	 computePlane(x0, y0, z0, x1, y1, z1, x2, y2, z2, &firstvertex->plane);

	 firstvertex = secondvertex;
      };
   }

}				/* CalculateBoundingPlanes() */
void
BSPtraverseTreeAndCalculateBoundingPlanes(BSPNODE * bspNode, OLDPOINT * position)
{

   if (bspNode == NULL_BSPNODE)
      return;

   if (bspNode->kind == PARTITION_NODE) {
      if (BSPisViewerInPositiveSideOfPlane(&bspNode->node->sameDir->plane, position)) {

	 BSPtraverseTreeAndCalculateBoundingPlanes(bspNode->node->negativeSide, position);
	 CalculateBoundingPlanes(bspNode->node->sameDir);
	 CalculateBoundingPlanes(bspNode->node->oppDir);	/* back-face cull */
	 BSPtraverseTreeAndCalculateBoundingPlanes(bspNode->node->positiveSide, position);

      } else {

	 BSPtraverseTreeAndCalculateBoundingPlanes(bspNode->node->positiveSide, position);
	 CalculateBoundingPlanes(bspNode->node->oppDir);
	 CalculateBoundingPlanes(bspNode->node->sameDir);	/* back-face cull */
	 BSPtraverseTreeAndCalculateBoundingPlanes(bspNode->node->negativeSide, position);

      }
   } else
      assert(bspNode->kind == IN_NODE || bspNode->kind == OUT_NODE);
}				/* BSPtraverseTreeAndCalculateBoundingPlane() */

/*
 * Returns true if polygon faces the viewpoint, assuming a clockwise winding
 * of vertices as seen from the front.
 */
int
VertexPlaneFacesViewer(VERTEX * vertex, OLDPOINT * positie)
{
   OLDPOINT           viewvec, normal;
   viewvec.xx = vertex->xx - positie->xx;
   viewvec.yy = vertex->yy - positie->yy;
   viewvec.zz = vertex->zz - positie->zz;
   normal.xx = -vertex->plane.aa;
   normal.yy = -vertex->plane.bb;
   normal.zz = -vertex->plane.cc;
   if (DotvProduct(&viewvec, &normal) < -0.01)
      return 1;
   else
      return 0;
}

void
CalculateNearestDistance(FACE * faceList, OLDPOINT * position, OLDPOINT * direction)
{
   float           tempDistance, tempDistance2;
   OLDPOINT           hitposition, hitpoint;
   OLDPOINT           tmppoint;
   FACE           *ftrav;
   myboolean         insidePolygon;
   myboolean         tempstuck;
   float           floatzero = 0.0;
   float           testdist;


   for (ftrav = faceList; ftrav != NULL_FACE; ftrav = ftrav->fnext) {

      tempstuck = FALSE;

      tempGlobalLastHit++;

      testdist = IntersectLinePlane(position, direction, &ftrav->plane);
      if (testdist >= floatzero) {
	 VERTEX         *firstvertex;
	 VERTEX         *secondvertex;

	 hitposition.xx = ftrav->plane.aa;	/* planes normal (aa,bb,cc) */
	 hitposition.yy = ftrav->plane.bb;
	 hitposition.zz = ftrav->plane.cc;
	 tmppoint = pointscalar(&hitposition, PlayerRadius);
	 hitposition = pointadd(&tmppoint, position);
	 tempDistance = IntersectLinePlane(&hitposition, direction, &ftrav->plane);
	 if (tempDistance >= floatzero) {

	    {

	       if (tempDistance < GlobalDistance) {
		  /*
		   * look if within polygon boundaries
		   */

		  /*
		   * hitpoint = hitposition + tempDistance * direction;
		   */
		  tmppoint = pointscalar(direction, tempDistance);
		  hitpoint = pointadd(&tmppoint, &hitposition);

		  insidePolygon = TRUE;
		  firstvertex = ftrav->vhead;
		  for (secondvertex = ftrav->vhead->vnext; secondvertex != NULL_VERTEX;
		       secondvertex = secondvertex->vnext) {
		     /*
		      * calculate distance from hitpoint to vertexplane
		      */


		     tempDistance2 =
			firstvertex->plane.aa * hitpoint.xx +
			firstvertex->plane.bb * hitpoint.yy +
			firstvertex->plane.cc * hitpoint.zz +
			firstvertex->plane.dd;
		     if (tempDistance2 > (PlayerRadius)) {	/* outside boundary */
			insidePolygon = FALSE;
		     };
		     firstvertex = secondvertex;
		  };		/* end for every vertexplane check */



		  if (insidePolygon) {
		     if (tempDistance < GlobalDistance) {
			stuck = tempstuck;
			GlobalDistance = tempDistance;
			GlobalHitPlaneNormal = ftrav->plane;
			GlobalLastHit = tempGlobalLastHit;
		     }
		  }
	       }		/* tempDistance > Globaldistance */
	    }

	 } else {

	 }
      }
   }
}

void
BSPtraverseTreeAndFindNearestPolygon(BSPNODE * bspNode, OLDPOINT * position, OLDPOINT * direction)
/*
 * sets GlobalDistance to distance of intersection of line with nearest
 * polygon in bsptree
 */

{

   if (bspNode == NULL_BSPNODE)
      return;

   if (bspNode->kind == PARTITION_NODE) {
      if (BSPisViewerInPositiveSideOfPlane(&bspNode->node->sameDir->plane, position)) {

	 BSPtraverseTreeAndFindNearestPolygon(bspNode->node->negativeSide, position, direction);
	 CalculateNearestDistance(bspNode->node->sameDir, position, direction);
	 CalculateNearestDistance(bspNode->node->oppDir, position, direction);	/* back-face cull */
	 BSPtraverseTreeAndFindNearestPolygon(bspNode->node->positiveSide, position, direction);

      } else {

	 BSPtraverseTreeAndFindNearestPolygon(bspNode->node->positiveSide, position, direction);
	 CalculateNearestDistance(bspNode->node->oppDir, position, direction);
	 CalculateNearestDistance(bspNode->node->sameDir, position, direction);	/* back-face cull */
	 BSPtraverseTreeAndFindNearestPolygon(bspNode->node->negativeSide, position, direction);

      }
   } else
      assert(bspNode->kind == IN_NODE || bspNode->kind == OUT_NODE);
}				/* BSPtraverseTreeAndCalculateBoundingPlane() */

float
CollideTwoSpheres(OLDPOINT * center1, OLDPOINT * center2,
		  OLDPOINT * speed1, OLDPOINT * speed2)
{
   float           A, B, C;
   float           discriminant;
   float           result;

   /* calculate A,B and C for ABC-formule */

   A = (speed2->xx - speed1->xx) * (speed2->xx - speed1->xx) +
      (speed2->yy - speed1->yy) * (speed2->yy - speed1->yy) +
      (speed2->zz - speed1->zz) * (speed2->zz - speed1->zz);

   B = 2 * ((center2->xx - center1->xx) * (speed2->xx - speed1->xx)) +
      2 * ((center2->yy - center1->yy) * (speed2->yy - speed1->yy)) +
      2 * ((center2->zz - center1->zz) * (speed2->zz - speed1->zz));

   C = (center2->xx - center1->xx) * (center2->xx - center1->xx) +
      (center2->yy - center1->yy) * (center2->yy - center1->yy) +
      (center2->zz - center1->zz) * (center2->zz - center1->zz);
   C -= (ONORMALRADIUS + ONORMALRADIUS) * (ONORMALRADIUS + ONORMALRADIUS);

   discriminant = (B * B) - (4 * A * C);
   if (discriminant < 0) {
      result = 9999999;		/* no collision */
   } else {
      result = (-B - sqrt(discriminant)) /
	 2 * A;

   };

   return (result);

}
