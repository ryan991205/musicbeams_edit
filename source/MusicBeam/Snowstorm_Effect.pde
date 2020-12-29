class Snowstorm_Effect extends Effect
{ 

  Snowstorm_Effect(MusicBeam controller, int y)
  {
    super(controller, y);

    radiusSlider = cp5.addSlider("radius"+getName()).setGroup(controlGroup).setPosition(0, 5).setSize(395, 45);
    radiusSlider.setRange(25, 200).setValue(40);
    radiusSlider.getCaptionLabel().set("Size").align(ControlP5.RIGHT, ControlP5.CENTER);

    speedSlider = cp5.addSlider("speed"+getName()).setRange(0.01, 1).setValue(0.3).setPosition(0, 55).setSize(395, 45).setGroup(controlGroup);
    speedSlider.getCaptionLabel().set("Speed").align(ControlP5.RIGHT, ControlP5.CENTER);

    hueSlider = cp5.addSlider("hue"+getName()).setRange(0, 360).setSize(295, 45).setPosition(50, 105).setGroup(controlGroup);
    hueSlider.getCaptionLabel().set("hue").align(ControlP5.RIGHT, ControlP5.CENTER);
    hueSlider.setValue(0);
    HueControlListener hL = new HueControlListener(); 
    hueSlider.addListener(hL);

    aHueToggle = cp5.addToggle("ahue"+getName()).setPosition(0, 105).setSize(45, 45).setGroup(controlGroup);
    aHueToggle.getCaptionLabel().set("A").align(ControlP5.CENTER, ControlP5.CENTER);
    aHueToggle.setState(true);

    bwToggle = ctrl.cp5.addToggle("bw"+getName()).setPosition(350, 105).setSize(45, 45).setGroup(controlGroup);
    bwToggle.getCaptionLabel().set("BW").align(ControlP5.CENTER, ControlP5.CENTER);
    bwToggle.setState(false);

    calcPoints();
  }

  public String getName()
  {
    return "Snowstorm";
  }
  
  char triggeredByKey() {
    return '6';
  }

  Slider radiusSlider, speedSlider, hueSlider;

  Toggle aHueToggle, bwToggle;

  LinkedList<Float> r, x, y;

  int px, py, pts;

  int lauf = 0;

  boolean kick = false;

  void draw()
  {
    if (radiusSlider.isMousePressed())
      calcPoints();
    else {
    translate(-stg.width/2-lauf*speedSlider.getValue()*10, -stg.height/2);
    for (int i=0;i<pts;i++) {
      float posx, posy;
      posx = (2*radiusSlider.getValue()*(i%px))+x.get(i);
      posy = (2*radiusSlider.getValue()*(i/px))+y.get(i);
      stg.fill((hueSlider.getValue())%360, bwToggle.getState()?0:100, 100);
      stg.ellipse(posx, posy, r.get(i), r.get(i));
    }

    if (lauf>=(2*radiusSlider.getValue()/(speedSlider.getValue()*10))-1) {  
      x.add(x.remove());
      y.add(y.remove());
      r.add(r.remove());
      lauf=0;
    } 
    else
      lauf++;
    }

    if (aHueToggle.getState()&& (isKick()&&isSnare()))
      hueSlider.setValue((hueSlider.getValue()+60)%360);
  }

  void calcPoints() {
    px = int(stg.width/(2*radiusSlider.getValue()))+2;
    py = int(stg.height/(2*radiusSlider.getValue()))+1;
    pts = px*py;
    x = new LinkedList();
    y = new LinkedList();
    r = new LinkedList();
    for (int i=0;i<pts;i++) {
      r.add(i, random(radiusSlider.getValue()/10, radiusSlider.getValue()));
      x.add(i, random(0, radiusSlider.getValue()));
      y.add(i, random(0, radiusSlider.getValue()));
    }
  }
}
