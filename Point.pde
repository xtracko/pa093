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