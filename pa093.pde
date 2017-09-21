class Point {
   public int x;
   public int y;
   
   public Point(int x, int y) {
     this.x = x;
     this.y = y;
   }
   
   public Point add(Point other) {
     return new Point(this.x + other.x, this.y + other.y);
   }
   
   public Point sub(Point other) {
     return new Point(this.x - other.x, this.y - other.y);
   }
   
   public int dot(Point other) {
     return this.x * other.x + this.y * other.y;
   }
   
   public float norm() {
     return sqrt(this.x * this.x + this.y * this.y);
   }
   
   public float distance(Point other) {
     return this.sub(other).norm();
   }
}

class Canvas {
  public static final int POINT_RADIUS = 4;
  private ArrayList<Point> points = new ArrayList();
  
  public void addRandomPoint() {
    int x = (int)random(width);
    int y = (int)random(height);
    addPoint(x, y);
  }
  
  public void addPoint(int x, int y) {
    points.add(new Point(x, y));
  }
  
  public void removePoint(int x, int y) {
    points.remove(selectPoint(x, y));
  }
  
  public Point selectPoint(int x, int y) {
    Point coords = new Point(x, y);
    for (Point p : points) {
      if (p.distance(coords) <= POINT_RADIUS)
        return p;
    }
    return null;
  }
  
  void drawPoints() {
    fill(0);
    stroke(0);
    for (Point p : points) {
      ellipse(p.x, p.y, POINT_RADIUS * 2, POINT_RADIUS * 2);
    }
  }
}

Canvas canvas = new Canvas();

void setup() {
  size(800, 600);
}

void mouseClicked() {
  switch (mouseButton) {
    case LEFT:
      canvas.addPoint(mouseX, mouseY);
      break;
    case RIGHT:
      canvas.removePoint(mouseX, mouseY);
      break;
  }
  redraw();
}

void mouseDragged() {
  Point p = canvas.selectPoint(pmouseX, pmouseY);
  if (p != null) {
    p.x = mouseX;
    p.y = mouseY;
  }
  redraw();
}

void keyPressed() {
  switch (key) {
    case 'r':
    case 'R':
      for (int i = 0; i != 5; ++i) {
        canvas.addRandomPoint();
      }
      break;
  }
  redraw();
}

void draw() {
  background(255);
  canvas.drawPoints();
}