#include "bsp.h"
#include "3d.h"
#define MAX_OBJECTS 40         /* max number of special (moving?) objects */

typedef struct ObjectTag {
   OLDPOINT centerpoint;    /* center of object
                                 * (midpoint of bounding sphere
                                 */
   OLDPOINT movingdir;              /* direction of movement */
   float movingspeed;            /* movingspeed */ 
   int special;                  /* what kind of object */
   int texoffset;                /* texture offset for scrolling textures */
   float ObjRadius;              /* radius of bounding sphere */
   FACE *faceList;              /* polygons of object */
} OBJECT;

extern OBJECT  ObjectList[MAX_OBJECTS]; 
void drawmovingFaceList(OLDPOINT center,const FACE *faceList);
void AddObject (OLDPOINT center,FACE *faceList,int special);
extern int NumberOfObjects;
void UpdateObjectList();
void DrawObjectList();
void MakeNewObject(point_t midpoint,float radius);
