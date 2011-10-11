import processing.net.*;
import processing.opengl.*;
import ch.hyperdoc.*;

ArrayList planets, stars;
Controller dataController;
ArrayList entrys;

void setup() {
  size(screenWidth, screenHeight, OPENGL);
  dataController = new Controller(this, "10.207.240.133", 8000);
  dataController.getData();
  ArrayList tags = dataController.getTags();
  ArrayList tagsAmount = new ArrayList();
  for(int i = 0;i < tags.size(); i++) {
    tagsAmount.add(0);
  }
  entrys = dataController.getEntrys();
  
  for(int i = 0; i <= tags.size()-1; i++) {
    String testTag = (String) tags.get(i);
    for(int entryI = 0; entryI <= entrys.size()-1; entryI++) {
      Entry testEntry = (Entry)entrys.get(entryI);
      String[] testEntryTags = testEntry.getTags();
      for(int tagI = 0; tagI < testEntryTags.length; tagI++) {
        if(testTag.equals(testEntryTags[tagI])) {
          Integer value = (Integer)tagsAmount.get(i);
          tagsAmount.set(i, value+1);          
        }
      }   
    }
    println("tag : " + testTag + " -> amount: " + Integer.toString((Integer)tagsAmount.get(i)));
  }
  
  planets = new ArrayList();
  for(int i = 0; i < tags.size(); i++) {
    planets.add(new PlanetDruidia(random(width), random(height), (String)tags.get(i), (Integer)tagsAmount.get(i)));
    PlanetDruidia tempPlanet = (PlanetDruidia)planets.get(i);
    tempPlanet.setup();
  }
  
}

void draw() {
  background(0);
  for(int i = 0; i < planets.size(); i++) {
    PlanetDruidia tempPlanet = (PlanetDruidia)planets.get(i);
    tempPlanet.draw();
  }
}


