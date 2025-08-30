#ifndef _3D_INCLUDED
#define _3D_INCLUDED

#include "global.h"
#include "bsp.h"
#include "svga.h"

 
#define NOBLOCK 'n'
#define COMMENT '/'
#define WORD long
#define BYTE int


#define SPANWIDTH          8//1// 2// 4// 16;//  8
#define SPANWIDTHEXP       3//0// 1// 2//  4;//  3    2^spanwidthexp=spanwidth
   
#define MAX_POLY_VERTS      32//18       // assumes polygons have no more than
				    //  four sides and are clipped a
				    //  maximum of four times by frustum.
				    //  Must be increased for more sides
				    //  or more clip planes
#define DIST_VLAK       0
#define MAX_SCREEN_HEIGHT   2048
#define MOVEMENT_SPEED      2.0
#define VMOVEMENT_SPEED     2.0

#define MAX_MOVEMENT_ACCEL  6.0
#define MOVEMENT_ACCEL      1.0
#define ROLL_SPEED          (PI/20.0)
#define PITCH_SPEED         (PI/20.0)
#define YAW_SPEED           (PI/10.0)
#define MAX_YAW_SPEED       YAW_SPEED*MAX_MOVEMENT_SPEED
#define MAX_COORD           0x4000
#define NUM_FRUSTUM_PLANES  4
#define CLIP_PLANE_EPSILON  0.0001
#define MAX_SPANS           100000
#define MAX_SURFS           100000
#define MAX_EDGES           100000
extern int MAX_MOVEMENT_SPEED;
#define TEX_WIDTH        255
#define TEX_HEIGHT       255
#define TEX_U1           0
#define TEX_V1           0






typedef struct {
    float v[3];
} point_t;

typedef struct {
    float x,y;       
} texcoord_t;


typedef struct {
    float   x, y;
    float z;
} point2D_t;

typedef struct {
    int x, y;
    float z;     //for mipmapping is distance needed, maybe zinv is ok too?
    int count;
    point_t A,B,C;
    int color;
//    float invz,dinvz; 
} span_t;

typedef struct {
    float  distance;
    point_t normal;
} plane_t;

typedef struct {
    int         color;
    point_t     P,M,N;
    point_t     A,B,C;
    int         bspdepth;       //information from bsptree
    int         numverts;
    point_t     verts[MAX_POLY_VERTS];
    plane_t     plane;
} polygon_t;

typedef struct surf_s {
    struct surf_s   *pnext, *pprev;
    int             color;
    point_t        A,B,C;
    int             bspdepth;   //information from bsptree
    int             visxstart;
    int             state;
    struct edge_s       *edge;  
    float       invz,dinvz; //information for z-depthsort
} surf_t;

typedef struct {
    int         numverts;
    point2D_t   verts[MAX_POLY_VERTS];
} polygon2D_t;

typedef struct convexobject_s {
    struct convexobject_s   *pnext;
    struct convexobject_s   *pprev;
    int                     numpolys;
    polygon_t               ppoly[1];
} convexobject_t;

typedef struct edge_s {
    int x;//int             x;
    int xstep;//long             xstep;
    int             leading;
    float invz,dinvz;
    surf_t          *psurf;
    struct edge_s   *pnext, *pprev;
    struct edge_s   *pnextremove;

} edge_t;

void
VGA_DrawSpans(void);
void
VBE_DrawSpans(void);

void AddPolygonEdges (plane_t *plane, polygon2D_t *screenpoly);
void ScanEdges (void);
void ClearEdgeLists(void);
int  InitPos(void);

void ProjectPolygon (polygon_t *ppoly, polygon2D_t *ppoly2D);
void addpolygon (polygon_t *ppoly);
int InitDraw();
int UpdateDraw();
void ComputeMagic(OLDPOINT center,FACE *faceList);
void drawFaceList(const FACE *faceList);

void ComputeMagic(OLDPOINT center,FACE *faceList);
void SetUpFrustum(void);
extern float           speedscale ;
extern float           playerspeedscale ;

extern float           roll, pitch, yaw, yawspeed;
extern float           playerroll, playerpitch, playeryaw, playeryawspeed;
extern point_t         playercurrentpos;
extern float           currentspeed;
extern float           playeraccel;
extern point_t         xaxis;
extern point_t         yaxis;
extern point_t         zaxis;

extern int currentbspdepth;
extern int currentcolor;
extern float  mroll[3][3];
extern float  mpitch[3][3];
extern float  myaw[3][3];
extern int DIBWidth;
extern int DIBHeight;
extern int DIBPitch;
extern point_t vpn,vright,vup;
extern float mip;
extern int RUN_LENGTH;
extern int RUN_LENGTHEXP;
extern point_t currentpos;
extern point_t startpos;
extern float  playercurrentspeed;
extern float  playerspeedscale;
extern float playerpitch;
extern point_t playercurrentpos;
extern float playeryawspeed;
extern float playerroll;
extern surf_t surfs[MAX_SURFS];
extern surf_t  *pavailsurf;
extern edge_t  *pavailedge;
extern edge_t  edges[MAX_EDGES];
extern int WindowOffsetX,WindowOffsetY;
extern polygon_t       coockiespoly;

extern VBE_modeInfo coockieModeInfo;
extern char           *VideoOffset;

extern int coockieOffset;
extern int modeMenu[];
extern int currentMode ;
extern int lastMode ;

#endif  /* _3D_INCLUDED */
