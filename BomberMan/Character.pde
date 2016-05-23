class Character implements Drawable{
  int x,y,dx,dy,health,speed,timer;
  int status;//0 = normal, 1 = damaged
  color iro;
  boolean slidingX,slidingY;
  int radius; 
  
  Character(int x,int y,int dx,int dy){
    this.x=x;
    this.y=y;
    this.dx=dx;
    this.dy=dy;
    status = 0;
    speed = 2;
    health = 3;
    radius = 1;
    slidingX = false;
    slidingY = false;
  }
  int getRad(){
    return radius;
  }
  void useItem(int itemType){
   if(itemType == 0){
     speed+=.5;
     System.out.println("Used speed skates");
    }
   else{ //itemType == 1
     System.out.println("going to use firePowUp");
     radius++;
   }  
  }
  void draw(){
   if(status ==1 && millis() - timer >= 1500){
      status = 0;
    }
   fill(0,200,200);
   if(status ==0 || (int)(millis() - timer)/250%2==0){
     rect(x,y,40,40);
   }
}

  boolean leftRightClear(){
    if(dx<0){
     if(x-21<0 || getTile(x-21,y).getState() == 2){
       return false;
     }
    }else{
      if(x+21>width || getTile(x+21,y).getState() == 2){
       return false;
     }
    }
  return true;  
  }
  
  boolean upDownClear(){
   if(dy<0){
     if(y-21<0 || getTile(x,y-21).getState() == 2){
       return false;
     }
    }else{
      if(y+21>height || getTile(x,y+21).getState() == 2){
       return false;
     }
    }
    return true;
  }
  
  void takeDamage(){
    //System.out.println("HURT");
    health--;
    status = 1;
    timer = millis();
  }
}