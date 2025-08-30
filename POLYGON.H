#ifndef _GENBALL_DEFINE
#define _GENBALL_DEFINE

#include "bsp.h"
/* Describes a single 3D point in homogeneous coordinates */
typedef struct  {
   double X;   /* X coordinate */
   double Y;   /* Y coordinate */
   double Z;   /* Z coordinate */
   double W;
} Point444;
void MakeSphere(OLDPOINT center,int Radius,int Bands);
#endif
