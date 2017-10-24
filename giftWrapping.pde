import java.util.List;

List<Point> compute_gift_wrapping(List<Point> points) {
  if (points.size() < 3)
    return new ArrayList();
    
  Point pivot = Collections.max(points);
  
  List<Point> hull = new ArrayList();
  List<Point> work = new ArrayList(points);
  hull.add(pivot);
  work.remove(pivot);
  
  Point a = new Point(pivot.x - 10, pivot.y);
  Point b = pivot;
  
  do {
    Angle minimal_angle = Collections.min(compute_angles(a, b, points));
    Point c = minimal_angle.c;
    hull.add(c);
    work.remove(c);
    
    
    a = b;
    b = c;
  } while (b != pivot);    
  return hull;
}