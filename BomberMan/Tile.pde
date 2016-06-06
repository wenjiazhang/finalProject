 class Tile implements Drawable{ 
      int x,y; //location
      int state; //has block, had block, never had block 
      boolean Broken;
      int itemType; //speed Upgrade, or bomb Upgrade, or none
      PImage img;
      
    Tile(int x, int y, int state, int IT){
      this.x = x;
      this.y = y;
      this.state = state; //starts off as 0 or 2 (cannot start off with item)
      itemType = IT;
      if(itemType == 0){
        img = loadImage("speedUp.png");
      }
      else if(itemType ==1){
        img = loadImage("bombUp.png");
      }
    }
    int getIT(){
      return itemType;
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
      if(state == 1 && itemType < 2){
        fill(#FFFFFF);
        rect(x+20,y+20,40,40);
        image(img,x+20,y+20,40,40);
        noFill();
      }
      else if(state == 2){
        fill(0,0,0);
      }
      /*else if(state == 3){
        fill(#1F11F0);
      }*/
      else{
        fill(#FFFFFF);
      }
      rect(x+20,y+20,40,40);
      //image(photo,x,y);
    }
   
 }