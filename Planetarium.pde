PImage image;
PImage shipTexture;
PImage sunTexture;
float[] desp = {0.5,1,0.75,1.2,0.8,1,2};
float[] distanceX = {1,1.8,2.3,3,3.6,5.5,0.5};
float[] inverseTimes = {1,5,8,3.8,12,5,15};
float[] ang = {0,0,0,0,0,0,0};
float sunSize = 60;
String[] names = {"Sun","Mercury", "Venus", "Earth", "Mars", "Jupiter"};
int[] colorFirstComponent = {255,65,249,45,254,191,144};
int[] colorSecondComponent = {111,79,72,80,162,162,130};
int[] colorThirdComponent = {0,186,59,235,122,122,130};
PShape ship;
int xShipCoordinate = width/2;
int yShipCoordinate = 1000;
int zShipCoordinate = 0;
float rotationX = 0;
float rotationY = 0;
float rotationZ = 0;


void setup(){
  size(1000, 683, P3D);
  stroke(0);
  imageMode(CENTER);
  image = loadImage("background.jpg");
  ship = loadShape("Quarren Coyote Ship.obj");
  shipTexture = loadImage("shipTexture.jpg");
  ship.setTexture(shipTexture);
}

void draw(){
  background(image);
  translate(width/2, height/2,0);
  rotateX(radians(-10));
  pushMatrix();
  drawSun();
  drawPlanets();
  popMatrix();
  showShip();
}

void drawSun(){
  
  ang[0] = ang[0] + desp[0];
  pushMatrix();
  fill(colorFirstComponent[0],colorSecondComponent[0],colorThirdComponent[0]);
  stroke(colorFirstComponent[0],colorSecondComponent[0],colorThirdComponent[0]);
  drawName(32,names[0]);
  rotateY(radians(ang[0]));
  sphere(sunSize);
  texture(sunTexture);
  popMatrix();
  
  ang[0] = ang[0] + desp[0];
}

void drawName(int size, String name){
  pushMatrix();
  textSize(size);
  translate(-30,-100);
  text(name, 10, 30); 
  popMatrix();
}

void drawPlanets(){
  for (int i = 1; i <= 5; i++){
    drawPlanet(i);
  }
}

void drawPlanet(int i ){
  ang[i] = ang[i] + desp[i];
  pushMatrix();
  rotateY(radians(ang[i]));
  translate(-sunSize*distanceX[i],0,0);
  fill(colorFirstComponent[i],colorSecondComponent[i],colorThirdComponent[i]);
  stroke(colorFirstComponent[i],colorSecondComponent[i],colorThirdComponent[i]);
  sphere(sunSize/inverseTimes[i]);
  rotateY(-radians(ang[i]));
  drawName(14,names[i]);
  if (i == 5) drawSatellite();
  rotateX(radians(-30));
  popMatrix();
}

void drawSatellite() {
  ang[6] = ang[6] + desp[6];
  pushMatrix();
  rotateX(radians(ang[6]));
  translate(0,-sunSize*distanceX[6],-sunSize*distanceX[6]);
  fill(colorFirstComponent[6],colorSecondComponent[6],colorThirdComponent[6]);
  stroke(colorFirstComponent[6],colorSecondComponent[6],colorThirdComponent[6]);
  sphere(sunSize/inverseTimes[6]);
  rotateY(-radians(ang[6]));
  rotateX(radians(-30));
  popMatrix();
}

void showShip() {
  pushMatrix();
  scale(0.17);
  rotateX(PI);
  moveShip();
  translate(xShipCoordinate, yShipCoordinate, zShipCoordinate);
  rotateY(rotationY);
  rotateZ(rotationZ);
  rotateX(rotationX);
  shape(ship);
  popMatrix();
}

void moveShip() {
  if (keyPressed) {
    if (key == 'w') {
      yShipCoordinate += 25;
    } else if (key == 's') {
      yShipCoordinate -= 25;
    } else if (key == 'd') {
      xShipCoordinate += 25;
    } else if (key == 'a') {
      xShipCoordinate -= 25;
    } else if (key == 'r') {
      zShipCoordinate += 25;
    } else if (key == 'f') {
      zShipCoordinate -= 25;
    } else if (key == '2') {
      rotationX += 0.25;
    } else if (key == '8') {
      rotationX  -= 0.25;
    } else if (key == '9') {
      rotationY += 0.25;
    } else if (key == '7') {
      rotationY  -= 0.25;
    } else if (key == '4') {
      rotationZ += 0.25;
    } else if (key == '6') {
      rotationZ  -= 0.25;
    }
  }
}
