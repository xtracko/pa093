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
  
  public void draw_points() {
    fill(200);
    stroke(200);
    
    for (Point p : points) {
      ellipse(p.x, p.y, POINT_RADIUS * 2, POINT_RADIUS * 2);
    }
  }
  
  public void draw_shape() {
    noFill();
    stroke(200);
    
    beginShape();
    for (Point p : points)
      vertex(p.x, p.y);
    endShape();
  }
  
  public void draw_gift_wrapping() {
    List<Point> hull = compute_gift_wrapping(points);
    draw_hull(hull);
  }
  
  public void draw_graham_scan() {
    List<Point> hull = compute_graham_scan(points);
    draw_hull(hull);
  }
  
  public void draw_delaunay_triangulation() {
    noFill();
    stroke(255, 85, 85);
    
    beginShape(TRIANGLES);
    for (Point p : compute_delaunay_triangulation(points))
      vertex(p.x, p.y);
    endShape();
  }
  
  private void draw_hull(List<Point> points) {
    noFill();
    stroke(255, 85, 85);
    
    beginShape();
    for (Point p : points)
      vertex(p.x, p.y);
    endShape();
  }
}

void draw_variable(String name, String value, float x, float y) {
  fill(0);
  text(name, x, y);
  
  fill(255, 85, 85);
  text(value, x + textWidth(name), y);
}