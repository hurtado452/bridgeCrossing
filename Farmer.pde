public class Farmer{

  PImage[] images = new PImage[2];
  int posX = 525;
  int posY = 275;
  String dirState = "idling";
  String idlingState = "left";
  //boundries
  int minX = 75;
  int maxX = 738;  

  void checkBorders(){
    if(posX < minX){
       joe.posX = minX;
    }
    if(posX > maxX){
       joe.posX = maxX;
    }
  }
  boolean bridgeBreak(){
    if(posX > 261 && posX < 341){
      return true;
    }
    return false;
  }
  void checkState(){
    if(dirState == "right"){
      posX = posX + 4;
      checkBorders();
      idlingState = "right";
    }
    else if(dirState == "left"){
      posX = posX - 4;
      checkBorders();
      idlingState = "left";
    }
    else{
      //idling do nothing  
    }
    
    
  }
  void loadImages(){
    images[0] = loadImage("farmer_left.png");
    images[1] = loadImage("farmer_right.png");  
  }
  void reset(){
    joe.posX = 525;
    dirState = "idling";
    idlingState = "left";
  }
}
