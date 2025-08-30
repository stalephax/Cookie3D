
#include <windows.h>
#include <GL/gl.h>
#include <GL/glu.h>
#include <GL/glut.h>


#include <stdio.h>
#include "bsp.h"		/* bsptree specific routines  */
#include "3d.h"
#include "cckfile.h"
#include "collide.h"
#include "object.h"
#include "move.h"
#define MAX_NUMTEXTURES 20

GLuint textureids[MAX_NUMTEXTURES];   /* deze moet bij de objectklasse */

int             lastMode = 0;    /* points to last mode in modeMenu */
int             INITIAL_DIB_WIDTH = 256;//256;//256;//320;	/* dimensions of cur.
						 /* screenmode */
int             INITIAL_DIB_HEIGHT = 256;//256;//256;//200;
int             INITIAL_WINDOW_WIDTH = 256;	/* dimensions of window */
int             INITIAL_WINDOW_HEIGHT = 256;
int             BYTES_PER_SCANLINE = 256;//256;//320;	/* obvious */
unsigned char  *screenbuffer;	/* pointer to screenmemory */
unsigned char  *VideoOffset;	/* pointer to start of screenmem */
unsigned char*	CopyVideoOffset;	/* pointer to start of screenmem */
int				bTeapot=0;

int             linenumber;
OLDPOINT           playerposition;
int             shooting = 0;

int gClientWidth = 700;
int gClientHeight = 700;

void
BSPtraverseTreeAndRender(const BSPNODE * bspNode)
{

   if (bspNode == NULL_BSPNODE)
      return;

   if (bspNode->kind == PARTITION_NODE) {
      if (BSPisViewerInPositiveSideOfPlane(&bspNode->node->sameDir->plane, &playerposition)) {

	 BSPtraverseTreeAndRender(bspNode->node->negativeSide);
	 drawFaceList(bspNode->node->sameDir);
	 drawFaceList(bspNode->node->oppDir);	/* back-face cull */
	 BSPtraverseTreeAndRender(bspNode->node->positiveSide);

      } else {

	 BSPtraverseTreeAndRender(bspNode->node->positiveSide);
	 drawFaceList(bspNode->node->oppDir);
	 drawFaceList(bspNode->node->sameDir);	/* back-face cull */
	 BSPtraverseTreeAndRender(bspNode->node->negativeSide);

      }
   } else
      assert(bspNode->kind == IN_NODE || bspNode->kind == OUT_NODE);
}				/* BSPtraverseTreeAndRender() */


#define POLYSIZE 170.0f

GLfloat xcurcoef[] = {0.00, 0.01 ,0.00, 0.0};
GLfloat ycurcoef[] = {0.01, 0.00 ,0.00, 0.0};

void RenderMenu(void)
{	// Orthogonale projectie maken...
	GLfloat topx, topy;
	unsigned char* copyloper;
	char* fuckCopyVideoOffset;
	int i,j;
	static float angle2=0;
	static float transie=-200;
	int counter=0;
	i=0;
	j=0;
	

	glClear(0);
	glPushMatrix();
	glLoadIdentity();

	gluLookAt(0,0,80,0,0,0,0,1,0);

	glBindTexture(GL_TEXTURE_2D, textureids[0]);
	
	

	
	
	
	

	
	topx=-gClientWidth/2.0+5.0f;
	topy= gClientHeight/2.0-5.0f;;
    	
	glBindTexture(GL_TEXTURE_2D, textureids[0]);
	//glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_REPEAT);
	//glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_REPEAT);
	//glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
	//glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
	
	
	copyloper = VideoOffset;
	memset(CopyVideoOffset,0x00,INITIAL_DIB_HEIGHT*INITIAL_DIB_WIDTH*4);
	 
	{
		//unsigned char* colorpointer;
		int rgbacolor;
		int colorindex;
		
		//colorpointer= globalpalette;
		fuckCopyVideoOffset= CopyVideoOffset;//+idx;
		for (j=0;j<INITIAL_DIB_HEIGHT;j++)
			
		{
			for (i=0;i<INITIAL_DIB_WIDTH;i++)
			{
				int idx;
				int idx2;
				
					idx = 4*(i+INITIAL_DIB_WIDTH*(INITIAL_DIB_HEIGHT-1-j));
					fuckCopyVideoOffset= CopyVideoOffset+idx;
					colorindex= *copyloper;		
					
					idx2 = colorindex*3;
					*fuckCopyVideoOffset = globalpalette[idx2];//(char) globalpalette[idx2];//0x00;
					fuckCopyVideoOffset++;
					//copyloper++;
					*fuckCopyVideoOffset = globalpalette[idx2+1];//*copyloper;//(char) globalpalette[idx2+1];//0x00;
					fuckCopyVideoOffset++;
					//copyloper++;
					*fuckCopyVideoOffset = globalpalette[idx2+2];//*copyloper;//(char) globalpalette[idx2+2];//0x00;
					fuckCopyVideoOffset++;
					//copyloper++;
					*fuckCopyVideoOffset = 0xff; //alpha
					fuckCopyVideoOffset++;
					copyloper++;
								
				
			

			}
		}

	}
	
	glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, INITIAL_DIB_WIDTH,INITIAL_DIB_HEIGHT, 0, GL_RGBA, GL_UNSIGNED_BYTE, CopyVideoOffset);//texturestart);//CopyVideoOffset);//textureimagemap.pp);
	
		
	
		glDisable(GL_TEXTURE_GEN_S);
		glDisable(GL_TEXTURE_GEN_T);
	
		glPushMatrix();
		
		if (transie < -34)
			transie+=2;
				
		glTranslatef(-topx-POLYSIZE/2,-topy+POLYSIZE/2,-transie);
				
		glRotatef(transie+10,1,0,0);
				
		glBegin(GL_POLYGON);
		glNormal3f(0.0f, 0.0f, 1.0f);

		
		glTexCoord2f(0.0f, 0.0f);
		glVertex3f(topx,        topy-POLYSIZE, 00.0f);
		glTexCoord2f(1.0f, 0.0f);
		glVertex3f(topx+POLYSIZE, topy-POLYSIZE, 00.0f);
		glTexCoord2f(1.0f, 1.0f);
		glVertex3f(topx+POLYSIZE, topy,        00.0f);
		glTexCoord2f(0.0f, 1.0f);
		glVertex3f(topx,        topy,       00.0f);
		glEnd();
		
		glPopMatrix();

		/*
	for (i=0;i<1000;i++)
	{
		float rotate = i*10;//10;//abs(cos(i)*(100));
		float angle = 180+sin(i)*(120);
		glPushMatrix();
		//glRotatef(angle2,1,0,0);
		
		glRotatef(angle2,0,0,1);
		glTranslatef(0,0,-1000-rotate);
		glRotatef(angle,1,1,1);
		
		
		
		

		glBegin(GL_POLYGON);
		glNormal3f(0.0f, 0.0f, 1.0f);

		
		glTexCoord2f(0.0f, 0.0f);
		glVertex3f(-POLYSIZE,        -POLYSIZE, 0.0f);
		glTexCoord2f(1.0f, 0.0f);
		glVertex3f(POLYSIZE, -POLYSIZE, 0.0f);
		glTexCoord2f(1.0f, 1.0f);
		glVertex3f(POLYSIZE, POLYSIZE,        0.0f);
		glTexCoord2f(0.0f, 1.0f);
		glVertex3f(-POLYSIZE,        POLYSIZE,        0.0f);
		glEnd();
		glPopMatrix();
    }
	*/
	//glEnable(GL_LIGHTING);

	
	 

	//glutSolidTorus(100,140,10,10);// GLdouble innerRadius, GLdouble outerRadius, GLint sides, GLint rings);
	
	glEnable(GL_TEXTURE_GEN_S);
	glEnable(GL_TEXTURE_GEN_T);
	
	glTexGeni(GL_S,GL_TEXTURE_GEN_MODE,GL_SPHERE_MAP);//GL_OBJECT_LINEAR);
	glTexGeni(GL_T,GL_TEXTURE_GEN_MODE,GL_SPHERE_MAP);//GL_OBJECT_LINEAR);

	glTexGenfv(GL_S,GL_OBJECT_PLANE,xcurcoef);
	glTexGenfv(GL_T,GL_OBJECT_PLANE,ycurcoef);
	

	//glutSolidCube(10);
	//glutSolidSphere(40,10,10);
	//

	glTranslatef(0,150,-300);
	glRotatef(angle2,0,1,0);
	glutSolidTorus(25,72,40,40);//SolidTeapot(380);

	if (bTeapot)
	{
		
		//glutSolidTeapot(40);
		
		
		
	}
		angle2++;
    //camera.UpdateCamera();
	glPopMatrix();	
}


void Display(void)
{ 
	int i;
	point_t         savepos;
	 

	
//	 CheckKeys();
	 UpdateViewPos();
	 SetUpFrustum();
	 ClearEdgeLists();
	 pavailsurf = surfs;
	 pavailedge = edges;

	 // Draw all visible faces in all objects 
	 savepos = currentpos;


	 playerposition.xx = currentpos.v[0];
	 playerposition.yy = currentpos.v[2];
	 playerposition.zz = currentpos.v[1];
	 currentbspdepth = 0;

	 // draw faces in bsptree back-to-front order  

	 BSPtraverseTreeAndRender(root);	// traverse and render it 

	 UpdateObjectList();
	 DrawObjectList();

	 ScanEdges();
	 
	 VGA_DrawSpans();


	glEnable(GL_DEPTH_TEST);
	glDepthMask(GL_TRUE);
	glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    // Teken eerst niet transparante objecten met "gewone" Z-buffer
	
	// Teken nu transparante objecten met z-buffer read only
	
	//glDepthMask(GL_FALSE);
	
	RenderMenu();
	
	currentpos = savepos;

	//glFlush();
	glutSwapBuffers();
}


void InitGLState(void)
{ 
	glClearColor(0.4f, 0.0f, 0.0f, 1.0f);
	
	glShadeModel(GL_FLAT);//GL_SMOOTH);

	//glEnable(GL_CULL_FACE);
	//glFrontFace(GL_CCW);
	//glCullFace(GL_BACK);

	//glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
	//glEnable(GL_BLEND);
	glEnable(GL_TEXTURE_2D);
}


void Animate(void) {
	
	
	glutPostRedisplay();
}

/*
void
CheckKeys()
{
   gravitationvec.v[0] = 0;
   gravitationvec.v[1] = -1;
   gravitationvec.v[2] = 0;

   if ((shooting > 0) && !(keyBoard.c)) {
      MakeNewObject(currentpos, NORMALRADIUS);
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
      // add object at players position 
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

	 if ((DIBWidth > INITIAL_WINDOW_WIDTH / 10) &&
	     (DIBHeight > INITIAL_WINDOW_HEIGHT / 10)) {

	    DIBWidth -= INITIAL_WINDOW_WIDTH / 10;
	    DIBHeight -= INITIAL_WINDOW_HEIGHT / 10;
	    WindowOffsetX += INITIAL_WINDOW_WIDTH / 20;
	    WindowOffsetY += INITIAL_WINDOW_HEIGHT / 20;
	 };
	 UpdateDraw();
	 smallerwindow = 1;
      };

   };
   if (keyBoard.plus) {
      if (largerwindow == 0) {
	 DIBWidth += INITIAL_WINDOW_WIDTH / 10;
	 DIBHeight += INITIAL_WINDOW_HEIGHT / 10;
	 WindowOffsetX -= INITIAL_WINDOW_WIDTH / 20;
	 WindowOffsetY -= INITIAL_WINDOW_HEIGHT / 20;
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
      if (currentMode > 0) {
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
      if (RUN_LENGTHEXP > 1) {
	 RUN_LENGTH = (RUN_LENGTH >> 1);
	 RUN_LENGTHEXP -= 1;
	 sleep(1);
      }
   };


   if (keyBoard.f) {
      playerspeedscale *= 1.1;
   };
   if (keyBoard.z) {
      // Set the initial location, direction, and speed  
      InitDraw();
      InitPos();
   };

   if (keyBoard.s) {
      playerspeedscale *= 0.9;
   };
};
*/
void KeyboardSpecialUpFunc(int key, int x, int y)
{
	switch(key)
	{ 
	case GLUT_KEY_UP:
	case GLUT_KEY_DOWN:
		playeraccel = 0;
		break;
	}
}

void KeyboardUp(int key, int x, int y)
{
	switch(key)
	{ 
	case ' ':
		{

		
		gravitationvec.v[1] = - abs(gravitationvec.v[1]);
		
		break;
		}
	case 't':
		{
			bTeapot = 0;
			break;
		}

	}
}

void Keyboard(int key, int x, int y)
{
	switch(key)
	{ 
	case ' ':
		{
			
			gravitationvec.v[1] = abs(gravitationvec.v[1]);
			

			break;
		}
	case 'c':
		{
		shooting=10;
		MakeNewObject(currentpos, NORMALRADIUS);
			break;
		}

		case 't':
		{
			bTeapot = 1;
			break;
		}
		
	}

}
void SpecialKeyboard(int key, int x, int y)
{

	
	switch(key)

	{ 
	
	case GLUT_KEY_HOME:
 InitDraw();
      InitPos();
		break;

	case GLUT_KEY_UP:
	//camera.rotx=fmod(camera.rotx-2.0,360.0); 
	//UpdateStuff();
	  playeraccel = MOVEMENT_ACCEL;
      if (playeraccel > (MAX_MOVEMENT_ACCEL))
	 playeraccel = (MAX_MOVEMENT_ACCEL);
	break;
    case GLUT_KEY_DOWN:
		//camera.rotx=fmod(camera.rotx+2.0,360.0);   
		//UpdateStuff();
		playeraccel = -MOVEMENT_ACCEL;
		if (playeraccel < -(MAX_MOVEMENT_ACCEL))
			playeraccel = -(MAX_MOVEMENT_ACCEL);
		break;
    case GLUT_KEY_LEFT:
		//camera.roty=fmod(camera.roty-2.0,360.0);   
		//UpdateStuff();
		  playeryawspeed -= YAW_SPEED * playerspeedscale;
      if (playeryawspeed < -(MAX_YAW_SPEED * playerspeedscale))
	 playeryawspeed = -(MAX_YAW_SPEED * playerspeedscale);
		break;
    case GLUT_KEY_RIGHT:
		//camera.roty=fmod(camera.roty+2.0,360.0);
		//UpdateStuff();
		      playeryawspeed += YAW_SPEED * playerspeedscale;
      if (playeryawspeed > (MAX_YAW_SPEED * playerspeedscale))
	 playeryawspeed = (MAX_YAW_SPEED * playerspeedscale);
		break;
    case GLUT_KEY_PAGE_UP:
		//camera.translation=camera.translation-1.0;
		//UpdateStuff();
		playerpitch -= PITCH_SPEED * playerspeedscale;
      if (playerpitch < 0)
	 playerpitch += PI * 2;

	
		break;
    case GLUT_KEY_PAGE_DOWN:
		//camera.translation=camera.translation+1.0;  
		//UpdateStuff();
		      playerpitch += PITCH_SPEED * playerspeedscale;
      if (playerpitch >= (PI * 2))
	 playerpitch -= PI * 2;


		break;
	}
	

	
}
		

void Reshape(int w,int h)
{
	glViewport(0,0,(GLsizei)w,(GLsizei)h);

	glMatrixMode(GL_PROJECTION);
	glLoadIdentity();
	glFrustum(-1.0,1.0,-1.0,1.0,1.5,2020.0);
	glMatrixMode(GL_MODELVIEW);

}

int main(int argc, char *argv[])
{

	int             SVtextx, SVtexty, defcolor = 0;
   char            buf[80];
	unsigned char header[300];
	FILE* filep;
   FACE           *faceList;
   OLDPOINT           center;
   OLDPOINT           oldPosition;
   
   int i,j;
   center.xx = 0;
   center.yy = 0;
   center.zz = 0;
  
   if (argc < 2) {
      fprintf(stderr, "Usage: %s <datefile>\n", argv[0]);
      exit(1);
   }

   VideoOffset = malloc(INITIAL_DIB_WIDTH * INITIAL_DIB_HEIGHT);
   CopyVideoOffset = malloc(INITIAL_DIB_WIDTH * INITIAL_DIB_HEIGHT*4);

   getScene(argv[1], &oldPosition, &faceList);	/* get list of faces from
						 * file */
   printf("\nScene file loaded\n");
   ComputeMagic(center, faceList);

   printf("\nConstructing BSP tree\n");

      /* create bsptree */

      root = BSPconstructTree(&faceList);	/* construct BSP tree */
      printf("\nBSP construction ready.\n");

      if (true) //((VBEVersion = SV_init()) < 0x200) 
	  {
	 printf("\nVESA VBE 2.0 not found, using VGA 320x200\n");
	 //ignoreVBE = true;
      } else {
	 printf("\nVESA VBE 2.0 found, using SVGA 320x200\n");
	 //ignoreVBE = false;

      };

      printf("\nIn demo, use cursorkeys to move around, <escape> to quit,\n");
      printf("<c> to shoot a ball (maximum of 3 balls)\n");
      printf("<pageup/down> to look up/down, <home,end> to rotate view\n");
      printf("<+,-> to resize viewwindow, <d> to reverse gravity and\n");
      printf("<z> to restore original settings,<1,2> to change Videomode.\n");
      printf("<f,s> to change speed\n\n");
      printf("Please press any key to view demo.\n");
    //  getch();


      /* Draw all visible faces in all objects */

      playerposition.xx = currentpos.v[0];
      playerposition.yy = currentpos.v[2];
      playerposition.zz = currentpos.v[1];
      currentbspdepth = 0;

      /* draw faces in bsptree back-to-front order  */

      //Initialize();		/* keyboard routine */
      //cckVBE_INIT();
      /*
	  if (ignoreVBE) {
	 currentMode = 0;
      } else {
	 currentMode = 1;
      }
	  */
      //cckSetMode(modeMenu[currentMode]);

      InitDraw();
      InitPos();

      BSPtraverseTreeAndCalculateBoundingPlanes(root, &playerposition);
      //ZTimerInit();
      //LZTimerOn();





	glutInitDisplayMode(GLUT_DOUBLE | GLUT_RGBA | GLUT_DEPTH);
	glutInitWindowSize(gClientWidth, gClientHeight);
	glutInitWindowPosition(0, 0);
	glutCreateWindow("OldEng");
	glutIdleFunc(Animate);
	InitGLState();
	
	glPixelStorei(GL_UNPACK_ALIGNMENT, 1);
	
	

	glutDisplayFunc(Display);//Animate);
	//glutIdleFunc(Animate);
	glutReshapeFunc(Reshape);
	glutKeyboardFunc(Keyboard);
	glutKeyboardUpFunc(KeyboardUp);
	glutSpecialFunc(SpecialKeyboard);
	glutSpecialUpFunc(KeyboardSpecialUpFunc);
	//glutMotionFunc(Motion);
	//glutMouseFunc(Mouse);




	glPixelStorei(GL_UNPACK_ALIGNMENT, 1);
	glGenTextures(MAX_NUMTEXTURES, textureids);
	

	glBindTexture(GL_TEXTURE_2D, textureids[0]);
	
	glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_REPEAT);
	glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_REPEAT);
	glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
	glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
	
	glutMainLoop();


     BSPfreeTree(&root);	/* free it */

	 //LZTimerOff();

   //CleanUp();
   //_setvideomode(3);		/* always go back to VGA textmode 3 */
   printf("(c) Copyright 1997 E.J.Coumans.\n");
   printf("Please report bugs and comments to: coockie@stack.nl\n");
   
	return 0;
}


