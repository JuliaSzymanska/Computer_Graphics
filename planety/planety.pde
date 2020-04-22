PShape s,c, ca, ca1, ship;
PImage bg;

void setup() {
  size(1600, 900, P3D);
  noStroke();
  s = loadShape("teapot.obj");  
  c = loadShape("cube.obj"); 
  ca = loadShape("capsule.obj"); 
  ca1 = loadShape("capsule_1.obj"); 
  ship = loadShape("SpaceShip.obj");
  bg = loadImage("background.jpg");
}

//----------------------------STEROWANIE:---------------------------------------
// Ruch myszki odpowiada ruchom statku(kamery) w prawo/lewo oraz góre/dól
// By oddalić/ przybliżyć należy przytrzymać prawy/lewy klawisz myszy
// Spacja opwoduje odpalenie broni
// Naciśnięcie klawisza 'M' zmienia sposób sterowania z myszy na klawiaturę
//Gdzie odpowiednio klawisze D/A, W/S, E/Q dla ruchu prawo/lewo, góra/dół, przód/tył
//Klawisze +/= dodają i odejmują orbity
//Klawisz O przełącza w tryb sterowania statkiem przy nieruchomym obserwatorze


float viewX = 0, viewY = 0, scaleM = 10, time = 0.f;
int R = 0, G = 0, B = 0, moveX = 0, moveY = 0, moveZ = 0, cameraX = 0, cameraY = 0, cameraZ = 0;
boolean zoom = false, orbit = false, mouse = true, pressedX_right = false, pressedX_left = false, pressedY_down = false, pressedY_up = false, pressedZ_in = false, pressedZ_out = false, weapon = false,
observer = true, first = true, pilot = false, landing = false, observer_available = true;
int k = 0, i = 0;
void draw()
{
  background(bg);
  lights();
  translate(width *0.5f, height *0.5f);
  
  if(mousePressed && mouseButton == LEFT && observer_available == true){
   moveZ += 10; 
  }
  else if(mousePressed && mouseButton == RIGHT && observer_available == true){
   moveZ -= 10; 
  }
  if(mouse == true && observer_available == true){
    moveX = -mouseX + 810;
    moveY = -mouseY + 400;
  }
  else if(observer_available == true){
    if(pressedX_right){
      moveX += 10;
    }
    else if(pressedX_left){
      moveX -= 10;
    }
    if(pressedY_up){
      moveY += 10;
    }
    else if(pressedY_down){
      moveY -= 10;
    }
    if(pressedZ_in){
      moveZ += 10;
    }
    else if(pressedZ_out){
      moveZ -= 10;
    }
  }
    //scale(0.005);
    //shape(ship,0,0);
    //fill(38,255,241);
    //sphere(50);
    //popMatrix();
  //}
  
  //Płaszczyzna z rzucanymi smugami światła
 // translate(0,0,-800);
 // fill(90,70,90);
 // spotLight(R, G, B, 0, -400, 400, 0, 0, -1, PI/3, 7.5);
 // int dim = 20;
 // for (int i = -width/2; i < 1.5* width + 220; i += dim) {
 // for (int j = -width/2; j < 1.5* width + 220; j += dim) {
 //  pushMatrix();
 //   translate(i - width *0.5f - 100, j - height *0.5f, 0);
 //   box(dim, dim, 1);
 //  popMatrix();
 // }
 //}
 // translate(0, 0, 800); 
  
  scale(scaleM);
  
  if(landing == false && pilot == true){
    if(moveX < 0){
      moveX += 5;
    }
    else if(moveX > 0){
      moveX -= 5;
    }
    if(moveY + 120 < 0 ){
      moveY += 5;
    }
    else if(moveY + 120 > 0){
      moveY -= 5;
    }
    if(moveZ + 1500 < 0){
      moveZ += 5;
    }
    else if(moveZ + 1500 > 0){
      moveZ -= 5;
    }
    if(moveX < 6 && moveX > -6 && moveY + 120 < 6 && moveY + 120 > -6 && moveZ + 1500 < 6 && moveZ + 1500 > -6)
    landing = true;
  }
  
  //SpaceShip
  translate(0,300,1800);
  scale(0.01);
  if(observer == true && landing == false){
    first = true;
  camera(moveX,moveY - 100,(height/2 + moveZ) / tan(PI/6) + 1200, moveX,moveY-300,(height/2 + moveZ) / tan(PI/6), 0,1,0);}
  //else if (landing == false){
  else{
    if(first == true){
      first = false;
      cameraX = moveX;
      cameraY = moveY;
      cameraZ = moveZ;
    }
    camera(cameraX,cameraY - 100,(height/2 + cameraZ) / tan(PI/6) + 1200, cameraX,cameraY-300,(height/2 + cameraZ) / tan(PI/6), 0,1,0);
  }
  translate(moveX, moveY, ((height/2 + (moveZ)) / tan(PI/6)));
  //else{
  //  pushMatrix();
  //  rotateY(-HALF_PI*0.5);
  //  rotateX(-HALF_PI*0.91);
  //  scale(100);
  //  translate(-17, 7);
  //  rotate(8*time);
  //  scale(0.01);
  //  popMatrix();  
  //}
  
  line(30, 20, 20, 2000, 2000, 2000);
  rotateY(PI);
  spotLight(255, 255, 255, 0, 100, -50, 0, 0, 10, 5, 0);
  if(landing == false){
    pushMatrix();
    scale(0.5);
    shape(ship,0,0);
    fill(38,255,241);
    sphere(50);
    popMatrix();
  }
  //else if(landing == false){
  //  pushMatrix();
  //  //translate(moveX, moveY, ((height/2 + (moveZ)) / tan(PI/6)));
  //  if(moveX < 0){
  //    translate(10, 0 ,0);
  //    moveX += 10;
  //  }
  //  else if(moveX > 0){
  //    translate(-10, 0 ,0);
  //    moveX -= 10;
  //  }
  //  if(moveY < 0){
  //    translate(0, 10 ,0);
  //    moveY += 10;
  //  }
  //  else if(moveY > 0){
  //    translate(0, -10 ,0);
  //    moveY -= 10;
  //  }
  //  if(moveZ < 0){
  //    translate(0, 0 ,10);
  //    moveZ += 10;
  //  }
  //  else if(moveZ > 0){
  //    translate(0, 0 ,-10);
  //    moveZ -= 10;
  //  }
  //  if(moveX < 11 && moveX > -11 && moveY < 11 && moveY > -11 && moveZ < 11 && moveZ > -11)
  //  landing = true;
  //  scale(0.005);
  //  shape(ship,0,0);
  //  fill(38,255,241);
  //  sphere(50);
  //  popMatrix();
  //}
  
  if(weapon == true){
  fill(243,116,42);
    translate(60,-(50 + i), k);
    sphere(30);
    translate(-60,50 + i, -k );
    translate(-60,-(50 + i), k);
    sphere(30);
    translate(60,50 + i, -k );
    k += 50;
    i += 10;
    if(i > 350){
      weapon = false;
      i = 0;
      k = 0;
    }
  }
  
  rotateY(PI);
  translate(0,-100*0.025,-1800*0.025);
  translate(-moveX, -moveY,  -((height/2 + (moveZ)) / tan(PI/6)));
  scale(100);
  
  //Sun
  pushMatrix();
  spotLight(255,0,0, 0,0,0, width *0.5f,height *0.5f,0, 5,0);
  fill(255,0,0);
  rotate(3*time);
  lightSpecular(255, 0, 0);
  emissive(0, 26, 20);
  specular(255, 0, 0);
  shininess(1.0);
  sphere(1);
  
  //1. planet
  popMatrix();
  pushMatrix();
  rotateY(HALF_PI*0.5);
  rotateX(HALF_PI*0.5);
  if(orbit == true){
    drawOrbits(3);
  }
  rotate(5*time);
  translate(-3, 0);
  specular(255,0,0);
  scale(0.6);
  shape(ca,0,0);
  drawMoon1();
  
  //2. planet
  popMatrix();
  pushMatrix();
  rotateX(-HALF_PI*0.5);
  rotateY(HALF_PI*0.25);
  if(orbit == true){
    drawOrbits(7);
  }
  rotate(6*time);
  specular(255,0,100);
  translate(-7, -3, -0.5);
  scale(1);
  shape(c,0,0);
  
  //1.moon of the 2. planet
  rotateZ(3.2*time);
  rotate(1.8*time);
  translate(-2, 0);
  scale(0.35);
  fill(127,255,212);
  sphere(1);
  
  //3. planet
  popMatrix();
  pushMatrix();
  rotateY(PI*0.39);
  rotateX(-PI*0.67);
  rotateZ(-PI*0.67);
  if(orbit == true){
    drawOrbits(12);
  }
  rotate(5*time);
  translate(-11, 5);
  scale(0.9);
  shape(ca1,0,0);
  drawMoon3();
  
  //4. planet
  spotLight(0,0,255, 0, 0, 0, 0,-100,0, 100,1);
  popMatrix();
  rotateY(-HALF_PI*0.5);
  rotateX(-HALF_PI*0.91);
  if(orbit == true){
    drawOrbits(19);
  }
  rotate(8*time);
  translate(-17, 7);
  scale(0.9);
  pushMatrix();
  if(pilot == true && landing == true){
    rotateZ(PI);
    rotateZ(-HALF_PI/2);
    rotateX(HALF_PI);
    rotateY(HALF_PI);
    scale(0.005);
    translate(-200,-400);
    //camera(0,0 - 100,(height/2 + 0) / tan(PI/6) + 1200, 0,-300,(height/2 + 0) / tan(PI/6), 0,1,0);
    shape(ship,0,0);
    observer = true;
  }
  popMatrix();
  //camera(0,0,(height/2 + 0) / tan(PI/6), 0,0,(height/2 + 0) / tan(PI/6), 0,1,0);
  shape(s,0,0);
  drawMoon4();
  time += .004f;
}


void drawMoon1(){
 //1. moon of the 1. planet
 pushMatrix();
 rotateZ(5*time);
 rotateX(3.5*time);
 translate(-2, -3);
 scale(0.01);
 shape(c,0,2); 
  
  
 //2. moon of the 1. planet
 popMatrix();
 rotateY(5*time);
 rotateZ(3.5*time);
 translate(-2.8, 2);
 scale(0.5);
 fill(150,180,200);
 sphere(1);
}

void drawMoon3(){
  //1. moon of the 3. planet
  pushMatrix();
  rotateY(2*time);
  rotateX(1.5*time);
  translate(-2, -3);
  scale(0.5);
  shape(ca,0,0);
  
  
 //2. moon of the 3. planet
 popMatrix();
 rotateY(5*time);
 rotateX(2*time);
 translate(-4, -3);
 scale(0.3);
 fill(244,164,96);
 box(2,2,2);
}

void drawMoon4(){
 //1. moon of the 4. planet
 pushMatrix();
 rotateY(5*time);
 rotateX(3.5*time);
 translate(-3.5, 4);
 scale(0.7);
 fill(154,205,50);
 sphere(1);
  
  
 //2.moon of the 4. planet
 popMatrix();
 pushMatrix();
 rotateY(1*time);
 rotateX(3.1*time);
 translate(-3, -5);
 scale(0.6);
 fill(25,169,79);
 sphere(1);
  
 //3. moon of the 4. planet
 popMatrix();
 pushMatrix();
 rotateY(3.5*time);
 rotateX(3*time);
 translate(-6, -7);
 scale(0.5);
 fill(240,128,128);
 box(2,2,2);
  
  //4. moon of the 4. planety
 popMatrix();
 rotateY(0.8*time);
 rotateX(0.9*time);
 translate(-1.5, 8);
 scale(0.8);
 fill(255,160,122);
 sphere(1);
}

void drawOrbits(float radius){
  stroke(255);
  strokeWeight(0.02f);
  noFill();
  circle(0,0,2*radius);
  noStroke();
}  

void keyPressed(){
 //if(key != CODED && keyCode == 'Z' && zoom == false){
 //  scaleM = 0.75 * scaleM;
 //  zoom = true;
 //} else if (key != CODED && keyCode == 'Z' && zoom == true){
 //  scaleM = 4 * scaleM / 3;
 //  zoom = false;
 //}
 if(key == '=' && orbit == false){
   draw();
   orbit = true;
 } else if (key == '-' && orbit == true){
   draw();
   orbit = false;
 }
 //if(key != CODED && keyCode == 'R' && R == 0){
 //  R = 255;
 //} else if (key != CODED && keyCode == 'R' && R == 255){
 //  R = 0;
 //}
 //if(key != CODED && keyCode == 'G' && G == 0){
 //  G = 255;
 //} else if (key != CODED && keyCode == 'G' && G == 255){
 //  G = 0;
 //}
 //if(key != CODED && keyCode == 'B' && B == 0){
 //  B = 255;
 //} else if (key != CODED && keyCode == 'B' && B == 255){
 //  B = 0;
 //}
 if(key != CODED && keyCode == 'M'){
   mouse = !mouse;
 }
 if(key != CODED && keyCode == 'D' && mouse == false){
   pressedX_right = !pressedX_right;
   pressedX_left = false;
 }
 if(key != CODED && keyCode == 'A' && mouse == false){
   pressedX_left = !pressedX_left;
   pressedX_right = false;
 }
 if(key != CODED && keyCode == 'W' && mouse == false){
   pressedY_up = !pressedY_up;
   pressedY_down = false;
 }
 if(key != CODED && keyCode == 'S' && mouse == false){
   pressedY_down = !pressedY_down;
   pressedY_up = false;
 }
 if(key != CODED && keyCode == 'Q' && mouse == false){
   pressedZ_in = !pressedZ_in;
   pressedZ_out = false;
 }
 if(key != CODED && keyCode == 'E' && mouse == false){
   pressedZ_out = !pressedZ_out;
   pressedZ_in = false;
 }
 if(key != CODED && keyCode == ' '){
   weapon = true;
 }
 if(key != CODED && keyCode == 'O'){
   observer = !observer;
 }
 if(key != CODED && keyCode == 'P'){
   pilot = !pilot;
   landing = false;
   observer_available = false;
   observer = true;
   if(pilot == false){
     observer_available = true;
   }
 }
}
