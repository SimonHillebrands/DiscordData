public class Toggle extends Button{
    boolean value;
    Toggle(int x,int y,int w,int h,String l,color c,int[] c_a,boolean v,int comp){
     super(x,y,w,h,l,c,c_a,0,comp); 
     this.value = v;
  }
   public boolean getState(){
      return this.value; 
   }
   public void update(){
      this.value = !(this.value); 
   }
  public void Draw(){
    if(this.value)
      this.c = this.color_array[0];
    else
      this.c = this.color_array[1];
    
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
