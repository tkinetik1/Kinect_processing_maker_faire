import SimpleOpenNI.*;
SimpleOpenNI kinect;

int closestValue;
int closestX;
int closestY;

float lastX;
float lastY;
Float a = 0.0;

int counter = 0;
PFont f;

int[] arrxp = {820,72,-80,680,880,120,-1320,1240,-660,860,510};
int[] arryp = {10,-270,475,60,-80,44,243,40,-60,800,-100};
float[] arrxs = {100.0,-400.0,878.0,-1267.0,1550.0,-445.0,800.0,-120.0,1040.0,-4.0,10.0};
float[] arrys = {-100.0,420.0,-80.0,132.0,-112.0,400.0,-80.0,124.0,-100.0,400.0,-1000.0};
int[] poll;


void setup()
{
  background(255); 
  size(640, 480);
  kinect = new SimpleOpenNI(this);
  kinect.enableDepth();
  frameRate(30);  
  counter = 0;
}

void draw()
{
  closestValue = 8000;
  
  kinect.update();

  int[] depthValues = kinect.depthMap();
  
    for(int y = 0; y < 480; y++){
      for(int x = 0; x < 640; x++){
        
        // reverse x by moving in from
        // the right side of the image 
        int reversedX = 640-x-1;
        
        // use reversedX to calculate
        // the array index
        int i = reversedX + y * 640;
        int currentDepthValue = depthValues[i];
      
        // only look for the closestValue within a range
        // 610 (or 2 feet) is the minimum
        // 1525 (or 5 feet) is the maximum
        if(currentDepthValue > 610 && currentDepthValue < 1525 && currentDepthValue < closestValue){
            
          closestValue = currentDepthValue;
          closestX = x;
          closestY = y;
        }
      }
    }

   // "linear interpolation", i.e.
   // smooth transition between last point
   // and new closest point
   float interpolatedX = lerp(lastX, closestX, 0.1f);   
   float interpolatedY = lerp(lastY, closestY, 0.1f);
   float rand = random(0,255);
   float rand1 = random(0,255);
   float rand2 = random(0,255);
   float rand4 = random(20,40);
   stroke(rand4,rand4,rand4,20);
   //background(0);
   
   // make a thicker line, which looks nicer
   
   
   strokeWeight(3);
   noFill();        
   line(lastX*10, lastY*10, interpolatedX*2, interpolatedY*2);
   line(lastX*20, lastY, interpolatedX, interpolatedY*20);
  line(lastX, lastY, interpolatedX*interpolatedX, interpolatedY*interpolatedY);
 
   
   for ( int i = 0; i < 10; i++) {
  line(lastX, lastY, 450, 750+tan(a)*40);
      if( counter > 1000) {
 int counter = 0;
   rand1 = random(0,255);
     // fill(25, rand1, rand1,05);
    stroke(rand1,rand2,rand4,50);
   noFill();
   //rect(arrys[i]*5,arrxs[i]*5,rand1*2,rand*2);
   //fill(rand1,rand1,rand1); 
    
        line(i/arrxs[i]+lastX,i/arrys[i],i+arrys[i]*40,interpolatedY-arrxs[i]);
          line(i+arrxs[i],i*arrys[i]+lastY+i,i+arrys[i]*interpolatedX,interpolatedY*i);
          stroke(rand1,rand1,rand4,50);
            line(i*arrxs[i]+lastX,i*arrys[i]*4,i+arrys[i]*20,interpolatedY-arrxs[i]);
              line(i*arrxs[i]+lastX*4,i*arrys[i]-interpolatedY,i+arrys[i]*10*lastY,interpolatedY-arrxs[i]);
     
       //fill(rand4,rand1,rand4); 
       line(lastX* i , lastY * i ,interpolatedX * i, interpolatedY * i);
  }
//float rand = random(0, 255);
//float rand1 = random(0, 255);
//float rand2 = random(0, 255);   


    stroke(rand2,rand2,rand4,50);
   // fill(rand2,rand,rand1);
  
    line(arrxp[i],rand1+arryp[i],rand-arrxs[i],rand2-arrys[i]);
   
    strokeWeight(1.8);
 
    
    //line(arryp[i],arrxp[i],rand*i,rand2*i);
     
 arrxp[i] -= arrxs[i];
 arryp[i] += arrys[i];
  
   arrxs[i] = 4 - random(3)-1;
  arrys[i] = 4 - random(3)-1; 
  

  
     lastX = interpolatedX;
   lastY = interpolatedY;
   

  
  
  
  
  counter++;
  
  if (arrxp[i] > width) {
    arrxp[i] = 0; 
  }
  
  if (arrxp[i] < 0 ) {
    arrxp[i] = width;
  }
  if (arryp[i] > height) {
    arryp[i] = 0; 
  }
  if (arryp[i] < 0 ) {
    arryp[i] = height;  
  }
  }
}
