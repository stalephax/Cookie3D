#include "3dmath.h"
#include "bsp.h"
#include "ggems.h"

float
DotvProduct(OLDPOINT * vec1, OLDPOINT * vec2)
{
   return (vec1->xx * vec2->xx +
	   vec1->yy * vec2->yy +
	   vec1->zz * vec2->zz);
}

float DotProduct(point_t *vec1, point_t *vec2)
{
    return vec1->v[0] * vec2->v[0] +
	   vec1->v[1] * vec2->v[1] +
	   vec1->v[2] * vec2->v[2];
}


/////////////////////////////////////////////////////////////////////
// 3-D cross product.
/////////////////////////////////////////////////////////////////////
void CrossProduct(point_t *in1, point_t *in2, point_t *out)
{
    out->v[0] = in1->v[1] * in2->v[2] - in1->v[2] * in2->v[1]  ;
    out->v[1] = in1->v[2] * in2->v[0] - in1->v[0] * in2->v[2] ;
    out->v[2] = in1->v[0] * in2->v[1] - in1->v[1] * in2->v[0]  ;
}
void CrossvProduct(VERTEX *in1, VERTEX *in2, point_t *out)
{
    out->v[0] = in1->yy * in2->zz - in1->zz * in2->yy  ;
    out->v[1] = in1->zz * in2->xx - in1->xx * in2->zz ;
    out->v[2] = in1->xx * in2->yy - in1->yy * in2->xx  ;
}


//////////
//     substract two vectors
///////
VERTEX vectorsubtract(VERTEX in1, VERTEX in2)
{
 VERTEX out;
    out.xx = in1.xx - in2.xx ;
    out.yy = in1.yy - in2.yy ;
    out.zz = in1.zz - in2.zz ;
    out.uu = in1.uu - in2.uu ;
    out.vv = in1.vv - in2.vv ;
 return(out);
}

VERTEX vectoradd(VERTEX in1, VERTEX in2)
{
 VERTEX out;
    out.xx = in1.xx + in2.xx ;
    out.yy = in1.yy + in2.yy ;
    out.zz = in1.zz + in2.zz ;
    out.uu = in1.uu + in2.uu ;
    out.vv = in1.vv + in2.vv ;
 return(out);
}


////////
///    scalar product (vector * scalar)
///////
VERTEX vectorscalar(VERTEX in1, float mul)
{
  VERTEX out;
    out.xx = in1.xx * mul ;
    out.yy = in1.yy * mul ;
    out.zz = in1.zz * mul ;
    out.uu = in1.uu * mul ;
    out.vv = in1.vv * mul ;

 return(out);
}
////////
///    scalar product (vector * scalar)
///////
OLDPOINT pointscalar(OLDPOINT *in1, float mul)
{
  OLDPOINT out;
    out.xx = in1->xx * mul ;
    out.yy = in1->yy * mul ;
    out.zz = in1->zz * mul ;

 return(out);
}
OLDPOINT pointadd(OLDPOINT *in1, OLDPOINT *in2)
{
 OLDPOINT out;
    out.xx = in1->xx + in2->xx ;
    out.yy = in1->yy + in2->yy ;
    out.zz = in1->zz + in2->zz ;
 return(out);
}
OLDPOINT pointsub(OLDPOINT *in1, OLDPOINT *in2)
{
 OLDPOINT out;
    out.xx = in1->xx - in2->xx ;
    out.yy = in1->yy - in2->yy ;
    out.zz = in1->zz - in2->zz ;
 return(out);
}

/////////////////////////////////////////////////////////////////////
// Concatenate two 3x3 matrices.
/////////////////////////////////////////////////////////////////////
void MConcat(float in1[3][3], float in2[3][3], float out[3][3])
{
    int     i, j;

    for (i=0 ; i<3 ; i++)
    {
	for (j=0 ; j<3 ; j++)
	{
	    out[i][j] = in1[i][0] * in2[0][j] +
			in1[i][1] * in2[1][j] +
			in1[i][2] * in2[2][j];
	}
    }
}

