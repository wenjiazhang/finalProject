import java.lang.Math;
static int state;
color background;
Player player1;
ArrayList<Drawable> toDraw = new ArrayList<Drawable>();
ArrayList<Bomb> bombs = new ArrayList<Bomb>();
ArrayList<Character> chars = new ArrayList<Character>();
ArrayList<Block> blocks = new ArrayList<Block>();
Tile[][] grid = new Tile[height/10][width/10];
void setup(){
  colorMode(HSB);
  state = 0;
  size(640, 480);
  background = color(0,0,200);
  player1 = new Player(100,100,0,0);
   for(int i = 0;i<grid.length;i++){
    for(int index = 0;index<grid[0].length;index++){
      grid[i][index] = new Tile(i*10, index*10);
      toDraw.add(grid[i][index]);
      System.out.println("Tile added!");
    }
  } 
  toDraw.add(player1);
  noStroke();
  ellipseMode(CENTER);
  rectMode(CENTER);
}

void draw(){
  background(background);
 
  /*for(int i = 0;i<grid.length;i+=10){
    for(int index = 0;index<grid[0].length;index+=10){
      if((int)(Math.random() * 3) == 1){
        blocks.add(new Block(i,index));
      }
    }
  }*/
  //get input
  
  //change states
  player1.x+=player1.dx;
  player1.y+=player1.dy;
  for(int i=0;i<bombs.size();i++){
    if(bombs.get(i).countDown()){
      bombs.get(i).explode();
      i--;
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
    player1.dy = -2;
  }else if(keyCode == DOWN){
    player1.dy = 2;
  }else if(keyCode == LEFT){
    player1.dx = -2;
  }else if(keyCode == RIGHT){
    player1.dx = 2;
  }else if(key == ' '){
    Bomb temp = new Bomb(player1.x,player1.y,1);
    bombs.add(temp);
    toDraw.add(temp);
  }
}

void mousePressed(){
  
}