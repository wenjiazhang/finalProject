class Block implements Drawable{
  int x,y;
  boolean Broken;
  int item; //0 is holds no item, 1 is holds speed up, 2 is holds bigger blast
  
  Block(int x, int y){
    this.x = x;
    this.y = y;
    item = (int)(Math.random()* 3); //will implement later
  }
  void draw(){
    fill(0,0,225);
    rect(x,y,10,10);
  }
  /*void break(){ 
    // only activated in main, when bomb explodes nearby
    toDraw.remove(this);
    blocks.remove(this);
    Broken = true;
  }*/
  
}