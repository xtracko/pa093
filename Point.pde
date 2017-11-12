import java.util.Comparator;

class Point implements Comparable<Point> {
  public float x;
  public float y;
  public boolean flag = false;
  
  public Point(float x, float y) {
    this.x = x;
    this.y = y;
  }
  
  @Override
  boolean equals(Object other) {
    if (this == other)
        return true;      
    if (other == null || !(other instanceof Point))
      return false;
    return compareTo((Point)other) == 0;
  }
  
  @Override
  int compareTo(Point other) {
    int result = Float.compare(this.y, other.y);
    return (result != 0) ? result : Float.compare(other.x, this.x);
  }
  
  public Point mul(float scalar) { return new Point(x * scalar, y * scalar); }
  public Point div(float scalar) { return new Point(x / scalar, y / scalar); }
  
  public Point add(Point other) { return new Point(x + other.x, y + other.y); }
  public Point sub(Point other) { return new Point(x - other.x, y - other.y); }
   
  public float dot(Point other) { return x * other.x + y * other.y; }
  public float norm() { return sqrt(x * x + y * y); }
  
  public float distance(Point other) { return sub(other).norm(); }
}

class XComparator implements Comparator<Point> {
  @Override
  public int compare(Point lhs, Point rhs) {
    return Float.compare(lhs.x, rhs.x);
  }
}

class YComparator implements Comparator<Point> {
  @Override
  public int compare(Point lhs, Point rhs) {
    return Float.compare(lhs.y, rhs.y);
  }
}

float computeAngle(Point a, Point b, Point c) {
  Point l1 = b.sub(a);
  Point l2 = c.sub(b);
  float mag = l1.norm() * l2.norm();
  
  return acos(l1.dot(l2) / mag);
}

float crossProduct(Point a, Point b, Point c) {
  return (b.x - a.x) * (c.y - a.y) - (b.y - a.y) * (c.x - a.x);
}

boolean isCcw(Point a, Point b, Point c) {
  return Float.compare(crossProduct(a, b, c), 0) > 0;
}

Point closerPoint(Point from, Point toA, Point toB) {
  float dA = from.distance(toA);
  float dB = from.distance(toB);
  return (Float.compare(dA, dB) < 0) ? toA : toB;
}

class Edge {
    Point a;
    Point b;

    Edge(Point a, Point b) {
        this.a = a;
        this.b = b;
    }

    Edge reverse() {
        return new Edge(b, a);
    }

    @Override
    public boolean equals(Object other) {
        if (this == other)
            return true;      
        if (!(other instanceof Edge))
            return false;
        Edge edge = (Edge)other;
        return a.equals(edge.a) && b.equals(edge.b);
    }
}