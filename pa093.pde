String help = "(left mouse click) Add point\n"
            + "(right mouse click) Remove point\n"
            + "(mouse drag) Move point\n"
            + "(r) Add 5 random points\n"
            + "(c) Clear canvas\n"
            + "(d) Default mode\n"
            + "(h) Gift-Wrapping hull\n" 
            + "(g) Graham-Scan hull\n"
            + "(t) Delaunay triangulation\n";

Mode mode = Mode.DEFAULT;
Canvas canvas = new Canvas();

void setup() {
  size(1000, 800);
  textMode(SHAPE);
}

void mouseClicked() {
  switch (mouseButton) {
  case LEFT:
    canvas.add_point(mouseX, mouseY);
    break;
  case RIGHT:
    canvas.remove_point(mouseX, mouseY);
    break;
  }
  redraw();
}

void mouseDragged() {
  Point selected = canvas.select_point(pmouseX, pmouseY);
  if (selected != null) {
    selected.x = mouseX;
    selected.y = mouseY;
  }
  redraw();
}

void keyPressed() {
  switch (key) {
  case 'r':
  case 'R':
    canvas.add_random_points(5);
    break;
  case 'c':
  case 'C':
    canvas.cleanPoints();
    break;
  case 'd':
  case 'D':
    mode = Mode.DEFAULT;
    break;
  case 'h':
  case 'H':
    mode = Mode.GW_HULL;
    break;
  case 'g':
  case 'G':
    mode = Mode.GS_HULL;
    break;
  case 't':
  case 'T':
    mode = Mode.DE_TRIAG;
    break;
  }
  redraw();
}

void draw() {
  background(255);
  
  canvas.draw_points();
  switch (mode) {
  case DEFAULT:
    break;
  case GW_HULL:
    canvas.draw_gift_wrapping();
    break;
  case GS_HULL:
    canvas.draw_graham_scan();
    break;
  case DE_TRIAG:
    canvas.draw_delaunay_triangulation();
    break;
  }
  
  draw_help();
  //draw_variable("Tool: ", tool.toString(), 20, 20);
  draw_variable("Mode: ", mode.toString(), 20, 35);
}

void draw_help() {
  float position = width - textWidth(help) - 20;
  
  fill(0);
  text(help, position, 20);
}