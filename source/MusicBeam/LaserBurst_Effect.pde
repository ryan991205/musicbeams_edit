class LaserBurst_Effect extends Effect
{ 

  LaserBurst_Effect(MusicBeam controller, int y)
  {
    super(controller, y);

    radiusSlider = cp5.addSlider("radius"+getName()).setGroup(controlGroup).setPosition(0, 5).setSize(395, 45).setGroup(controlGroup);
    radiusSlider.setRange(10, 100).setValue(30);
    radiusSlider.getCaptionLabel().set("Size").align(ControlP5.RIGHT, ControlP5.CENTER);

    speedSlider = cp5.addSlider("speed"+getName()).setRange(0.01, 1).setValue(0.3).setPosition(0, 55).setSize(395, 45).setGroup(controlGroup);
    speedSlider.getCaptionLabel().set("Speed").align(ControlP5.RIGHT, ControlP5.CENTER);
    
    rotationSpeedSlider = cp5.addSlider("rotationspeed"+getName()).setPosition(0, 105).setSize(395, 45).setGroup(controlGroup);
    rotationSpeedSlider.setRange(0, 1).setValue(0.3);
    rotationSpeedSlider.getCaptionLabel().set("Rotation Speed").align(ControlP5.RIGHT, ControlP5.CENTER);

    inverseToggle = cp5.addToggle("inverse"+getName()).setSize(395, 45).setPosition(0, 155).setGroup(controlGroup);
    inverseToggle.getCaptionLabel().set("Inverse").align(ControlP5.CENTER, ControlP5.CENTER);

    hueSlider = cp5.addSlider("hue"+getName()).setRange(0, 360).setSize(295, 45).setPosition(50, 205).setGroup(controlGroup);
    hueSlider.getCaptionLabel().set("hue").align(ControlP5.RIGHT, ControlP5.CENTER);
    hueSlider.setValue(0);
    HueControlListener hL = new HueControlListener(); 
    hueSlider.addListener(hL);

    aHueToggle = cp5.addToggle("ahue"+getName()).setPosition(0, 205).setSize(45, 45).setGroup(controlGroup);
    aHueToggle.getCaptionLabel().set("A").align(ControlP5.CENTER, ControlP5.CENTER);
    aHueToggle.setState(true);

    bwToggle = ctrl.cp5.addToggle("bw"+getName()).setPosition(350, 205).setSize(45, 45).setGroup(controlGroup);
    bwToggle.getCaptionLabel().set("BW").align(ControlP5.CENTER, ControlP5.CENTER);
    bwToggle.setState(false);

    pts = new LinkedList();
  }

  public String getName()
  {
    return "LaserBurst";
  }
  
  char triggeredByKey() {
    return '7';
  }

  Slider radiusSlider, speedSlider, hueSlider, rotationSpeedSlider;

  Toggle aHueToggle, bwToggle, inverseToggle;

  LinkedList<Float[]> pts;

  Boolean rightSide = false;
  
  float rotation = 0;

  void draw()
  {
    rotate(inverseToggle.getState()?rotation:-rotation);
    if (isKick() || effect_manual_triggered) {
      Float[] k = {
        0.0f, random(0, PI)
      };
      pts.add(k);
    }
    for (int i=0; i<pts.size(); i++) {
      Float[] k = pts.get(i);
      stg.fill(hueSlider.getValue(), bwToggle.getState()?0:100, 100);

      float r;
      if (inverseToggle.getState()) {
        r = (1-k[0])*stg.getMaxRadius();
      } 
      else {
        r = k[0]*stg.getMaxRadius();
      }

      stg.ellipse(r*cos(k[1]), r*sin(k[1]), radiusSlider.getValue(), radiusSlider.getValue());
      // stg.fill((hueSlider.getValue()+120)%360, bwToggle.getState()?0:100,100);
      stg.ellipse(r*cos(k[1]+PI), r*sin(k[1]+PI), radiusSlider.getValue(), radiusSlider.getValue());
      if (k[0]>=1)
        pts.remove(i);
      else
        k[0]+=speedSlider.getValue()/100;
    }
    if (aHueToggle.getState()&& (isKick()||isSnare()))
      hueSlider.setValue((hueSlider.getValue()+1)%360);
    rotation = (rotation+rotationSpeedSlider.getValue()/20)%PI;
  }
}
