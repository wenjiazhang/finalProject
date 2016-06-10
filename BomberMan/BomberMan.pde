import java.lang.Math;
import processing.sound.*;
import java.io.FileNotFoundException;
static int state; //// 0=main menu 1=in-game pvp 2=in-game ai 3=lose 4=win 5=mode select 6=char select pvp 7=char select ai
color background;
Character player1, player2;
int score; //WENDY I ADDED THIS (increases by the number of 
//blocks you destroy and later on, when you hit another player);
BufferedReader reader;
String line;
PImage mainmenu;
SoundFile music;

//Item[][] itemGrid;

ArrayList<Drawable> toDraw = new ArrayList<Drawable>();
ArrayList<Volatile> explosives = new ArrayList<Volatile>();
ArrayList<Character> chars = new ArrayList<Character>();
ArrayList<ArrayList<Button>> buttons;
ArrayList<String> colors = new ArrayList<String>();

Tile[][] grid;

void setup(){
  //set modes
  colorMode(HSB);
  textAlign(LEFT, TOP);
  noStroke();
  ellipseMode(CENTER);
  rectMode(CENTER);
  imageMode(CENTER);
  size(640, 480);
 
  //initiate vars
  state = 0;
  score = 0;
  //File f = new File("~/finalProject/BomberMan/data/stage01.dat");
  reader = createReader("stage01.dat");
  grid = new Tile[width/40][height/40];
  for(int i = 0;i<grid.length;i++){
    try{
      line = reader.readLine();
    }catch(IOException e){
      e.printStackTrace();
      line = null;
    }
    if(line != null){
      int[]States = int(split(line, ' '));
      for(int index = 0;index<grid[0].length;index++){
        grid[i][index] = new Tile(i*40, index*40,States[index],(int)(Math.random()*10));
        toDraw.add(grid[i][index]);
        //System.out.println("Tile added!");
      }
    }
  }
  
  //buttons
  buttons = new ArrayList<ArrayList<Button>>();
  for(int i =0;i<buttons.size();i++){
    buttons.set(i, new ArrayList<Button>());
  }
  buttons.add(0,new ArrayList<Button>());
  buttons.add(1,new ArrayList<Button>()); //state 2
  buttons.add(2,new ArrayList<Button>()); //state 3
  buttons.add(3,new ArrayList<Button>()); //state 4
  buttons.add(4,new ArrayList<Button>()); // state 5
  buttons.add(5,new ArrayList<Button>()); // state 6
  buttons.add(6,new ArrayList<Button>()); // state 7
  buttons.get(0).add(new Button(width*2/5-40,400,"Play",20,color(0,0,150),color(0,0,200)));
  buttons.get(0).add(new Button(width*3/5-40,400,"Exit",20,color(0,0,150),color(0,0,200)));
  //buttons.get(0).add(new Button(width/20,height/3+80,"Lose!",20, color(0,0,0),color(0,0,100)));
  //buttons.get(0).add(new Button(width/20,height/3+120,"Win!",20, color(0,0,0),color(0,0,100)));
  buttons.get(2).add(new Button(60,390,"Play Again!",20,color(#FF0505),color(0,0,100)));
  buttons.get(3).add(new Button(60,390,"Play Again!",20,color(#FF0505),color(0,0,100)));
  buttons.get(4).add(new Button(width/3,height/3,"Player VS Player",20,color(0,0,150),color(0,0,200)));
  buttons.get(4).add(new Button(width/3,height/3+80,"Player VS Computer",20,color(0,0,150),color(0,0,200)));
  background = color(0,0,200);
  music = new SoundFile(this, "mainmenu.mp3");
  loop();
  music.play();
  
  //method calls
  resetColors();
}

void draw(){
  System.out.println(state);
  if (state == 0){
    if(millis()/500%4==0){
      mainmenu = loadImage("mainmenu0.png");
    }else if(millis()/500%4==1){
      mainmenu = loadImage("mainmenu1.png");
    }else if(millis()/500%4==2){
      mainmenu = loadImage("mainmenu2.png");
    }else{
      mainmenu = loadImage("mainmenu3.png");
    }
    image(mainmenu,320,240);
    for(Button butt : buttons.get(0)){ //<>//
      butt.draw();
    }
  }else if(state == 1 || state == 2){
    background(background); //<>//
    //get input
    if(player1.health == 0){
      for(int i = 0;i<explosives.size();i++){
        explosives.remove(i);
      }
      state = 3; //you lose!
    }else if(chars.size()<2){
      state = 4; //you win!
    }
    //change states
    //player movement
    
    for(Character chara : chars){
      if(chara.leftRightClear()){
        chara.x+=chara.dx;
      }
      if(chara.upDownClear()){
        chara.y+=chara.dy;
      }
    }
    
    if(state==2){
      for(int i=1;i<chars.size();i++){
        if((chars.get(i).x-20)%40==0 && (chars.get(i).y-20)%40==0){
          chars.get(i).think();
        }
      }
    }
    
    //use item
    if(grid[player1.x/40][player1.y/40].getState() == 1){
      player1.useItem(grid[player1.x/40][player1.y/40].getIT());
      grid[player1.x/40][player1.y/40].setState(0);
    }
    
    //change bomb/cross states
    for(int i=0;i<explosives.size();i++){
      if(explosives.get(i) instanceof Cross){
        //System.out.println("cross radius is" + explosives.get(i).getRadius());
        for(int e=0;e<chars.size();e++){
          if(((Cross)explosives.get(i)).inBlast(chars.get(e).x,chars.get(e).y) && chars.get(e).status == 0){
            if(chars.get(e)==player1){
              score -= 10; //this is where the problem is
            }
            if(chars.get(e).takeDamage()){
             e--; 
            }
          }
        }
      }   
      if(explosives.get(i).countDown()){
      int x = explosives.get(i).getX();
      int y = explosives.get(i).getY();
      if(explosives.get(i) instanceof Bomb){
      if(inGrid(x/40+1,y/40)){
        int tempState = grid[x/40+1][y/40].getState();
        if(tempState >= 2 && tempState != 4){
          grid[x/40+1][y/40].setState(tempState-1);
          score+= 20;
        }
      }
      if(inGrid(x/40-1,y/40)){
        int tempState = grid[x/40-1][y/40].getState();
        if(tempState >= 2 && tempState != 4){
          grid[x/40-1][y/40].setState(tempState-1);
          score+= 20;
        }
      }
      if(inGrid(x/40,y/40+1)){
        int tempState = grid[x/40][y/40+1].getState();
        if(tempState >= 2 && tempState != 4){
          grid[x/40][y/40+1].setState(tempState-1);
          score+= 20;
        }
      }
      if(inGrid(x/40,y/40-1)){
        int tempState = grid[x/40][y/40-1].getState();
        if(tempState >= 2 && tempState != 4){
          grid[x/40][y/40-1].setState(tempState-1);
          score+= 20;
        }
      }
      }
      explosives.get(i).explode();
      System.out.println("x/y: " + x + "/" + y); //<>//
      i--;
    }
    }
 //<>//
    
    //draw
    //player1.draw();
    for(Drawable drawing : toDraw){
      drawing.draw();
    }
    fill(0,200,200);
    textSize(20);
    text("Health: "+player1.health, 0,40);
    text("Score: " + score, 100,40);
  }
  else if(state == 3){ //lose page
    PImage bomb = loadImage("bomb.jpg");
    PImage wings = loadImage("wings.png");
    background(#D3BCE3);
    PImage endPg = loadImage("loseImage.jpg");
    PImage catMeme = loadImage("catMeme.jpg");
    image(endPg, width/2, height/2-100 ,width,height);
    image(catMeme, width/2, height/2 + 70, 200,200);
    for(int i = 0;i<12;i++){
      if(i % 2 == 0){
        image(bomb,20,i*40+20,40,40);
      }
      else{
        image(wings,20,i*40+20,40,40);
      }
    }
    for(int i = 0;i<12;i++){
      if(i % 2 == 0){
        image(bomb,620,i*40+20,40,40);
      }
      else{
        image(wings,620,i*40+20,40,40);
      }
    }
    textSize(40);
    fill(#050000);
    text("Your score is: " + score, 120, 420);
    for(Button butt : buttons.get(2)){
      butt.draw();
    }
    }
    else if(state == 4){//win page
    PImage bomb = loadImage("bomb.jpg");
    PImage wings = loadImage("wings.png");
    PImage winMeme = loadImage("winMeme.jpg");
    background(#D3BCE3);
    image(winMeme, width/2, height/2-50 ,width-80,height-100);
    for(int i = 0;i<12;i++){
      if(i % 2 == 0){
        image(bomb,20,i*40+20,40,40);
      }
      else{
        image(wings,20,i*40+20,40,40);
      }
    }
    for(int i = 0;i<12;i++){
      if(i % 2 == 0){
        image(bomb,620,i*40+20,40,40);
      }
      else{
        image(wings,620,i*40+20,40,40);
      }
    }
    textSize(40);
    fill(#050000);
    text("You Win!! Your score is: " + score, 60, 420);
    for(Button butt : buttons.get(3)){
      butt.draw();
    }
  }
  else if(state == 5){
    background(32,8,245);
    for(Button butt : buttons.get(4)){
      butt.draw();
    }
  }
}

void keyReleased() {
  if(state == 1 || state == 2){
    if(keyCode== UP){
        player1.dy = 0;
    }else if(keyCode == DOWN){
        player1.dy = 0;
    }else if(keyCode == LEFT){
        player1.dx = 0;
    }else if(keyCode == RIGHT){
        player1.dx = 0;
    }
    if(state == 1){
      if(key == 'w'){
          player2.dy = 0;
      }else if(key == 's'){
          player2.dy = 0;
      }else if(key == 'a'){
          player2.dx = 0;
      }else if(key == 'd'){
          player2.dx = 0;
      }
    }
  }
}

void keyPressed() {
  if(state == 1 || state == 2){
    if(keyCode== UP && player1.dx ==0){
      player1.dy = -player1.speed;
      player1.autoTurn(0);
      player1.facing = 2;
    }else if(keyCode == DOWN && player1.dx ==0){
      player1.dy = player1.speed;
      player1.autoTurn(1);
      player1.facing = 0;
    }else if(keyCode == LEFT && player1.dy ==0){
      player1.dx = -player1.speed;
      player1.autoTurn(2);
      player1.facing = 1;
    }else if(keyCode == RIGHT && player1.dy ==0){
      player1.dx = player1.speed;
      player1.autoTurn(3);
      player1.facing = 3;
    }else if(key == ' '){
      player1.placeBomb();
    }
    
    if(state == 1){
      if(key== 'w' && player2.dx ==0){
        player2.dy = -player2.speed;
        player2.autoTurn(0);
        player2.facing = 2;
      }else if(key == 's' && player1.dx ==0){
        player2.dy = player2.speed;
        player2.autoTurn(1);
        player2.facing = 0;
      }else if(key == 'a' && player2.dy ==0){
        player2.dx = -player2.speed;
        player2.autoTurn(2);
        player2.facing = 1;
      }else if(key == 'd' && player2.dy ==0){
        player2.dx = player2.speed;
        player2.autoTurn(3);
        player2.facing = 3;
      }else if(keyCode == CONTROL){
        player2.placeBomb();
      }
    }
  }
}
  
void mousePressed(){
  if(state == 0){
    if(buttons.get(0).get(0).retOver()){
      state = 5; //mode select
    }else if(buttons.get(0).get(1).retOver()){
      exit();
    }
    /*else if(buttons.get(0).get(2).retOver()){
      state = 3;
    }
    else if(buttons.get(0).get(3).retOver()){
      state = 4;
    }*/
  }
  else if(state == 3){
    if(buttons.get(2).get(0).retOver()){
      setup();
      buttons.get(0).get(0).setOver(false);
      state = 0;
    }
  }
  else if(state == 4){
    if(buttons.get(3).get(0).retOver()){
      setup();
      buttons.get(0).get(0).setOver(false);
      state = 0;
    }
  }
  else if(state == 5){
    if(buttons.get(4).get(0).retOver()){
      placeChars(true);
      state = 1;
    }
    if(buttons.get(4).get(1).retOver()){
      placeChars(false);
      state = 2;
    }
  }
}

Tile getTile(int xcor,int ycor){
  return grid[xcor/40][ycor/40];
}

boolean inGrid(int xcor, int ycor){
  if(xcor< 0 || xcor>grid.length - 1 ||  ycor < 0 || ycor>grid[0].length - 1){
    return false;
  }
  return true;
}

void placeChars(boolean pvp){
  int row = 1;
  int col = 1;
  while(grid[row][col].getState() >= 2){
    col++;
  }
  player1 = new Player(row*40+20,col*40+20,0,0,'R');
  chars.add(player1);
  toDraw.add(player1);
  colors.remove(""+player1.colour);
  
  if(pvp){
    col=width/40-1;
    row = 0;
    while(grid[col][row].getState() >= 2){
      col--;
    }
    player2 = new Player(col*40+20,row*40+20,0,0,'B');
    
    chars.add(player2);
    toDraw.add(player2);
  }else{
    Character chara1 = new Character(620,20,0,0,colors.get(0).charAt(0),4);
    Character chara2 = new Character(20,460,0,0,colors.get(1).charAt(0),4);
    Character chara3 = new Character(620,460,0,0,colors.get(2).charAt(0),4);
    
    chars.add(chara1);
    toDraw.add(chara1);
    chars.add(chara2);
    toDraw.add(chara2);
    chars.add(chara3);
    toDraw.add(chara3);
  }
  
}

void resetColors(){
    colors.add("R");
    colors.add("B");
    colors.add("G");
    colors.add("P");
}