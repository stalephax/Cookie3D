
//#include "pcx.h"                /* pcx pictures loader  */
#include "global.h"             /* specific to this program */
#include "bsp.h"                /* bsptree specific routines  */
#include "keyboard.h"           /* keyboard handler           */
#include "3d.h"
#include "3dmath.h"
#include "collide.h"
//#include <graph.h>
#include "object.h"
#define COLLISION_RECURSE 5  /* how many recursion in collision after each collide */
#define MAX_GRAVITATIONSPEED 20.0

point_t         gravitationvec = {0, -1,0};//-1, 0};
   PLANE           zeronormal = {0,0,0,0};
   PLANE           plane1normal,plane2normal,thisnormal;
   int             hit1,hit2;

char            texbuf[80];
float           movedelta = 0.99995;
float           smallvalue = 0.001; //was 0.01
float           bitsmallvalue = 0.1;
float           zerodist = 0.01;
float           zerodist2 = 0.0;
float           margin  = 1.0;
float           gravitationspeed;
float           gravitationaccel;
float           playeraccel;
float
NewNormalizeVector(float ii, float jj, float kk,
		   float *ii2, float *jj2, float *kk2)
{
   float           magnitude, dfactor;
   magnitude = ((float) ii * ii + (float) jj * jj + (float) kk * kk);
   if (magnitude > smallvalue) {
      magnitude = sqrt(magnitude);

      dfactor = 1.0 / (magnitude);

      *ii2 = (float) (ii * dfactor);
      *jj2 = (float) (jj * dfactor);
      *kk2 = (float) (kk * dfactor);

      return (magnitude);
   } else {
      *ii2 = 0;
      *jj2 = 0;
      *kk2 = 0;
      magnitude = 0;
      return (magnitude);
   };
   /* normalizeVector() */
};
float
CheckDistance(int lasthit, point_t * curpos, point_t * motvec, float speed)
{

   OLDPOINT           colpos, coldir;
   float           motdir;
   float           dist;

   GlobalLastHit = lasthit;
   GlobalDistance = 0;
   GlobalDistance = 1/GlobalDistance;
   
   colpos.xx = curpos->v[0];
   colpos.yy = curpos->v[2];
   colpos.zz = curpos->v[1];
   if (speed >= 0) {
      /* move forewards */
      motdir = 1;
      dist = speed;
      coldir.xx = motvec->v[0];
      coldir.yy = motvec->v[2];
      coldir.zz = motvec->v[1];
   } else {
      /* move backwards */
      dist = -speed;
      motdir = -1;
      coldir.xx = -motvec->v[0];
      coldir.yy = -motvec->v[2];
      coldir.zz = -motvec->v[1];
   };
   stuck = FALSE;
   BSPtraverseTreeAndFindNearestPolygon(root, &colpos, &coldir);

   if (stuck) {
      GlobalDistance = 0;
//      return (GlobalDistance);
   };
//   assert(GlobalDistance >= 0.0);
   if (GlobalDistance < 0.0)
      GlobalDistance = 0.0;

   /* intersection found */

   return (motdir * (GlobalDistance - margin));
};

void
UpdateViewPos()
{
   float           kkk, distance,distance2, tmpdistance, displaydistance;
   float           tmpdistance2;
   int             thislasthit;
   int             recurse;

   int             i;
   float           motiondir;
   point_t         motionvec;
   point_t         viewmotionvec,newmotionvec, displayvec;

   point_t         nextpos;
   OLDPOINT           tmppoint1, tmppoint2, tmppoint3;

   float           scale;
   float           s, c, mtemp1[3][3], mtemp2[3][3];

   yaw = playeryaw;
   roll = playerroll;
   currentpos = playercurrentpos;
   pitch = playerpitch;
   yawspeed = playeryawspeed;
   speedscale = playerspeedscale;
   yaw = yaw + YAW_SPEED * yawspeed;


   if (yaw < 0)
      yaw += PI * 2;
   if (yaw >= (PI * 2))
      yaw -= PI * 2;

   /*
    * Set up the world-to-view rotation. Note: much of the work done in
    * concatenating these matrices can be factored out, since it contributes
    * nothing to the final result; multiply the three matrices together on
    * paper to generate a minimum equation for each of the 9 final elements
    */

   s = sin(roll);
   c = cos(roll);
   mroll[0][0] = c;
   mroll[0][1] = s;
   mroll[1][0] = -s;
   mroll[1][1] = c;
   s = sin(pitch);
   c = cos(pitch);
   mpitch[1][1] = c;
   mpitch[1][2] = s;
   mpitch[2][1] = -s;
   mpitch[2][2] = c;

   s = sin(yaw);
   c = cos(yaw);
   myaw[0][0] = c;
   myaw[0][2] = -s;
   myaw[2][0] = s;
   myaw[2][2] = c;

   MConcat(mroll, myaw, mtemp1);
   MConcat(mpitch, mtemp1, mtemp2);

   /*
    * Break out the rotation matrix into vright, vup, and vpn. We could work
    * directly with the matrix; breaking it out into three vectors is just to
    * make things clearer
    */
   for (i = 0; i < 3; i++) {
      vright.v[i] = mtemp2[0][i];
      vup.v[i] = mtemp2[1][i];
      vpn.v[i] = mtemp2[2][i];
   }

   /*
    * Simulate crude friction
    */  
   if (currentspeed >= (MOVEMENT_SPEED * speedscale / 2))
      currentspeed += (playeraccel -0.5) * MOVEMENT_SPEED * speedscale;
   else if (currentspeed <= -(MOVEMENT_SPEED * speedscale / 2))
      currentspeed += (playeraccel +0.5) * MOVEMENT_SPEED * speedscale;
   else
      currentspeed = playeraccel * MOVEMENT_SPEED * speedscale;

   if (currentspeed > MAX_MOVEMENT_SPEED * speedscale) {
      currentspeed = MAX_MOVEMENT_SPEED * speedscale;
   };
   if (currentspeed < -MAX_MOVEMENT_SPEED * speedscale) {
      currentspeed = -MAX_MOVEMENT_SPEED * speedscale;
   };

   if (yawspeed > (YAW_SPEED * speedscale / 1.2))
      yawspeed -= (YAW_SPEED) * speedscale / 1.2;
   else if (yawspeed < (-YAW_SPEED * speedscale / 1.2))
      yawspeed += YAW_SPEED * speedscale / 1.2;
   else
      yawspeed = 0.0;

   playerspeedscale = speedscale;

   /*
    * Move in the view direction, across the x-y plane, as if walking. This
    * approach moves slower when looking up or down at more of an angle
    */
   motionvec.v[0] = DotProduct(&vpn, &xaxis);
   motionvec.v[1] = 0;//smallvalue;
   motionvec.v[2] = DotProduct(&vpn, &zaxis);

  // motionvec = vpn;


   /* collision detection handling */


   /* add gravitation */

   gravitationspeed += gravitationaccel;
   if (gravitationspeed > MAX_GRAVITATIONSPEED) {
      gravitationspeed = MAX_GRAVITATIONSPEED;
   };

   distance = gravitationspeed;
   distance2 = currentspeed;
   newmotionvec = gravitationvec;
   viewmotionvec = motionvec;
   thislasthit = -1;
   PlayerRadius = NORMALRADIUS;
   tmpdistance = CheckDistance(thislasthit, &currentpos, &newmotionvec, distance);
   if (tmpdistance >= (zerodist)) {       /* add full gravitation */

   } else {                     /* cut gravitation */
      tmppoint1.xx = newmotionvec.v[0];
      tmppoint1.yy = newmotionvec.v[1];
      tmppoint1.zz = newmotionvec.v[2];
      tmppoint2.xx = GlobalHitPlaneNormal.aa;
      tmppoint2.yy = GlobalHitPlaneNormal.cc;
      tmppoint2.zz = GlobalHitPlaneNormal.bb;

      scale = (DotvProduct(&tmppoint1, &tmppoint2));
	 if (fabs(scale) < movedelta) 
	 {
	  //  distance *= (1 - (scale));
	    tmppoint3 = pointscalar(&tmppoint2, (-scale));
	    tmppoint2 = pointadd(&tmppoint1, &tmppoint3);
	    kkk = NewNormalizeVector(tmppoint2.xx, tmppoint2.yy, tmppoint2.zz,
		&newmotionvec.v[0], &newmotionvec.v[1], &newmotionvec.v[2]);
	    distance *= kkk;

	 } 
	 else {
	    distance = 0;
	   gravitationspeed = 0;
	 };
      /*  viewer must look parallel to ground ??? */
   
      tmppoint1.xx = motionvec.v[0];
      tmppoint1.yy = motionvec.v[1];
      tmppoint1.zz = motionvec.v[2];
      tmppoint2.xx = GlobalHitPlaneNormal.aa;
      tmppoint2.yy = GlobalHitPlaneNormal.cc;
      tmppoint2.zz = GlobalHitPlaneNormal.bb;

      scale = DotvProduct(&tmppoint1, &tmppoint2);
	 if (fabs(scale) < movedelta) 
	 {
	    distance2 *= (1 - (scale));
	    tmppoint3 = pointscalar(&tmppoint2, (-scale));
	    tmppoint2 = pointadd(&tmppoint1, &tmppoint3);
	    kkk = NewNormalizeVector(tmppoint2.xx, tmppoint2.yy, tmppoint2.zz,
		&viewmotionvec.v[0], &viewmotionvec.v[1], &viewmotionvec.v[2]);
	    distance2 *= kkk;

	 } 
	 else {
	    distance2 = 0;
	 };
      
      
   };
   //if (gravitationspeed < 0) {
   //   printf("grav. < 0");
   //   exit(-1);
//   };
   if (gravitationspeed > MAX_GRAVITATIONSPEED) {
      gravitationspeed = MAX_GRAVITATIONSPEED;
   };
   if (gravitationspeed < 0) {
      gravitationspeed = 0;
   };

//   currentspeed = distance2;

   tmppoint1.xx = newmotionvec.v[0] * distance;
   tmppoint1.yy = newmotionvec.v[1] * distance;
   tmppoint1.zz = newmotionvec.v[2] * distance;
   tmppoint2.xx = viewmotionvec.v[0] * distance2;
   tmppoint2.yy = viewmotionvec.v[1] * distance2;
   tmppoint2.zz = viewmotionvec.v[2] * distance2;
   tmppoint3 = pointadd(&tmppoint1, &tmppoint2);

   distance = NewNormalizeVector(tmppoint3.xx, tmppoint3.yy, tmppoint3.zz,
		&newmotionvec.v[0], &newmotionvec.v[1], &newmotionvec.v[2]);

   displayvec = newmotionvec;
   
   if (distance < 0) {
      motiondir = -1;
      distance = -distance;
      newmotionvec.v[0] *=-1;
      newmotionvec.v[1] *=-1;
      newmotionvec.v[2] *=-1;
   } else {
      motiondir = 1;
   };
   displaydistance = 0;
   displaydistance = 1/displaydistance;

   thislasthit = -1;
   recurse = 0;
     //while!
   while ((recurse < COLLISION_RECURSE) && (fabs(distance) > smallvalue)) {   /* while for strafe */

      GlobalHitPlaneNormal = zeronormal;
      tempGlobalLastHit = -1;
      GlobalLastHit = -1;
      PlayerRadius = NORMALRADIUS;
      tmpdistance = CheckDistance(thislasthit, &currentpos, &newmotionvec, distance);
      hit1 = GlobalLastHit;
      plane1normal = GlobalHitPlaneNormal;

      GlobalHitPlaneNormal = zeronormal;
      tempGlobalLastHit = -1;
      GlobalLastHit = -1;
      PlayerRadius = SMALLRADIUS;
      tmpdistance2 = CheckDistance(thislasthit, &currentpos, &newmotionvec, distance);
      hit2 = GlobalLastHit;
      plane2normal = GlobalHitPlaneNormal;

      if (tmpdistance2 < displaydistance) displaydistance = tmpdistance2;


      if  (hit1 != hit2)    {

                if (tmpdistance2 <= (tmpdistance + smallvalue)) {
                        /* please don't move */
                        if (tmpdistance2 < 4)
                                tmpdistance = 0.0;
                        thisnormal = plane2normal;
                } else {
                        if (tmpdistance2 < 4)
                                tmpdistance = 0.0;
                        thisnormal = plane1normal;
                };

      } else {
        thisnormal = plane1normal;
      };

     // if (thisnormal.aa == 0 && thisnormal.bb == 0 && thisnormal.cc == 0)
     //     recurse = COLLISION_RECURSE;

      if ((tmpdistance >= zerodist) && ((distance) <= (tmpdistance))) { /* was fabs() 2keer */
	 /* move in desired way, and set distance to 0 */
         if (tmpdistance >= zerodist) {  
	 for (i = 0; i < 3; i++) {
	    nextpos.v[i] = currentpos.v[i] + newmotionvec.v[i] * (distance);
	    if (nextpos.v[i] > MAX_COORD)
	       nextpos.v[i] = MAX_COORD;
	    if (nextpos.v[i] < -MAX_COORD)
	       nextpos.v[i] = -MAX_COORD;
	 }
	 currentpos = nextpos;
	 };
	 distance = 0;
	
      } else {
	  if (tmpdistance > zerodist)  
	 {
	    for (i = 0; i < 3; i++) {
	       nextpos.v[i] = currentpos.v[i]
		  + newmotionvec.v[i] * (tmpdistance);
	       if (nextpos.v[i] > MAX_COORD)
		  nextpos.v[i] = MAX_COORD;
	       if (nextpos.v[i] < -MAX_COORD)
		  nextpos.v[i] = -MAX_COORD;
	    }
	    currentpos = nextpos;
	    
	    distance -= tmpdistance;

	    if (distance * motiondir < 0) {
	       distance = 0;
	    };
	 };
	 thislasthit = GlobalLastHit;
	 tmppoint1.xx = newmotionvec.v[0];
	 tmppoint1.yy = newmotionvec.v[1];
	 tmppoint1.zz = newmotionvec.v[2];
         tmppoint2.xx = thisnormal.aa;
         tmppoint2.yy = thisnormal.cc;
         tmppoint2.zz = thisnormal.bb;

         scale = (DotvProduct(&tmppoint1, &tmppoint2));
         if (fabs(scale) < movedelta) 
	 {
            distance *= (1 - scale);  //fabs??
	    tmppoint3 = pointscalar(&tmppoint2, (-scale));
	    tmppoint2 = pointadd(&tmppoint1, &tmppoint3);
	    kkk = NewNormalizeVector(tmppoint2.xx, tmppoint2.yy, tmppoint2.zz,
		&newmotionvec.v[0], &newmotionvec.v[1], &newmotionvec.v[2]);
	    distance *= kkk;

	 } 
         else {
            distance = 0;
         };
     };

      recurse++;
   };
    /*
   if (DIBHeight <= 180)
     {
   _settextcolor(4);
   _settextposition(25, 0);
   _outtext("                                       ");
   _settextposition(25, 0);
   sprintf(texbuf, "y:%f r:%f p:%f) ",
            yaw,
            roll,
            pitch
      );
   
   _outtext(texbuf);
   _settextposition(1, 0);
   _settextcolor(11*16);
   _outtext("c3d engine version 24.01.1997am");
   
   };
    
     
     if (DIBHeight <= 160)
     {
   _settextposition(24, 0);
   _settextcolor(4);
   _outtext("                                      ");
   _settextposition(24, 0);
   sprintf(texbuf, "walldist.:%f ballspeed:%i",
	    displaydistance,
	shooting
      );
   
   _outtext(texbuf);
   _settextposition(2, 0);
   _settextcolor(4);
   _outtext("Resize window: + / - (on keypad)");
};
   
   if (DIBHeight <= 140)
     {
   _settextposition(3, 0);
   _settextcolor(4);
   _outtext("Move : arrowkeys       Shoot ball : c");
};
   
if (DIBHeight <= 120)
     {
   
   _settextposition(4, 0);
   _settextcolor(4);
   _outtext("Startposition : z      Quit : <esc>");
};
if (DIBHeight <= 100)
     {
  _settextposition(5, 0);
   _settextcolor(4);
   _outtext("Turn head : pgup/dn    Rotate : home/end");
};
if (DIBHeight <= 80)
     {
  _settextposition(6, 0);
   _settextcolor(4);
   _outtext("Reverse Gravity : d    SpeedAdjust: f/s ");
};
if (DIBHeight <= 60)
     {
  _settextposition(7, 0);
   _settextcolor(4);
   _outtext("Texture quality : 1 2  coockie@stack.nl");
};
if (DIBHeight <= 20)
     {
  _settextposition(9, 0);
   _settextcolor(11*16);
   _outtext("Even a 486 can run with THIS windowsize");
};
      */
 
   playeryawspeed = yawspeed;
   playeryaw = yaw;
   playerroll = roll;
   playercurrentpos = currentpos;
   playerpitch = pitch;

}
/**************************************************************/
/* move spheres! */
/**************************************************************/

void MoveObject(int objectnumber) {

//int motiondir;
int thislasthit,recurse,i;
float scale,distance,tmpdistance,tmpdistance2;
float kkk;
int objgravitation = 1.772453851;
//point_t newgravitationvec;
//float newobjgravitation;
point_t newmotionvec;
point_t nextpos,objcurrentpos;
OLDPOINT           tmppoint1, tmppoint2, tmppoint3,tmppoint4;
   thislasthit = -1;
   recurse = 0;
/*
ObjectList[objectnumber].centerpoint;
ObjectList[objectnumber].movingdir;
ObjectList[objectnumber].movingspeed;
*/
////////////////
////////////////
objcurrentpos.v[0] = ObjectList[objectnumber].centerpoint.xx;
objcurrentpos.v[1] = ObjectList[objectnumber].centerpoint.zz; /* swap x and y */
objcurrentpos.v[2] = ObjectList[objectnumber].centerpoint.yy;
newmotionvec.v[0] = ObjectList[objectnumber].movingdir.xx;
newmotionvec.v[1] = ObjectList[objectnumber].movingdir.zz; /* swap xy */
newmotionvec.v[2] = ObjectList[objectnumber].movingdir.yy;

distance = ObjectList[objectnumber].movingspeed;

tmppoint1.xx = newmotionvec.v[0] * distance ;
tmppoint1.yy = newmotionvec.v[1] * distance;
tmppoint1.zz = newmotionvec.v[2] * distance;
tmppoint2.xx = gravitationvec.v[0] * objgravitation;
tmppoint2.yy = gravitationvec.v[1] * objgravitation;
tmppoint2.zz = gravitationvec.v[2] * objgravitation;
tmppoint3 = pointadd(&tmppoint1, &tmppoint2);
   
   distance = NewNormalizeVector(tmppoint3.xx, tmppoint3.yy, tmppoint3.zz,
		&newmotionvec.v[0], &newmotionvec.v[1], &newmotionvec.v[2]);

if (distance == 0) {
/* nothing happend :) */
} else
    
    {

   if ((recurse < COLLISION_RECURSE) && (fabs(distance) > smallvalue)) {   /* while for strafe */

      GlobalHitPlaneNormal = zeronormal;
      tempGlobalLastHit = -1;
      GlobalLastHit = -1;
      PlayerRadius = ONORMALRADIUS;
      tmpdistance = CheckDistance(thislasthit, &objcurrentpos, &newmotionvec, distance);
      hit1 = GlobalLastHit;
      plane1normal = GlobalHitPlaneNormal;

      GlobalHitPlaneNormal = zeronormal;
      tempGlobalLastHit = -1;
      GlobalLastHit = -1;
      PlayerRadius = OSMALLRADIUS;
      tmpdistance2 = CheckDistance(thislasthit, &objcurrentpos, &newmotionvec, distance);
      hit2 = GlobalLastHit;
      plane2normal = GlobalHitPlaneNormal;

      if  (hit1 != hit2)    {

                if (tmpdistance2 <= (tmpdistance + smallvalue)) {
                        /* please don't move */
                        if (tmpdistance2 < 4)
                                tmpdistance = 0.0;
                        thisnormal = plane2normal;
                } else {
                        if (tmpdistance2 < 4)
                                tmpdistance = 0.0;
                        thisnormal = plane1normal;
                };

      } else {
        thisnormal = plane1normal;
      };


      if ((tmpdistance > zerodist) && ((distance) <= (tmpdistance))) { /* was fabs() 2keer */
	 /* move in desired way, and set distance to 0 */
         if (tmpdistance >= zerodist) {  
	 for (i = 0; i < 3; i++) {
            nextpos.v[i] = objcurrentpos.v[i] + newmotionvec.v[i] * (distance);
	    if (nextpos.v[i] > MAX_COORD)
	       nextpos.v[i] = MAX_COORD;
	    if (nextpos.v[i] < -MAX_COORD)
	       nextpos.v[i] = -MAX_COORD;
	 }
         objcurrentpos = nextpos;
	 };
	ObjectList[objectnumber].movingspeed = distance ;
	distance = 0;
	
      } else {
	  if (tmpdistance > zerodist)  
	 {
        //    for (i = 0; i < 3; i++) {
         //      nextpos.v[i] = objcurrentpos.v[i]
          //        + newmotionvec.v[i] * (tmpdistance);
           //    if (nextpos.v[i] > MAX_COORD)
            //      nextpos.v[i] = MAX_COORD;
             //  if (nextpos.v[i] < -MAX_COORD)
              //    nextpos.v[i] = -MAX_COORD;
         //   }
         //   objcurrentpos = nextpos;
         //   
          //  distance -= tmpdistance;

            //if (distance * motiondir < 0) {
            if (distance  < 0) {
	       distance = 0;
	    };
	 };
	 thislasthit = GlobalLastHit;
	 tmppoint1.xx = newmotionvec.v[0];
	 tmppoint1.yy = newmotionvec.v[1];
	 tmppoint1.zz = newmotionvec.v[2];
         tmppoint2.xx = thisnormal.aa;
         tmppoint2.yy = thisnormal.cc;
         tmppoint2.zz = thisnormal.bb;

         scale = (DotvProduct(&tmppoint1, &tmppoint2));
         if (fabs(scale) < movedelta) 

	 {
	    tmppoint3 = pointscalar(&tmppoint2, (-scale));
	    tmppoint4 = pointadd(&tmppoint1, &tmppoint3);
	    tmppoint2 = pointadd(&tmppoint4, &tmppoint3);
	    kkk = NewNormalizeVector(tmppoint2.xx, tmppoint2.yy, tmppoint2.zz,
		&newmotionvec.v[0], &newmotionvec.v[1], &newmotionvec.v[2]);
	ObjectList[objectnumber].movingspeed = distance * 0.95 ;

	 } 
         else {
	 newmotionvec.v[0] *= -1;
	 newmotionvec.v[1] *= -1;
	 newmotionvec.v[2] *= -1;
	ObjectList[objectnumber].movingspeed = distance *0.95;
         };
     };

      recurse++;
   };
};
ObjectList[objectnumber].centerpoint.xx = objcurrentpos.v[0] ;
ObjectList[objectnumber].centerpoint.zz = objcurrentpos.v[1] ;
ObjectList[objectnumber].centerpoint.yy = objcurrentpos.v[2] ;
ObjectList[objectnumber].movingdir.xx = newmotionvec.v[0] ;
ObjectList[objectnumber].movingdir.zz = newmotionvec.v[1] ; /* swap xy */
ObjectList[objectnumber].movingdir.yy = newmotionvec.v[2] ;

}
