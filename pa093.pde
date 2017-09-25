class Vec2 {
  private float x;
  private float y;
  
  public Vec2(float x, float y) {
    this.x = x;
    this.y = y;
  }
  
  public Vec2 add(Vec2 other) {
     return new Vec2(this.x + other.x, this.y + other.y);
   }
   
   public Vec2 sub(Vec2 other) {
     return new Vec2(this.x - other.x, this.y - other.y);
   }
   
   public float dot(Vec2 other) {
     return this.x * other.x + this.y * other.y;
   }
   
   public float norm() {
     return sqrt(x * x + y * y);
   }
   
   public float distance(Vec2 other) {
     return sub(other).norm();
   }
}

class Mat2 {
  private float a;
  private float b;
  private float c;
  private float d;
  
  public Mat2(float a, float b, float c, float d) {
    this.a = a;
    this.b = b;
    this.c = c;
    this.d = d;
  }
  
  public float det() {
    return a * c - b * d;
  }
}

class Canvas {
  public static final int POINT_RADIUS = 4;
  private ArrayList<Vec2> points = new ArrayList();
  
  public void addRandomPoint() {
    int x = (int)random(width);
    int y = (int)random(height);
    addPoint(x, y);
  }
  
  public void addPoint(int x, int y) {
    points.add(new Vec2(x, y));
  }
  
  public void removePoint(int x, int y) {
    points.remove(selectPoint(x, y));
  }
  
  public Vec2 selectPoint(int x, int y) {
    Vec2 coords = new Vec2(x, y);
    for (Vec2 p : points) {
      if (p.distance(coords) <= POINT_RADIUS)
        return p;
    }
    return null;
  }
  
  void drawPoints() {
    fill(0);
    stroke(0);
    for (Vec2 p : points) {
      ellipse(p.x, p.y, POINT_RADIUS * 2, POINT_RADIUS * 2);
    }
  }
}

Canvas canvas = new Canvas();

enum State {
  DEFAULT,
  GW_HULL,
  GS_HULL,
}

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
  Vec2 p = canvas.selectPoint(pmouseX, pmouseY);
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
    case 'g':
    case 'G':
      break;
  }
  redraw();
}

void draw() {
  background(255);
  canvas.drawPoints();
}