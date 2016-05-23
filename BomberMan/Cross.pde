class Cross implements Drawable,Volatile{
  int x,y,size;
  float time;
  
  Cross(int x,int y,int size){
    this.x = x;
    this.y = y;
    this.size = size;
    time = millis();
  }
  
  void draw(){
    fill(30,200,230);
    rect(x,y-(size*10),10,size*20);
    rect(x,y+(size*10),10,size*20);
    rect(x-(size*10),y,size*20,10);
    rect(x+(size*10),y,size*20,10);
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