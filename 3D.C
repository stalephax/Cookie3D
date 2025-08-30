#include "3d.h"
#include "3dmath.h"
#include "ggems.h"
#include "move.h" /* gravitationspeed */
#include "pmode.h"
#include "cckfile.h"
#include "cckvideo.h"
#include "global.h"
unsigned char  *pcxtexture;

#define FIELD_OF_VIEW 1.75
int             DIBWidth, DIBHeight;
int             DIBPitch;
int             WindowOffsetX, WindowOffsetY;
int             currentcolor;
int             currentbspdepth;
int             RUN_LENGTH = 8;
int             RUN_LENGTHEXP = 3;

int MAX_MOVEMENT_SPEED = 15.0;
 

       

int coockieGS;
int VBE_Color;
int VBE_Count;
polygon_t       coockiespoly;

point_t         currentpos, startpos;

float           fieldofview, xcenter, ycenter;
float           xscreenscale, yscreenscale, maxxscale,maxyscale,maxscal;
float           maxscreenscaleinv;
int             numobjects;

/* vars for fast texturemapper */
double          sixtyfive;/* = 65536.0 * 256; */
/* was static */

int             mask2, mipmask;
float mip;
float           cc, cinv;
BYTE            du_hi;
WORD            du_lo;
BYTE            dv_hi;
WORD            dv_lo;
WORD            fu_lo;
WORD            fv_lo;

int             u, v;
int             run;
float           aa, bb;
long            u0, u1, v0, v1, du, dv;


point_t         A, B, C;        /* texture gradients */

float           roll, pitch, yaw, yawspeed;
float           playerroll, playerpitch, playeryaw, playeryawspeed;
point_t         playercurrentpos;
float           currentspeed;


int             totalcount;
float           speedscale = 1;
float           playerspeedscale = 1;

plane_t         frustumplanes[NUM_FRUSTUM_PLANES];


float           mroll[3][3] = {{1, 0, 0}, {0, 1, 0}, {0, 0, 1}};
float           mpitch[3][3] = {{1, 0, 0}, {0, 1, 0}, {0, 0, 1}};
float           myaw[3][3] = {{1, 0, 0}, {0, 1, 0}, {0, 0, 1}};
point_t         vpn = {1,0,0};
point_t         vright, vup;
point_t         xaxis = {1, 0, 0};
point_t         yaxis = {0, 1, 0};
point_t         zaxis = {0, 0, 1};


/* Span, edge, and surface lists  */
span_t          spans[MAX_SPANS];
edge_t          edges[MAX_EDGES];
surf_t          surfs[MAX_SURFS];

/* Bucket list of new edges to add on each scan line */
edge_t          newedges[MAX_SCREEN_HEIGHT];

/* Bucket list of edges to remove on each scan line */
edge_t         *removeedges[MAX_SCREEN_HEIGHT];

/* Head and tail for the active edge list */
edge_t          edgehead;
edge_t          edgetail;

/* Edge used as sentinel of new edge lists */
edge_t          maxedge = {0x7FFFFFFF};

/* Head/tail/sentinel/background surface of active surface stack  */
surf_t          surfstack;

/* pointers to next available surface and edge */
surf_t         *pavailsurf;
edge_t         *pavailedge;



/*
 * Add the polygon's edges to the global edge table.
 */

void
AddPolygonEdges(plane_t * plane, polygon2D_t * screenpoly)
{
	double          distinv, deltax, deltay, slope;
	int             i, nextvert, numverts, Ceiltopy, Ceilbottomy;
	edge_t         *pedge;
	int             a, b;
	float           temp_invz, temp_ninvz;

	float           Realheight, Realwidth;
	float           YPrestep;
	int             TopIndex, BottomIndex;

	numverts = screenpoly->numverts;

	/*
	 * Clamp the polygon's vertices just in case some very near points
	 * have wandered out of range due to floating-point imprecision 
	 */
	 for (i=0 ; i<numverts ; i++) { 
	 if (screenpoly->verts[i].x < (-0.5))
		screenpoly->verts[i].x = -0.5; 
	  if (screenpoly->verts[i].x > ((double)DIBWidth - 0.5 )) 
		screenpoly->verts[i].x = (double)DIBWidth - 0.5 ; 
		if (screenpoly->verts[i].y < (-0.5))
	  screenpoly->verts[i].y = -0.5; 
	  if (screenpoly->verts[i].y > ((double)DIBHeight - 0.5  )) 
	  screenpoly->verts[i].y = (double)DIBHeight - 0.5; }
	 
	/* Add each edge in turn */
	for (i = 0; i < numverts; i++) {
		nextvert = i + 1;
		if (nextvert >= numverts)
			nextvert = 0;

		if (screenpoly->verts[i].y < screenpoly->verts[nextvert].y) {
			TopIndex = i;
			BottomIndex = nextvert;
		} else {
			TopIndex = nextvert;
			BottomIndex = i;
		};


		Ceiltopy = (int) ceil(screenpoly->verts[TopIndex].y);
		Ceilbottomy = (int) ceil(screenpoly->verts[BottomIndex].y);


		Realheight = ((screenpoly->verts[BottomIndex].y -
			       screenpoly->verts[TopIndex].y));
		Realwidth = ((screenpoly->verts[BottomIndex].x -
			      screenpoly->verts[TopIndex].x));

		YPrestep = (float) (Ceiltopy - screenpoly->verts[TopIndex].y) * 0;


		if (Ceilbottomy == Ceiltopy)
			continue;       /* doesn't cross any scan lines */
		if (screenpoly->verts[i].y > screenpoly->verts[nextvert].y)
			/* if (Realheight < 0) */
		{
			pavailedge->leading = 1;

			deltax = screenpoly->verts[BottomIndex].x -
				screenpoly->verts[TopIndex].x;
			deltay = screenpoly->verts[BottomIndex].y -
				screenpoly->verts[TopIndex].y;

			slope = Realwidth / Realheight;

			/*
			 * Edge coordinates are in 16.16 fixed point
			 */
			pavailedge->xstep = (int) (slope * (float) 0x10000);
			pavailedge->x = (int) ((screenpoly->verts[TopIndex].x +
						(((float) Ceiltopy - screenpoly->verts[TopIndex].y) * slope)
						) * (float) 0x10000);

			a = TopIndex;
			b = BottomIndex;

		} else {
			/* Trailing edge */
			pavailedge->leading = 0;

			deltax = screenpoly->verts[BottomIndex].x -
				screenpoly->verts[TopIndex].x;
			deltay = screenpoly->verts[BottomIndex].y -
				screenpoly->verts[TopIndex].y;
			slope = Realwidth / Realheight;

			/*
			 * Edge coordinates are in 16.16 fixed point
			 */
			pavailedge->xstep = (int) (slope * (float) 0x10000);
			pavailedge->x = (int) ((screenpoly->verts[TopIndex].x +
						(((float) Ceiltopy - screenpoly->verts[TopIndex].y) * slope)
						) *
					       (float) 0x10000);

			a = TopIndex;
			b = BottomIndex;
		}

		if (screenpoly->verts[TopIndex].z == 0.0)
			temp_invz = 999999.0;
		else
			temp_invz = 1.0 / screenpoly->verts[TopIndex].z;
		if (screenpoly->verts[BottomIndex].z == 0.0)
			temp_ninvz = 999999.0;
		else
			temp_ninvz = 1.0 / screenpoly->verts[BottomIndex].z;

		pavailedge->invz = temp_invz;

		if (deltay != 0) {
			deltay = Realheight;
			pavailedge->dinvz = (temp_ninvz - temp_invz) / deltay;

		} else {
			pavailedge->dinvz = 0;
		}



		/* Put the edge on the list to be added on top scan */
		pedge = &newedges[Ceiltopy];
		while (pedge->pnext->x < pavailedge->x)
			pedge = pedge->pnext;
		pavailedge->pnext = pedge->pnext;
		pedge->pnext = pavailedge;

		/* Put the edge on the list to be removed after final scan */
		pavailedge->pnextremove = removeedges[Ceilbottomy - 1];
		removeedges[Ceilbottomy - 1] = pavailedge;

		/*
		 * Associate the edge with the surface we'll create for this
		 * polygon
		 */
		pavailedge->psurf = pavailsurf;

		/* Make sure we don't overflow the edge array */
		if (pavailedge < &edges[MAX_EDGES])
			pavailedge++;
	}

	/*
	 * Create the surface, so we'll know how to sort and draw from the
	 * edges
	 */
	pavailsurf->state = 0;
	pavailsurf->color = currentcolor;
	pavailsurf->bspdepth = currentbspdepth;
	pavailsurf->A = A;
	pavailsurf->B = B;
	pavailsurf->C = C;

	/*
	 * Set up the 1/z gradients from the polygon, calculating the base
	 * value at screen coordinate 0,0 so we can use screen coordinates
	 * directly when calculating 1/z from the gradients
	 */
	distinv = 1.0 / plane->distance;

	/*
	 * pavailsurf->zinvstepx = plane->normal.v[0] * distinv *
	 * maxscreenscaleinv * (fieldofview / 2.0);  pavailsurf->zinvstepy =
	 * -plane->normal.v[1] * distinv * maxscreenscaleinv * (fieldofview /
	 * 2.0); pavailsurf->zinv00 = plane->normal.v[2] * distinv - xcenter *
	 * pavailsurf->zinvstepx - ycenter * pavailsurf->zinvstepy;
	 */
	/* Make sure we don't overflow the surface array */
	if (pavailsurf < &surfs[MAX_SURFS])
		pavailsurf++;
}


short           OldFPUCW, FPUCW;


void   fpu32()
{
	_asm { fstcw[OldFPUCW]
		 mov ax, OldFPUCW
	 and eax, 0xcff
	 mov[FPUCW], ax
	 fldcw[FPUCW]
		//modify [EAX];]
	}
}
//#pragma aux fpu32 = \
//   "fstcw [OldFPUCW]"\
//   "mov ax,OldFPUCW"\
//   "and eax,0xcff"\
//  "mov [FPUCW],ax"\
//   "fldcw [FPUCW]"\
//   //modify [EAX];
//
void            fpu64()
{
	_asm fldcw [OldFPUCW]
}
//#pragma aux fpu64 = \
//   "fldcw [OldFPUCW]";
//
/*
 * void fastertimer(); #pragma aux fastertimer = \ "mov al,0x36" \ "out
 * 0x43,al" \ "mov al,2" \ "out 0x40,al" \ "mov al,2" \ "out 0x40,al" \
 */


#define    ASMDEEL  _asm fld1  _asm fdiv cc  _asm fstp cinv



//#pragma aux deel = \
//  "fld1" \
//  "fdiv cc" \
//  "fstp cinv" \
//


void            deel1()
{
  _asm fld1
  _asm fdiv cc
}

//#pragma aux deel1 = \
//  "fld1" \
//  "fdiv cc" \
//

void            deel2()
{
	_asm fstp cinv
}
//#pragma aux deel2 = \
//  "fstp cinv" \
//

void            updateuv0()
{
	_asm fld sixtyfive
	_asm fmul cinv
	_asm fld st
	_asm fmul aa
   _asm fistp u0
	_asm fmul bb
   _asm fistp v0

}
/*
#pragma aux updateuv0 = \
   "fld sixtyfive" \
   "fmul cinv" \
   "fld st" \
   "fmul aa" \
   "fistp u0" \
   "fmul bb" \
   "fistp v0" \
*/
void            updateuv1()
{
   _asm fld sixtyfive
   _asm fmul cinv
   _asm fld st
   _asm fmul aa
   _asm fistp u1
   _asm fmul bb
   _asm fistp v1

}
//#pragma aux updateuv1 = \
//   "fld sixtyfive" \
//   "fmul cinv" \
//   "fld st" \
//   "fmul aa" \
//   "fistp u1" \
//   "fmul bb" \
//   "fistp v1" \
//

void            initfasttex1()
{
           _asm mov   eax, pcxtexture
	       _asm add   al,  byte ptr u
	       _asm add   ah,  byte ptr v
	       _asm mov   ebx, eax
           _asm mov   edi, screenbuffer
	       _asm and   bx,  word ptr mask2
	       _asm mov   dx,  word ptr fu_lo
	       _asm shl   edx, 16
	       _asm mov   dh,  byte ptr dv_hi
		   _asm mov   dl,  byte ptr du_hi
	       _asm mov   ax,  word ptr fv_lo
	       _asm shl   eax, 16

}
/*#pragma aux initfasttex1 = \
               "mov   eax, pcxtexture" \
	       "add   al,  byte ptr u" \
	       "add   ah,  byte ptr v" \
	       "mov   ebx, eax" \
               "mov   edi, screenbuffer" \
	       "and   bx,  word ptr mask2" \
	       "mov   dx,  word ptr fu_lo" \
	       "shl   edx, 16"  \
	       "mov   dh,  byte ptr dv_hi" \
	       "mov   dl,  byte ptr du_hi" \
	       "mov   ax,  word ptr fv_lo" \
	       "shl   eax, 16"  \
	  modify [eax ebx ecx edx esi edi ebp];
*/

void VBE_MemSet()
{
               _asm mov   ecx,VBE_Count
               _asm mov   eax,VBE_Color
               _asm mov   edi,screenbuffer
               _asm loopje: mov byte ptr gs:[ecx+edi],al
               _asm dec   ecx
               _asm jnz   loopje

}
/*
#pragma aux VBE_MemSet = \
               "mov   ecx,VBE_Count" \
               "mov   eax,VBE_Color" \
               "mov   edi,screenbuffer" \
               "loopje: mov byte ptr gs:[ecx+edi],al" \
               "dec   ecx"\
               "jnz   loopje" \
          modify [eax ecx edi];
*/

void            initfasttex2()
{
			_asm mov   si,  word ptr du_lo
			_asm shl   esi, 16
			_asm  mov   cx,  word ptr dv_lo
			_asm	shl   ecx, 16
			_asm  mov   cx,  word ptr run
			_asm push  ebp
			_asm xor   ebp, ebp
			_asm mov   bp, cx
			_asm xor   cx, cx
			_asm add   edi, ebp
			_asm neg   ebp
}
/*
#pragma aux initfasttex2 = \
	       "mov   si,  word ptr du_lo" \
	       "shl   esi, 16"   \
	       "mov   cx,  word ptr dv_lo" \
	       "shl   ecx, 16"     \
	       "mov   cx,  word ptr run"     \
	       "push  ebp"           \
	       "xor   ebp, ebp"       \
	       "mov   bp, cx"          \
	       "xor   cx, cx"           \
	       "add   edi, ebp"          \
	       "neg   ebp"                \
	  modify [eax ebx ecx edx esi edi ebp];

  */

void  fasttexloop0(void)
{
	_asm ml5: and bx,word ptr mask2
	_asm or bx,word ptr mipmask
	_asm mov   al, byte ptr [ebx]
	_asm add   edx, esi
	_asm adc   bl,  dl
	_asm add   eax, ecx
	_asm adc   bh,  dh
	_asm mov byte ptr gs:[edi+ebp],al
	_asm inc   ebp
	_asm jnz   ml5
	_asm pop   ebp
	_asm mov   screenbuffer, edi

}
/*
#pragma aux fasttexloop0 = \
"ml5: and bx,word ptr mask2" \
"or bx,word ptr mipmask" \
"mov   al, byte ptr [ebx]" \
"add   edx, esi" \
"adc   bl,  dl" \
"add   eax, ecx" \
"adc   bh,  dh" \
"mov byte ptr gs:[edi+ebp],al" \
"inc   ebp" \
"jnz   ml5" \
"pop   ebp" \
"mov   screenbuffer, edi" \
modify[eax ebx ecx edx esi edi ebp];
*/

void  fasttexloop1(void)
{
	_asm ml5: and bx,word ptr mask2
	_asm or bx,word ptr mipmask
	_asm mov   al, byte ptr [ebx]
	_asm add   edx, esi
	_asm adc   bl,  dl
	_asm add   eax, ecx
	_asm adc   bh,  dh
	_asm mov [edi+ebp],al
	_asm inc   ebp
	_asm jnz   ml5
	_asm pop   ebp
	_asm mov   screenbuffer, edi
}
/*
#pragma aux fasttexloop1 = \
"ml5: and bx,word ptr mask2" \
"or bx,word ptr mipmask" \
"mov   al, byte ptr [ebx]" \
"add   edx, esi" \
"adc   bl,  dl" \
"add   eax, ecx" \
"adc   bh,  dh" \
"mov [edi+ebp],al" \
"inc   ebp" \
"jnz   ml5" \
"pop   ebp" \
"mov   screenbuffer, edi" \
modify[eax ebx ecx edx esi edi ebp];
*/
          

/*
 * Draw all the spans
 */
 
void
VBE_DrawSpans(void)
{
	span_t         *pspan;
	int             count;
	float           A16x, B16x, C16x;
	float           x0, y0;
	int             xx, yy;
	fpu32();
                                                     
        //coockieGS = coockie_getLinearSelector(&coockieModeInfo);
        //cckInitGS(); 

        for (pspan = spans; pspan->x != -1; pspan++) {
                screenbuffer = pspan->x + WindowOffsetX + (DIBPitch * (pspan->y + WindowOffsetY));


		if (pspan->color != -1) {
			pcxtexture = texturestart;
			pcxtexture += ((pspan->color & 127) * 65536);

				xx = pspan->x;
				yy = pspan->y;

				A16x = pspan->A.v[0] * RUN_LENGTH;
				B16x = pspan->B.v[0] * RUN_LENGTH;
				C16x = pspan->C.v[0] * RUN_LENGTH;


				x0 = xx - xcenter;
				y0 = yy - ycenter;

				aa = x0 * pspan->A.v[0] + y0 * pspan->A.v[1] + pspan->A.v[2];
				bb = x0 * pspan->B.v[0] + y0 * pspan->B.v[1] + pspan->B.v[2];
				cc = x0 * pspan->C.v[0] + y0 * pspan->C.v[1] + pspan->C.v[2];

                                if (pspan->z < (maxxscale)) {
				mask2 = 127*256+127;
				mipmask = 0;
				sixtyfive = 65536*256;
				} /*
				  else 
                                if (pspan->z <2*maxxscale) {
				mask2 = 63*256+63;
				mipmask = 128;
				sixtyfive = 65536*128;
				} else 
                                if (pspan->z < 4*maxxscale) {
				mask2 = 31*256+31;
				mipmask = 128+64;
				sixtyfive = 65536*64;
				} else 
                                if (pspan->z < 8*maxxscale) {
				mask2 = 15*256+15;
				mipmask = 128+64+32;
				sixtyfive = 65536*32;
				} else 
                                //if (pspan->z < 16*maxxscale) 
				{
				mask2 = 7*256+7;
				mipmask = 128+64+32+16;
				sixtyfive = 65536*16;
				};
                                    
				if ((pspan->color == 0)|| (mip == 1)) {
				mask2 = 127*256+127;
				mipmask = 0;
				sixtyfive = 65536*256;
				};
				   
*/
				/* cinv = 1/cc; */

				ASMDEEL //deel();
				/*
				 * compute u and v at the start and end of a
				 * sub-span:
				 */
				/*
				 * u0 = (long) (aa * cinv * (float)0x10000)
				 * *256 ; v0 = (long) (bb * cinv *
				 * (float)0x10000) *256 ;
				 */
				updateuv0();

				count = pspan->count;

				aa += A16x;
				bb += B16x;
				cc += C16x;

				ASMDEEL //deel();

				/*
				 * u1 = (long) (aa * cinv * (float)0x10000)
				 * *256 ; v1 = (long) (bb * cinv *
				 * (float)0x10000) *256 ;
				 */
				updateuv1();
				run = RUN_LENGTH;
				while (count >= RUN_LENGTH) {

					/*
					 * compute linear increment for u and
					 * v:
					 */
					du = (u1 - u0) >> RUN_LENGTHEXP;
					dv = (v1 - v0) >> RUN_LENGTHEXP;

					aa += A16x;
					bb += B16x;
					cc += C16x;

					u = (u0 >> 16); /* & 255; */
					v = (v0 >> 16); /* & 255; */

					deel1();

					/*
					 * perform bilinear interpolation
					 * across sub-span:
					 */
					du_hi = (BYTE) (du >> 16);
					du_lo = (WORD) (du & 0xffff);
					dv_hi = (BYTE) (dv >> 16);
					dv_lo = (WORD) (dv & 0xffff);
					fu_lo = (WORD) (u0 & 0xffff);
					fv_lo = (WORD) (v0 & 0xffff);


					/*
					 * lineartexture();
					 */

					initfasttex1();
				  	initfasttex2();
                    fasttexloop0();
					deel2();

					count -= run;

					u0 = u1;
					v0 = v1;

					/*
					 * u1 = (long) (aa * cinv *
					 * (float)0x10000) *256 ; v1 = (long)
					 * (bb * cinv * (float)0x10000) *256
					 * ;
					 */
					updateuv1();
				};
				if (count) {
					run = (count > RUN_LENGTH) ? RUN_LENGTH : count;
					/*
					 * compute linear increment for u and
					 * v:
					 */
					du = (u1 - u0) >> RUN_LENGTHEXP;
					dv = (v1 - v0) >> RUN_LENGTHEXP;
					u = (u0 >> 16); /* & 255; */
					v = (v0 >> 16); /* & 255; */
					du_hi = (BYTE) (du >> 16);
					du_lo = (WORD) (du & 0xffff);
					dv_hi = (BYTE) (dv >> 16);
					dv_lo = (WORD) (dv & 0xffff);
					fu_lo = (WORD) (u0 & 0xffff);
					fv_lo = (WORD) (v0 & 0xffff);
					initfasttex1();
					initfasttex2();
                    fasttexloop0();

				}

		} else {
                        VBE_Color = 0;//pspan->color;
                        VBE_Count = pspan->count;
                        VBE_MemSet();
                        /* fill background color
                        */
			screenbuffer += pspan->count;

		};
	}

	fpu64();
}


//#define _RAWASSEMBLY
#define WATJES_C

/*
 * Draw all the spans
 */
 
void
VGA_DrawSpans(void)
{
	span_t         *pspan;
	int             count;
	float           A16x, B16x, C16x;
	float           x0, y0;
	int             xx, yy;

//#ifdef _RAWASSEMBLY
	fpu32();
//#endif
                                                     
        for (pspan = spans; pspan->x != -1; pspan++) {
                screenbuffer = (unsigned char *) VideoOffset;
                screenbuffer += pspan->x + WindowOffsetX + (DIBPitch * (pspan->y + WindowOffsetY));


		if (pspan->color != -1) {
			pcxtexture = texturestart;
			pcxtexture += ((pspan->color & 127) * 65536);

				xx = pspan->x;
				yy = pspan->y;

				A16x = pspan->A.v[0] * RUN_LENGTH;
				B16x = pspan->B.v[0] * RUN_LENGTH;
				C16x = pspan->C.v[0] * RUN_LENGTH;


				x0 = xx - xcenter;
				y0 = yy - ycenter;

				aa = x0 * pspan->A.v[0] + y0 * pspan->A.v[1] + pspan->A.v[2];
				bb = x0 * pspan->B.v[0] + y0 * pspan->B.v[1] + pspan->B.v[2];
				cc = x0 * pspan->C.v[0] + y0 * pspan->C.v[1] + pspan->C.v[2];

                                if (pspan->z < (maxxscale)) {
				mask2 = 127*256+127;
				mipmask = 0;
				sixtyfive = 65536*256;
				} /*
								else 
                                if (pspan->z <2*maxxscale) {
				mask2 = 63*256+63;
				mipmask = 128;
				sixtyfive = 65536*128;
				} else 
                                if (pspan->z < 4*maxxscale) {
				mask2 = 31*256+31;
				mipmask = 128+64;
				sixtyfive = 65536*64;
				} else 
                                if (pspan->z < 8*maxxscale) {
				mask2 = 15*256+15;
				mipmask = 128+64+32;
				sixtyfive = 65536*32;
				} else 
                                //if (pspan->z < 16*maxxscale) 
				{
				mask2 = 7*256+7;
				mipmask = 128+64+32+16;
				sixtyfive = 65536*16;
				};
                                    
				if ((pspan->color == 0)|| (mip == 1)) {
				mask2 = 127*256+127;
				mipmask = 0;
				sixtyfive = 65536*256;
				};
				   

				*/

//#ifdef _RAWASSEMBLY
//				deel();
//#endif
//#ifdef WATJES_C
				cinv = 1/cc;
//#endif
				/*
				 * compute u and v at the start and end of a
				 * sub-span:
				 */
//#ifdef WATJES_C
	
//				 u0 = (long) (aa * cinv * (float)0x10000)  *256 ; 
//				 v0 = (long) (bb * cinv *  (float)0x10000) *256 ;
		 
//#endif

//#ifdef _RAWASSEMBLY
				updateuv0();
//#endif

				count = pspan->count;

				aa += A16x;
				bb += B16x;
				cc += C16x;

//#ifdef _RAWASSEMBLY
//				deel();
//#endif

//#ifdef WATJES_C
			
				cinv = 1/cc;

				//  u1 = (long) (aa * cinv * (float)0x10000)  *256 ; 
				//  v1 = (long) (bb * cinv *  (float)0x10000) *256 ;				 
				
//#endif

//#ifdef _RAWASSEMBLY
				updateuv1();
//				  _asm fld sixtyfive
//					_asm fmul cinv
//					_asm fld st
//					_asm fmul aa
//					_asm fistp u1
//					_asm fmul bb
//					_asm fistp v1
//#endif

				run = RUN_LENGTH;
				while (count >= RUN_LENGTH) {

					/*
					 * compute linear increment for u and
					 * v:
					 */
					du = (u1 - u0) >> RUN_LENGTHEXP;
					dv = (v1 - v0) >> RUN_LENGTHEXP;

					aa += A16x;
					bb += B16x;
					cc += C16x;

					u = (u0 >> 16); /* & 255; */
					v = (v0 >> 16); /* & 255; */

//#ifdef _RAWASSEMBLY
//					deel1();
//#endif

					cinv = 1/cc;

					/*
					 * perform bilinear interpolation
					 * across sub-span:
					 */
					du_hi = (BYTE) (du >> 16);
					du_lo = (WORD) (du & 0xffff);
					dv_hi = (BYTE) (dv >> 16);
					dv_lo = (WORD) (dv & 0xffff);
					fu_lo = (WORD) (u0 & 0xffff);
					fv_lo = (WORD) (v0 & 0xffff);


					/*
					 * lineartexture();
					 */

//#ifdef _RAWASSEMBLY

					// BEGIN initfasttex1();

					_asm pusha
					_asm mov   eax, pcxtexture
				   _asm add   al,  byte ptr u
				   _asm add   ah,  byte ptr v
				   _asm mov   ebx, eax
				   _asm mov   edi, screenbuffer
				   _asm and   bx,  word ptr mask2
				   _asm mov   dx,  word ptr fu_lo
				   _asm shl   edx, 16
				   _asm mov   dh,  byte ptr dv_hi
				   _asm mov   dl,  byte ptr du_hi
				   _asm mov   ax,  word ptr fv_lo
				   _asm shl   eax, 16
					// END initfasttex1();
					//BEGIN initfasttex2();
					_asm mov   si,  word ptr du_lo
					_asm shl   esi, 16
					_asm  mov   cx,  word ptr dv_lo
					_asm	shl   ecx, 16
					_asm  mov   cx,  word ptr run
					_asm push  ebp
					_asm xor   ebp, ebp
					_asm mov   bp, cx
					_asm xor   cx, cx
					_asm add   edi, ebp
					_asm neg   ebp
					//END initfasttex2();
                    //BEGIN fasttexloop1();
					_asm ml5: and bx,word ptr mask2
					_asm or bx,word ptr mipmask
					_asm mov   al, byte ptr [ebx]
					_asm add   edx, esi
					_asm adc   bl,  dl
					_asm add   eax, ecx
					_asm adc   bh,  dh
					_asm mov [edi+ebp],al
					_asm inc   ebp
					_asm jnz   ml5
					_asm pop   ebp
					_asm mov   screenbuffer, edi
					//END fasttexloop1();

					_asm popa


					//deel2();
//#endif


//#ifdef WATJES_C
//					memset (screenbuffer,1,run);
//                    screenbuffer += run;
//#endif



					count -= run;

					u0 = u1;
					v0 = v1;
//#ifdef WATJES_C
						cinv = 1/cc;

//					  u1 = (long) (aa * cinv *	  (float)0x10000) *256 ; 
//					  v1 = (long)	  (bb * cinv * (float)0x10000) *256		  ;
//#endif

//#ifdef _RAWASSEMBLY
					updateuv1();
//#endif

				};
				if (count) {
					run = (count > RUN_LENGTH) ? RUN_LENGTH : count;
					/*
					 * compute linear increment for u and
					 * v:
					 */
					du = (u1 - u0) >> RUN_LENGTHEXP;
					dv = (v1 - v0) >> RUN_LENGTHEXP;
					u = (u0 >> 16); /* & 255; */
					v = (v0 >> 16); /* & 255; */
					du_hi = (BYTE) (du >> 16);
					du_lo = (WORD) (du & 0xffff);
					dv_hi = (BYTE) (dv >> 16);
					dv_lo = (WORD) (dv & 0xffff);
					fu_lo = (WORD) (u0 & 0xffff);
					fv_lo = (WORD) (v0 & 0xffff);

//#ifdef _RAWASSEMBLY
					//initfasttex1();
					//initfasttex2();
                    //fasttexloop1();
					//memset (screenbuffer,0,run);
					//screenbuffer += run;//pspan->count;
								// BEGIN initfasttex1();
					
					_asm pusha
					_asm mov   eax, pcxtexture
				   _asm add   al,  byte ptr u
				   _asm add   ah,  byte ptr v
				   _asm mov   ebx, eax
				   _asm mov   edi, screenbuffer
				   _asm and   bx,  word ptr mask2
				   _asm mov   dx,  word ptr fu_lo
				   _asm shl   edx, 16
				   _asm mov   dh,  byte ptr dv_hi
				   _asm mov   dl,  byte ptr du_hi
				   _asm mov   ax,  word ptr fv_lo
				   _asm shl   eax, 16
					// END initfasttex1();
					//BEGIN initfasttex2();
					_asm mov   si,  word ptr du_lo
					_asm shl   esi, 16
					_asm  mov   cx,  word ptr dv_lo
					_asm	shl   ecx, 16
					_asm  mov   cx,  word ptr run
					_asm push  ebp
					_asm xor   ebp, ebp
					_asm mov   bp, cx
					_asm xor   cx, cx
					_asm add   edi, ebp
					_asm neg   ebp
					//END initfasttex2();
                    //BEGIN fasttexloop1();
					_asm sml5: and bx,word ptr mask2
					_asm or bx,word ptr mipmask
					_asm mov   al, byte ptr [ebx]
					_asm add   edx, esi
					_asm adc   bl,  dl
					_asm add   eax, ecx
					_asm adc   bh,  dh
					_asm mov [edi+ebp],al
					_asm inc   ebp
					_asm jnz   sml5
					_asm pop   ebp
					_asm mov   screenbuffer, edi
					//END fasttexloop1();

					_asm popa

//#endif

				}

		} else {
                         /* fill background color
                        */
                        memset (screenbuffer,0,pspan->count);
                        screenbuffer += pspan->count;

		};
	}

//#ifdef _RAWASSEMBLY
	fpu64();
//#endif

}



void
ScanEdges(void)
{
	int             x, y;
	float           fx, fy;
	float           tinvz, tinvz2;
	edge_t         *pedge, *pedge2, *ptemp, *matching_edge;
	edge_t          left_edge;
	span_t         *pspan;
	surf_t         *psurf, *psurf2;
	float           slice_width;

	pspan = spans;

	left_edge.invz = -999999.0;
	left_edge.dinvz = 0;

	/*
	 * Set up the active edge list as initially empty, containing only
	 * the sentinels (which are also the background fill). Most of these
	 * fields could be set up just once at start-up
	 */
	edgehead.pnext = &edgetail;
	edgehead.pprev = NULL;
	edgehead.x = -0xFFFF;   /* left edge of screen */
	edgehead.leading = 1;
	edgehead.psurf = &surfstack;

	edgetail.pnext = NULL;  /* mark edge of list */
	edgetail.pprev = &edgehead;
	edgetail.x = DIBWidth << 16;    /* right edge of screen  */
	edgetail.leading = 0;
	edgetail.psurf = &surfstack;

	/*
	 * The background surface is the entire stack initially, and is
	 * infinitely far away, so everything sorts in front of it. This
	 * could be set just once at start-up
	 */
	surfstack.pnext = surfstack.pprev = &surfstack;
	surfstack.color = -1;
	surfstack.bspdepth = -32767;
	surfstack.invz = -999999.0;
	surfstack.dinvz = 0;
	surfstack.edge = &left_edge;

	for (y = 0; y < DIBHeight; y++) {
		fy = (float) y;

		/* Sort in any edges that start on this scan */
		pedge = newedges[y].pnext;
		pedge2 = &edgehead;
		while (pedge != &maxedge) {
			while (pedge->x > pedge2->pnext->x)
				pedge2 = pedge2->pnext;

			ptemp = pedge->pnext;
			pedge->pnext = pedge2->pnext;
			pedge->pprev = pedge2;
			pedge2->pnext->pprev = pedge;
			pedge2->pnext = pedge;

			pedge2 = pedge;
			pedge = ptemp;
		}

		/*
		 * Scan out the active edges into spans
		 * 
		 * Start out with the left background edge already inserted, and
		 * the surface stack containing only the background
		 */
		surfstack.state = 1;
		surfstack.visxstart = 0;

		for (pedge = edgehead.pnext; pedge; pedge = pedge->pnext) {
			psurf = pedge->psurf;
			if (pedge->leading) {
				/*
				 * set surface edge upon finding leading edge
				 */
				psurf->edge = pedge;
				matching_edge = pedge->pnext;
				while (matching_edge && matching_edge != &maxedge) {
					if (matching_edge->psurf == psurf)
						break;
					matching_edge = matching_edge->pnext;
				}
				if (matching_edge == 0)
					slice_width = 0;
				else
					slice_width = (float) matching_edge->x * (1.0 / (float) 0x10000)
						- (float) pedge->x * (1.0 / (float) 0x10000);

				if (slice_width != 0 && matching_edge != &maxedge) {
					psurf->dinvz = (matching_edge->invz - pedge->invz)
						/ slice_width;
				} else {
					psurf->dinvz = 0;

				}
			      //  fx = (float) pedge->x * (1.0 / (float) 0x10000);
				fx = (((int) pedge->x) + 0xFFFF) >> 16;
				psurf->invz = pedge->invz - fx * psurf->dinvz;
				/*
				 * It's a leading edge. Figure out where it
				 * is relative to the current surfaces and
				 * insert in the surface stack; if it's on
				 * top, emit the span for the current top.
				 * First, make sure the edges don't cross
				 */
				if (++psurf->state == 1) {
					/*
					 * Calculate the surface's 1/z value
					 * at this pixel
					 * 
					 * See if that makes it a new top
					 * surface
					 */
					psurf2 = surfstack.pnext;

					if ((psurf->bspdepth != -1) && (psurf2->bspdepth != -1))
						/*
						 * use bsp depthsort for
						 * static world objects
						 */
					{
						tinvz2 = psurf2->bspdepth;
						tinvz = psurf->bspdepth;
					} else {
						/*
						 * use calculated z depthsort
						 * if moving objects are
						 * involved (one of the
						 * bspdepths is -1)
						 */
						tinvz2 = psurf2->invz + psurf2->dinvz * fx;
						tinvz = psurf->invz + psurf->dinvz * fx;
					};
					if ((tinvz >= tinvz2)) {
						/*
						 * It's a new top surface
						 * emit the span for the
						 * current top
						 */
						x = (((int) pedge->x) + 0xFFFF) >> 16;
						pspan->count = x - psurf2->visxstart;
						if (pspan->count > 0) {
							
							pspan->y = y;
							pspan->x = psurf2->visxstart;
							pspan->z = 1 / (psurf2->invz + psurf2->dinvz * (float) pspan->x);  
							if (psurf2->dinvz > 0) {
							pspan->z = 1 / (psurf2->invz + psurf2->dinvz * (float)(pspan->x + pspan->count));
							};
							pspan->color = psurf2->color;

							pspan->A = psurf2->A;
							pspan->B = psurf2->B;
							pspan->C = psurf2->C;

							//pspan->invz = psurf2->invz
							//        + psurf2->dinvz * (float) pspan->x;
							//pspan->dinvz = psurf2->dinvz;

							if (pspan < &spans[MAX_SPANS])
								pspan++;
						}
						psurf->visxstart = x;

						/*
						 * Add the edge to the stack
						 */
						psurf->pnext = psurf2;
						psurf2->pprev = psurf;
						surfstack.pnext = psurf;
						psurf->pprev = &surfstack;
					} else {
						/*
						 * Not a new top; sort into
						 * the surface stack.
						 * Guaranteed to terminate
						 * due to sentinel background
						 * surface
						 */
						do {
							psurf2 = psurf2->pnext;

							if ((psurf->bspdepth != -1) && (psurf2->bspdepth != -1)) {
								tinvz2 = psurf2->bspdepth;
								tinvz = psurf->bspdepth;
							} else {
								tinvz2 = psurf2->invz + psurf2->dinvz * fx;
								tinvz = psurf->invz + psurf->dinvz * fx;
							};

						} while ((tinvz < tinvz2));
						/*
						 * Insert the surface into
						 * the stack
						 */
						psurf->pnext = psurf2;
						psurf->pprev = psurf2->pprev;
						psurf2->pprev->pnext = psurf;
						psurf2->pprev = psurf;
					}
				}
			} else {
				/*
				 * It's a trailing edge; if this was the top
				 * surface, emit the span and remove it.
				 * First, make sure the edges didn't cross
				 */
				if (--psurf->state == 0) {
					if (surfstack.pnext == psurf) {
						/*
						 * It's on top, emit the span
						 */
						x = (((int) pedge->x + 0xFFFF) >> 16);
						pspan->count = x - psurf->visxstart;
						if (pspan->count > 0) {
							pspan->y = y;
							pspan->x = psurf->visxstart;
							pspan->z = 1 / (psurf->invz + psurf->dinvz * (float) pspan->x);  
							if (psurf->dinvz > 0) {
							pspan->z = 1/(psurf->invz + psurf->dinvz * (float)(pspan->x+pspan->count));
							};

							pspan->color = psurf->color;
							pspan->A = psurf->A;
							pspan->B = psurf->B;
							pspan->C = psurf->C;

							//pspan->invz = psurf->invz
							//        + psurf->dinvz * (float) pspan->x;
							//pspan->dinvz = psurf->dinvz;

							/*
							 * Make sure we don't
							 * overflow the span
							 * array
							 */
							if (pspan < &spans[MAX_SPANS])
								pspan++;
						}
						psurf->pnext->visxstart = x;
					}
					/*
					 * Remove the surface from the stack
					 */
					psurf->pnext->pprev = psurf->pprev;
					psurf->pprev->pnext = psurf->pnext;
				}
			}
		}

		/*
		 * Remove edges that are done
		 */
		pedge = removeedges[y];
		while (pedge) {
			pedge->pprev->pnext = pedge->pnext;
			pedge->pnext->pprev = pedge->pprev;
			pedge = pedge->pnextremove;
		}

		/*
		 * Step the remaining edges one scan line, and re-sort
		 */
		for (pedge = edgehead.pnext; pedge != &edgetail;) {
			ptemp = pedge->pnext;

			/* Step the edge */
			pedge->x += pedge->xstep;

			/*
			 * yet more modifications for texture mapping Step
			 * the texture
			 */
			pedge->invz += pedge->dinvz;

			/*
			 * Move the edge back to the proper sorted location,
			 * if necessary
			 */
			while (pedge->x < pedge->pprev->x) {
				pedge2 = pedge->pprev;
				pedge2->pnext = pedge->pnext;
				pedge->pnext->pprev = pedge2;
				pedge2->pprev->pnext = pedge;
				pedge->pprev = pedge2->pprev;
				pedge->pnext = pedge2;
				pedge2->pprev = pedge;
			}

			pedge = ptemp;
		}
	}

	pspan->x = -1;          /* mark the end of the list */
}
/*
 * Clear the lists of edges to add and remove on each scan line.
 */
void
ClearEdgeLists(void)
{
	int             i;

	for (i = 0; i < DIBHeight; i++) {
		newedges[i].pnext = &maxedge;
		removeedges[i] = NULL;
	}
}

void
TransformvPoint(point_t * pin, VERTEX * pout)
{
	int             i;
	point_t         tvert;

	/*
	 * Translate into a viewpoint-relative coordinate
	 */
	for (i = 0; i < 3; i++) {
		tvert.v[i] = pin->v[i] - currentpos.v[i];
	}

	/*
	 * Rotate into the view orientation
	 */
	pout->xx = DotProduct(&tvert, &vright);
	pout->yy = DotProduct(&tvert, &vup);
	pout->zz = DotProduct(&tvert, &vpn);
}

/*
 * Transform a point from worldspace to viewspace.
 */
void
TransformPoint(point_t * pin, point_t * pout)
{
	int             i;
	point_t         tvert;

	/*
	 * Translate into a viewpoint-relative coordinate
	 */
	for (i = 0; i < 3; i++) {
		tvert.v[i] = pin->v[i] - currentpos.v[i];
	}

	/*
	 * Rotate into the view orientation
	 */
	pout->v[0] = DotProduct(&tvert, &vright);
	pout->v[1] = DotProduct(&tvert, &vup);
	pout->v[2] = DotProduct(&tvert, &vpn);

}


/*
 * Transform a polygon from worldspace to viewspace.
 */
void
TransformPolygon(polygon_t * pinpoly, polygon_t * poutpoly)
{
	int             i;

	for (i = 0; i < pinpoly->numverts; i++) {
		TransformPoint(&pinpoly->verts[i], &poutpoly->verts[i]);
	}

	poutpoly->numverts = pinpoly->numverts;

}

int
ClipToPlane(polygon_t * pin, plane_t * pplane, polygon_t * pout);

/*
 * Clip a polygon to the frustum.
 */
int
ClipToFrustum(polygon_t * pin, polygon_t * pout)
{
	int             i, curpoly;
	polygon_t       tpoly[2], *ppoly;

	curpoly = 0;
	ppoly = pin;

	for (i = 0; i < (NUM_FRUSTUM_PLANES - 1); i++) {
		if (!ClipToPlane(ppoly,
				 &frustumplanes[i],
				 &tpoly[curpoly])) {
			return 0;
		}
		ppoly = &tpoly[curpoly];
		curpoly ^= 1;
	}

	return ClipToPlane(ppoly,
			   &frustumplanes[NUM_FRUSTUM_PLANES - 1],
			   pout);
}

int
PolyFacesViewer(polygon_t * ppoly, plane_t * pplane, point_t positie);

void
addpolygon(polygon_t * ppoly)
{
	polygon2D_t     screenpoly;
	polygon_t       tpoly1, tpoly2, tpoly3;
	plane_t         plane;
	point_t         tnormal;
	VERTEX          P, M, N;

	if (PolyFacesViewer(ppoly, &ppoly->plane, currentpos)) {
		if (ClipToFrustum(ppoly, &tpoly1)) {
			currentcolor = ppoly->color;
			currentbspdepth = ppoly->bspdepth;
			TransformPolygon(&tpoly1, &tpoly2);
			TransformPolygon(ppoly, &tpoly3);
			TransformvPoint(&ppoly->P, &P);
			TransformvPoint(&ppoly->M, &M);
			TransformvPoint(&ppoly->N, &N);


			M = vectorsubtract(M, P);
			N = vectorsubtract(N, P);

			/* Compute gradients */
                        P.xx *= maxxscale;
                        M.xx *= maxxscale;
                        N.xx *= maxxscale;
                        P.yy *= -maxyscale;
                        M.yy *= -maxyscale;
                        N.yy *= -maxyscale;

			CrossvProduct(&P, &N, &A);
			CrossvProduct(&M, &P, &B);
			CrossvProduct(&N, &M, &C);
			/*
			 * Move the polygon's plane into viewspace
			 */
			ProjectPolygon(&tpoly2, &screenpoly);

			tnormal = ppoly->plane.normal;
			plane.distance = ppoly->plane.distance;
			/*
			 * Determine the distance from the viewpont
			 */
			plane.distance -=
				DotProduct(&currentpos, &tnormal);
			/*
			 * Rotate the normal into view orientation
			 */
			plane.normal.v[0] =
				DotProduct(&tnormal, &vright);
			plane.normal.v[1] =
				DotProduct(&tnormal, &vup);
			plane.normal.v[2] =
				DotProduct(&tnormal, &vpn);


			AddPolygonEdges(&plane, &screenpoly);
			currentbspdepth++;

		}
	}
}



/*
 * *******************************************
 * 
 * 
 */
int
InitPos(void)
{
	gravitationspeed = 0;
	gravitationaccel = 0.3;
	playerspeedscale = 1;
	speedscale = 1;
	roll = 0.0;
	pitch = 0.0;
	yaw = 0.9211;
	yawspeed = 0.0;
	currentspeed = 0.0;
	currentcolor = -1;
	currentpos = startpos;
	playeryawspeed = yawspeed;
	playeryaw = yaw;
	playerroll = roll;
	playercurrentpos = currentpos;
	playerpitch = pitch;

         return (0);

}

int
InitDraw(void)
{
        /*          
	 * Create a main window for this application instance
	 */
	mip = 0;
	DIBWidth = INITIAL_WINDOW_WIDTH;
	DIBHeight = INITIAL_WINDOW_HEIGHT;
        DIBPitch = BYTES_PER_SCANLINE;//INITIAL_DIB_WIDTH;
	WindowOffsetX = 0;
	WindowOffsetY = 0;
         //DIBWidth -= INITIAL_WINDOW_WIDTH/10;
         //DIBHeight -= INITIAL_WINDOW_HEIGHT/10;
         //WindowOffsetX += INITIAL_WINDOW_WIDTH/20;
         //WindowOffsetY += INITIAL_WINDOW_HEIGHT/20;
         //DIBWidth -= INITIAL_WINDOW_WIDTH/10;
         //DIBHeight -= INITIAL_WINDOW_HEIGHT/10;
         //WindowOffsetX += INITIAL_WINDOW_WIDTH/20;
         //WindowOffsetY += INITIAL_WINDOW_HEIGHT/20;

	/*
	 * Set the initial location, direction, and speed
	 */
        fieldofview = FIELD_OF_VIEW;
	xscreenscale = DIBWidth / fieldofview;
        yscreenscale = DIBHeight / (fieldofview );
        maxxscale = xscreenscale ;
        maxyscale = yscreenscale ;
        maxscal = max(xscreenscale,yscreenscale);
        maxscreenscaleinv = 1.0 / maxscal;
	xcenter = DIBWidth / 2.0 - 0.5;
	ycenter = DIBHeight / 2.0 - 0.5;
	RUN_LENGTH = 8;
	RUN_LENGTHEXP = 3;
	/* clear screen */

        /*
		if (true) (modeMenu[currentMode] == -1) 
		{
                screenbuffer = (char *) 0xa0000;
                memset(screenbuffer, 0, INITIAL_DIB_WIDTH * INITIAL_DIB_HEIGHT);
        } else {
                //coockieGS = coockie_getLinearSelector(&coockieModeInfo);
                //cckInitGS(); 
                //SV_clear(0);

        };
		*/


        return (0);
}
int
UpdateDraw(void)
{

	/*
	 * Create a main window for this application instance
	 */
	mip = 0;
        fieldofview = FIELD_OF_VIEW;
	xscreenscale = DIBWidth / fieldofview;
	yscreenscale = DIBHeight / fieldofview;
        maxxscale = xscreenscale  ;
        maxyscale = yscreenscale ;
        maxscal=max(xscreenscale,yscreenscale);
        maxscreenscaleinv = 1.0 / maxscal;
	xcenter = DIBWidth / 2.0 - 0.5;
	ycenter = DIBHeight / 2.0 - 0.5;
	RUN_LENGTH = 8;
	RUN_LENGTHEXP = 3;
	/* clear screen */
    /*    
	if (modeMenu[currentMode] == -1) {
                screenbuffer = (char *) 0xa0000;
                memset(screenbuffer, 0, INITIAL_DIB_WIDTH * INITIAL_DIB_HEIGHT);
        } else {
                //coockieGS = coockie_getLinearSelector(&coockieModeInfo);
                //cckInitGS(); 
                //SV_clear(0);
        };
		*/
        return (0);
}

void
ProjectPolygon(polygon_t * ppoly, polygon2D_t * ppoly2D)
{
	int             i;
	float           zrecip;

	for (i = 0; i < ppoly->numverts; i++) {
		zrecip = 1.0 / ppoly->verts[i].v[2];
		ppoly2D->verts[i].x =
                        ppoly->verts[i].v[0] * zrecip * maxxscale + xcenter;
		ppoly2D->verts[i].y = ycenter -
                        (ppoly->verts[i].v[1] * zrecip * maxyscale);
		ppoly2D->verts[i].z = ppoly->verts[i].v[2];
	}

	ppoly2D->numverts = ppoly->numverts;
}


void
BackRotateVector(point_t * pin, point_t * pout)
{
	int             i;

	/*
	 * Rotate into the world orientation
	 */
	for (i = 0; i < 3; i++) {
		pout->v[i] = pin->v[0] * vright.v[i] +
			pin->v[1] * vup.v[i] +
			pin->v[2] * vpn.v[i];
	}

}


/*
 * Returns true if polygon faces the viewpoint, assuming a clockwise winding
 * of vertices as seen from the front.
 */
int
PolyFacesViewer(polygon_t * ppoly, plane_t * pplane, point_t positie)
{
	int             i;
	point_t         viewvec;

	for (i = 0; i < 3; i++) {
		viewvec.v[i] = ppoly->verts[0].v[i] - positie.v[i];
	}

	/*
	 * Use an epsilon here so we don't get polygons tilted so sharply
	 * that the gradients are unusable or invalid
	 */
	if (DotProduct(&viewvec, &pplane->normal) < -0.01)
		return 1;
	else
		return 0;
}
/*
 * Set up a clip plane with the specified normal.
 */
void
SetWorldspaceClipPlane(point_t * normal, plane_t * plane)
{

	/*
	 * Rotate the plane normal into worldspace
	 */
	BackRotateVector(normal, &plane->normal);

	plane->distance = DotProduct(&currentpos, &plane->normal) +
		CLIP_PLANE_EPSILON;
}

/*
 * Set up the planes of the frustum, in worldspace coordinates.
 */
void
SetUpFrustum(void)
{
	float           angle, s, c;
	point_t         normal;

        angle = atan(2.0 / fieldofview *maxxscale/xscreenscale);
	s = sin(angle);
	c = cos(angle);

	/*
	 * Left clip plane
	 */
	normal.v[0] = s;
	normal.v[1] = 0;
	normal.v[2] = c;
	SetWorldspaceClipPlane(&normal, &frustumplanes[0]);

	/*
	 * Right clip plane
	 */
	normal.v[0] = -s;
	SetWorldspaceClipPlane(&normal, &frustumplanes[1]);

        angle = atan(2.0 / fieldofview * maxyscale / yscreenscale);
	s = sin(angle);
	c = cos(angle);

	/*
	 * Bottom clip plane
	 */
	normal.v[0] = 0;
	normal.v[1] = s;
	normal.v[2] = c;
	SetWorldspaceClipPlane(&normal, &frustumplanes[2]);

	/*
	 * Top clip plane
	 */
	normal.v[1] = -s;
	SetWorldspaceClipPlane(&normal, &frustumplanes[3]);
}

texcoord_t
computePMN(VERTEX S0, VERTEX S1, VERTEX S2, float wu, float wv);

/*
 * Clip a polygon to a plane.
 */
int
ClipToPlane(polygon_t * pin, plane_t * pplane, polygon_t * pout)
{
	int             i, j, nextvert, curin, nextin;
	float           curdot, nextdot, scale;
	point_t        *pinvert, *poutvert;

	pinvert = pin->verts;

	poutvert = pout->verts;

	curdot = DotProduct(pinvert, &pplane->normal);
	curin = (curdot >= pplane->distance);

	for (i = 0; i < pin->numverts; i++) {
		nextvert = (i + 1) % pin->numverts;

		/*
		 * Keep the current vertex if it's inside the plane
		 */
		if (curin)
			*poutvert++ = *pinvert;

		nextdot = DotProduct(&pin->verts[nextvert], &pplane->normal);
		nextin = (nextdot >= pplane->distance);

		/*
		 * Add a clipped vertex if one end of the current edge is
		 * inside the plane and the other is outside
		 */
		if (curin != nextin) {
			scale = (pplane->distance - curdot) /
				(nextdot - curdot);
			for (j = 0; j < 3; j++) {
				poutvert->v[j] = pinvert->v[j] +
					((pin->verts[nextvert].v[j] - pinvert->v[j]) *
					 scale);
			}

			poutvert++;
		}
		curdot = nextdot;
		curin = nextin;
		pinvert++;
	}

	pout->numverts = poutvert - pout->verts;

	if (pout->numverts < 3)
		return 0;

	return 1;
}

texcoord_t
computePMN(VERTEX S0, VERTEX S1, VERTEX S2, float wu, float wv)
{
	texcoord_t      out;
	float           x, y;
	float           h0, h1, h2;
	float           n;

	/*
	 * find Point with P.uu = wu and P.vv = wv so find x and y so that S0
	 * + x * S1 + y * S2 = (wu,wv) , simplify to x*S1 + y*S2 = (0,0) - S0
	 * pointwise gives the two equations eq1:  x*S1.uu + y * S2.uu = wu -
	 * S0.uu eq2:  x*S1.vv + y * S2.vv = wv - S0.vv with gauss
	 * elimination if (S1.uu == 0) or if (S1.vv == 0) then y can be
	 * easily found and x to by substiuuting y.
	 */

	if (S1.uu == 0) {
		y = (wu - S0.uu) / (S2.uu);

	} else if (S1.vv == 0) {
		y = (wv - S0.vv) / (S2.vv);

	} else {

		/*
		 * if both S1.uu and S1.vv are not equal to zero then
		 * calculate new equation, from eq1 and eq2 by substracting
		 * eq2 n times from eq1, so that it results in equation with
		 * first index 0 so n = S1.uu/S1.vv
		 */
		n = S1.uu / S1.vv;
		h0 = S1.uu - n * S1.vv;
		h1 = S2.uu - n * S2.vv;
		h2 = (wu - S0.uu) - n * (wv - S0.vv);
		/*
		 * h0 should be zero (almost -> floating point
		 * errors/distortions!)
		 */
		y = h2 / h1;
	}
	/*
	 * substitute y in eq1:  x*S1.uu + y * S2.uu = wu - S0.uu
	 */
	if (S1.uu != 0) {
		x = ((wu - S0.uu) - (y * S2.uu)) / (S1.uu);
	} else if (S1.vv != 0) {
		x = ((wv - S0.vv) - (y * S2.vv)) / (S1.vv);
	} else {
		printf("Error in texmap coordinates!");
		//exit(-1);
	};

	out.x = x;
	out.y = y;
	return (out);
}

void
ComputeMagic(OLDPOINT center,FACE * faceList)
{
	texcoord_t      texfactor;
	int             polygoncount;
	int             tw;
	float           lengte;
	VERTEX          l0, l1, l2;
	VERTEX          S0, S1, S2;
	point_t         ss1;
	VERTEX          P, M, N;
	VERTEX          tempp, tempm, tempn;
	FACE           *ftrav;

	tw = 128;//tw;
	for (ftrav = faceList; ftrav != NULL_FACE; ftrav = ftrav->fnext) {
		/*
		 * for each polygon do...
		 */
		VERTEX         *vtrav;
		polygoncount = 0;

		vtrav = ftrav->vhead;
		if (vtrav == NULL_VERTEX) {
			printf("Error:Polygon detected with less then 1 vertices");
			exit(-1);
		} else {
			l0.xx = vtrav->xx+center.xx;
			l0.yy = vtrav->yy+center.yy;
			l0.zz = vtrav->zz+center.zz;
			l0.uu = vtrav->uu;
			l0.vv = vtrav->vv;

		};
		vtrav = vtrav->vnext;
		if (vtrav == NULL_VERTEX) {
			printf("Error:Polygon detected with less then 2 vertices");
			exit(-1);
		} else {
			l1.xx = vtrav->xx+center.xx;
			l1.yy = vtrav->yy+center.yy;
			l1.zz = vtrav->zz+center.zz;
			l1.uu = vtrav->uu;
			l1.vv = vtrav->vv;

		};
		vtrav = vtrav->vnext;
		if (vtrav == NULL_VERTEX) {
			printf("Error:Polygon detected with less then 3 vertices");
			exit(-1);
		} else {
			l2.xx = vtrav->xx+center.xx;
			l2.yy = vtrav->yy+center.yy;
			l2.zz = vtrav->zz+center.zz;
			l2.uu = vtrav->uu;
			l2.vv = vtrav->vv;

		};

		if ((((l1.uu != 0) ||
		      (l1.vv != 0)) ||
		     (l2.uu != 0)) ||
		    (l2.vv != 0)) {
			/* if texture coordinates given, use them */


			S0 = l0;
			S1 = vectorsubtract(l1, l0);
			S2 = vectorsubtract(l2, l0);



		} else {
			/* if no texture coordinates given, compute them */
			/*
			 * calculate point in 3space, where
			 * texturecoordinates should be 0
			 */


			S0 = l0;
			if ((ftrav->plane.aa == 0) && (ftrav->plane.bb == 0)) {
				/*
				 * polygon lies in zplane, faces
				 * upwards/downwards
				 */
				S1.xx = tw;
				S1.yy = 0;
				S1.zz = 0;
				S1.uu = tw;
				S1.vv = 0;
				S2.xx = 0;
				S2.yy = -tw;
				S2.zz = 0;
				S2.uu = 0;
				S2.vv = tw;

			} else {
				/*
				 * calculate texturevectors that define
				 * texturespace
				 */
				S1.xx = (-(ftrav->plane.bb));
				S1.yy = (ftrav->plane.aa);
				S1.zz = 0;
				lengte = sqrt(S1.xx * S1.xx + S1.yy * S1.yy + S1.zz * S1.zz);
				S1.xx = (tw / lengte) * S1.xx;
				S1.yy = (tw / lengte) * S1.yy;
				S1.zz = (tw / lengte) * S1.zz;

				S1.uu = tw;
				S1.vv = 0;
				S2.xx = ftrav->plane.aa;
				S2.yy = ftrav->plane.bb;
				S2.zz = ftrav->plane.cc;
				CrossvProduct(&S1, &S2, &ss1);
				S2.xx = ss1.v[0];
				S2.yy = ss1.v[1];
				S2.zz = ss1.v[2];

				lengte = sqrt(S2.xx * S2.xx + S2.yy * S2.yy + S2.zz * S2.zz);
				S2.xx = (tw / lengte) * S2.xx;
				S2.yy = (tw / lengte) * S2.yy;
				S2.zz = (tw / lengte) * S2.zz;
				S2.uu = 0;
				S2.vv = tw;
			}

			/* calc p,m,n */
		}

		texfactor = computePMN(S0, S1, S2, 0, 0);
		/* P = S0 + x * S1 + y * S2; */
		P = vectoradd(S0, vectoradd(vectorscalar(S1, texfactor.x),
					    vectorscalar(S2, texfactor.y)));

		texfactor = computePMN(S0, S1, S2, tw, 0);
		/* M = S0 + x * S1 + y * S2; */
		M = vectoradd(S0, vectoradd(vectorscalar(S1, texfactor.x),
					    vectorscalar(S2, texfactor.y)));

		texfactor = computePMN(S0, S1, S2, 0, tw);
		/* N = S0 + x * S1 + y * S2; */
		N = vectoradd(S0, vectoradd(vectorscalar(S1, texfactor.x),
					    vectorscalar(S2, texfactor.y)));

		tempp.xx = P.xx;
		tempp.yy = P.yy;
		tempp.zz = P.zz;

		if (P.uu >= 0) {
			tempp.uu = P.uu;
		} else
			tempp.uu = 0;
		if (P.vv >= 0) {
			tempp.vv = P.vv;
		} else
			tempp.vv = 0;

		ftrav->P = tempp;

		tempm.xx = M.xx;
		tempm.yy = M.yy;
		tempm.zz = M.zz;
		if (M.uu >= 0) {
			tempm.uu = M.uu;
		} else
			tempm.uu = 0;
		if (M.vv >= 0) {
			tempm.vv = M.vv;
		} else
			tempm.vv = 0;

		ftrav->M = tempm;

		tempn.xx = N.xx;
		tempn.yy = N.yy;
		tempn.zz = N.zz;
		if (N.uu >= 0) {
			tempn.uu = N.uu;
		} else
			tempn.uu = 0;
		if (N.vv >= 0) {
			tempn.vv = N.vv;
		} else
			tempn.vv = 0;
		ftrav->N = tempn;


	}                       /* end add each polygon in bspleaf   */

}                               /* computegradients() */




void
drawFaceList(const FACE * faceList)
{
	int             polygoncount;
	const FACE     *ftrav;


	for (ftrav = faceList; ftrav != NULL_FACE; ftrav = ftrav->fnext) {
		VERTEX         *vtrav;

		polygoncount = 0;
		for (vtrav = ftrav->vhead; vtrav->vnext != NULL_VERTEX;
		     vtrav = vtrav->vnext) {
			coockiespoly.verts[polygoncount].v[0] = vtrav->xx;
			coockiespoly.verts[polygoncount].v[1] = vtrav->zz;
			coockiespoly.verts[polygoncount].v[2] = vtrav->yy;
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
		coockiespoly.bspdepth = currentbspdepth;
		coockiespoly.plane.distance = 0;
		coockiespoly.plane.normal.v[0] = -ftrav->plane.aa;
		coockiespoly.plane.normal.v[1] = -ftrav->plane.cc;
		coockiespoly.plane.normal.v[2] = -ftrav->plane.bb;
		addpolygon(&coockiespoly);
	}

}                               /* drawFaceList() */

