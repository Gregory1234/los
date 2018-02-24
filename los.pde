import processing.sound.*;


int num = 5;
//Current numbers in the screen
int[] nr = new int[num+2];
int max = 26;
int power = 0;
boolean powerd = true;
boolean clicking = false;

long time = 0;

float vel = 0;
float off = 0;

PImage[] imgs = new PImage[max];

WhiteNoise noise;
color mylerp(color c1,color c2,float a){
  float b=1-a;
  return color(a*red(c1)+b*red(c2),a*green(c1)+b*green(c2),a*blue(c1)+b*blue(c2));
}

void gradientRect(color c1, color c2) {
  fill(mylerp(c1,c2,0.5));
  rect(0, 10, width, 10);
  for (int l = 0; l < height; l++){
    color sc = mylerp(c1, c2, l*1f/width);
    noStroke();
    fill(sc);
    rect(0,l,width,1);
  }
}

PImage generateRay(color c){
  PImage ret = new PImage(width/10,1,ARGB);
  ret.loadPixels();
  for(int i = 0;i<ret.pixels.length;i++){
    ret.pixels[i]=color(red(c),green(c),blue(c),255-(20*abs(i-(width/20f))/(float)width)*255f);
  }
  ret.updatePixels();
  return ret;
}

PImage ray;

void setup(){
  size(800,600);
  surface.setResizable(true);
  for(int i = 0;i<num+2;i++)
    nr[i]=rand();
  for(int i = 0;i<max;i++)
    imgs[i]=loadImage("data/"+(i+1)+".png");
  for(int i = 0;i<max;i++)
    if(imgs[i]==null)
      imgs[i]=loadImage("data/"+21+".png");
  noise = new WhiteNoise(this);
  noise.play();
  textFont(createFont("Impact",100));
  ray = generateRay(0xff0000);
  ray.save("X:\\Users\\Greg\\Desktop\\sounds\\test.png");
}

boolean playingNoide = false;
float minnoisetime = 50;
void draw(){
  //background(0);
  gradientRect(0x0a1f42,0x232830);
  //background(0);
  //tykSound.play(1,5);
  
  println(50f/(vel+0.1));
  if(millis()-time>50f/(vel+0.1)&&50f/(vel+0.1)>minnoisetime){
    playingNoide=false;
    noise.stop();
  }
  int s = height/3;
  
  for(int i = -1;i<num+1;i++){
    fill(50);
    rect(width/2-s*num/2+i*s-s*off/10f+10*(i-num+2),height/5+s,s,s/5);
    fill(255);
    textAlign(CENTER,CENTER);
    image(imgs[nr[i+1]-1],width/2-s*num/2+i*s-s*off/10f+10*(i-num+2),height/5,s,s);
    
    
    textSize(s*0.2);
    text(nr[i+1],width/2-s*num/2+i*s+s/2-s*off/10f+10*(i-num+2),height*49/88);
  }
  int rayWidth=100;
  image(ray,width/2-width/rayWidth/2,0,width/rayWidth,height*5/6);
  //fill(0);
  //rect(width/2+num*s/2,0,s,height);
  //rect(width/2-s*num/2-s,0,s,height);
  fill(255);
  textSize(height/10);
  text("Moc",width/2,height*3/4);
  fill(50);
  rect(width/4,height*5/6,width/2,height/8);
  
  for(float i = 0;i<power;i+=200f/width){
    stroke(2.56*i,256-2.56*i,0);
    line(map(i,0,100,width/4,3*width/4),height*5/6,map(i,0,100,width/4,3*width/4),height*5/6+height/8);
  }
  stroke(0);
  if((mousePressed||(keyPressed&&key==' '))&&vel<=0.01){
     clicking=true;
     if(powerd){
       power+=2;
       if(power>=100)
         powerd=false;
     }else{
       power-=2;
       if(power<=0)
         powerd=true;
     }
  }else{
    if(clicking){
      shoot();
      clicking=false;
    }
    else{
      power=0;
    }
  }
  if(vel>0.01){
    off+=vel;
    vel-=0.001;
  }else{
    off/=1.1;
  }
  if(off>=5){
    vel*=0.999;
    off-=10;
    for(int i = 0;i<num+1;i++){
      nr[i]=nr[i+1];
    }
    nr[num+1]=rand();
    if(!playingNoide&&!(playingNoide&&50f/(vel+0.1)>minnoisetime)){
      playingNoide=true;
      noise.play(0.01);
    }
    time=millis();
  }
  if(abs(off-2.5)<vel){
    vel-=0.01;
  }
  
}

void shoot(){
  if(vel<=0.01)
    vel+=power/10f+0.3;
}

int rand(){
  int i = int(random(0,max))+1;
  return i;
}