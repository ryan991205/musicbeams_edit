class Scanner_ZigZag extends Effect
{
  String getName() {
    return "Scanner ZigZag ";
  }

  char triggeredByKey() {
    return 'a';
  }

  private void generateLine_up(float x, float y)
  {
    stg.quad( x, 
              y, 
              x + line_width, 
              y, 
              x-line_height, 
              y - line_height,
              (x-line_height-line_width), 
              y - line_height);
  }

  private void generateLine_down(float x, float y)
  {
   stg.quad( x, 
              y, 
              x - line_width, 
              y, 
              x+line_height -line_width , 
              y - line_height,
              (x+line_height)-0, 
              y - line_height);
  }

  private void generateFullZigZag(float x, float y,int ammountOfLines)
  {
    stg.fill(hueSlider.getValue(), 255, 255);

    for(int i =0; i < ammountOfLines; i++)
    {
        // 2.1 magic number, dont like it but this val keeps offset/spacing about right.
        generateLine_up(x+(2.1*(i*line_height)),y);
        generateLine_down((x+line_width)+(2.1*(i*line_height)), y);
    }
  }

  Scanner_ZigZag(MusicBeam ctrl, int y)
  {
    super(ctrl, y);

    hueSlider = cp5.addSlider("hue"+getName()).setRange(0, 360).setSize(395, 45).setPosition(0, 5).setGroup(controlGroup);
    hueSlider.getCaptionLabel().set("hue").align(ControlP5.RIGHT, ControlP5.CENTER);
    hueSlider.setValue(115);

    speedSlider = cp5.addSlider("Speed"+getName()).setRange(0.4,8).setValue(1).setPosition(0, 55).setSize(395, 45).setGroup(controlGroup);
    speedSlider.getCaptionLabel().set("Speed").align(ControlP5.RIGHT, ControlP5.CENTER);

    hightSlider = cp5.addSlider("Height"+getName()).setRange(100, 500).setValue(300).setPosition(0, 105).setSize(395, 45).setGroup(controlGroup);
    hightSlider.getCaptionLabel().set("Height").align(ControlP5.RIGHT, ControlP5.CENTER);

    top_Line_POS_Slider = cp5.addSlider("Upper line position"+getName()).setRange(-200, 600).setSize(395, 45).setPosition(0, 155).setGroup(controlGroup);
    top_Line_POS_Slider.getCaptionLabel().set("Upper line position").align(ControlP5.RIGHT, ControlP5.CENTER);
    top_Line_POS_Slider.setValue(-150);

    bot_Line_POS_Slider = cp5.addSlider("Lower line position"+getName()).setRange(-200, 600).setSize(395, 45).setPosition(0, 205).setGroup(controlGroup);
    bot_Line_POS_Slider.getCaptionLabel().set("Lower line position").align(ControlP5.RIGHT, ControlP5.CENTER);
    bot_Line_POS_Slider.setValue(400);

    lineWidth_Slider = cp5.addSlider("Line width"+getName()).setRange(5, 40).setSize(395, 45).setPosition(0, 255).setGroup(controlGroup);
    lineWidth_Slider.getCaptionLabel().set("Line width").align(ControlP5.RIGHT, ControlP5.CENTER);
    lineWidth_Slider.setValue(30);
  }

  Slider bot_Line_POS_Slider, top_Line_POS_Slider, hueSlider, speedSlider, hightSlider, lineWidth_Slider;

  float rx = -5000;

  float line_width = 30;
  float line_height = 400;

  void draw()
  {
    line_width = lineWidth_Slider.getValue();
    line_height = hightSlider.getValue();

    generateFullZigZag(rx , top_Line_POS_Slider.getValue(), 55);
    generateFullZigZag(rx ,bot_Line_POS_Slider.getValue(), 55);

    translate(-stg.width/2, -stg.height/2);
      
    rx =  rx+ (speedSlider.getValue()*4);
    if( rx >= 0-((stg.width))-(line_width))
    {
      rx = -4000;
    }
 
  }

  boolean isTriggeredByBeat()
  {
    return
      isHat()   ||
      isSnare() ||
      isKick()  ||
      isOnset();
  }
}
