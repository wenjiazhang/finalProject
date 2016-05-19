 class Tile implements Drawable{ 
      int x,y; //location
      boolean Broken;
      
    Tile(int x, int y){
      this.x = x;
      this.y = y;
    }
    void draw(){
        fill(#5213AD);
        rect(x,y,10,10);
      //image(photo,x,y);
    }
  }