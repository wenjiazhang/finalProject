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
      grid[i][index] = new Tile(i*40, index*40,(int)(Math.random()*2)*2,(int)(Math.random()*3));
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
  //<>// //<>//
  //get input
  
  //change states
  //player movement
  
    if(player1.leftRightClear()){
    player1.x+=player1.dx;
    }
    if(player1.upDownClear()){
      player1.y+=player1.dy;
    }
  
  
  //use item
  if(grid[player1.x/40][player1.y/40].getState() == 1){
    player1.useItem(grid[player1.x/40][player1.y/40].getIT());
    grid[player1.x/40][player1.y/40].setState(0);
  }
  
  //change bomb/cross states
  for(int i=0;i<explosives.size();i++){
    if(explosives.get(i) instanceof Cross){
      System.out.println("cross radius is" + explosives.get(i).getRadius());
      
      if(((Cross)explosives.get(i)).inBlast(player1.x,player1.y) && player1.status == 0){
        player1.takeDamage();
      }
    }   
    if(explosives.get(i).countDown()){
      int x = explosives.get(i).getX();
      int y = explosives.get(i).getY();
      //int rad = explosives.get(i).getRadius();
      explosives.get(i).explode();
      System.out.println("x/y: " + x + "/" + y);
      //only if we decide to make a superFirePowerUp
      //for(int inc = 1;inc<rad+1;inc++){
      //  if(grid[x/40+inc][y/40].getState() == 2){
      //    grid[x/40+inc][y/40].setState(1);
      //  }
      //  if(grid[x/40-inc][y/40].getState() == 2){
      //    grid[x/40-inc][y/40].setState(1);
      //  }
      //  if(grid[x/40][y/40+inc].getState() == 2){ //<>//
      //    grid[x/40][y/40+inc].setState(1);
      //  }
      //  if(grid[x/40][y/40-inc].getState() == 2){
      //    grid[x/40][y/40-inc].setState(1);
      //  }
      //}
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
      player1.dy = 0;
  }else if(keyCode == DOWN){
      player1.dy = 0;
  }else if(keyCode == LEFT){
      player1.dx = 0;
  }else if(keyCode == RIGHT){
      player1.dx = 0;
  }else if(key == ' '){
    
  }
}

void keyPressed() {
  if(keyCode== UP && player1.dx ==0){
    player1.dy = -player1.speed;
    player1.autoTurn(0);
  }else if(keyCode == DOWN && player1.dx ==0){
    player1.dy = player1.speed;
    player1.autoTurn(1);
  }else if(keyCode == LEFT && player1.dy ==0){
    player1.dx = -player1.speed;
    player1.autoTurn(2);
  }else if(keyCode == RIGHT && player1.dy ==0){
    player1.dx = player1.speed;
    player1.autoTurn(3);
  }else if(key == ' '){
    Bomb temp = new Bomb(player1.x,player1.y,1,player1.radius);
    explosives.add(temp);
    toDraw.add(temp);
  }
}

void mousePressed(){
  
}

Tile getTile(int xcor,int ycor){
  return grid[xcor/40][ycor/40];
}