import java.util.List;

List<Point> grahamScan(List<Point> points) {
  if (points.size() < 3)
    return new ArrayList();
  
  Point pivot = Collections.max(points);
  Point xline = new Point(pivot.x - 1, pivot.y);
  
  List<Angle> angles = computeAngles(xline, pivot, points);
  Collections.sort(angles);
  removeSimilarAngles(pivot, angles);
  
  List<Point> hull = new ArrayList();
  hull.add(pivot);
  hull.add(angles.get(0).c);
  
  for (Angle angle: angles.subList(1, angles.size())) {
    Point a = hull.get(hull.size() - 2);
    Point b = hull.get(hull.size() - 1);
    Point c = angle.c;
       
    while (isCcw(a, b, c)) {
      hull.remove(hull.size() - 1);
        a = hull.get(hull.size() - 2);
        b = hull.get(hull.size() - 1);
    }
    
    hull.add(c);
  }

  return hull;
}

void removeSimilarAngles(Point pivot, List<Angle> angles) {
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

List<Angle> computeAngles(Point a, Point b, List<Point> cs) {
  List<Angle> angles = new ArrayList();
  for (Point c : cs)
    angles.add(new Angle(a, b, c));
  return angles;
}

class Angle implements Comparable<Angle> {
  public float value;
  public Point a;
  public Point b;
  public Point c;
  
  public Angle(Point a, Point b, Point c) {
    this.value = computeAngle(a, b, c);
    this.a = a;
    this.b = b;
    this.c = c;
  }
  
  @Override
  public int compareTo(Angle other) {
    return Float.compare(this.value, other.value);
  }
  
  @Override
  public boolean equals(Object other) {
    if (this == other)
        return true;      
    if (other == null || !(other instanceof Angle))
      return false;
    return compareTo((Angle)other) == 0;
  }
}