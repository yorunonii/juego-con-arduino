import processing.serial.*;
Serial port;
float posicionY1;
int x=89;
int y=400;
int vel=3;
int vida=1;
int virusPos = 0;
PImage fondo;
PImage nave;
PImage viruz;
int puntaje =0;
int time;
float posX[];
float posY[];
float sensor;
int estado[];
float distancia = 0;
int escena=0;
void setup(){
size(250,500);
println(Serial.list());
port= new Serial(this,Serial.list()[0],9600);
//port= new Serial(this,"/dev/cu.usbmodem14311",9600);
fondo= loadImage ("fondo.png");
nave= loadImage ("nave.png");
viruz= loadImage ("viruz.png");
posX= new float[2];
posY= new float[2];
}
void draw(){
  background(30,50,90);
  image (fondo,0,0);
  for(int i=0;i<2;i++){
  posY [i] =posY [i] + int (random(1,10));
  }
  fill(67,8,8);
  if(escena==0){
    if(vida==1){
    image(viruz,posX[0],posY[0]);
    if(posY[0]> 450){
      puntaje++;
      posY[0]= int (random(-100, 0));
      posX[0]= int (random(50, 200));
    }
    image(viruz,posX[1],posY[1]);
    if(posY[1]> 450){
      puntaje++;
      posY[1]= int (random(-100, 0));
      posX[1]= int (random(50, 200));
    }
  }
   

  
  
   image (nave,x,y);
   interaccionTeclado();
   if(x>180){
    x=x-10;}
   if(x<-5){
    x=x+10;}
  if(y>445){
  y=y-10;}
  if(y<0){
  escena = 2;}
  fill(#0AFF06);
  textSize(25);
  text("SCORE "+puntaje,30,40);
  
  time=millis()/1000;
  text("tiempo"+time,300,30);
  
  if(port.available()>0){
  sensor=port.read();
  if(sensor == '1'){
  y= y-vel*10;
  println("aeiouaeiou");
  }
  
  }

  for(int i = 0; i<posX.length; i++){
    distancia=dist(x,y,posX[i],posY[i]);
    if(distancia <= 30){
      escena = 1;
    }
  }
  }
  if(escena==1){
    background(#FF0000);
    textSize(30);
    fill(255, 255,255);
    text("GAME OVER", 40, 225);
    
    textSize(20);
    text("SCORE:   "+puntaje, 80, 275);
  }
  if(escena==2){
    background(#0DFF99);
    textSize(30);
    fill(255, 255,255);
    text("YOU WIN", 65, 225);
    
    textSize(20);
    text("SCORE:   "+puntaje, 80, 275);
  }
}
void interaccionTeclado(){
if(keyPressed == true){
  /*if(key=='w'){
  y= y-vel;}*/
  if(key=='s'){
  y= y+vel;}
  if(key=='a'){
  x= x-vel;}
  if(key=='d'){
  x= x+vel;}
}}
