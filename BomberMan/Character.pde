class Character implements Drawable{
  int x,y,dx,dy,health,speed,timer;
  int status;//0 = normal, 1 = damaged
  int iro,radius;
  int facing; //0=south 1=west 2=north 3=east
  char col;
  PImage sprite;
  
  Character(int x,int y,int dx,int dy,int iro,char col){
    this.x=x;
    this.y=y;
    this.dx=dx;
    this.dy=dy;
    this.iro = iro;
    this.col = col;
    status = 0;
    speed = 2;
    health = 3;
    radius = 1;
    facing = 0;
    sprite = loadImage("Rfront0.png");
  }
  int getRad(){
    return radius;
  }
  void useItem(int itemType){
   if(itemType == 0){
     speed+=1;
     System.out.println("Used speed skates");
    }
   else if(itemType == 1){
     System.out.println("going to use firePowUp");
     radius++;
   }  
  }
  void draw(){
   if(status ==1 && millis() - timer >= 1500){
      status = 0;
    }
   String dir;
   if(facing==0){
     dir = "front";
   }else if(facing==1){
     dir = "left"; 
   }else if(facing==2){
     dir = "back";
   }else{
    dir = "right"; 
   }
   if((int)(millis() - timer)/250%2==0 || (dy==0 && dx==0 && status ==0)){
     image(loadImage(col+dir+0+".png"),x,y-5);
   }else if(status!=1){
     image(loadImage(col+dir+1+".png"),x,y-5);
   }
}

  boolean leftRightClear(){
    if(dx<0){
     if(x-21<0 || getTile(x-21,y).getState() >= 2){
       return false;
     }
    }else{
      if(x+21>width || getTile(x+21,y).getState() >= 2){
       return false;
     }
    }
  return true;  
  }
  
  boolean upDownClear(){
   if(dy<0){
     if(y-21<0 || getTile(x,y-21).getState() >= 2){
       return false;
     }
    }else{
      if(y+21>height || getTile(x,y+21).getState() >= 2){
       return false;
     }
    }
    return true;
  }
  
  boolean takeDamage(){
    //System.out.println("HURT");
    health--;
    status = 1;
    timer = millis();
    if(health==0){
      toDraw.remove(this);
      chars.remove(this);
      return true;
    }
    return false;
  }
  
   void autoTurn(int direct){
    if(direct == 0 ||direct == 1){
      if(this.upDownClear() && Math.abs(x - getTile(x,y).x-20) <= 10){
        this.x = getTile(x,y).x+20;
      }else{
       dy = 0; 
      }
    }else if(direct == 2 ||direct == 3){
      if(this.leftRightClear() && Math.abs(y - getTile(x,y).y-20) <= 10){
        this.y = getTile(x,y).y+20;
      }else{
       dx = 0; 
      }
    }
  }
}