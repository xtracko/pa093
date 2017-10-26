import java.util.Collections;
import java.util.List;

class Canvas {
  private final int POINT_RADIUS = 4;
  private List<Point> points = new ArrayList();
  
  
  public void add_point(int x, int y) {
    points.add(new Point(x, y));
  }
  
  public void remove_point(int x, int y) {
    points.remove(select_point(x, y));
  }
  
  public void cleanPoints() {
    points.clear();
  }
  
  public Point select_point(int x, int y) {
    Point coords = new Point(x, y);
    for (Point p : points) {
      if (p.distance(coords) <= POINT_RADIUS)
        return p;
    }
    return null;
  }
  
  public void add_random_points(int n) {
    if (n < 0)
      throw new IllegalArgumentException("Negative count of points");
    
    final float span = 6;
    for (int i = 0; i != n; ++i) {
      int x = (int)(randomGaussian() * (width / span)) + (width / 2);
      int y = (int)(randomGaussian() * (height / span)) + (height / 2);
      
      add_point(x, y);
    }
  }
  
  public List<Point> get_points() {
    return Collections.unmodifiableList(points);
  }
  
  void draw_points() {
    fill(200);
    stroke(200);
    
    for (Point p : get_points()) {
      ellipse(p.x, p.y, POINT_RADIUS * 2, POINT_RADIUS * 2);
    }
  }
  
  void draw_shape() {
    noFill();
    stroke(200);
    
    beginShape();
    for (Point p : get_points())
      vertex(p.x, p.y);
    endShape(CLOSE);
  }
}