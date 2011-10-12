import processing.net.*;
import processing.opengl.*;
import ch.hyperdoc.*;

ArrayList planets, stars, displayedStars;
Controller dataController;
ArrayList entrys;

void setup() {
  size(screenWidth, screenHeight, OPENGL);
  dataController = new Controller(this, true);
  dataController.getData();
  ArrayList tags = dataController.getTags();
  ArrayList tagsAmount = new ArrayList();
  displayedStars = new ArrayList();
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
    ArrayList tempTag = new ArrayList();
    tempTag.add((String)tags.get(i));
    pushMatrix(random(width), random(height));
    planets.add(new PlanetDruidia(0, 0, (String)tempTag.get(0), (Integer)tagsAmount.get(i)));
    PlanetDruidia tempPlanet = (PlanetDruidia)planets.get(i);
    
    ArrayList tempStars = controller.getEntryswithTags(tempTag, entrys);
    for(int starI = 0; starI < tempStars.size(); starI++) {
      
    }
    tempPlanet.setup();
    popMatrix();
  }
  
}

void draw() {
  background(0);
  for(int i = 0; i < planets.size(); i++) {
    PlanetDruidia tempPlanet = (PlanetDruidia)planets.get(i);
    tempPlanet.draw();
  }
}


