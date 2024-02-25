class FlappyBird {
  boolean[] keyInput;
  boolean pauseStage;
  boolean gameplayStage;
  boolean startMenuStage;
  boolean initialState; // bruhh gua lupa ini buat apa, tapi kalo diapus rusak, diemin aja 
  boolean restartStage;
  boolean saveScoreStage;
  boolean xMouseCheck;
  boolean yMouseCheck;
  final int manyPipes = 3;
  
  FlappyBird() {
    gameInitialState();
  }
  
  void update() {
    xMouseCheck = mouseX >= display.xScreen && mouseX <= display.xScreen + display.screenWidth;
    yMouseCheck = mouseY >= 0 && mouseY <= height;
  }
  
  void gameInitialState() {
    this.keyInput = new boolean[3];
    this.gameplayStage = false;
    this.startMenuStage = true;
    this.initialState = false;
    this.restartStage = false;
    this.pauseStage = false;
    this.keyInput[2] = true;
    this.saveScoreStage = false;
  }
}

FlappyBird flappyBird;
Display display;
Ground ground;
Pipes[] pipes;
Score score;
Bird bird;

Button hsbtn;
Button plybtn;
Button rstbtn;
Button addsbtn;
Button extbtn1;
Button extbtn2;
Button pausebtn;
Button mmbtn;
Button backbtn;
Button scorebtn;


void fpb_initialized() {
  strokeWeight(1); // optional
  textFont(createFont("fpb_assets/pixel-bit-advanced.ttf", 15));
  textMode(SHAPE);
  cursor(HAND);
  
  flappyBird = new FlappyBird();
  display = new Display();
  ground = new Ground();
  bird = new Bird();
  score = new Score();
  
  rstbtn = new Button(width / 2 + 10, height / 2, 140, 40, 10);
  addsbtn = new Button(width / 2 - 150, height / 2, 150, 40, 10);
  //hsbtn = new Button(width / 2 - 150, height / 2 + 50, 160, 40, 10);
  plybtn = new Button(width / 2 + 10 + 10, height / 2 + 50, 130, 40, 10);
  mmbtn = new Button(width / 2 - 150, height / 2 + 50, 150, 40, 10); 
  extbtn2 = new Button(width / 2 + 10, height / 2 + 50, 140, 40, 10);
  extbtn1 = new Button(width / 2 - 150, height / 2 + 50, 160, 40, 10);
  pausebtn = new Button(display.xScreen + display.screenWidth - 35, 15, 22, 22, 8);
  backbtn = new Button(display.xScreen + 90, 430, 150, 40, 10);
  scorebtn = new Button(display.xScreen + 270, 430, 150, 40, 10);;
  
  pipes = new Pipes[flappyBird.manyPipes];
  pipesInitialized();
}

void fpb_deInitialized() {
  noStroke(); // optional
  cursor(ARROW);
  
  flappyBird = null;
  display = null;
  ground = null;
  bird = null;
  score = null;
  
  rstbtn = null;
  addsbtn = null;
  hsbtn = null;
  plybtn = null;
  extbtn2 = null;
  extbtn1 = null;
  pausebtn = null;
  backbtn = null;
  scorebtn = null;
  
  pipes = null;
}

void setup() {
  //size(400, 600, P2D);
  size(1368, 672, P2D);
  
  fpb_initialized();
}

void draw() {
  flappy_bird_game();
}

void mousePressed() {
  fpb_mousePressed();
}

void mouseReleased() {
  fpb_mouseReleased();
}

void keyPressed() {
  fpb_keyPressed();
}

void keyReleased() {
  fpb_keyReleased();
}

void flappy_bird_game() {
  flappyBird.update();
  display.renderScreenDisplay();
  
  if (flappyBird.startMenuStage) {
    ground.renderGround();
    bird.renderPlayer();
    display.title();
    
    //hsbtn.renderButton("High Score", 15);
    plybtn.renderButton("Play Game", 15);
    extbtn1.renderButton("Exit Game", 15);
  }
  
  else if (flappyBird.gameplayStage) {
    for (int i = 0; i < flappyBird.manyPipes; i++) {
      pipes[i].update();
    } pipesDisplayRender();
    
    bird.update(score.currentScore);
    score.update();
    ground.renderGround();
  }
  
  else if (flappyBird.restartStage) {
    bird.update(score.currentScore);
    pipesDisplayRender();
    bird.renderPlayer();
    ground.renderGround();
    display.restartMenu(score.currentScore);
    
    mmbtn.renderButton("Main Menu", 15);
    extbtn2.renderButton("Exit Game", 15);
    addsbtn.renderButton("Add Score", 15);
    rstbtn.renderButton("Restart", 15);
  }
  
  else if (flappyBird.saveScoreStage) {
    score.displayInput();
    pipesDisplayRender();
    bird.renderPlayer();
    ground.renderGround();
    image(score.addScoreMenu, display.xScreen + 75, 100, 360, 400);
    //rect(display.xScreen + 75, 100, 360, 400);
    score.displayInput();
    backbtn.renderButton("Back", 15);
    scorebtn.renderButton("Add", 15);
    //rect(display.xScreen + 90, 415, 150, 40);
    //rect(display.xScreen + 270, 415, 150, 40);
  }
   
  //pausebtn.renderButton("| |", 14);
  display.renderBorderDisplay();
}

void pipesInitialized() {
  for (int i = 0; i < flappyBird.manyPipes; i++) {
    pipes[i] = new Pipes();
  }
  
  int num = int(random(50, 1500));
  //println(num);
  
  pipes[0].xTopPipe = display.xScreen + display.screenWidth + num;
  for (int i = 1; i < flappyBird.manyPipes; i++) {
    pipes[i].xTopPipe = pipes[i-1].xTopPipe + pipes[i-1].pipeWidth + pipes[i-1].gapBetweenPipe;
  }
}

void pipesDisplayRender() {
  for (int i = 0; i < flappyBird.manyPipes; i++) {
     pipes[i].renderPipe();
  }
}

void fpb_mouseReleased() {
  cursor(HAND);
  if (flappyBird.xMouseCheck && flappyBird.yMouseCheck) {
    
    if (flappyBird.gameplayStage) {
      flappyBird.keyInput[2] = true;
      flappyBird.keyInput[1] = false;
    }
  }
}

void fpb_mousePressed() {
  cursor(MOVE);
  // Start Menu buttons
  if (flappyBird.startMenuStage) {
    if (plybtn.hoverCheck()) {
      flappyBird.initialState = false;
      flappyBird.gameplayStage = true; 
      flappyBird.startMenuStage = false;
    }
    
    if (extbtn1.hoverCheck()) {
      fpb_deInitialized(); //*CheckPoint
      //menu = 0;
      exit();
      return;
    }
  }
  
  // Restart Menu buttons
  else if (flappyBird.restartStage) {
    if (rstbtn.hoverCheck()) {
      bird.playerInitialState();
      score.scoreInitialState();
      pipesInitialized();
      
      flappyBird.initialState = false;
      flappyBird.gameplayStage = true;
      flappyBird.restartStage = false;
    }
    
    if (addsbtn.hoverCheck()) {
      flappyBird.restartStage = false;
      flappyBird.saveScoreStage = true;
    }
    
    if (mmbtn.hoverCheck()) {
      bird.playerInitialState();
      score.scoreInitialState();
      pipesInitialized();
      
      flappyBird.initialState = false;
      flappyBird.startMenuStage = true;
      flappyBird.restartStage = false;
    }
    
    if (extbtn2.hoverCheck()) {
      fpb_deInitialized(); //*CheckPoint
      //menu = 0;
      exit();
      return;
    }
  }
  
  else if (flappyBird.saveScoreStage) {
    if (backbtn.hoverCheck()) {
      flappyBird.restartStage = true;
      flappyBird.saveScoreStage = false;
    }
    
    if (scorebtn.hoverCheck()) {
      score.saveScore();
      flappyBird.restartStage = true;
      flappyBird.saveScoreStage = false;
    }
  }
  
  // Mouse input buat lompat
  if (flappyBird.xMouseCheck && flappyBird.yMouseCheck) {
    flappyBird.keyInput[1] = true;
    
    if (flappyBird.gameplayStage && !flappyBird.initialState) {
      flappyBird.initialState = true;
    }
  }
}

void fpb_keyPressed() {
  // if pause menu is off and player press ESC or P
  // then open pause menu
  // ....
    
  if (keyCode == 32) {
    if (flappyBird.startMenuStage) {
      flappyBird.startMenuStage = false;
      flappyBird.gameplayStage = true;
    }
    
    if (flappyBird.gameplayStage) {
      flappyBird.keyInput[0] = true;

      if (!flappyBird.initialState) {
        flappyBird.initialState = true;
      }
    }

    else if (flappyBird.restartStage) {
      bird.playerInitialState();
      score.scoreInitialState();
      pipesInitialized();
      
      bird.player_gravity = -11;
      flappyBird.initialState = true;
      flappyBird.gameplayStage = true;
      flappyBird.restartStage = false;
    }
  }
  
  if (flappyBird.saveScoreStage) {
    score.pressBoard();
    
  }
}

void fpb_keyReleased() {
  score.keyInputs[keyCode] = false;
  
  if (keyCode == 32)
    flappyBird.keyInput[0] = false;
}
