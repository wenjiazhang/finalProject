 class Tile implements Drawable{ 
      int x,y; //location
      int state; //has block, had block, never had block 
      boolean Broken;
      int itemType; //speed Upgrade, or bomb Upgrade 
      PImage img;
      
    Tile(int x, int y, int state, int IT){
      this.x = x;
      this.y = y;
      this.state = state; //starts off as 0 or 2 (cannot start off with item)
      itemType = IT;
      if(itemType == 0){
        img = loadImage("speedUp.jpg");
      }
      else{
        img = loadImage("bombUp.png");
      }
    }
    PImage getImg(){
      return img;
    }
    int getState(){
      return state;
    }
    void setState(int newState){
      state = newState;
      System.out.println("tile at " + x + "/" + y + "is now at state " + state);
    }
    void draw(){
      if(state == 1){
        fill(#FFFFFF);
        image(img,x,y,30,30);
      }
      else if(state == 0){
        fill(#FFFFFF);
      }
      //else if(state == 1){
      //  image(img,x,y,30,30);
      //  fill(0,0,0);
      //}
      else{
        fill(0,0,0);
      }
      rect(x+20,y+20,40,40);
      //image(photo,x,y);
    }
   
 }