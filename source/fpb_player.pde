class Bird {
  float xCoor;
  float yCoor;
  float playerWidth;
  float playerHeight;
  float player_gravity;
  PImage burung = loadImage("fpb_assets/bird.png");
  
  Bird() {
    playerInitialState();
  }
  
  void update(int indexPipe) {
    movementUpdatePlayer();
    groundCollisionPlayer();
    pipesCollisionPlayer(indexPipe % flappyBird.manyPipes);
    renderPlayer();
  }
  
  void movementUpdatePlayer() {
    if (flappyBird.initialState && player_gravity < 10) 
      player_gravity += 1;
    
    if (flappyBird.gameplayStage && flappyBird.keyInput[0]) {
      player_gravity = -8;
    }
    
    if (flappyBird.gameplayStage && (flappyBird.keyInput[2] && flappyBird.keyInput[1])) {
      player_gravity = -11;
      flappyBird.keyInput[2] = false;
    }
    
    if (yCoor - playerHeight / 2 <= -playerHeight) {
      yCoor = -playerHeight / 2;
    }
      
    if (flappyBird.initialState) {
      yCoor += player_gravity;
    }
  }
  
  boolean deathFlag;
  void groundCollisionPlayer() {
    if (yCoor + playerWidth / 2 > ground.yGround) {
      if (deathFlag)
        player_gravity = -11;
        
      flappyBird.restartStage = true;
      flappyBird.gameplayStage = false;
      deathFlag = false;
    }
  }
  
  void pipesCollisionPlayer(int index) {
    float a = playerWidth / 2;
    float b = playerHeight / 2;
    float xCenter = xCoor;
    float yCenter = yCoor;
    float xClosest = max(pipes[index].xTopPipe, min(xCenter, pipes[index].xTopPipe + pipes[index].pipeWidth));
    float yClosest = max(pipes[index].yTopPipe, min(yCenter, pipes[index].yTopPipe + pipes[index].pipeTopHeigth));
    
    float distanceX = xCenter - xClosest;
    float distanceY = yCenter - yClosest;
      
    if ((pow(distanceX, 2) / pow(a, 2)) + (pow(distanceY, 2) / pow(b, 2)) <= 1) {
      if (deathFlag)
        player_gravity = -11;
        
      flappyBird.restartStage = true;
      flappyBird.gameplayStage = false;
      deathFlag = false;
    }
    
    xClosest = max(pipes[index].xBottomPipe, min(xCenter, pipes[index].xBottomPipe + pipes[index].pipeWidth));
    yClosest = max(pipes[index].yBottomPipe, min(yCenter, pipes[index].yBottomPipe + pipes[index].pipeBottomHeigth));
    
    distanceX = xCenter - xClosest;
    distanceY = yCenter - yClosest;
      
    if ((pow(distanceX, 2) / pow(a, 2)) + (pow(distanceY, 2) / pow(b, 2)) <= 1) {
      if (deathFlag)
        player_gravity = -11;
        
      flappyBird.restartStage = true;
      flappyBird.gameplayStage = false;
      deathFlag = false;
    }
  }
  
  void playerInitialState() {
    this.xCoor = width / 2 - 60;
    this.yCoor = (height - ground.groundHeight) / 2 - 50;
    this.playerWidth = 50;
    this.playerHeight = 40;
    this.player_gravity = 0;
    this.deathFlag = true;
  }
  
  void renderPlayer() {
     //ellipse(xCoor, yCoor, playerWidth, playerHeight);
    image(burung, xCoor - 35, yCoor - 30, playerWidth + 20, playerHeight + 20);
  }
}
