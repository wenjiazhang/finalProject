class Cross implements Drawable{
  int x,y,size;
  
  Cross(int x,int y,int size){
    this.x = x;
    this.y = y;
    this.size = size;
  }
  
  void draw(){
    fill(30,200,230);
    rect(x,y-(size/2),10,size);
    rect(x,y+(size/2),10,size);
    rect(x-(size/2),y,size,10);
    rect(x+(size/2),y,size,10);
  }
}