class PlanetDruidia {
  int num;
  Ellipse e[];
  float posX, posY, planetSize;
  String tag;
  color ellipsecolor;
  ArrayList colors;

  //char[] chars = {'0','1','2','3','4','5','6','7','8','9','-','<'};
  
  PlanetDruidia(float posX, float posY, String tag, float planetSize) {
   this.posX = posX;
   num = ceil(planetSize/10);
   e = new Ellipse[num];
   this.posY = posY; 
   this.tag = tag;
   this.planetSize = planetSize;
   colors = new ArrayList();
   for(int i = 0; i < num; i++) {
   colors.add(0);
   }   
  }

  void setup() {
    //noFill();//(255,0,0,40);
    
    noSmooth();


    // textFont(createFont("Veranda",14,true,chars));
    //  textMode(SCREEN);
    
   if(tag.length() >= 3) {
    colors.set(0, color(map((int)tag.charAt(0), 95, 115, 0, 255), map((int)tag.charAt(1), 95, 115, 0, 255), map((int)tag.charAt(2), 95, 115, 0, 255) ));  
    colors.set(colors.size()-1, color(map((int)tag.charAt(tag.length()-3), 95, 115, 0, 255), map((int)tag.charAt(tag.length()-2), 95, 115, 0, 255), map((int)tag.charAt(tag.length()-1), 95, 115, 0, 255) ));  
   } else {
     colors.set(0, color(random(255), random(255), random(255)));
     colors.set(colors.size()-1, color(random(255), random(255), random(255)));
   }
   
    /*println("name: " + (String)names.get(k) + " -> anzahl: " + Integer.toString((Integer)amount.get(k)));
    println("ASCII Values ->" + Integer.toString((int)username.charAt(0)));*/
    if(colors.size() >= 3) {
      color from = (Integer)colors.get(0);
      color to = (Integer)colors.get(colors.size()-1);
      float adder = 1/(colors.size()-2);
      
      for(int i = 1; i < colors.size()-1; i++, adder+=adder) {
        colors.set(i, lerpColor(from, to, adder));
      }
    }
    
    /*colors.set(1, lerpColor(from, to, .33));
    colors.set(2, lerpColor(from, to, .66));
    colors.set(3, lerpColor(from, to, .99));  */
     
      for (int i = 0;i<num;i++)
      e[i] = new Ellipse(posX, posY, 0, i, colors, planetSize);
  }

  void draw() {
    
   //lights();
   

    //background(0);
   
    
    for (int i = 0;i<num;i++)
      e[i].draw();
    
    
  }

  class Ellipse {

    float x, y, z;
    PVector rot;
    int id;
    float dens = .2;
    float r;
    //String tags = test.getTag();
   

    float rate = 100.0;
    float speed = 0.02;
    float ellipseSize;
    int segno;
    color ellipseColor, ellipse4Color;
    ArrayList colors;
    float noise1, noise2;
    
    
  
   

    Ellipse(float _x, float _y, float _z, int _id, ArrayList theColors, float _r) {
      x=_x;
      y=_y;
      z=_z;
      r = random(_r*2, _r*2+20);
      ellipseSize= _r*2;
      id=_id;
      colors = theColors;
      segno = (int)random(40);
      rot = new PVector(random(-1, 1), random(-1, 1), random(-1, 1));
      ellipse4Color = lerpColor((Integer)colors.get(0), (Integer)colors.get(colors.size()-1), 0.5);
      ellipseColor = (Integer)colors.get(id);
      noise1 = random(-10, 40);
      noise2 = random(50, 78);
    }

    void follow() {
      x+=(mouseX-x)/(20.0);

      y+=(mouseY-y)/(20.0);
    }

    void draw() {
      //follow();
      
      noFill();
      noStroke();
      

  
      

      rot.add(
      noise((id+frameCount)/rate)*speed, 
      noise((id+noise1+frameCount)/rate)*speed, 
      noise((id+noise2+frameCount)/rate)*speed
        );

      pushMatrix();
      translate(x, y, z);
 
      

      pushMatrix();
      rotateX(rot.x);
      rotateY(rot.y);
      rotateZ(rot.z);

      int cnt = 0;

      beginShape();
      for (float f = -PI;f<PI;f+=dens) {
        float X = cos(f)*r;
        float Y = sin(f)*r;


        if (abs(cnt-segno)<5) {
          // pushStyle();
          // fill(255,map(modelZ(X,Y,0),-r,r,0,255));
          // text("<-"+segno,modelX(X,Y,0),modelY(X,Y,0));
          // popStyle();
          stroke(ellipseColor, map(modelZ(X, Y, 0), -r, r, 1, 180-abs(cnt-segno)*30));
        }
        else {
          stroke(ellipseColor, map(modelZ(X, Y, 0), -r, r, 1, 60));
        }

        strokeWeight(map(modelZ(X, Y, 0), -r, r, 5, 1.8));

        vertex(X, Y, 0);
        cnt++;
      }
      endShape(CLOSE);

      if (frameCount%2==0)
        segno++;
      if (segno>=cnt) {
        segno=0;
      }
      /*
                cnt = 0;
       for(float f = -PI;f<PI;f+=dens){
       if(cnt==segno){
       stroke(#ff0000,map(modelZ(X,Y,0),-r,r,0,200)); 
       float X = cos(f)*r;
       float Y = sin(f)*r;
       strokeWeight(map(modelZ(X,Y,0),-r,r,5,1.8));
       line(X,Y,lerp(X,0,0.1),lerp(Y,0,0.1));
       }
       cnt++;
       }
       */
      popMatrix();
      popMatrix();
      
      pushMatrix();
      translate(x, y);
      noStroke();
      //fill((Integer)colors.get(0));
      fill(ellipse4Color);
     
      ellipse(0,0,ellipseSize, ellipseSize); 
      
      
      //noFill();

  popMatrix();
    }
  }
}

