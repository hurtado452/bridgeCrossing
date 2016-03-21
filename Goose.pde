public class Goose {
  
  PImage[] images = new PImage[2];
  int posX = 600;
  int posY = 305;
  String dirState = "idling";
  String idlingState = "left";
  //boundries
  int minX = 100;
  int maxX = 738;  

  void checkBorders(){
    if(posX < minX){
       goose.posX = minX;
    }
    if(posX > maxX){
       goose.posX = maxX;
    }
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
    images[0] = loadImage("goose_right.png");
    images[1] = loadImage("goose.png"); 
  }
  void reset(){
    goose.posX = 600;
    dirState = "idling";
    idlingState = "left";
  } 
  
}
