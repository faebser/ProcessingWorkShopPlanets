class Stern {
color sternColor;
float sternSizeMin, sternSizeMax, sternSize;
float x, y;
float xoff = 0.0;
color Blau;
color MischBlau;

Stern (float x, float y, color sternColor){
  this.sternColor = sternColor;
  this.x = x;
  this.y = y;
  sternSizeMin = 2;
  sternSizeMax = 15;
  Blau = color (165,251,255);
  MischBlau = lerpColor(Blau,sternColor,0.2);
  sternSize = random(sternSizeMin, sternSizeMax);
}
void update(){

}

void draw() {
  smooth();
  //sternSize = random(sternSizeMin, sternSizeMax);
  fill(MischBlau,80);//sternBlauerSchein
  ellipse(x,y,sternSize+5,sternSize+5);
  fill(MischBlau,60);
  ellipse(x,y,sternSize+10,sternSize+10);

xoff = xoff + random(0,1);
float n = noise(xoff) * 35;

  fill(sternColor);//Stern-Kern
  ellipse(x,y,sternSize,sternSize);
  stroke(sternColor,80);//GlanzLinien
  pushMatrix();
  translate(x,y);
  line(0,n,0,-n);
  line(2,n-5,2,-n-10);
  line(n,0,-n,0);
  line(n+2,-2,-n-2,-2);
  popMatrix();
  }

}
