import java.util.ArrayDeque;
import java.util.Queue;

class ActiveEdgeList extends ArrayDeque<Edge> {
  @Override
  public boolean add(Edge e) {
    if (super.remove(e.reverse()))
      return false;
    return super.add(e);
  }
}

List<Triangle> delaunay(List<Point> points) {
  if (points.size() < 3) {
    return new ArrayList();
  }

  Queue<Edge> ael = new ActiveEdgeList();
  List<Triangle> triangulation = new ArrayList();

  {
    Point a = points.get(0);
    Point b = a.closestPoint(points.subList(1, points.size()));

    Edge e = new Edge(a, b);
    Point c = findDelaunayPoint(e, points);
    if (c == null) {
        e = e.reverse();
        c = findDelaunayPoint(e, points);
    }

    ael.add(e);
    ael.add(new Edge(e.b, c));
    ael.add(new Edge(c, e.a));
    triangulation.add(new Triangle(a, b, c));
  }

  while (!ael.isEmpty()) {
    Edge e = ael.peek();
    Point p = findDelaunayPoint(e.reverse(), points);

    if (p != null) {
        ael.add(new Edge(e.a, p));
        ael.add(new Edge(p, e.b));
        triangulation.add(new Triangle(e.a, p, e.b));
    }
    ael.remove();
  }
  
  return triangulation;
}

float delaunayDistance(Edge edge, Point point) {
  Point a = edge.a;
  Point b = edge.b;
  Point c = point;

  float cp = crossProduct(a, b, c);
  if (Float.compare(cp, 0) >= 0)
    return Float.MAX_VALUE;

  float a2 = (a.x * a.x) + (a.y * a.y);
  float b2 = (b.x * b.x) + (b.y * b.y);
  float c2 = (c.x * c.x) + (c.y * c.y);
  float cx = (a2 * (b.y - c.y) + b2 * (c.y - a.y) + c2 * (a.y - b.y)) / (2 * cp);
  float cy = (a2 * (c.x - b.x) + b2 * (a.x - c.x) + c2 * (b.x - a.x)) / (2 * cp);

  Point center = new Point(cx, cy);
  float radius = center.distance(a);

  boolean abp = isCcw(edge.a, edge.b, point);
  boolean abc = isCcw(edge.a, edge.b, center);
  return (!abp && !abc) ? radius : -radius;
}

Point findDelaunayPoint(Edge e, List<Point> ps) {
  Point result = null;
  float minimal = Float.MAX_VALUE;

  for (Point p : ps) {
    float d = delaunayDistance(e, p);
    if (Float.compare(d, minimal) < 0) {
      result = p;
      minimal = d;
    }
  }
  return result;
}