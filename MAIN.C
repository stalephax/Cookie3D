/*
   3D engine, main program (demo)
 * (c) Copyright 1997 Erwin J. Coumans  Eindhoven       coockie@stack.nl
 */

#include "global.h"             /* specific to this program */
#include "bsp.h"                /* bsptree specific routines  */
#include "keyboard.h"           /* keyboard handler           */
#include "3d.h"
#include "3dmath.h"
#include "collide.h"
#include "move.h"
#include "object.h"             /* moving objects & sky */
#include "svga.h"
#include "ztimer.h"
#include <graph.h>
#include "cckvideo.h"
#include "cckfile.h"

 /*---------------------------- VESA ---------------------------*/
             


long frames = 0;
long newCount,lastCount,fpsRate;
int             linenumber;
OLDPOINT           playerposition;

/* timer  */
int             timercount = 1;
int             semaphore1;
int             semaphore2;
int shooting = 0;
int largerwindow= 0;
int smallerwindow= 0;

/********************************************/

void
BSPtraverseTreeAndRender(const BSPNODE * bspNode)
{

   if (bspNode == NULL_BSPNODE)
      return;

   if (bspNode->kind == PARTITION_NODE) {
      if (BSPisViewerInPositiveSideOfPlane(&bspNode->node->sameDir->plane, &playerposition)) {

	 BSPtraverseTreeAndRender(bspNode->node->negativeSide);
	 drawFaceList(bspNode->node->sameDir);
	 drawFaceList(bspNode->node->oppDir);   /* back-face cull */
	 BSPtraverseTreeAndRender(bspNode->node->positiveSide);

      } else {

	 BSPtraverseTreeAndRender(bspNode->node->positiveSide);
	 drawFaceList(bspNode->node->oppDir);
	 drawFaceList(bspNode->node->sameDir);  /* back-face cull */
	 BSPtraverseTreeAndRender(bspNode->node->negativeSide);

      }
   } else
      assert(bspNode->kind == IN_NODE || bspNode->kind == OUT_NODE);
}                               /* BSPtraverseTreeAndRender() */


void
CheckKeys()

{
   gravitationvec.v[0] = 0;
   gravitationvec.v[1] = -1;
   gravitationvec.v[2] = 0;

   if ((shooting > 0) && !(keyBoard.c))
	{
	MakeNewObject(currentpos,NORMALRADIUS);
	shooting = 0;
	};
   if ((largerwindow == 1) && !(keyBoard.plus))
	largerwindow = 0;
   if ((smallerwindow == 1) && !(keyBoard.minus))
	smallerwindow = 0;
          
   playeraccel = 0;
   if (keyBoard.down) {
      playeraccel = -MOVEMENT_ACCEL;
      if (playeraccel < -(MAX_MOVEMENT_ACCEL))
         playeraccel = -(MAX_MOVEMENT_ACCEL);
   };

   if (keyBoard.up) {
      playeraccel = MOVEMENT_ACCEL;
      if (playeraccel > (MAX_MOVEMENT_ACCEL))
         playeraccel = (MAX_MOVEMENT_ACCEL);

   };

   if (keyBoard.pgup) {
      playerpitch -= PITCH_SPEED * playerspeedscale;
      if (playerpitch < 0)
	 playerpitch += PI * 2;
   };

   if (keyBoard.pgdn) {
      playerpitch += PITCH_SPEED * playerspeedscale;
      if (playerpitch >= (PI * 2))
	 playerpitch -= PI * 2;
   };
   if (keyBoard.d) {
      gravitationvec.v[0] = 0;
      gravitationvec.v[1] = 1;
      gravitationvec.v[2] = 0;

   };

   if (keyBoard.c) {
	/* add object at players position */
	if ((shooting >= 0) && (shooting < MAX_SHOOTSPEED)) {
		shooting++;
	};
   };
   if (keyBoard.left) {
      playeryawspeed -= YAW_SPEED * playerspeedscale;
      if (playeryawspeed < -(MAX_YAW_SPEED * playerspeedscale))
	 playeryawspeed = -(MAX_YAW_SPEED * playerspeedscale);

   };

   if (keyBoard.right) {
      playeryawspeed += YAW_SPEED * playerspeedscale;
      if (playeryawspeed > (MAX_YAW_SPEED * playerspeedscale))
	 playeryawspeed = (MAX_YAW_SPEED * playerspeedscale);

   };
   if (keyBoard.minus) {
      if (smallerwindow == 0) {

      if ((DIBWidth > INITIAL_WINDOW_WIDTH/10 ) &&
         (DIBHeight > INITIAL_WINDOW_HEIGHT/10 ))
      {

         DIBWidth -= INITIAL_WINDOW_WIDTH/10;
         DIBHeight -= INITIAL_WINDOW_HEIGHT/10;
         WindowOffsetX += INITIAL_WINDOW_WIDTH/20;
         WindowOffsetY += INITIAL_WINDOW_HEIGHT/20;
      };
      UpdateDraw();
      smallerwindow = 1;
      };

   };
   if (keyBoard.plus) {
      if (largerwindow == 0) {
      DIBWidth += INITIAL_WINDOW_WIDTH/10;
      DIBHeight += INITIAL_WINDOW_HEIGHT/10;
      WindowOffsetX -= INITIAL_WINDOW_WIDTH/20;
      WindowOffsetY -= INITIAL_WINDOW_HEIGHT/20;
      if (DIBWidth > INITIAL_WINDOW_WIDTH) {
	 DIBWidth = INITIAL_WINDOW_WIDTH;
	 DIBHeight = INITIAL_WINDOW_HEIGHT;
	 WindowOffsetY = 0;
	 WindowOffsetX = 0;
      };
      if (DIBHeight > INITIAL_WINDOW_HEIGHT) {
	 DIBWidth = INITIAL_WINDOW_WIDTH;
	 DIBHeight = INITIAL_WINDOW_HEIGHT;
	 WindowOffsetY = 0;
	 WindowOffsetX = 0;
      };

      UpdateDraw();
      largerwindow = 1;
      };
   };

   if (keyBoard.home) {
      playerroll -= ROLL_SPEED * playerspeedscale;
      if (playerroll < 0)
	 playerroll += PI * 2;
   };
   if (keyBoard.end) {
      playerroll += ROLL_SPEED * playerspeedscale;
      if (playerroll >= (PI * 2))
	 playerroll -= PI * 2;
   };


   if (keyBoard.n2) {
      if (currentMode < lastMode) {
           currentMode++;
           cckSetMode(modeMenu[currentMode]);
           InitDraw();
      }
   };
   if (keyBoard.n1) {
      if (currentMode>0) {
           currentMode--;
           cckSetMode(modeMenu[currentMode]);
           InitDraw();
      }
   };
   if (keyBoard.n3) {
      if (RUN_LENGTHEXP < 5) {
         RUN_LENGTH = RUN_LENGTH << 1;
         RUN_LENGTHEXP += 1;
         sleep(1);
      }
   };
   if (keyBoard.n4) {
      if (RUN_LENGTHEXP>1) {
         RUN_LENGTH = (RUN_LENGTH >> 1);
         RUN_LENGTHEXP -= 1;
         sleep(1);
      }
   };


   if (keyBoard.f) {
      playerspeedscale *= 1.1;
   };
   if (keyBoard.z) {
      /* Set the initial location, direction, and speed  */
      InitDraw();
      InitPos();
   };

   if (keyBoard.s) {
      playerspeedscale *= 0.9;
   };
};

int
main(int argc, char *argv[])
{
int SVtextx,SVtexty,defcolor=0;
	char    buf[80];

     
   FACE           *faceList;
   OLDPOINT         center;
   OLDPOINT           oldPosition;
   point_t      savepos;
   center.xx = 0;
   center.yy = 0;
   center.zz = 0;
   semaphore1 = 1;
   semaphore2 = 2;

   if (argc < 2) {
      fprintf(stderr, "Usage: %s <datefile>\n", argv[0]);
      exit(1);
   }
   getScene(argv[1], &oldPosition, &faceList); /* get list of faces
								 * from file */
   printf("\nScene file loaded\n");
   ComputeMagic(center,faceList);
   
   printf("\nConstructing BSP tree\n");

   {
      /* create bsptree */

      root = BSPconstructTree(&faceList);       /* construct BSP tree */
      printf("\nBSP construction ready.\n");

      if ((VBEVersion = SV_init()) < 0x200) {
                printf("\nVESA VBE 2.0 not found, using VGA 320x200\n");
                ignoreVBE=true;
                 } else {
                printf("\nVESA VBE 2.0 found, using SVGA 320x200\n");
                ignoreVBE=false;

                 };

      printf("\nIn demo, use cursorkeys to move around, <escape> to quit,\n");
      printf("<c> to shoot a ball (maximum of 3 balls)\n");
      printf("<pageup/down> to look up/down, <home,end> to rotate view\n");
      printf("<+,-> to resize viewwindow, <d> to reverse gravity and\n");
      printf("<z> to restore original settings,<1,2> to change Videomode.\n");
      printf("<f,s> to change speed\n\n");
      printf("Please press any key to view demo.\n");
      getch();
         
        
      /* Draw all visible faces in all objects */


      playerposition.xx = currentpos.v[0];
      playerposition.yy = currentpos.v[2];
      playerposition.zz = currentpos.v[1];
      currentbspdepth = 0;

      /* draw faces in bsptree back-to-front order  */

       
      Initialize();             /* keyboard routine */
      cckVBE_INIT();
      if (ignoreVBE) {
      currentMode=0;
      } else {
      currentMode=1;
      }
      cckSetMode(modeMenu[currentMode]);

      InitDraw();
      InitPos();

      BSPtraverseTreeAndCalculateBoundingPlanes(root, &playerposition);
		ZTimerInit();
		LZTimerOn();

      while (!(keyBoard.escape)) {
	 CheckKeys();
	 UpdateViewPos();
	 SetUpFrustum();
	 ClearEdgeLists();
	 pavailsurf = surfs;
	 pavailedge = edges;

	 /* Draw all visible faces in all objects */
	 savepos = currentpos ;

	 
	 playerposition.xx = currentpos.v[0];
	 playerposition.yy = currentpos.v[2];
	 playerposition.zz = currentpos.v[1];
	 currentbspdepth = 0;

	 /* draw faces in bsptree back-to-front order  */

	 BSPtraverseTreeAndRender(root);        /* traverse and render it */

         UpdateObjectList();
         DrawObjectList();

	 ScanEdges();
         if (modeMenu[currentMode]==-1)
                {
                VGA_DrawSpans();
        _settextcolor(0);
        _settextposition(1,1);
        _outtext(buf);
        _settextposition(1,1);

        _settextcolor(255);
                  sprintf(buf,"VGA Mode 320 x 200. FPS:%3d.%d ",
                    fpsRate / 10, fpsRate % 10
                  );

        _outtext(buf);
        _settextcolor(0);
        _settextposition(1,1);
                   
                   
                  
                } else
                {
                VBE_DrawSpans();
                
                SVtextx = 1;
                SVtexty = 1;
                defcolor = 255;
                coockieGS = coockie_getLinearSelector(&coockieModeInfo);
                cckInitGS(); 
                SV_writeText(SVtextx,SVtexty,buf,0); 

                  sprintf(buf,"VESA 2.0 Mode %d x %d. FPS:%3d.%d ",
                  coockieModeInfo.XResolution,
                  coockieModeInfo.YResolution,
                   fpsRate / 10, fpsRate % 10
                  );
                SV_writeText(SVtextx,SVtexty,buf,defcolor); 
                };
	 currentpos = savepos ;
         frames++;
                        if (frames == 9) {
                                frames=0;
                        	newCount = LZTimerLap();
                                fpsRate = (int) (1000000000L / (10*(newCount - lastCount)) );
				lastCount = newCount;
		}

      }

      BSPfreeTree(&root);       /* free it */
   }
		LZTimerOff();

   CleanUp();
   _setvideomode(3); /* always go back to VGA textmode 3 */
   printf("(c) Copyright 1997 E.J.Coumans.\n");
   printf("Please report bugs and comments to: coockie@stack.nl\n");
      if (currentMode!=0) {
      printf("SVGA VBE mode (%d,%d)",coockieModeInfo.XResolution,
                                     coockieModeInfo.YResolution  );
      } else {
      printf("VGA 320x200");
      };
   return (0);
}
