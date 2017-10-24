import java.util.Collections;

public class Angle implements Comparable<Angle> {
  public final float value;
  public final Point a;
  public final Point b;
  public final Point c;
  
  public Angle(Point a, Point b, Point c) {
    this.value = compute_angle(a, b, c);
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

float compute_angle(Point a, Point b, Point c) {
  Point l1 = b.sub(a);
  Point l2 = c.sub(b);
  float mag = l1.norm() * l2.norm();
  
  return acos(l1.dot(l2) / mag);
}

List<Angle> compute_angles(Point a, Point b, List<Point> cs) {
  List<Angle> angles = new ArrayList();
  for (Point c : cs)
    angles.add(new Angle(a, b, c));
  return angles;
}