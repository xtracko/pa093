import java.util.List;
import java.util.Collection;
import java.util.Map;
import java.util.Set;
import java.util.HashMap;

class UndirectedEdge {
  public final Point a;
  public final Point b;
  
  public UndirectedEdge(Point a, Point b) {
    this.a = a;
    this.b = b;
  }
  
  @Override
  public boolean equals(Object other) {
    if (other == this) return true;
    if (!(other instanceof UndirectedEdge)) return false;
    
    UndirectedEdge e = (UndirectedEdge) other;
    return (a == e.a && b == e.b) || (b == e.a && a == e.b);
  }
  
  @Override
  public int hashCode() {
    return a.hashCode() ^ b.hashCode();
  }
  
  public boolean covers(Point p) {
    return (p == a) || (p == b);
  }
}

class TrianglePair {
  public Triangle fst;
  public Triangle snd;
  
  public TrianglePair(Triangle fst, Triangle snd) {
    this.fst = fst;
    this.snd = snd;
  }
}

class EdgeMap {
  private Map<UndirectedEdge, TrianglePair> map = new HashMap();
  
  void add(UndirectedEdge e, Triangle t) {
    TrianglePair pair = (TrianglePair) map.get(e);
    
    if (pair == null) {
      map.put(e, new TrianglePair(t, null));
    } else {
      assert(pair.snd == null);
      pair.snd = t;
    }
  }
  
  Set<Map.Entry<UndirectedEdge, TrianglePair>> entrySet() {
    return map.entrySet();
  }
}

boolean xnor(boolean a, boolean b) {
  return (a && b) || (!a && !b);
}

Point centerpoint(UndirectedEdge edge) {
  return edge.a.add(edge.b).div(2);
}

Point circumcenter(Triangle triangle) {
  Point a = triangle.A;
  Point b = triangle.B;
  Point c = triangle.C;
  
  float cp = crossProduct(a, b, c);
  if (Float.compare(cp, 0) == 0)
    return null;

  float a2 = (a.x * a.x) + (a.y * a.y);
  float b2 = (b.x * b.x) + (b.y * b.y);
  float c2 = (c.x * c.x) + (c.y * c.y);
  float cx = (a2 * (b.y - c.y) + b2 * (c.y - a.y) + c2 * (a.y - b.y)) / (2 * cp);
  float cy = (a2 * (c.x - b.x) + b2 * (a.x - c.x) + c2 * (b.x - a.x)) / (2 * cp);

  return new Point(cx, cy);
}

List<Edge> voronoi(List<Triangle> triangulation) {
  EdgeMap edges = new EdgeMap();
  
  for (Triangle triangle : triangulation) {
    UndirectedEdge a = new UndirectedEdge(triangle.B, triangle.C);
    UndirectedEdge b = new UndirectedEdge(triangle.A, triangle.C);
    UndirectedEdge c = new UndirectedEdge(triangle.A, triangle.B);
    
    edges.add(a, triangle);
    edges.add(b, triangle);
    edges.add(c, triangle);
  }
  
  List<Edge> diagram = new ArrayList();
  
  for (Map.Entry<UndirectedEdge, TrianglePair> entry : edges.entrySet()) {
    UndirectedEdge edge = entry.getKey();
    TrianglePair pair = entry.getValue();
    
    if (pair.fst != null && pair.snd != null) {
      Point c1 = circumcenter(pair.fst);
      Point c2 = circumcenter(pair.snd);
      
      diagram.add(new Edge(c1, c2));
    }
    else if (pair.fst != null) {
      diagram.add(makeBorderEdge(edge, pair.fst));
    }
    else if (pair.snd != null) {
      diagram.add(makeBorderEdge(edge, pair.snd));
    }
  }
  
  return diagram;
}

Edge makeBorderEdge(UndirectedEdge edge, Triangle triangle) {
  boolean isACovered = edge.covers(triangle.A);
  boolean isBCovered = edge.covers(triangle.B);
  boolean isCCovered = edge.covers(triangle.C);
  
  Point c1 = circumcenter(triangle);
  Point c2 = centerpoint(edge);
  Point dir = c2.sub(c1).normalise();
  
  Point uncovered = null;
  if (isACovered && isBCovered) uncovered = triangle.C;
  if (isACovered && isCCovered) uncovered = triangle.B;
  if (isBCovered && isCCovered) uncovered = triangle.A;
  
  boolean isCircumCentreInTriangle = xnor(isCcw(edge.a, edge.b, c1), isCcw(edge.a, edge.b, uncovered));
  
  Point p = null;
  if (isCircumCentreInTriangle)
    p = c2.add(dir.mul(50));
  else
    p = c1.add(dir.mul(-50));
  
  return new Edge(c1, p);
}