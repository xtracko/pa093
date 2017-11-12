import java.util.Collections;
import java.util.List;

List<Point> giftWrapping(List<Point> points) {
  if (points.size() < 3)
    return new ArrayList();
  
  Point pivot = Collections.max(points);

  List<Point> hull = new ArrayList();
  hull.add(pivot);
  
  Point a = new Point(pivot.x - 10, pivot.y);
  Point b = pivot;
  Point c = find_minimal_angle(a, b, points);
  
  while(c != pivot) {
    hull.add(c);

    a = b;
    b = c;
    c = find_minimal_angle(a, b, points);
  }
  return hull;
}

Point find_minimal_angle(Point a, Point b, List<Point> cs) {
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