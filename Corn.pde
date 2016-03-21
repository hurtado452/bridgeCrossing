public class Corn{
  
  PImage images;
  int posX = 650;
  int posY = 295;
  String dirState = "idling";
  //boundries
  int minX = 100;
  int maxX = 738;  
  void loadImages(){
    images = loadImage("corn.png");

  }
  void checkBorders(){
    if(posX < minX){
       corn.posX = minX;
    }
    if(posX > maxX){
       corn.posX = maxX;
    }
  }  
  void checkState(){
    if(dirState == "right"){
      posX = posX + 4;
      checkBorders();
    }
    else if(dirState == "left"){
      posX = posX - 4;
      checkBorders();
    }
    else{
      //idling do nothing  
    } 
  }
  void reset(){
    corn.posX = 650;
    dirState = "idling";
  }  
}
