import SimpleOpenNI.*;
SimpleOpenNI kinect;

int closestValue;
int closestX;
int closestY;

float lastX;
float lastY;

int counter = 0;


void setup()
{
  size(640, 480);
  kinect = new SimpleOpenNI(this);
  kinect.enableDepth();   
  
  // start out with a black background
  background(255); 
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
   float rand2 = random(550,850);
   float rand4 = random(20,40);
   stroke(7,30,30,100);
   //background(0);
   
   // make a thicker line, which looks nicer
   strokeWeight(4);
   noFill();        
   line(lastX, lastY, interpolatedX, interpolatedY);
      
   
   //ellipse(lastX, lastY, interpolatedX, interpolatedY);
   //rect(lastX, lastY, interpolatedX, interpolatedY);
   
   for(int i = 0; i<25; i++) 
   {
   
   stroke(rand,rand,rand1, 70);
   strokeWeight(2);

    
   rectMode(CENTER);
   rect(lastX, lastY, 35, 35);
   ellipse(lastX, lastY, rand4*i, rand4*i);
   line(lastX , lastY ,interpolatedX, interpolatedY);
   line(lastX, lastY, rand4*i, rand4*i);
   
   }
   
   lastX = interpolatedX;
   lastY = interpolatedY;
 
   counter++;
   if(counter > (rand2)) {
   
    counter = 0; 
   }
   
}

void keyPressed(){
    // save image to a file
    // then clear it on the screen
    save("drawing.png");
    background(255);
}
