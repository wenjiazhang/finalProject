class Character implements Drawable{
  int x,y,dx,dy,health,speed,timer;
  int status;//0 = normal, 1 = damaged
  Character target;
  int radius;
  int facing; //0=south 1=west 2=north 3=east
  char colour;
  PImage sprite;
  char[][] map;
  Tile goal;
  boolean droppedBomb,fleeing;
  float wait;
  int score;
  
  Character(int x,int y,int dx,int dy,char colo,int health){
    this.x=x;
    this.y=y;
    this.dx=dx;
    this.dy=dy;
    this.colour = colo;
    status = 0;
    speed = 4;
    this.health = health;
    radius = 1;
    facing = 0;
    droppedBomb = false;
    target = this;
    goal = getTile(x,y);
    sprite = loadImage("Rfront0.png");
    map= new char[width/40][height/40];
    clearMap();
    wait = 0.0;
    fleeing = false;
    score = 0;
  }
  int getHealth(){
    return health;
  }
  int getScore(){
    return score;
  }
  void setScore(int s){
    score = s;
  }
  int getRad(){
    return radius;
  }
  void useItem(int itemType){
   if(itemType == 0){
     speed+=1;
     System.out.println("Used speed skates");
    }
   else if(itemType == 1){
     System.out.println("going to use firePowUp");
     radius++;
   }  
  }
  void draw(){
   if(status ==1 && millis() - timer >= 1500){
      status = 0;
    }
   String dir;
   if(facing==0){
     dir = "front";
   }else if(facing==1){
     dir = "left"; 
   }else if(facing==2){
     dir = "back";
   }else{
    dir = "right"; 
   }
   if((int)(millis() - timer)/250%2==0 || (dy==0 && dx==0 && status ==0)){
     image(loadImage(colour+dir+0+".png"),x,y-5);
   }else if(status!=1){
     image(loadImage(colour+dir+1+".png"),x,y-5);
   }
}

  boolean leftRightClear(){
    if(dx<0){
     if(x-21<0 || getTile(x-21,y).getState() > 1 || getTile(x-21,y).hasBomb&&!getTile(x,y).hasBomb){
       return false;
     }
    }else{
      if(x+21>=width || getTile(x+21,y).getState() > 1 || getTile(x+21,y).hasBomb&&!getTile(x,y).hasBomb){
       return false;
     }
    }
  return true;  
  }
  
  boolean upDownClear(){
   if(dy<0){
     if(y-21<0 || getTile(x,y-21).getState() > 1 || getTile(x,y-21).hasBomb){
       return false;
     }
    }else{
      if(y+21>=height || getTile(x,y+21).getState() > 1 || getTile(x,y+21).hasBomb){
       return false;
     }
    }
    return true;
  }
  
   boolean takeDamage(){
    //System.out.println("HURT");
    health--;
    status = 1;
    timer = millis();
    if(health==0){
      toDraw.remove(this);
      chars.remove(this);
      return true;
    }
    return false;
  }
  
   void autoTurn(int direct){
    if(direct == 0 ||direct == 1){
      if(this.upDownClear()){
        this.x = getTile(x,y).x+20;
      }else{
       dy = 0; 
      }
    }else if(direct == 2 ||direct == 3){
      if(this.leftRightClear()){
        this.y = getTile(x,y).y+20;
      }else{
       dx = 0; 
      }
    }
  }
  
  void placeBomb(){
    if(!droppedBomb){
      Bomb temp = new Bomb(x,y,colour,radius,this);
      explosives.add(temp);
      toDraw.add(temp);
      getTile(x,y).hasBomb = true;
      droppedBomb = true;
    }
  }
  
  void think(){
    //check for danger and react
    for(Volatile bomb : explosives){
      if(!fleeing && (bomb.getX()==x && Math.abs(x-bomb.getX())<=bomb.getRadius()*40) || (bomb.getY()==y && Math.abs(x-bomb.getX())<=bomb.getRadius()*40)){
        clearMap();
        run(bomb);
        //System.out.println("AAAR BOMB");
        fleeing=true;
      }
    }
    if(!fleeing){
      //find target
      if(target==this || target.health<=0){
        for(Character chara : chars){
          if(Math.abs(chara.x - x) <= 300 && Math.abs(chara.y - y) <= 300 && chara!=this){
            target = chara;
            break;
          }
        }
      }
      if(target!=this){
        goal = getTile(target.x,target.y);
        //drop bomb near char
        if(Math.abs(target.x-x)<=40 && Math.abs(target.y-y)<=40){
          placeBomb();
        }
      }else if(goal==getTile(x,y)){
        goal = getTile((int)(Math.random()*width),(int)(Math.random()*height));
      }
      
      //move
      int goalx = goal.x+20;
      int goaly = goal.y+20;
      
      if(Math.abs(goalx-x)-Math.abs(goaly-y)>40 || y==goaly){
        dy=0;
        if(goalx<x){
          facing = 1;
          dx = -speed;
          //autoTurn(2);
        }else{
          facing = 3;
          dx = speed;
          //autoTurn(3);
        }
      }else{
        dx=0;
        if(goaly<y){
          facing = 2;
          dy = -speed;
        }else{
          facing = 0;
          dy = speed;
        }
      }
      
       if((facing==0||facing==2) && !upDownClear() || (facing==1||facing==3) && !leftRightClear()){
          placeBomb();
          //System.out.println("DO THE BOMB");
          
          
       }
    }else{
         map[x/40][y/40] = '*';
         if(x<600 && map[x/40+1][y/40] == '@'){
           facing = 3;
           dx=speed;
           dy=0;
         }else if(x>39 && map[x/40-1][y/40] == '@'){
           facing = 1;
           dx=-speed;
           dy=0;
         }else if(y<440 && map[x/40][y/40+1] == '@'){
           facing = 0;
           dy=speed;
           dx=0;
         }else if(y>39 && map[x/40][y/40-1] == '@'){
           facing = 2;
           dy=-speed;
           dx=0;
         }else{
           if(wait == 0.0){
            wait = millis();
            return;
           }
           if(millis()-wait>2000){
             map[x/40][y/40] = ' ';
             if(x<600 && map[x/40+1][y/40] == '*'){
               facing = 3;
               dx=speed;
               dy=0;
             }else if(x>39 && map[x/40-1][y/40] == '*'){
               facing = 1;
               dx=-speed;
               dy=0;
             }else if(y<440 && map[x/40][y/40+1] == '*'){
               facing = 0;
               dy=speed;
               dx=0;
             }else if(y>39 && map[x/40][y/40-1] == '*'){
               facing = 2;
               dy=-speed;
               dx=0;
             }else{
               fleeing = false;
               wait = 0.0;
               //System.out.println("No longer fleeing");
             }
           }
         }
       }
  }
  
  void run(Volatile bomb){
    run(bomb,x/40,y/40);
  }
  
  boolean run(Volatile bomb,int xcor,int ycor){    
    //land
    map[xcor][ycor] = '@';
    //reach end
    if((xcor*40+20!=bomb.getX() && ycor*40+20!=bomb.getY()) || (Math.abs(xcor*40+20 - bomb.getX())>bomb.getRadius()*40 || Math.abs(ycor*40+20 - bomb.getY())>bomb.getRadius()*40)){
      return true;
    }
    //moving forward
    if(xcor<width/40-1 &&  grid[xcor+1][ycor].getState()<2 && !grid[xcor+1][ycor].hasBomb && map[xcor+1][ycor] == ' '){
        return run(bomb,xcor+1,ycor);
    }else if(xcor>0 &&  grid[xcor-1][ycor].getState()<2 && !grid[xcor-1][ycor].hasBomb && map[xcor-1][ycor] == ' '){
        return run(bomb,xcor-1,ycor);
    }else if(ycor<height/40-1 &&  grid[xcor][ycor+1].getState()<2 && !grid[xcor][ycor+1].hasBomb && map[xcor][ycor+1] == ' '){
        return run(bomb,xcor,ycor+1);
    }else if(ycor>0 && grid[xcor][ycor-1].getState()<2 && !grid[xcor][ycor-1].hasBomb && map[xcor][ycor-1] == ' '){
        return run(bomb,xcor,ycor-1);
    }
    //backtracking
    map[xcor][ycor] = '.';
    if(xcor<width/40-1 &&  grid[xcor+1][ycor].getState()<2 && !grid[xcor+1][ycor].hasBomb && map[xcor+1][ycor] == '@'){
        return run(bomb,xcor+1,ycor);
    }else if(xcor>0 &&  grid[xcor-1][ycor].getState()<2 && !grid[xcor-1][ycor].hasBomb && map[xcor-1][ycor] == '@'){
        return run(bomb,xcor-1,ycor);
    }else if(ycor<height/40-1 &&  grid[xcor][ycor+1].getState()<2 && !grid[xcor][ycor+1].hasBomb && map[xcor][ycor+1] == '@'){
        return run(bomb,xcor,ycor+1);
    }else if(ycor>0 && grid[xcor][ycor-1].getState()<2 && !grid[xcor][ycor-1].hasBomb && map[xcor][ycor-1] == '@'){
        return run(bomb,xcor,ycor-1);
    }
    return false;
  }
  
  void clearMap(){
   for(int row=0;row<map.length;row++){
      for(int col=0;col<map[0].length;col++){
        map[row][col] = ' ';
      }
    } 
  }
}