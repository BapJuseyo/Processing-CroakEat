/* Cette classe permet de créer les 'criquets' qui seront manger par "l'oeil 
de la grenouille" (representé par la classe MyBall) */
class Criquet {
  // initialisation des paramètres initiaux d'un objet Ball
  float x;
  float y;
  float speedX;
  float speedY;
  float a = 1;
  float b = 1;
  float diameter;
  color c;
  boolean alive;
  AudioSample sound;
  
  // Constructeur
  Criquet(float tempX, float tempY, float tempDiameter) {
    x = tempX;
    y = tempY;
    diameter = tempDiameter;
    
    int random_x = round(random(0,1));
    if (random_x == 1) {
      speedX = random(-2,2);
      speedY = 2; }
    else {
      speedX = 2;
      speedY = random(-2,2);}
    
    a = random(0,2);
    b = random(0,2);
    c = (225); 
    alive = true;
    sound = minim.loadSample("chirp.mp3");
  }
  
  // Méthode qui permet de déplacer l'objet en modifiant ses coordonées 
  // et de modifier son diametre de facon aleatoire au cours de la trajectoire
  void move() {
    y = y + a*speedY;
    x = x + b*speedX;
      // modification du diametre de l'objet de façon aléatoire
    if (round(random(0,10)) > 9) this.changeDiameter();
  }
  
  // Méthode qui permet d'afficher l'objet 
  void display() {
    fill(c); 
    strokeWeight(2);
    ellipse(x,y,diameter,diameter); //draw a circle
  }
  
  // Méthode qui permet de modifier la couleur de l'objet
  void changeColor(){
    int r = int(random(0,255));
    int b = int(random(0,255));
    int g = int(random(0,255));
    if (alive){
      this.c = color(r, g, b);
    } else {
      this.c = color(0, 0, 0);
    }
  }
  
  // Méthode qui permet de modifier le diamètre de l'objet
  void changeDiameter(){
    this.diameter = random(20, 40);
  }
  
  // Méthodes qui permettent de déterminer les limites de l'objet en en retournant
  // l'emplacement de ses bords (x et y etant le centre de l'objet)
  float left_limit(){
    return x-diameter/2;
  }
  float right_limit(){
    return x+diameter/2;
  }
  float top_limit(){
    return y-diameter/2;
  }
  float bottom_limit(){
    return y+diameter/2;
  }
  
  // Méthode qui permet de modifier les caractéristiques du criquet en fonction de 
  // sa position
  void checkPosition(){
        // si le criquet touche les bords de l'ecran de l'application, il change 
        // de comportement
  if (this.right_limit() > width) { 
    this.speedX = -this.speedX;
        // changement de couleur et de diametre
    this.changeColor();
    this.changeDiameter();
        // le criquet stridule
    this.sound.trigger();
  }
  
  if (this.left_limit() < 0) {
    this.speedX = -this.speedX;
    this.changeColor();
    this.changeDiameter();
    this.sound.trigger();
  }

  if (this.bottom_limit() > height) {
    this.speedY = -this.speedY;
    this.changeColor();
    this.changeDiameter();
    this.sound.trigger();
  }

  if (this.top_limit() < 0) {
    this.y = (this.diameter/2 + 20);
    this.speedY = -this.speedY;
    this.changeColor();
    this.changeDiameter();
    this.sound.trigger();
  }
}


}
