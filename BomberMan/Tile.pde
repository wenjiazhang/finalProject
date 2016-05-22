 class Tile implements Drawable{ 
      int x,y; //location
      int state; //has block, had block, never had block 
      boolean Broken;
      int item;
      
    Tile(int x, int y, int state){
      this.x = x;
      this.y = y;
      this.state = state;
    }
    int getState(){
      return state;
    }
    void draw(){
      if(state < 2){
        fill(#FFFFFF);
      }
      else{
        fill(0,0,0);
      }
        rect(x,y,40,40);
      //image(photo,x,y);
    }
  }