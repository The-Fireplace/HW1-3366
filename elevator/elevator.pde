PFont f, f2, f3, f4;
boolean target0 = false, target1 = false, target2 = false, target3 = false;
final int floor_size = 15;
int position = floor_size;
int floorIndex(){return (position+floor_size/2) / floor_size;}
boolean up = true;
boolean moving = false;

void setup() {
  size(640, 400);
  frameRate(12);
  //printArray(PFont.list());
  f = createFont("Liberation Sans", 24);
  f2 = createFont("Liberation Sans", 72);
  f3 = createFont("Liberation Sans", 12);
  f4 = createFont("Liberation Sans", 48);
  textFont(f);
  textAlign(CENTER, CENTER);
}

void draw() {
  background(0x999999);
  
  fill(0);
  text("Current Floor", 550, 24);
  textFont(f2);
  text(floorDisplay(floorIndex()), 550, 72);
  textFont(f);
  if(moving()) {
    textFont(f4);
    if(up)
      text('^', 550, 48);
    else
      text('v', 550, 120);
    textFont(f);
  }
  
  if(mousePressed && overCircle(50, 100, 50, mouseX, mouseY) && (moving() || floorIndex() != 3) && !target3) {
    if(!moving())
      up = true;
    target3 = true;
  }
  if(target3)
    fill(0, 255, 0);
  else
    fill(255);
  ellipse(100, 50, 50, 50);
  fill(0);
  text('3', 101, 47);
  
  if(mousePressed && overCircle(50, 100, 125, mouseX, mouseY) && (moving() || floorIndex() != 2) && !target2) {
    if(!moving())
      up = floorIndex() < 2;
    target2 = true;
  }
  if(target2)
    fill(0, 255, 0);
  else
    fill(255);
  ellipse(100, 125, 50, 50);
  fill(0);
  text('2', 101, 122);
  
  if(mousePressed && overCircle(50, 100, 200, mouseX, mouseY) && (moving() || floorIndex() != 1) && !target1) {
    if(!moving())
      up = floorIndex() < 1;
    target1 = true;
  }
  if(target1)
    fill(0, 255, 0);
  else
    fill(255);
  ellipse(100, 200, 50, 50);
  fill(0);
  text('1', 101, 197);
  
  if(mousePressed && overCircle(50, 100, 275, mouseX, mouseY) && (moving() || floorIndex() != 0) && !target0) {
    if(!moving())
      up = false;
    target0 = true;
  }
  if(target0)
    fill(0, 255, 0);
  else
    fill(255);
  ellipse(100, 275, 50, 50);
  fill(0);
  text('B', 101, 272);
  
  //Make the font smaller for word button labels
  textFont(f3);
  
  if(mousePressed && overCircle(50, 350, 350, mouseX, mouseY))
    fill(0x99, 0x99, 255);
  else
    fill(255);
  ellipse(350, 350, 50, 50);
  fill(0);
  text("Open\r\nDoors", 350, 350);
  
  if(mousePressed && overCircle(50, 425, 350, mouseX, mouseY))
    fill(0x99, 0x99, 255);
  else
    fill(255);
  ellipse(425, 350, 50, 50);
  fill(0);
  text("Close\r\nDoors", 425, 350);
  
  textFont(f);
  
  //Move the elevator and calculate its next move if needed
  if(moving()) {
    if(up)
      ++position;
    else
      --position;
    if(position % floor_size == 0) {
      if(position == 0 && target0) {
        target0 = false;
        up = true;
      }
      else if(position == floor_size && target1) {
        target1 = false;
        up = up ? target2 || target3 : !target0;
      }
      else if(position == floor_size*2 && target2) {
        target2 = false;
        up = up ? target3 : !target0 && !target1;
      }
      else if(position == floor_size*3 && target3) {
        target3 = false;
        up = false;
      }
    }
  }
}

boolean overCircle(int r, int centerX, int centerY, int mX, int mY) {
  return dist(centerX, centerY, mX, mY) < r;
}

boolean moving() {
  return target0 || target1 || target2 || target3;
}

char floorDisplay(int floorIndex) {
  if(floorIndex() < 1)
    return 'B';
  return Character.forDigit(floorIndex, 10);
}
