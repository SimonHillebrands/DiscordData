public class Button extends Rect{
  public boolean mouseOver;
  Button(int x,int y,int w,int h,String l,color c,int[] c_a,int v,int comp){
     super(x,y,w,h,l,c,c_a,v,comp); 
  }
  Button(int x,int y,int w,int h,String l,color c,int v,int comp){
     super(x,y,w,h,l,c,v,comp); 
  }
 public boolean mouseOver(){
  if (mouseX >= x && mouseX <= x+w && mouseY >= y && mouseY <= y+h) {
    return true;
  } else {
    return false;
  }
 }
 public void update(int x, int y, int w, int h){
   this.x = x;
   this.y = y;
   this.w = w;
   this.h = h;
 }
  public void Draw(){
    if(mouseOver()){
      float r =red(c);
      float g = green(c);
      float b = blue(c);
      int brightness = 0;
      if(mousePressed)
      {
         brightness = -75; 
      }else{
         brightness = -25;
      }
      r+=brightness;
      g+=brightness;
      b+=brightness;
      fill(r,g,b);
    }else{
    fill(c);
    }
    rect(x,y,w,h,7);
    fill(0,0,0);
    text(label,x+5,y+(h/2)+5);
  }
  
}
