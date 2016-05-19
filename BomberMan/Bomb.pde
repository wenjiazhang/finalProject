class Bomb implements Drawable{
 int x,y,team;
 float time;
 
 Bomb(int x,int y,int team){
   this.x = x;
   this.y = y;
   this.team = team;
   time = millis();
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
   
   toDraw.remove(this);
   bombs.remove(this);
 }
}