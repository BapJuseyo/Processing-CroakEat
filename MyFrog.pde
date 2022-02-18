/* Cette classe permet de créer l'oeil de la grenouille (représentée par une balle) que
l'utilisateur pourra diriger avec la souris afin d'aller "manger" les criquets */
class MyFrog {
  // caractéristiques de l'objet
  float x;
  float y;
  float ease;
  float diameter;
  color c;
  int hit_number;
  
  // Constructeur qui définit les paramètres initiaux de la balle lors de sa création
  MyFrog() {
    // coordonnées x et y
    x = 0;
    y = 0;
    // vitesse de suivi de la balle
    ease = 0.01;
    // caractéristiques initiales de la balle
    diameter = 30;
    c = (225);
    hit_number = 0;
  }
  
  // méthode qui permet d'afficher l'objet
  void display() {
    // recuperation dynamique des coordonnées de l'objet
    this.x += (mouseX - x)*ease;
    this.y += (mouseY - y)*ease;
    if (end_game == true){
       this.x = 268;
       this.y = 180;
    }
    // affichage de l'objet
    fill(c); 
    ellipse(this.x,this.y,diameter,diameter);  // 1er cercle
    fill(0); 
    strokeWeight(4); 
    ellipse(this.x,this.y,diameter/2,diameter/2); // 2nd cercle
  }
  
  // méthode qui permet de modifier le diamètre de l'objet
  void changeDiameter(float diameter){
    this.diameter += diameter/10;
  }
  
  // méthodes qui permettent de déterminer les limites de l'objet en en retournant
  // l'emplacement de ses bords (x et y etant le centre de l'objet)
  float left(){
    return x-diameter/2;
  }
  float right(){
    return x+diameter/2;
  }
  float top(){
    return y-diameter/2;
  }
  float bottom(){
    return y+diameter/2;
  }
}
