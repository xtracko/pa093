import java.util.Collections;

List<Edge> delaunay(List<Point> points) {
  if (points.size() <  3)
    return new ArrayList();

  Point p = points.get(0);
  Point q = points.get(1);
  for (Point r : points.subList(2, points.size()))
    q = closerPoint(p, q, r);
  Edge e1 = new Edge(p, q);

  Point r = find_delaunay_point(e1, points);
  if (r == null) {
      e1 = e1.reverse();
      r = find_delaunay_point(e1, points);
  }
  Edge e2 = new Edge(e1.b, r);
  Edge e3 = new Edge(r, e1.a);
  
  AactiveEdgeList ael = new AactiveEdgeList();
  List<Edge> triangulation = new ArrayList();
  
  ael.add(e1);
  ael.add(e2);
  ael.add(e3);
  triangulation.add(e1);
  triangulation.add(e2);
  triangulation.add(e3);

  while (!ael.isEmpty()) {
    Edge edge = ael.get(0);
    Edge reverse = edge.reverse();

    p = find_delaunay_point(reverse, points);
    if (p != null) {
      e2 = new Edge(reverse.b, p);
      e3 = new Edge(p, reverse.a);
      ael.add(e2);
      ael.add(e3);
      triangulation.add(e2);
      triangulation.add(e3);
    }
    ael.remove(edge);
    triangulation.add(edge);
  }
  return triangulation;
}

float delaunay_distance(Edge edge, Point point) {
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

Point find_delaunay_point(Edge e, List<Point> ps) {
  Point result = null;
  float minimal = Float.MAX_VALUE;

  for (Point p : ps) {
    float d = delaunay_distance(e, p);
    if (Float.compare(d, minimal) == -1) {
      result = p;
      minimal = d;
    }
  }
  return result;
}

class AactiveEdgeList extends ArrayList<Edge> {
  @Override
  public boolean add(Edge e) {
    if (super.remove(e.reverse()))
      return false;
    return super.add(e);
  }
}