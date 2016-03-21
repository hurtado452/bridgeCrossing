import java.util.*;

PFont f;
PImage bg,startScreen,finished;
PImage fall_1, fall_2, fall_3, fall_4;
PImage eat_gc, eat_fg;
boolean started = false;
boolean broken = false;
boolean dropped = false;
String story_text;
int timeline = 0;
int counter = 0;
//goose,corn,fox
boolean[] selectedGoods = {false,false,false};
Stack stackGoods = new Stack();
Farmer joe = new Farmer();
Goose goose = new Goose();
Corn corn = new Corn();
Fox fox = new Fox();
StoryLine text = new StoryLine();
void setup(){
 size(792,538);
 f = createFont("Arial",14,true); 
 bg = loadImage("bg_8.png");
 startScreen = loadImage("startScreen.png");
 finished = loadImage("finished.png");
 fall_1 = loadImage("end_fox_goose.png");
 fall_2 = loadImage("end_fox_corn.png");
 fall_3 = loadImage("end_corn_goose.png");
 fall_4 = loadImage("end_all_fall.png");
 eat_gc = loadImage("goose_ate_corn.png");
 eat_fg = loadImage("fox_ate_goose.png");
}

void draw(){
  checkKeys();
  if(!started){
    background(startScreen);
    joe.reset();
    goose.reset();
    corn.reset();
    fox.reset();    
  }
  else{
    background(bg);
    story();
    resetGame();
    checkKeys();
  }
}

void story(){  
  fill(0);
  textFont(f);
  story_text = text.display(timeline);
  text(story_text,500,200);

}
void resetGame(){
  joe.loadImages();
  goose.loadImages();
  corn.loadImages();
  fox.loadImages();
  if(dropped){
    if(leftAlone()){
      broken = true;
    }
    else{
      checkgo();  
    }
  }
  if(logic()){
    if(joe.bridgeBreak()){
      if(selectedGoods[0] && selectedGoods[1] && !selectedGoods[2]){ //goose and corn
        image(fall_3,0,0);
        broken = true;
      }
      else if(selectedGoods[0] && selectedGoods[2] && !selectedGoods[1]){ //goose and fox
        image(fall_1,0,0);
        broken = true;   
      }
      else if(selectedGoods[2] && selectedGoods[1] && !selectedGoods[0]){ //fox and corn
        image(fall_2,0,0);
        broken = true; 
      }
      else if(selectedGoods[0] && selectedGoods[1] && selectedGoods[2]){
        image(fall_4,0,0);
        broken = true;         
      }
      else{
        //nothing 
      } 
    }
  }
  if(!broken){
    if(joe.dirState == "right"){
      image(joe.images[1],joe.posX,joe.posY);
      if(selectedGoods[0]){
        image(goose.images[0],goose.posX,goose.posY);
      }
      if(selectedGoods[1]){
        image(corn.images,corn.posX,corn.posY); 
      }
      if(selectedGoods[2]){
        image(fox.images[0],fox.posX,fox.posY);  
      }
    }
    else if(joe.dirState == "left"){
      image(joe.images[0],joe.posX,joe.posY);
      
      if(selectedGoods[0]){
        image(goose.images[1],goose.posX,goose.posY);
      }
      if(selectedGoods[1]){
        image(corn.images,corn.posX,corn.posY); 
      }
      if(selectedGoods[2]){
        image(fox.images[1],fox.posX,fox.posY);  
      }
    }
    else{
      if(joe.idlingState == "left"){
        image(joe.images[0],joe.posX,joe.posY);
        if(selectedGoods[0]){
          image(goose.images[1],goose.posX,goose.posY);
        }
        if(selectedGoods[1]){
          image(corn.images,corn.posX,corn.posY); 
        }
        if(selectedGoods[2]){
          image(fox.images[1],fox.posX,fox.posY);  
        }
      }
      if(joe.idlingState == "right"){
        image(joe.images[1],joe.posX,joe.posY);
        if(selectedGoods[0]){
          image(goose.images[0],goose.posX,goose.posY);
        }
        if(selectedGoods[1]){
          image(corn.images,corn.posX,corn.posY); 
        }
        if(selectedGoods[2]){
          image(fox.images[0],fox.posX,fox.posY);  
        }
      }
    }
    if(goose.dirState == "idling"){
      if(goose.idlingState == "left"){
        image(goose.images[1],goose.posX,goose.posY);  
      }
      else{
        image(goose.images[0],goose.posX,goose.posY);
      }  
    }
    if(corn.dirState == "idling"){
      image(corn.images,corn.posX,corn.posY);    
    }
    if(fox.dirState == "idling"){
      if(fox.idlingState == "left"){
        image(fox.images[1],fox.posX,fox.posY);  
      }
      else{
        image(fox.images[0],fox.posX,fox.posY);
      }       
    }
    joe.checkState();
    goose.checkState();
    corn.checkState();
    fox.checkState();
    increaseStory();
  }

}
void checkgo(){
  //checks for game over
  if(goose.posX <= 241 && corn.posX <= 241 && fox.posX <= 241){
    image(finished,0,0);
    broken = true;
  }  
}
boolean leftAlone(){

  if(goose.posX <= 241 && corn.posX <= 241 && joe.posX >= 245 && fox.posX >= 341){
    image(eat_gc,0,0);
    return true;
  }
  if(goose.posX <= 241 && fox.posX <= 241 && joe.posX >= 245 && corn.posX >= 341){
    image(eat_fg,0,0);
    return true;
  }
  if(goose.posX > 453 && fox.posX > 453 && joe.posX <= 300 && corn.posX <= 241){
    image(eat_fg,0,0);
    return true;
  }
  if(goose.posX > 453 && corn.posX > 453 && joe.posX <= 300 && fox.posX <= 241){
    image(eat_gc,0,0);
    return true;    
  }
  return false;  
}
void increaseStory(){
  
  if(counter < 100){
    if(counter > 25){
      timeline = 1;
    }
    counter++;
  }
  if(counter >= 100 && counter < 300){
    counter++;
    timeline = 2;
  }  
}

boolean logic(){
  int pickedUp = 0;
  for(int i=0;i<3;i++){
    if(selectedGoods[i] == true){
      pickedUp++;
    }  
  }
  if(pickedUp > 1){
    //farmer has picked two items kill bridge
    return true;  
  }
  return false;
}

HashSet<Integer> keysDown = new HashSet<Integer>();

void keyPressed(){
   keysDown.add(keyEvent.getKeyCode());
}

void keyReleased(){ 
  keysDown.remove(keyEvent.getKeyCode());
}

boolean keyDown(int kcode) {
  return keysDown.contains(kcode);
}

boolean checkCloseness(int itemX){
  int diff = joe.posX - itemX;
  if(abs(diff) >=0 && abs(diff) <=75){
    return true;
  }
  return false;  
}

void resetAll(){
  for(int i=0;i<3;i++){
    selectedGoods[i] = false;  
  }
  timeline = 0;
  counter = 0;
  broken = false;
  dropped = false;
  while(!stackGoods.isEmpty()){
    stackGoods.pop();  
  }
}

void checkKeys() {
  if(keyDown('R') && broken){
    started = false;
    resetAll();
  }
  if (keyDown(ENTER)){
    started = true; 
  }
  if(keyDown(LEFT) && started){
    joe.dirState = "left";
    if(selectedGoods[0]){
      goose.dirState = "left";
    }
    if(selectedGoods[1]){
      corn.dirState = "left";  
    }
    if(selectedGoods[2]){
      fox.dirState = "left";  
    }
  }
  if(keyDown(RIGHT) && started){
    joe.dirState = "right";
    if(selectedGoods[0]){
      goose.dirState = "right";
    }
    if(selectedGoods[1]){
      corn.dirState = "right";  
    }
    if(selectedGoods[2]){
      fox.dirState = "right";  
    }    
  }
  if(keyDown(' ') && started){
    if(!stackGoods.isEmpty() ){
      String temp = (String)stackGoods.pop();
      if(temp =="goose"){
        selectedGoods[0] = false; 
      }
      if(temp == "corn"){
        selectedGoods[1] = false;  
      }
      if(temp == "fox"){
        selectedGoods[2] = false;
      }
    }
    dropped = true;
  }
  if(keyDown('G') && started){
    if(checkCloseness(goose.posX)){
      selectedGoods[0] = true;
      stackGoods.push("goose");
    }
  }
  if(keyDown('C') && started){
    if(checkCloseness(corn.posX)){
      selectedGoods[1] = true;
      stackGoods.push("corn");
    }
  }
  if(keyDown('F') && started){
    if(checkCloseness(fox.posX)){
      selectedGoods[2] = true;
      stackGoods.push("fox");
    }
  }
  if(!keyDown(LEFT) && !keyDown(RIGHT)){
    joe.dirState = "idling";
    goose.dirState = "idling";
    fox.dirState = "idling";
    corn.dirState = "idling";    
  }
}
