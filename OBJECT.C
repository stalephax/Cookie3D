
#include "object.h"
//#include "pcx.h"                /* pcx pictures loader  */
#include "global.h"             /* specific to this program */
#include "bsp.h"                /* bsptree specific routines  */
#include "keyboard.h"           /* keyboard handler           */
#include "3d.h"
#include "3dmath.h"
#include "collide.h"
#include "move.h"
//#include <graph.h>
#include "polygon.h"
int     NumberOfObjects;
OBJECT  ObjectList[MAX_OBJECTS]; 

void
UpdatemovingFaceList(FACE * faceList,int *ftexoffset)
{
   int             texoffset;
   FACE           *ftrav;
   for (ftrav = faceList; ftrav != NULL_FACE; ftrav = ftrav->fnext) {
      VERTEX         *vtrav;
      /* for scrolling texture */
         ftexoffset = ftexoffset + 1;
         if (ftexoffset == 256) {
            texoffset = -256;
            ftexoffset = 0;
         } else {
            texoffset = 0;
         }
         for (vtrav = ftrav->vhead; vtrav->vnext != NULL_VERTEX;
              vtrav = vtrav->vnext) {
            vtrav->uu = vtrav->uu + 1 + texoffset;

         }
      }
      
}                               /* updatemovingFaceList() */
void
drawmovingFaceList(OLDPOINT center,const FACE * faceList)
{
        int             polygoncount;
        const FACE     *ftrav;
        for (ftrav = faceList; ftrav != NULL_FACE; ftrav = ftrav->fnext) {
                VERTEX         *vtrav;
                polygoncount = 0;
                for (vtrav = ftrav->vhead; vtrav->vnext != NULL_VERTEX;
                     vtrav = vtrav->vnext) {
                        coockiespoly.verts[polygoncount].v[0] = vtrav->xx+center.xx;
                        coockiespoly.verts[polygoncount].v[1] = vtrav->zz+center.zz;
                        coockiespoly.verts[polygoncount].v[2] = vtrav->yy+center.yy;
                        if (polygoncount < MAX_POLY_VERTS) {
                                polygoncount++;
                        } else {
                                printf("error. polygonvertices overflow");
                                exit(-1);
                        };
                }
                if (polygoncount < 3) {
                        printf("Error:Polygon detected with less then 3 vertices");
                        exit(-1);
                };
                coockiespoly.P.v[0] = ftrav->P.xx;
                coockiespoly.P.v[1] = ftrav->P.zz;
                coockiespoly.P.v[2] = ftrav->P.yy;
                coockiespoly.M.v[0] = ftrav->M.xx;
                coockiespoly.M.v[1] = ftrav->M.zz;
                coockiespoly.M.v[2] = ftrav->M.yy;
                coockiespoly.N.v[0] = ftrav->N.xx;
                coockiespoly.N.v[1] = ftrav->N.zz;
                coockiespoly.N.v[2] = ftrav->N.yy;
                coockiespoly.numverts = polygoncount;
                coockiespoly.color = ftrav->color;
                coockiespoly.bspdepth = -1;
                currentbspdepth = -1;
                coockiespoly.plane.distance = 0;
                coockiespoly.plane.normal.v[0] = -ftrav->plane.aa;
                coockiespoly.plane.normal.v[1] = -ftrav->plane.cc;
                coockiespoly.plane.normal.v[2] = -ftrav->plane.bb;
                addpolygon(&coockiespoly);
        }
}                               /* drawmovingFaceList() */

void AddObject (OLDPOINT center,FACE *faceList,int special) {
ObjectList[NumberOfObjects].centerpoint = center;
ObjectList[NumberOfObjects].special = special;
ObjectList[NumberOfObjects].faceList = faceList;
ObjectList[NumberOfObjects].texoffset = 0; /* to begin with ;) */
ObjectList[NumberOfObjects].movingspeed = shooting; /* just a beginning */
ObjectList[NumberOfObjects].movingdir.xx = vpn.v[0];
ObjectList[NumberOfObjects].movingdir.yy = vpn.v[2];
ObjectList[NumberOfObjects].movingdir.zz = vpn.v[1];
}
void UpdateObjectList() {
int i,j;
  
   int             texoffset;
   float        tempDistance,hitDistance;
   FACE           *ftrav;
   OLDPOINT          center1,center2,speed1,speed2;
   float spheredelta = 0.1;

tempDistance = 999999;
hitDistance =  999999;

for (i = 0; i < NumberOfObjects ; i++) {
        if (ObjectList[i].special == 2) {
                for (j = i+1; j < NumberOfObjects ; j++) {
                        if (ObjectList[j].special == 2) {
                        /* test if collision between balls */
                        center1 = ObjectList[i].centerpoint;
                        center2 = ObjectList[j].centerpoint;
                        speed1 = pointscalar(&ObjectList[i].movingdir,
                                             ObjectList[i].movingspeed);
                        speed2 = pointscalar(&ObjectList[j].movingdir,
                                             ObjectList[j].movingspeed);
                        tempDistance =
                        CollideTwoSpheres (&center1,&center2,
                                &speed1,&speed2);
                        if (tempDistance >= 0) {
                             if (tempDistance < hitDistance) {
                                 hitDistance = tempDistance;
                             }
                        } else {
                             if (tempDistance < hitDistance) {
                                 hitDistance = tempDistance;
                             }
                        };

                        };
                };
        };
};



  for (i = 0; i < NumberOfObjects ; i++) {
        if (ObjectList[i].special == 1) {
     
        
   for (ftrav = ObjectList[i].faceList; ftrav != NULL_FACE; ftrav = ftrav->fnext) {
      VERTEX         *vtrav;
      /* for scrolling texture */
         ObjectList[i].texoffset = ObjectList[i].texoffset + 1;
         if (ObjectList[i].texoffset == 256) {
            texoffset = -256;
            ObjectList[i].texoffset = 0;
         } else {
            texoffset = 0;
         }
         for (vtrav = ftrav->vhead; vtrav->vnext != NULL_VERTEX;
              vtrav = vtrav->vnext) {
            vtrav->uu = vtrav->uu + 1 + texoffset;

         }
      }
      
        ComputeMagic( ObjectList[i].centerpoint,ObjectList[i].faceList);
        };
        if (ObjectList[i].special == 2) {
        MoveObject(i);
        ComputeMagic( ObjectList[i].centerpoint,ObjectList[i].faceList);
        };
  }
};
void DrawObjectList() {
int i;

  for (i = 0; i < NumberOfObjects ; i++) {
        
        drawmovingFaceList( ObjectList[i].centerpoint,ObjectList[i].faceList);
  }
};
void MakeNewObject(point_t midpoint,float radius) {
   OLDPOINT center;
   int             movingspecial;
   int Radius = ONORMALRADIUS-1;
   int Bands = 3;
   movingspecial = 1;
   center.xx = midpoint.v[0];
   center.yy = midpoint.v[2];
   center.zz = midpoint.v[1];

  if (NumberOfObjects < MAX_OBJECTS) {
   ObjectList[NumberOfObjects].centerpoint = center;
   MakeSphere (center,Radius,Bands);  /* created new object */
   ComputeMagic( ObjectList[NumberOfObjects].centerpoint,ObjectList[NumberOfObjects].faceList);
   NumberOfObjects++;
  } else {
   NumberOfObjects--;
   freeFaceList(&ObjectList[NumberOfObjects].faceList);
   ObjectList[NumberOfObjects].centerpoint = center;
   MakeSphere (center,Radius,Bands);  /* created new object */
   ComputeMagic( ObjectList[NumberOfObjects].centerpoint,ObjectList[NumberOfObjects].faceList);
   NumberOfObjects++;
  };

}
