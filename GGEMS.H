/* 
 * GGems.h (GraphicsGems.h)  
 * Version 1.0 - Andrew Glassner
 * from "Graphics Gems", Academic Press, 1990
 */

#ifndef GG_H

#define GG_H 1
#include "debug.h"
/*********************/
/* 2d geometry types */
/*********************/

typedef struct Point2Struct {	/* 2d point */
        float x, y;
	} Point2;
typedef Point2 Vector2;

typedef struct IntPoint2Struct {	/* 2d integer point */
	int x, y;
	} IntPoint2;

typedef struct Matrix3Struct {	/* 3-by-3 matrix */
        float element[3][3];
	} Matrix3;

typedef struct Box2dStruct {		/* 2d box */
	Point2 min, max;
	} Box2;
	

/*********************/
/* 3d geometry types */
/*********************/

typedef struct Point3Struct {	/* 3d point */
        float x, y, z;
	} Point3;
typedef Point3 Vector3;

typedef struct IntPoint3Struct {	/* 3d integer point */
	int x, y, z;
	} IntPoint3;


typedef struct Matrix4Struct {	/* 4-by-4 matrix */
        float element[4][4];
	} Matrix4;

typedef struct Box3dStruct {		/* 3d box */
	Point3 min, max;
	} Box3;



/***********************/
/* one-argument macros */
/***********************/

   
/* round a to nearest integer towards 0 */
#define FLOOR(a)		((a)>0 ? (int)(a) : -(int)(-a))

/* round a to nearest integer away from 0 */
#define CEILING(a) \
((a)==(int)(a) ? (a) : (a)>0 ? 1+(int)(a) : -(1+(int)(-a)))

/* round a to nearest int */
#define ROUND(a)	((a)>0 ? (int)(a+0.5) : -(int)(0.5-a))		

/* take sign of a, either -1, 0, or 1 */
#define ZSGN(a)		(((a)<0) ? -1 : (a)>0 ? 1 : 0)	

/* take binary sign of a, either -1, or 1 if >= 0 */
#define SGN(a)		(((a)<0) ? -1 : 0)

/* shout if something that should be true isn't */
#define ASSERT(x) \
if (!(x)) fprintf(stderr," Assert failed: x\n");

/* square a */
#define SQR(a)		((a)*(a))	


/***********************/
/* two-argument macros */
/***********************/

         
/* swap a and b (see Gem by Wyvill) */
#define SWAP(a,b)	{ a^=b; b^=a; a^=b; }

/* linear interpolation from l (when a=0) to h (when a=1)*/
/* (equal to (a*h)+((1-a)*l) */
#define LERP(a,l,h)	((l)+(((h)-(l))*(a)))

/* clamp the input to the specified range */
#define CLAMP(v,l,h)	((v)<(l) ? (l) : (v) > (h) ? (h) : v)


/****************************/
/* memory allocation macros */
/****************************/

/* create a new instance of a structure (see Gem by Hultquist) */
#define NEWSTRUCT(x)	(struct x *)(malloc((unsigned)sizeof(struct x)))

/* create a new instance of a type */
#define NEWTYPE(x)	(x *)(malloc((unsigned)sizeof(x)))


/********************/
/* useful constants */
/********************/

#define PI		3.141592	/* the venerable pi */
#define PITIMES2	6.283185	/* 2 * pi */
#define PIOVER2		1.570796	/* pi / 2 */
#define E		2.718282	/* the venerable e */
#define SQRT2		1.414214	/* sqrt(2) */
#define SQRT3		1.732051	/* sqrt(3) */
#define GOLDEN		1.618034	/* the golden ratio */
#define DTOR		0.017453	/* convert degrees to radians */
#define RTOD		57.29578	/* convert radians to degrees */


/************/
/* mybooleans */
/************/

#define ON              1
#define OFF 		0
typedef int myboolean;			/* myboolean data type */
typedef myboolean flag;			/* flag data type */

extern float V2SquaredLength(), V2Length();
extern float V2Dot(), V2DistanceBetween2Points(); 
extern Vector2 *V2Negate(), *V2Normalize(), *V2Scale(), *V2Add(), *V2Sub();
extern Vector2 *V2Lerp(), *V2Combine(), *V2Mul(), *V2MakePerpendicular();
extern Vector2 *V2New(), *V2Duplicate();
extern Point2 *V2MulPointByProjMatrix();
extern Matrix3 *V2MatMul(), *TransposeMatrix3();

extern float V3SquaredLength(), V3Length();
extern float V3Dot(), V3DistanceBetween2Points();
extern Vector3 *V3Normalize(), *V3Scale(), *V3Add(), *V3Sub();
extern Vector3 *V3Lerp(), *V3Combine(), *V3Mul(), *V3Cross();
extern Vector3 *V3New(), *V3Duplicate();
extern Point3 *V3MulPointByMatrix(), *V3MulPointByProjMatrix();
extern Matrix4 *V3MatMul();

extern float RegulaFalsi(), NewtonRaphson(), findroot();

#endif



