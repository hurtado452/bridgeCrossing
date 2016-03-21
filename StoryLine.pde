public class StoryLine{
  int MAX = 3;
  String[] story = { "Joe: That old bridge can only hold my weight\nand something else....",
                     "Joe: I need to get my things across but\nI don't trust that fox or goose!\n",
                     " "};
   
  String display(int timeline){
    String line="";
    for(int i=0;i<MAX;i++){
      if(i == timeline){
        line = story[i];
         return line;
      }  
    }
    return line;
  }  
  
}
