class Pipes {
  float xTopPipe;
  float yTopPipe;
  float xBottomPipe;
  float yBottomPipe;
  float pipeTopHeigth;
  float pipeBottomHeigth;
  final float pipeSpeed = 2;
  final float pipeWidth = 80;
  final float gapPipeHeight = 140;
  final float gapBetweenPipe = 220;
  PImage topHeadPimg;
  PImage btmHeadPimg;
  PImage pipeImg;
  
  Pipes() {
    pipeInitialState();
  }
  
  void update() {
    xTopPipe -= pipeSpeed;
    xBottomPipe = xTopPipe;
    
    if (xTopPipe + pipeWidth <= (pipes[0].gapBetweenPipe + pipes[0].pipeWidth) * flappyBird.manyPipes + pipes[0].pipeWidth - (display.xScreen + display.screenWidth)) {
      pipeInitialState();
      
      xTopPipe = display.xScreen + display.screenWidth;
      xBottomPipe = xTopPipe;
    }
  }
   
  void pipeInitialState() {
    final float invsTopPipe = -100;
    
    this.pipeTopHeigth = random(40 - invsTopPipe, 380);
    this.pipeBottomHeigth = height - (pipeTopHeigth + invsTopPipe + gapPipeHeight + ground.groundHeight);
    this.xTopPipe = 400;
    this.yTopPipe = invsTopPipe;
    this.xBottomPipe = xTopPipe;
    this.yBottomPipe = pipeTopHeigth + invsTopPipe + gapPipeHeight;
    this.topHeadPimg = loadImage("fpb_assets/topHeadPipe.png");
    this.btmHeadPimg = loadImage("fpb_assets/bottomHeadPipe.png");
    this.pipeImg = loadImage("fpb_assets/bodyPipe.png");
  }
  
  void renderPipe() {
    //rect(xTopPipe, yTopPipe, pipeWidth, pipeTopHeigth);
    image(pipeImg, xTopPipe, yTopPipe, pipeWidth, pipeTopHeigth - 40);
    image(topHeadPimg, xTopPipe - 5, yTopPipe + pipeTopHeigth - 40, pipeWidth + 10, 40);
    
    
    //rect(xBottomPipe, yBottomPipe, pipeWidth, pipeBottomHeigth);
    image(pipeImg, xBottomPipe, yBottomPipe + 40, pipeWidth, pipeBottomHeigth - 40);
    image(btmHeadPimg, xTopPipe - 5, yBottomPipe, pipeWidth + 10, 40);
  }
}
