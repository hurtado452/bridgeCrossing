public class Fox{
  
  PImage[] images = new PImage[2];
  int posX = 700;
  int posY = 285;
  String dirState = "idling";
  String idlingState = "left";
  //boundries
  int minX = 100;
  int maxX = 738;
  
  void checkBorders(){
    if(posX < minX){
       fox.posX = minX;
    }
    if(posX > maxX){
       fox.posX = maxX;
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
    images[0] = loadImage("fox.png");
    images[1] = loadImage("fox_left.png");     
    
  }
  void reset(){
    fox.posX = 700;
    dirState = "idling";
    idlingState = "left";
  }  
}
