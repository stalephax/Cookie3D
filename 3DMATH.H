
#ifndef _3DMATH_INCLUDED
#define _3DMATH_INCLUDED

#include "3d.h"

VERTEX vectoradd(VERTEX in1, VERTEX in2);
VERTEX vectorscalar(VERTEX in1, float mul);
OLDPOINT pointadd(OLDPOINT *in1, OLDPOINT *in2);
OLDPOINT pointscalar(OLDPOINT *in1, float mul);
OLDPOINT pointsub(OLDPOINT *in1, OLDPOINT *in2);
float DotvProduct(OLDPOINT * vec1, OLDPOINT * vec2);
float DotProduct(point_t *vec1, point_t *vec2);
void CrossProduct(point_t *in1, point_t *in2, point_t *out);
void CrossvProduct(VERTEX *in1, VERTEX *in2, point_t *out);

VERTEX vectorsubtract(VERTEX in1, VERTEX in2);
void MConcat(float in1[3][3], float in2[3][3], float out[3][3]);

#endif // _3DMATH_INCLUDED
