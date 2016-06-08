class Bomb implements Drawable,Volatile{
 int x,y;
 float time;
 int radius;
 char team;
 PImage sprite;
 
 Bomb(int x,int y,char team,int rad){
   this.x = getTile(x,y).x+20;
   this.y = getTile(x,y).y+20;
   this.team = team;
   radius = rad;
   time = millis();
   sprite = loadImage(team+"bomb.png");
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
    image(sprite,x,y);
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