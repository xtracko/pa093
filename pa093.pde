App app = new App(State.GS_HULL);

void setup() {
  size(800, 600);
}

void mouseClicked() {
  app.mouseClicked();
  redraw();
}

void mouseDragged() {
  app.mouseDragged();
  redraw();
}

void keyPressed() {
  app.keyPressed();
  redraw();
}

void draw() {
  background(255);
  app.draw();
}