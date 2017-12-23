
int num = 3;
//Current numbers in the screen
int[] nr = new int[num+2];
int max = 26;
int power = 0;
boolean powerd = true;
boolean clicking = false;

float vel = 0;
float off = 0;

void setup(){
  size(800,600);
  for(int i = 0;i<num+2;i++)
    nr[i]=rand();
}

void draw(){
  background(0);
  
  int s = height/3;
  
  for(int i = -1;i<num+1;i++){
    fill(50);
    rect(width/2-s*num/2+i*s-s*off/10f,height/3,s,s);
    fill(255);
    textAlign(CENTER,CENTER);
    textSize(s*0.75);
    text(nr[i+1],width/2-s*num/2+i*s+s/2-s*off/10f,height*5/11);
  }
  
  fill(0);
  rect(width/2+num*s/2,height/3,s,s);
  rect(width/2-s*num/2-s,height/3,s,s);
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
  if(mousePressed&&vel<=0.01){
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
    off-=10;
    for(int i = 0;i<num+1;i++){
      nr[i]=nr[i+1];
    }
    nr[num+1]=rand();
    
  }
  if(abs(off-2.5)<vel){
    vel-=0.01;
  }
  
}

void shoot(){
  if(vel<=0.01)
    vel+=power/100f+0.3;
}

int rand(){
  int i = int(random(0,max))+1;
  return i;
}