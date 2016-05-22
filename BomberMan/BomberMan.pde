import java.lang.Math;
static int state;
color background;
Player player1;
ArrayList<Drawable> toDraw = new ArrayList<Drawable>();
ArrayList<Bomb> bombs = new ArrayList<Bomb>();
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
  //noStroke();
  ellipseMode(CENTER);
  rectMode(CENTER);
}

void draw(){
  background(background);
  //<>//
  //get input
  
  //change states
  player1.x+=player1.dx;
  player1.y+=player1.dy;
  if(grid[player1.x/40][player1.y/40].getState() == 1){
    player1.useItem(grid[player1.x/40][player1.y/40].getIT());
    grid[player1.x/40][player1.y/40].setState(0);
  }
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
  }
  //draw
  //player1.draw();
  for(Drawable drawing : toDraw){
    drawing.draw();
  }
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
  }else if(key == BACKSPACE){
    
  }
}

void keyPressed() {
  if(keyCode== UP){
    player1.dy = -2 - player1.speed;
  }else if(keyCode == DOWN){
    player1.dy = 2 + player1.speed;
  }else if(keyCode == LEFT){
    player1.dx = -2 - player1.speed;
  }else if(keyCode == RIGHT){
    player1.dx = 2 + player1.speed;
  }else if(key == ' '){
    Bomb temp = new Bomb(player1.x,player1.y,1);
    bombs.add(temp);
    toDraw.add(temp);
  }
}

void mousePressed(){
  
}