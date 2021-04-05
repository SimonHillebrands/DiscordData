import java.util.*; 
import java.lang.*; 
import java.util.Objects;

JSONObject message_data;
JSONObject message_data_totals;
JSONObject index;

JSONObject rankings;
JSONObject counts;

public int Normalize(int n, int max, int min){
  return(  (width)*(n-min)/(max-min));
}
int buttonOffset;
int rectOffset;

String[] common_words;
JSONObject[] data_objects; 
Toggle[] toggles;
Button[] buttons;
int state;
Toggle unique_words_button;
Rect[] rects;
int rect_size;
void setup(){ //<>//
  
  message_data =  loadJSONObject("message_data.json");
  message_data_totals = loadJSONObject("message_data_totals.json");
  index = loadJSONObject("messages\\index.json");
  Set keys = index.keys();
  
  data_objects = new JSONObject[keys.size()+1];
  buttons = new Button[keys.size()+1];
  buttonOffset = 0;
  rectOffset = 0;
  
    //Total word ranks and total word counts
  rankings = message_data_totals.getJSONObject("word_rankings");
  counts = message_data_totals.getJSONObject("word_counts");
  
  
  data_objects[0] = message_data_totals;
  buttons[0] = new Button(width-150,0,125,40,"All",color(125,255,125),0,data_objects[0].getInt("words")); 
  state = 0;
  
  int i1 =1;
  //Iterate through keys and create a button for each one
  for(Object key :keys){
        String value = index.get(key.toString()).toString();
        
        //Cut off the "Direct Message with" from the values
        if(value.length()>19){
          if(value.substring(0,20).equals("Direct Message with ")){
            index.setString(key.toString(),value.substring(20,value.length()));
          }
        }
    
        data_objects[i1] = message_data.getJSONObject(key.toString());
        int comp = data_objects[i1].getInt("words");

        buttons[i1] = new Button(width-150,0+(i1*45),125,40,index.get(key.toString()).toString(),color(125,255,125),i1,comp);
        i1++;
  }
  
  //JSONObject tom = message_data.getJSONObject("752615185457610869");
  //JSONObject tom_rankings = tom.getJSONObject("word_rankings");
  //JSONObject tom_counts = tom.getJSONObject("word_counts");
    
  //create a list of the most common words
  common_words = new String[250];
  for(int i =0;i<common_words.length;i++){
      common_words[i] = rankings.getString(String.valueOf(i)); 
  }

  size(1260,720);
  toggles = new Toggle[1];
  int[] colors = {color(125,255,125),color(255,125,125)};
  unique_words_button = new Toggle(width-250,0,50,20,"Unique",color(125,255,125),colors,true,0);
  toggles[0] = unique_words_button;
  
  
  rects = new Rect[250];
  rect_size = 20;
  populate_rects(0,false);
  sortButtons();

}
void populate_rects(int val,boolean New){ //<>//
  int offset = 1;
  JSONObject rankings = data_objects[val].getJSONObject("word_rankings");
  JSONObject counts = data_objects[val].getJSONObject("word_counts");
  
  int max =(int) (1.2* counts.getInt(rankings.getString(String.valueOf(1))));
  if(unique_words_button.getState()){
    while(Arrays.asList(common_words).contains(rankings.getString(String.valueOf(1+offset)))){
     offset++; 
    }
    max =(int) (1.2* counts.getInt(rankings.getString(String.valueOf(offset))));
  }
  
  for(int i = 0;i<rects.length-1;i++){
  //  try{
        
        String label = rankings.getString(String.valueOf(i+offset));
        if(label == null){
            rank(0,"",0,0,New);
          break;
        }
        int value = counts.getInt(label);
        
        rank(i,label,value,max,New);
   
  //  }catch(RuntimeException e){
  //    i--;
  //    offset++;
   // }
  }   
  
}
void rank(int i,String label,int value,int max,boolean New){
  int normValue = Normalize(value,max,1);
  if(New){
        rects[i].newRect(0,(i+1)*rect_size,normValue,rect_size,label+"\t:\t"+String.valueOf(value),i);

  }else{
    rects[i] = new Rect(0,(i+1)*rect_size,normValue,rect_size,label+"\t:\t"+String.valueOf(value),i);
  }
}
void sortButtons(){
  Arrays.sort(buttons,new SortbyTotal());
  for(int i = 0;i<buttons.length;i++){
   buttons[i].update(width-150,0+(i*45),125,40);
  }
}
void updateButtons(){
  for(int i = 0;i<buttons.length;i++){
     buttons[i].update(width-150,0+(i*45)-buttonOffset,125,40);
  }  
}
void updateRects(){
  
  for(int i = 1;i<rects.length-1;i++){
     rects[i].set_newRect(false);
     rects[i].update(0,(i)*20+rectOffset);

  }  
}
boolean pressed = false;

void draw(){ 
  background(125,125,125); //<>//

  //draw the rects
  for(int i = 0;i<rects.length-1;i++){
    rects[i].Draw();
  }
  
  for(int i = 0;i<toggles.length;i++){
    if(toggles[i].mouseOver() && pressed){
      toggles[i].update();
      populate_rects(state,false);
     // rectOffset=0;
      
      pressed = false;
    }
    toggles[i].Draw(); 
  }
  for(int i = 0;i<buttons.length;i++){
    if(buttons[i].mouseOver() && pressed){
      populate_rects(buttons[i].getValue(),true);
      state = buttons[i].getValue();
      //rectOffset = 0;
      pressed = false;
    }
    buttons[i].Draw();
  }
 pressed = false;
}
void mouseClicked() {
  pressed = !(pressed);
}
void mouseWheel(MouseEvent event){
 float e = event.getCount();
 if(mouseX>width-200){
   buttonOffset+=(int)e*30;
   updateButtons();
 }else{
   rectOffset+=(int)e*30;
   updateRects();
 }
}
