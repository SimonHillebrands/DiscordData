public class Rect{
  public int x,y,w,h,nx,ny,nw,nh;
  public color c;
  public color[] color_array;
  public String label;
  public int value;
  public int comp;
  private boolean newRects;
  public Rect(int x,int y,int w,int h,String l,int c){
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    label = l;
    this.c = c;
    newRects = false;
  }
  public Rect(int x,int y,int w,int h,String l,int c,int value,int comp){
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    label = l;
    this.value = value;
    this.c = c;
    this.comp = comp; 
        newRects = false;

  }
  public Rect(int x,int y,int w,int h,String l,int c,int[] color_array,int value,int comp){
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    label = l;
    this.value = value;
    this.c = c;
    this.color_array = color_array;
    this.comp = comp;
    newRects = false;

  }
  public int getValue(){
   return this.value; 
  }
  public void newRect(int x,int y,int w,int h,String l,int v){
    this.nx = x;
    this.ny = y;
    this.nw = w;
    this.nh = h;
    label = l;
    value = v;
    newRects = true;
  }
  public void update(int x, int y){
    this.x = x;
    this.y = y;    
  }

  public void Draw(){
    fill(125,255,125);
    rect(x,y,w,h);
    fill(255,255,255);
    label = label.replace("\"","");
    label = label.replace("Direct Message","DM");
    fill(0,0,0);
    //text(label + ":     "+value,5,y-(h/2)+2);
    text(label,x+5,y+(h/2)+5);
    if(newRects){
      for(int i = 0;i<10;i++){
          inc();
      }
    }
  }
  public int compare(int n1,int n2){
    if(n1>n2)
      return 1;
    if(n1<n2)
      return -1;
    else
      return 0;
  }
  public int get_y(){
   return this.y; 
  }
  public boolean get_new(){
   return this.newRects; 
  }
  public int[] get_vals(){
    return new int[]{x,nx,y,ny,w,nw,h,nh};
  }
  public void set_newRect(boolean bool){
    this.newRects=bool;
  }
  public void inc(){
    int s = 1;
    if(compare(x,nx) == 1)
      x-=s;
    else if(compare(x,nx) == -1)
      x+=s;
    if(compare(y,ny) == 1)
      y-=s;
    else if(compare(y,ny) == -1)
      y+=s;
    if(compare(w,nw) == 1)
      w-=s;
    else if(compare(w,nw) == -1)
      w+=s;
    if(compare(h,nh) == 1)
      h-=s;
    else if(compare(h,nh) == -1)
      h+=s;
     
    if(compare(x,nx) == 0 && compare(y,ny) == 0 && compare(w,nw) == 0 && compare(h,nh) == 0){
      newRects = false;
    }
  }
}
