class Score {
  int currentScore;
  PImage addScoreMenu = loadImage("fpb_assets/menu.png");
  JSONObject flappyScore;
  
  String str = "";
  
  boolean[] keyInputs = new boolean[256];
  
  int blinkingInterval = 800;
  int lastToggleTime = 0;
  boolean blinkFlag = true;
  
  Score() {
    scoreInitialState();
  }
  
  void update() {
    for (int i = 0; i < flappyBird.manyPipes; i++) {
      if ((bird.xCoor - bird.playerWidth / 2) >= (pipes[i].xTopPipe + pipes[i].pipeWidth -1) && (bird.xCoor - bird.playerWidth / 2) <= (pipes[i].xTopPipe + pipes[i].pipeWidth)) {
        currentScore += 1;
        break;
      }
    }
    
    renderCurrentScore();
  }
  
  void displayInput() {
    int elapsedTime = millis() - lastToggleTime;

    if (elapsedTime >= blinkingInterval) {
      if (blinkFlag)
        blinkFlag = false;
      else
        blinkFlag = true;
      
      lastToggleTime = millis();
    }
    
    if (blinkFlag) {
      rect(20.5 + textWidth(str), 10, 0.2, 30);
    }
    
    if (str.length() > 5) {
      str = str.substring(0, 5);
    }
    
    fill(0);
    textSize(35);
    text(str, display.xScreen + 180, 250);
    fill(255);
  }
  
  void pressBoard() {
    keyInputs[keyCode] = true;
    
    if (keyPressed) {
      if (str.length() > 0 && keyCode == 8) {
         str = str.substring(0, str.length() - 1);
      }
      
      if (key > 31 && key < 127)
        str += key;
    } 
  }
  
  void saveScore() {
     if (str.length() > 0) {
      flappyScore.setInt(str, int(currentScore));
      saveJSONObject(flappyScore, "data/flappy.json");

      str = "";
      return;
    }

    if (str.length() > 0) {
      str = str.substring(0, str.length() - 1);
    }
  }
  
  void scoreInitialState() {
    this.currentScore = 0;
  }
  
  void renderCurrentScore() {
    fill(255);
    textSize(35);
    text(str(currentScore), int(width / 2 - textWidth(str(currentScore)) / 2), 65);
  }
}
