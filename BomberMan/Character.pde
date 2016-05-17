class Character{
  int x,y,dx,dy;
  color iro;
  
  Character(){
    x=0;
    y=0;
    dx=0;
    dy=0;
  }
  
  Character(int x,int y,int dx,int dy){
    this.x=x;
    this.y=y;
    this.dx=dx;
    this.dy=dy;
  }
  
  void draw(){
   fill(0,0,0);
   rect(x,y,10,20);
  }
}