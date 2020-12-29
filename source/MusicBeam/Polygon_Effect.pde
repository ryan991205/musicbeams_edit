class Polygon_Effect extends Effect
{
  String getName()
  {
    return "Polygon RYAN EDIT (3*)";
  }

  char triggeredByKey() {
    return '8';
  }

  float[] px, py;

  int beatCount = 0;

  float rotation = 0;
  float rotation2 = 0;
  float rotation3 = 0;
  float rotationSoundMulti =0;
  float pointSoundMulti = 0;
  float controlradius = 200;
  
  float minPoints = 4;
  float maxPoints = 7;
  
   float timer = 0;

  Toggle aHueToggle, bwToggle;

  Slider weightSlider, pointsSlider, speedSlider, hueSlider, rotationSpeedSlider, valpointsSlider, val1pointsSlider;

  Polygon_Effect(MusicBeam controller, int y)
  {
    super(controller, y);

    weightSlider = cp5.addSlider("weight"+getName()).setPosition(0, 5).setSize(395, 45).setRange(0, 100).setGroup(controlGroup);
    weightSlider.getCaptionLabel().set("Weight").align(ControlP5.RIGHT, ControlP5.CENTER);
    weightSlider.setValue(20);

    pointsSlider = cp5.addSlider("points"+getName()).setPosition(0, 55).setSize(395, 45).setRange(minPoints, maxPoints).setNumberOfTickMarks(9).setGroup(controlGroup);
    pointsSlider.getCaptionLabel().set("Edges").align(ControlP5.RIGHT, ControlP5.CENTER);
    pointsSlider.setValue(8);
    
    valpointsSlider = cp5.addSlider("val min "+getName()).setPosition(0, 55).setSize(395, 45).setRange(4, 20).setNumberOfTickMarks(9).setGroup(controlGroup);
    valpointsSlider.getCaptionLabel().set("val").align(ControlP5.RIGHT, ControlP5.CENTER);
    valpointsSlider.setValue(8);

    val1pointsSlider = cp5.addSlider("val max "+getName()).setPosition(0, 55).setSize(395, 45).setRange(4, 20).setNumberOfTickMarks(9).setGroup(controlGroup);
    val1pointsSlider.getCaptionLabel().set("val").align(ControlP5.RIGHT, ControlP5.CENTER);
    val1pointsSlider.setValue(8);

    rotationSpeedSlider = cp5.addSlider("rotationspeed"+getName()).setPosition(0, 105).setSize(395, 45).setGroup(controlGroup);
    rotationSpeedSlider.setRange(-1, 1).setValue(0.3);
    rotationSpeedSlider.getCaptionLabel().set("Rotation Speed").align(ControlP5.RIGHT, ControlP5.CENTER);

    hueSlider = cp5.addSlider("hue"+getName()).setRange(0, 360).setSize(345, 45).setPosition(50, 155).setGroup(controlGroup);
    hueSlider.getCaptionLabel().set("hue").align(ControlP5.RIGHT, ControlP5.CENTER);
    hueSlider.setValue(0);
    HueControlListener hL = new HueControlListener(); 
    hueSlider.addListener(hL);

    aHueToggle = cp5.addToggle("ahue"+getName()).setPosition(0, 155).setSize(45, 45).setGroup(controlGroup);
    aHueToggle.getCaptionLabel().set("A").align(ControlP5.CENTER, ControlP5.CENTER);
    aHueToggle.setState(true);
  }
  
  int points, weight, radius, hue;
  
  int frameCount;

  void draw() {
    points = int(pointsSlider.getValue());
    weight = int(weightSlider.getValue());
    hue = int(hueSlider.getValue());
    minPoints = int(valpointsSlider.getValue());
    maxPoints = int(val1pointsSlider.getValue());
  
   // hue = );
   
   if(isHat() && timer<=0 )
   {
     beatCount++;
     if(beatCount >= 10)
     {
        rotationSoundMulti = random(-0.6,0.6);
        rotationSpeedSlider.setValue(rotationSoundMulti);
     }
     if(beatCount == 16)
     {
       pointSoundMulti = random(minPoints, maxPoints);
       pointsSlider.setValue(pointSoundMulti);
       
     }
     if(beatCount >= 32){
       beatCount= 0;
     }
     
        timer = (0.1*frameRate*3)/5;  
   }
   timer--;
    
   
 
    
setEllipse(0.4);
    rotate(rotation);
    for (int i=0; i < points; i++) {
      int prev = (i + 1) % points;
      stg.stroke((((i%2)==1?120:0)+hue)%360, 100, 100);
      stg.strokeWeight(weight);
      stg.line(px[i], py[i], px[prev], py[prev]);
      stg.fill(-1);
      stg.noStroke();
      stg.ellipse(px[i], py[i], 1.5*weight, 1.5*weight);
      stg.ellipse(px[prev], py[prev], 1.5*weight, 1.5*weight);
    }
    rotation = (rotation+rotationSpeedSlider.getValue()/20)%(2*PI);
    
    
     setEllipse(0.2);
     rotate(rotation2);
    for (int i=0; i < points; i++) {
      int prev = (i + 1) % points;
      stg.stroke((((i%2)==1?100:0)+hue)%200, 100, 100);
      stg.strokeWeight(weight);
      stg.line(px[i], py[i], px[prev], py[prev]);
      stg.fill(-1);
      stg.noStroke();
      stg.ellipse(px[i], py[i], 1*weight, 1*weight);
      stg.ellipse(px[prev], py[prev], 1*weight, 1*weight);
    }
    rotation2 = (rotation2+rotationSpeedSlider.getValue()/20)%(2*PI);
    
    
      setEllipse(0);
     rotate(rotation3);
    for (int i=0; i < points; i++) {
      int prev = (i + 1) % points;
      stg.stroke((((i%2)==1?100:0)+hue)%180, 100, 100);
      stg.strokeWeight(weight);
      stg.line(px[i], py[i], px[prev], py[prev]);
      stg.fill(-1);
      stg.noStroke();
      stg.ellipse(px[i], py[i], 0.5*weight, 0.5*weight);
      stg.ellipse(px[prev], py[prev], 0.5*weight, 0.5*weight);
    }
    rotation3 = (rotation3+rotationSpeedSlider.getValue()/20)%(2*PI);
    
    
    
  }

  // fill up arrays with ellipse coordinate data
  void setEllipse(float offset) {
    px = new float[points];
    py = new float[points];
    float radius = stg.getMinRadius()/(2+offset)-1.5*weight;
    float angle = 350.0/points;
    for ( int i=0; i<points; i++) {
      px[i] = cos(radians(angle))*(radius + weight / 2);
      py[i] = sin(radians(angle))*(radius + weight / 2);  
      angle+=360.0/points;
    }
  }

  void keyPressed(char key, int keyCode)
  {
    super.keyPressed(key, keyCode);
    if (key == CODED) {
      if (keyCode == LEFT)
        rotationSpeedSlider.setValue(rotationSpeedSlider.getValue()-0.05);
      else if (keyCode == RIGHT)
        rotationSpeedSlider.setValue(rotationSpeedSlider.getValue()+0.05);
    }
  }
}
