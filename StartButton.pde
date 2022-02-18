class StartButton {
  //boolean selected = false; 
  boolean rollover = false; 
  float x,y;

  StartButton(float Px, float Py) {
    x = Px;
    y = Py;
  }

  void display() {
    stroke(255);noFill();
    if (rollover) strokeWeight(5);
    else strokeWeight(2);
    textSize(50);
    text("PLAY", 350, 342);
    rect(x,y,200,50);
 }

  void rollover(int mx, int my) {
    if (mx > x && mx < x + 200 && my > y && my < y + 50){ 
      rollover = true;
    }else{
      rollover = false;}
  }

  void clic() {
    if (rollover) {
      game_stage = 2;
      end_game = false;
      if (end_game == false){ 
        for (int i=0;i<criquets.length;i++) criquets[i] = new Criquet(400,300,50);}
     }
  }
 
}
