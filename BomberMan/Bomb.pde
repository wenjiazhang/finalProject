class Bomb implements Drawable,Volatile{
 int x,y,team;
 float time;
 int radius;
 
 Bomb(int x,int y,int team,int rad){
   this.x = x;
   this.y = y;
   this.team = team;
   radius = rad;
   time = millis();
 }
 int getX(){
   return x;
 }
 int getY(){
   return y;
 }
 int getRadius(){
   return radius;
 }
 void setRadius(int newRad){
   radius = newRad;
 }
 void draw(){
   if(team == 1){
     fill(0,200,150);
   }else if(team == 2){
     fill(150,200,150);
   }else if(team == 3){
     fill(70,200,150);
   }else if(team == 4){
     fill(30,200,150);
   }
   if((int)(millis()-time)/250%2==0){
     ellipse(x,y,10,10);
   }
 }
 
 boolean countDown(){
   if(millis()-time>=2000){
    return true; 
   }
   return false;
 }
 
 String toString(){
   return "Bomb!";
 }
 
 void explode(){
   Cross temp = new Cross(x,y,radius*2+1);
   toDraw.add(temp);
   explosives.add(temp);
   toDraw.remove(this);
   explosives.remove(this);
 }
}