class Display {
  float xScreen;
  float yScreen;
  float screenWidth;
  float screenHeight;
  
  float xbg1;
  float ybg1;
  float xbg2;
  float ybg2;
  PImage bg;
  PImage scr;
  
  Display() {
    displayInitialState();
  }
  
  void optionMenu() {
    rect(xScreen + screenWidth - 35, 15, 22, 22, 8);
  }
  
  void title() {
    fill(255);
    textSize(45);
    text("FLAPPY BIRD", width / 2 - textWidth("FLAPPY BIRD") / 2, height / 2 - 180);
  }
  
  void restartMenu(int score) {
    fill(240);
    image(scr, width / 2 - 112, height / 2 - 120, 225, 80);
    
    fill(0);
    textSize(35);
    text(str(score), width / 2 - textWidth(str(score)) / 2, height / 2 - 65);
    fill(255);
    //rect(width / 2 - 112, height / 2 - 120, 225, 80, 10);
    fill(255);
  }

  void displayInitialState() {
    this.screenWidth = 500;
    this.screenHeight = height;
    this.xScreen = width / 2 - screenWidth / 2;
    this.yScreen = height;
    this.bg = loadImage("fpb_assets/bg.png");
    this.xbg1 = xScreen;
    this.xbg2 = xScreen + screenWidth;
    this.scr = loadImage("fpb_assets/menu.png");
  }
  
  void renderScreenDisplay() {
    if (flappyBird.gameplayStage || flappyBird.startMenuStage) {
      xbg1 -= 0.5;
      xbg2 -= 0.5;
    }
  
    if (xbg1 <= xScreen - screenWidth) {
      xbg1 = xScreen + screenWidth;
    }
    
    if (xbg2 <= xScreen - screenWidth) {
      xbg2 = xScreen + screenWidth;
    }
    
    image(bg, xbg1, ybg1);
    image(bg, xbg2, ybg2);
  }
  
  void renderBorderDisplay() {
    fill(0);
    rect(0, 0, xScreen, height);
    rect(xScreen + screenWidth, 0, width - xScreen + screenWidth, height);
    fill(255);
  }
}

class Button {
  float x;
  float y;
  float btnWidth;
  float btnHeight;
  float roundness;
  PImage img;
  
  Button(float x, float y, float btnWidth, float btnHeight, float roundness) {
    this.x = x;
    this.y = y;
    this.btnWidth = btnWidth;
    this.btnHeight = btnHeight;
    this.roundness = roundness;
    this.img = loadImage("fpb_assets/button.png");;
  }
  
  boolean hoverCheck() {
    return (mouseX >= x && mouseX <= x + btnWidth) && (mouseY >= y && mouseY <= y + btnHeight);
  }
  
  void renderButton(String texts, int fontSize) {
    image(img, x, y, btnWidth, btnHeight);
    //rect(x, y, btnWidth, btnHeight, 10);
    
    fill(0);
    textSize(fontSize);
    textAlign(LEFT);
    text(texts, int(int(x + btnWidth / 2) - int(textWidth(texts) / 2)), int(int(y + btnHeight / 2) + int(fontSize / 2 - 2)));
    fill(255);
  
    if (hoverCheck()) {
      fill(0, 100);
      rect(x, y, btnWidth, btnHeight, 10);
      fill(255);
    }
  }
}
