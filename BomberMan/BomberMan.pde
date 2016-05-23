import java.lang.Math;
static int state;
color background;
Player player1;
ArrayList<Drawable> toDraw = new ArrayList<Drawable>();
ArrayList<Volatile> explosives = new ArrayList<Volatile>();
ArrayList<Character> chars = new ArrayList<Character>();
Tile[][] grid;
//Item[][] itemGrid;
void setup(){
  colorMode(HSB);
  state = 0;
  size(640, 480);
  grid = new Tile[width/40][height/40];
  background = color(0,0,200);
   for(int i = 0;i<grid.length;i++){
    for(int index = 0;index<grid[0].length;index++){
      grid[i][index] = new Tile(i*40, index*40,(int)(Math.random()*2)*2,(int)(Math.random()*2));
      toDraw.add(grid[i][index]);
      //System.out.println("Tile added!");
    }
  } 
  //to prevent character starting off on wall
  int row = 1;
  int col = 1;
  while(grid[row][col].getState() == 2){
    col++;
  }
  player1 = new Player(row*40+20,col*40+20,0,0,0);
  toDraw.add(player1);
  noStroke();
  ellipseMode(CENTER);
  rectMode(CENTER);
}

void draw(){
  background(background);
  //<>//
  //get input
  
  //change states
  //player movement
  if(player1.slidingX){
    if((player1.x-20)%40 != 0 && player1.leftRightClear()){
      player1.x+=player1.dx;
    }else{
      player1.dx = 0;
      player1.slidingX = false;
    }
  }else if(player1.slidingY){
    if((player1.y-20)%40 != 0 && player1.upDownClear()){
      player1.y+=player1.dy;
    }else{
      player1.dy = 0;
      player1.slidingY = false;
    }
  }else{
    if(player1.leftRightClear()){
    player1.x+=player1.dx;
    }
    if(player1.upDownClear()){
      player1.y+=player1.dy;
    }
  }
  
  //use item
  if(grid[player1.x/40][player1.y/40].getState() == 1){
    player1.useItem(grid[player1.x/40][player1.y/40].getIT());
    grid[player1.x/40][player1.y/40].setState(0);
  }
  /*
  for(int i=0;i<bombs.size();i++){
    if(bombs.get(i).countDown()){
      int x = bombs.get(i).getX();
      int y = bombs.get(i).getY();
       bombs.get(i).explode();
      System.out.println("x/y: " + x + "/" + y);
      if(grid[x/40+1][y/40].getState() == 2){
        grid[x/40+1][y/40].setState(1);
      }
      if(grid[x/40-1][y/40].getState() == 2){
        grid[x/40-1][y/40].setState(1);
      }
      if(grid[x/40][y/40+1].getState() == 2){
        grid[x/40][y/40+1].setState(1);
      }
      if(grid[x/40][y/40-1].getState() == 2){
        grid[x/40][y/40-1].setState(1);
      }
      i--; //<>//
    }
  }*/
  
  //change bomb/cross states
  for(int i=0;i<explosives.size();i++){
    if(explosives.get(i) instanceof Cross){
      if(((Cross)explosives.get(i)).inBlast(player1.x,player1.y) && player1.status == 0){
        player1.takeDamage();
      }
    }
    if(explosives.get(i).countDown()){
      explosives.get(i).explode();
      i--;
    }
  }
  
  //draw
  //player1.draw();
  for(Drawable drawing : toDraw){
    drawing.draw();
  }
  fill(0,200,200);
  textSize(20);
  text("Health: "+player1.health, 0,40);
  if (state == 0){
    
  }else if(state ==1){
    
  }else{
    
  }
}

void keyReleased() {
  if(keyCode== UP){
    if(player1.dx == 0){
      player1.slidingY = true;
    }else{
      player1.dy = 0;
    }
  }else if(keyCode == DOWN){
    if(player1.dx == 0){
      player1.slidingY = true;
    }else{
      player1.dy = 0;
    }
  }else if(keyCode == LEFT){
    if(player1.dy == 0){
      player1.slidingX = true;
    }else{
      player1.dx = 0;
    }
  }else if(keyCode == RIGHT){
    if(player1.dy == 0){
      player1.slidingX = true;
    }else{
      player1.dx = 0;
    }
  }else if(key == ' '){
    
  }
}

void keyPressed() {
  if(keyCode== UP && player1.dx ==0){
    player1.dy = -player1.speed;
  }else if(keyCode == DOWN && player1.dx ==0){
    player1.dy = player1.speed;
  }else if(keyCode == LEFT && player1.dy ==0){
    player1.dx = -player1.speed;
  }else if(keyCode == RIGHT && player1.dy ==0){
    player1.dx = player1.speed;
  }else if(key == ' '){
    Bomb temp = new Bomb(player1.x,player1.y,1);
    explosives.add(temp);
    toDraw.add(temp);
  }
}

void mousePressed(){
  
}

Tile getTile(int xcor,int ycor){
  return grid[xcor/40][ycor/40];
}