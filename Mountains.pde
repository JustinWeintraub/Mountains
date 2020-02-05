float r=0;
void setup(){
  fullScreen();
}

void draw(){ //calls all functions
  drawSky();
  drawClouds();
  drawSun();
  drawMountain(80);
  drawMountain(40);
  drawMountain(0);
   
}

void drawSky(){
  color blue = color(0,0,255);
  color orange = color(255,165,0);
  
  for(int y=0; y<=height; y++){ //draws sky, going from blue to orange
    color c= lerpColor(blue,orange,map(y,0,height,0,1));
    stroke(c);
    line(0,y,width,y);
  }
}
void drawClouds(){
  loadPixels();
  for (int y=0; y<height; y++){
  for(int x=0; x<width; x++){
    float n=noise(x/100.0,y/100.0); //clouds uses 2d perlin noise of x and y
    color c=lerpColor(color(200),color(pixels[y*width+x]),pow(n,map(y, 0, height/2, 2, .1)));
    pixels[y*width+x]=c; //lerp colors from cloud to background, power allows for less clouds as you go down

  }
  updatePixels();
  }
}
void drawMountain(int change){
  color snow=color(255,250,250);
  color brown = color(70,56,30);
  //noiseDetail(int(map(mouseX,0,width,0,8)));
  noiseDetail(4);
  for(int x=0; x<width; x++){
    float n=noise(r+change+x/300.0);
    int y=int(map(n,0,1,change, height-1))-change;
    stroke(0);
    line(x,y-10,x,y);
    if(int(random(0,1000))==7){ //code for drawing small people in the background, see if you can find them!
      line(x,y-10, x, y-13);
      fill(0);
      ellipse(x,y-15,3,3);
    }
    loadPixels();
    while(y<height){ //mountains go from snow to brown, individually change pixels going down
    pixels[x+y*width]=lerpColor(snow-change,brown,map(y, 0, height,0, 1));//can be used for shadow
    y+=1;
    }
    updatePixels();
  }
  
}
void drawSun(){
  color sun = #FDB813;
  for (int times=0; times<5; times++){ //draws 5 sun rays
  float angle=radians(random(10, 80)); //angle allows it to point bottom right
  loadPixels();
  for(int distance=120; distance>100; distance-=2){
    int x= int(distance*cos(angle));
    int y=int(distance*sin(angle)); //rays lerpcolor from sun to background
    color c= lerpColor(sun, color(pixels[y*width+x]),map(distance, 100, 120,0, 1));
    noFill();
    stroke(c, 100);
    strokeWeight(4);
    line(0,0,x-20,y-20);
  }
  }
  stroke(sun);
  fill(sun);
  strokeWeight(1);
  ellipse(0,0,100,100); //draws sun
}
void mousePressed(){ //randomly resets screen every time
  r=random(0,1000);
  setup();
}
