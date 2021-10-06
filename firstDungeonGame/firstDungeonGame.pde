//images
PImage dungeonBackgroundImg;
PImage playerImg;
PImage enemyImg;
PImage storeBackgroundImg;

//screens
boolean startScreen = false;
boolean dungeonScreen = false;
boolean storeScreen = false;

//characters info
int playerHp = 100;
int enemyHp = 100;
int playerMana = 50;

//damage dealt
int playerDamage = 0;
int enemyDamage = 0;

//potions
int manaPotions = 0;
int hpPotions = 0;

//positions
int playerHpBarX = 10;
int playerHpBarY = 10;
int playerManaBarX = 10;
int playerManaBarY = 40;
int enemyHpBarX = 0;
int enemyHpBarY = 100;

//dragon hitbox
boolean inDragonHitBox;

//checking mana and hp
boolean isPlayerManaEmpty = false;
boolean isPlayerHpEmpty = false;
boolean isEnemyHpEmpty = false;

//checking win or lose
boolean lostGame = false;
boolean wonGame = false;

void setup(){
  size(800,800);
  dungeonBackgroundImg = loadImage("dungeonBackground.jpg");
  playerImg = loadImage("playerImage.png");
  enemyImg = loadImage("enemyImage.png");
  storeBackgroundImg = loadImage("potionShop.jpg");
}
void draw(){
  if(dungeonScreen){
    if(enemyHp <= 0) wonGame = true;
    if(!wonGame && !lostGame && ((isPlayerHpEmpty && hpPotions == 0) || (playerMana < 5 && manaPotions == 0))) lostGame = true;
    if(manaPotions > 0 && playerMana < 5){
      playerMana = 50;
      manaPotions--;
    }
    
    inDragonHitBox = ((mouseX >= 475 && mouseX <= 590) && (mouseY >= 445 && mouseY <= 525)) || //<>//
    ((mouseX >= 445 && mouseX <= 525) && (mouseY >= 325 && mouseY <= 350)); 
  
    //setting background, enemy images, health and mana bars
    image(dungeonBackgroundImg,0,0,width,height);
    drawBar(playerHpBarX,playerHpBarY, playerHp * 3,20, 5, 0,255,0);
    drawBar(playerManaBarX,playerManaBarY, playerMana * 3,20, 5, 0,0,255);
    
    pushMatrix();
    translate(width * 1.5/3, height * 0.5/3);
    image(enemyImg, 0, 0, 400,600); 
    drawBar(enemyHpBarX,enemyHpBarY, enemyHp * 3, 20, 5, 255,0,0);
    popMatrix();
    
    //inverting and setting players image
    pushMatrix();
    scale(-1,1);
    image(playerImg,-1*450,height * 2/3,250,150);
    popMatrix();
    
    if(inDragonHitBox){
      cursor(CROSS);
    }
    else{
       cursor(ARROW);
    }
  
     if(lostGame){
     fill(255,0,0); 
     textSize(100); 
     text("YOU DIED", width * 0.5/3,200); 
     }
     
     if(wonGame){
     fill(0,255,0); 
     textSize(100); 
     text("YOU WON", width * 0.5/3,200); 
     }
  }
  else if(storeScreen){
      image(storeBackgroundImg,0,0,width,height);
  }
  else{
    
  }
}

void mouseClicked(){
  if(inDragonHitBox && playerMana >= 5){
    playerMana -= 5;
    playerDamage = (int)random(0,13) * 2;
    enemyHp -= playerDamage;
    if(enemyHp < 0) enemyHp = 0;
  }
  
}

void drawBar(int x, int y, int rectWidth, int rectHeight, int radius, int red, int green, int blue){
  fill(red,green,blue);
  rect(x, y, rectWidth, rectHeight, radius);
}
