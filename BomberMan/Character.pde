class Character implements Drawable{
  int x,y,dx,dy;
  color iro;
  int speed;
  
  Character(){
    x=0;
    y=0;
    dx=0;
    dy=0;
    speed = 0;
  }
  
  Character(int x,int y,int dx,int dy,int speed){
    this.x=x;
    this.y=y;
    this.dx=dx;
    this.dy=dy;
    this.speed = speed;
  }

  void useItem(int itemType){
   if(itemType == 0){
     speed++;
     System.out.println("Used speed skates");
   }
  }
  void draw(){
   fill(0,200,200);
   rect(x,y,40,40);
  }
}