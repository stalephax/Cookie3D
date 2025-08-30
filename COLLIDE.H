#ifndef _COLLIDE_INCLUDE
#define _COLLIDE_INCLUDE

#define NORMALRADIUS 15
#define SMALLRADIUS 13
#define ONORMALRADIUS 8
#define OSMALLRADIUS 6
float
CollideTwoSpheres (OLDPOINT * center1,OLDPOINT * center2, 
                     OLDPOINT * speed1, OLDPOINT * speed2);


void
BSPtraverseTreeAndCalculateBoundingPlanes(const BSPNODE * bspNode,const OLDPOINT * position);

void  
BSPtraverseTreeAndFindNearestPolygon(BSPNODE * bspNode,OLDPOINT * position, OLDPOINT * direction);
/* sets GlobalDistance to distance of intersection of line 
with nearest polygon in bsptree */
extern float GlobalDistance;
extern PLANE GlobalHitPlaneNormal;
extern int   GlobalLastHit;
extern int   tempGlobalLastHit;

extern float PlayerRadius;
extern myboolean stuck;
#endif /* _COLLIDE_INCLUDE */
