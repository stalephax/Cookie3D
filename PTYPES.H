/*
 * Written by: Robert C. Pendleton
 * 
 * Placed in the public domain by the author.
 * 
 */

#ifndef _PTYPES_H_
#define _PTYPES_H_

//typedef enum
//{
//    FALSE = 0, TRUE = 1
//} myboolean;

/*
 * These define types with unique names for each length. They make it easier to
 * port other environments.
 * 
 */

typedef signed char int8;
typedef signed short int16;
typedef signed long int32;

typedef unsigned char uint8;
typedef unsigned short uint16;
typedef unsigned long uint32;

typedef float float32;
typedef double float64;

#ifdef FORCE_PTYPES

#define signed  (not a good idea)
#define int     (not a good idea)
#define short   (not a good idea)
#define long    (not a good idea)

#endif

#endif
