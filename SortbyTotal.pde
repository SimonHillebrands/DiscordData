class SortbyTotal implements Comparator<Button>{
  public int compare(Button a, Button b){
     return b.comp - a.comp; 
  }
}
