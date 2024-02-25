class Ground {
  float xGround;
  float yGround;
  float groundWidth ;
  float groundHeight;
  PImage ground;
  
  float x1;
  float y1;
  float x2;
  float y2;
  float tHeight;
  
  Ground() {
    groundInitialState();
  }
  
  void groundInitialState() {
    this.xGround = display.xScreen;
    this.yGround = height - 80;
    this.groundWidth = display.screenWidth;
    this.groundHeight = height - yGround;
    
    this.x1 = xGround;
    this.y1 = yGround;
    this.x2 = xGround + groundWidth;
    this.y2 = yGround;
    this.tHeight = 15;
    this.ground = loadImage("fpb_assets/ground.png");
  }
  
  void renderGrass() {
    if (flappyBird.gameplayStage || flappyBird.startMenuStage) {
      x1 -= pipes[0].pipeSpeed;
      x2 -= pipes[0].pipeSpeed;
    }
  
    if (x1 <= xGround - groundWidth) {
      x1 = xGround + groundWidth;
    }
    
    if (x2 <= xGround - groundWidth) {
      x2 = xGround + groundWidth;
    }
    
    fill(255, 0, 0);
    //rect(x1, y1, groundWidth, tHeight);
    image(ground, x1, y1, groundWidth, groundHeight);
    fill(0, 0, 255);
    //rect(x2, y2, groundWidth, tHeight);
    image(ground, x2, y2, groundWidth, groundHeight);
    fill(255);
  }
  
  void renderGround() {
    //image(ground, xGround, yGround, groundWidth, groundHeight);
    //rect(xGround, yGround, groundWidth, groundHeight);
    renderGrass();
  }
}
