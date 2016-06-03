class Cross implements Drawable,Volatile{
  int x,y,size;
  float time;
  
  Cross(int x,int y,int size){
    this.x = x;
    this.y = y;
    this.size = size;
    time = millis();
  }
  int getRadius(){
    return size/2;
  }
  void setRadius(int newRad){
    size = newRad * 2 +1;
  }
  int getX(){
    return x;
  }
  int getY(){
    return y;
  }
  int upToHere(String dir){
    int rad = size/2;
    for(int inc = 2;inc<rad+1;inc++){
      if(dir.equals("right")){
        if(inGrid(x/40+inc,y/40)){
        if(grid[x/40+inc][y/40].getState() >= 2){
            return (inc-1)*2 + 1;
        }
        }
      }
      if(dir.equals("left")){
        if(inGrid(x/40-inc,y/40)){
        if(grid[x/40-inc][y/40].getState() >= 2){
            return (inc-1)*2 + 1;
        }
        }
      }
      if(dir.equals("up")){
        if(inGrid(x/40,y/40-inc)){
        if(grid[x/40][y/40-inc].getState() >= 2){
            return (inc-1)*2 + 1;
        }
        }
      }
      else{ //string is down
      if(inGrid(x/40,y/40+inc)){
        if(grid[x/40][y/40+inc].getState() >= 2){
          return (inc-1)*2+1;
        }
      } 
      }
    }
    return size;
  }
  
  void draw(){
    fill(30,200,230);
    rect(x,y-(upToHere("up")*10),10,(upToHere("up")*20));
    rect(x,y+(upToHere("down")*10),10,(upToHere("down")*20));
    rect(x-(upToHere("left")*10),y,(upToHere("left")*20),10);
    rect(x+(upToHere("right")*10),y,(upToHere("right")*20),10);
  }
  
  boolean countDown(){
   if(millis()-time>=750){
    return true; 
   }
   return false;
 }
 
 void explode(){
   toDraw.remove(this);
   explosives.remove(this);
 }
 
 boolean inBlast(int xcor,int ycor){
   return Math.abs(getTile(xcor,ycor).x+20 -x) <= size/2*40 && getTile(xcor,ycor).y+20 ==y ||
   Math.abs(getTile(xcor,ycor).y+20 -y) <= size/2*40 && getTile(xcor,ycor).x+20 ==x;
 }
}