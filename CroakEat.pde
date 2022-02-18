/*
CROAK EAT !
Projet MUX101 de Louise Barreau
*/
import ddf.minim.*;
Minim minim;
AudioSample frog_sound;

// Paramètres du jeux :
int criquets_number = 15;
StartButton start; // bouton play
int remaining_criquets; // nombre de criquets restants
boolean end_game = false;

// Initialisation des criquets et de la grenouille
Criquet[] criquets = new Criquet[criquets_number]; 
MyFrog myFrog = new MyFrog();


// Definition des étapes de jeux :
int game_stage;
int BEGINNING = 1; // debut du jeu
int IN_PROCESS = 2; // jeu en cours
int END = 3; // fin du jeu



void setup(){
  
   criquets = new Criquet[criquets_number]; 
   myFrog = new MyFrog();
   end_game = false;

   deltaTime =5000;

   size(800,600);
   background(0);
   smooth();
   minim = new Minim(this);
   game_stage = 1;
   
   if (end_game == false){ 
        for (int i=0;i<criquets.length;i++) criquets[i] = new Criquet(400,300,50);
    }
    start = new StartButton(300, 300);
    frog_sound = minim.loadSample("croak.mp3");
}

void draw(){
  smooth();
  
  boolean WINNER = (myFrog.hit_number == criquets_number);
  boolean LOSER = (myFrog.hit_number == -1);
  
  int time = millis();
  
  if (game_stage == BEGINNING || game_stage == END){ 
    setup();
    if (WINNER || LOSER){ // si le joueur a gagné ou perdu, 
    // on patiente quelques secondes avant de retourner à la page principale
      while ( millis() < time + 3000){ 
        StartPage(); } }
    else {
      StartPage(); }
  }
  
  /* ANIMATION */
  if (game_stage == IN_PROCESS){ 
    background(0);
    // afficher la grenouille
    myFrog.display();
    
    // pour chaque criquet
    for (int i=0;i<criquets.length;i++){
       if (criquets[i].alive){ // si le criquet est vivant
           criquets[i].move(); // il bouge
           criquets[i].display(); // on peut le voir
           criquets[i].checkPosition(); // s'il rencontre un bord de l'ecran, il stridule
           
          boolean MY_FROG_IS_BIGGER = myFrog.diameter > criquets[i].diameter;
          float distance_with_myball = checkDistance(criquets[i], myFrog);
          
          // Lorsque la grenouille rencontre un criquet...
          if (distance_with_myball < myFrog.diameter) {
             if (MY_FROG_IS_BIGGER){ // si elle est plus grosse que sa proie:
                myFrog.changeDiameter(criquets[i].diameter); // elle grossit
                frog_sound.trigger() ; // elle emet un son : croak !
                criquets[i].alive = false; // le criquet disparait
                myFrog.hit_number += 1; } // son tableau de chasse prend un point
             else {
                myFrog.hit_number = -1; } // si elle est plus petite que sa proie, elle meurt d'indigestion
           }
       }
    }  
    
    // Cinématique de jeux en fonction du nombre de criquets restants
    if (WINNER){ // si la grenouille a mangé tous les criquets, le joueur gagne
        end_game = true;
        background(0);
        write_texte("WINNER !", 150, 300, 255, 128);
        game_stage = 3;}
    else if (LOSER){ // si la grenouille s'est ettoufé avec un plus gros criquet, le joueur perd
        end_game = true; 
        background(0);
        write_texte("GAME OVER !", 150, 300, 255, 100);
        game_stage = 3; } 
    else { // sinon on affiche juste le nombre de criquets restants
        remaining_criquets = criquets_number - myFrog.hit_number;
        write_texte("Number of remaining criquets: " + remaining_criquets, 20, 20, 255, 15); }
  }
}

// fonction qui verifie la distance entre 2 objets
float checkDistance(Criquet criquet, MyFrog myFrog){
      float distance = new PVector(myFrog.x, myFrog.y).dist(new PVector(criquet.x, criquet.y));
      return distance;
}

// fonction qui permet d'ecrire et de styliser (taille, couleur) du texte
void write_texte(String text, float x, float y, color c, float size){
     textSize(size);
     fill(c);
     text(text, x, y);
}

// fonction qui permet d'afficher la page de lancement du jeu
void StartPage(){
    background(0);
    textSize(80);
    write_texte("CROAK EAT", 220, 280, 255, 80); 
    start.display(); // affichage du bouton PLAY
}

// fonction qui permet de faire bouger l'oeil de la grenouille
void mouseMoved() {
    start.rollover(mouseX,mouseY);
}

// fonction qui permet de cliquer sur le bouton
void mousePressed() {
    start.clic();
}
