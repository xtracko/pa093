import java.util.Collections;
import java.util.List;

List<Point> giftWrapping(List<Point> points) {
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
    Point c = minimalAngle(a, b, points);
    hull.add(c);
    work.remove(c);
    
    a = b;
    b = c;
  } while (b != pivot);

  return hull;
}

Point minimalAngle(Point a, Point b, List<Point> cs) {
  Point point = null;
  float minimum = Float.MAX_VALUE;

  for (Point c : cs) {
    float angle = computeAngle(a, b, c);
    if (angle < minimum) {
      minimum = angle;
      point = c;
    }
  }

  return point;
}