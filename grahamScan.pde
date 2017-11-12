import java.util.List;
import java.util.Iterator;
import java.util.TreeMap;

List<Point> grahamScan(List<Point> points) {
  if (points.size() < 3)
    return new ArrayList();
  
  Point pivot = Collections.max(points);
  Point xline = new Point(pivot.x - 1, pivot.y);
  
  Iterator<Point> angles = compute_angles(xline, pivot, points);
  
  List<Point> hull = new ArrayList();
  hull.add(pivot);
  hull.add(angles.next());
  
  while (angles.hasNext()) {
    Point a = hull.get(hull.size() - 2);
    Point b = hull.get(hull.size() - 1);
    Point c = angles.next();
       
    while (isCcw(a, b, c)) {
      hull.remove(hull.size() - 1);
        a = hull.get(hull.size() - 2);
        b = hull.get(hull.size() - 1);
    }
    hull.add(c);
  }
  return hull;
}

Iterator<Point> compute_angles(Point a, Point pivot, List<Point> cs) {
  TreeMap<Float, Point> angles = new TreeMap();

  for (Point c1 : cs) {
    if(c1 == pivot)
      continue;
    
    float angle = computeAngle(a, pivot, c1);

    Point c2 = angles.get(angle);
    if (c2 == null || closerPoint(pivot, c1, c2) == c2)
      angles.put(angle, c1);
  }
  return angles.values().iterator();
}