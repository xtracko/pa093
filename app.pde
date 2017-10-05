String help = "(left mouse click) Add point\n"
            + "(right mouse click) Remove point\n"
            + "(mouse drag) Move point\n"
            + "(r) Add 5 random points\n"
            + "(c) Clear canvas\n"
            + "(h) Gift-Wrapping hull\n" 
            + "(g) Graham-Scan hull\n";

enum State {
  DEFAULT,
  GW_HULL,
  GS_HULL,
};

class App {
  private State state;
  private List<Vec> points = new ArrayList();
  private static final int POINT_RADIUS = 4;
  
  public App() {
    this.state = State.DEFAULT;
  }
  
  public App(State state) {
    this.state = state;
  }
  
  public void mouseClicked() {
    switch (mouseButton) {
    case LEFT:
      addPoint(mouseX, mouseY);
      break;
    case RIGHT:
      removePoint(mouseX, mouseY);
      break;
    }
  }
  
  public void mouseDragged() {
    Vec p = selectPoint(pmouseX, pmouseY);
    if (p != null) {
      p.x = mouseX;
      p.y = mouseY;
    }
  }
  
  public void keyPressed() {
    switch (key) {
    case 'r':
    case 'R':
      addRandomPoints(5);
      break;
    case 'c':
    case 'C':
      clean();
      break;
    case 'h':
    case 'H':
      switch_state(State.GW_HULL);
      break;
    case 'g':
    case 'G':
      switch_state(State.GS_HULL);
      break;
    case 'l':
      addPoint(425, 543);
      addPoint(699, 381);
      addPoint(582, 451);
      break;
    }
  }
  
  public void draw() {
    drawHelp();
    drawPoints();
    
    switch (state) {
    case DEFAULT:
      break;
    case GW_HULL:
      text("Gift Wrapping", width / 2, 10);
      drawHull(giftWrapping(points));
      break;
    case GS_HULL:
      text("Graham Scan", width / 2, 10);
      drawHull(grahamScan(points));
      break;
    }
  }
  
  private void drawHull(List<Vec> hull) {
     fill(100, 100, 100);
     stroke(100, 100, 100);
     for (int i = 1; i < hull.size(); ++i) {
       Vec a = hull.get(i - 1);
       Vec b = hull.get(i);
       line(a.x, a.y, b.x, b.y);
     }
  }
  
  
  private void switch_state(State to) {
    if (state == to)
      state = State.DEFAULT;
    else
      state = to;
  }
  
  private void addRandomPoints(int n) {
    if (n < 0)
      throw new IllegalArgumentException("blabla");
    
    final float span = 6;
    for (int i = 0; i != n; ++i) {
      int x = (int)(randomGaussian() * (width / span)) + (width / 2);
      int y = (int)(randomGaussian() * (height / span)) + (height / 2);
      
      addPoint(x, y);
    }
  }
  
  private void addPoint(int x, int y) {
    points.add(new Vec(x, y));
  }
  
  private void removePoint(int x, int y) {
    points.remove(selectPoint(x, y));
  }
  
  private Vec selectPoint(int x, int y) {
    Vec coords = new Vec(x, y);
    for (Vec p : points) {
      if (distance(p, coords) <= POINT_RADIUS)
        return p;
    }
    return null;
  }
  
  private void clean() {
    points.clear();
  }
  
  private void drawPoints() {
    fill(200);
    stroke(200);
    for (Vec p : points) {
      ellipse(p.x, p.y, POINT_RADIUS * 2, POINT_RADIUS * 2);
    }
  }
  
  private void drawHelp() {
    fill(255, 0, 0);
    text(help, 10, 10);
  }
}