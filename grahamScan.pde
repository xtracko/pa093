import java.util.List;

List<Point> compute_graham_scan(List<Point> points) {
  if (points.size() < 3)
    return new ArrayList();
  
  Point pivot = Collections.max(points);
  Point xline = new Point(pivot.x - 1, pivot.y);
  
  List<Angle> angles = compute_angles(xline, pivot, points);
  Collections.sort(angles);
  remove_similar_angles(pivot, angles);
  
  List<Point> hull = new ArrayList();
  hull.add(pivot);
  hull.add(angles.get(0).c);
  
  for (Angle angle: angles.subList(1, angles.size())) {
    Point a = hull.get(hull.size() - 2);
    Point b = hull.get(hull.size() - 1);
    Point c = angle.c;
       
    while (is_ccw(a, b, c)) {
      hull.remove(hull.size() - 1);
        a = hull.get(hull.size() - 2);
        b = hull.get(hull.size() - 1);
    }
    
    hull.add(c);
  }
  
  return hull;
}

private void remove_similar_angles(Point pivot, List<Angle> angles) {
  for (int i = 1; i != angles.size();) {
    Angle a = angles.get(i-1);
    Angle b = angles.get(i);
    
    if (!a.equals(b)) {
      ++i;
      continue;
    }
    
    float da = pivot.distance(a.c);
    float db = pivot.distance(b.c);
    angles.remove((Float.compare(da, db) < 0) ? a : b);
  }
}

void draw_graham_scan(List<Point> points) {
  noFill();
  stroke(255, 85, 85);
  
  beginShape();
  for (Point p : compute_graham_scan(points))
    vertex(p.x, p.y);
  endShape();
}