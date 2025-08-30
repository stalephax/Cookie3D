#ifndef _GENBALL_DEFINE
#define _GENBALL_DEFINE

#include "bsp.h"
/* Describes a single 3D point in homogeneous coordinates */

typedef struct {
   double x;   /* X coordinate */
   double y;   /* Y coordinate */
   double z;   /* Z coordinate */
   double w;
} Point444;
//*/
void MakeSphere(OLDPOINT center,int Radius,int Bands);
#endif
