import java.util.List;

KdNode compute_kd_tree(List<Point> points) {    
  return build_kd_tree(new ArrayList(points), true);
}

void draw_kd_tree(List<Point> points) {
  noFill();
  stroke(255, 85, 85);
  
  Rect canvas = new Rect(new Point(0, 0), new Point(width, height));
  KdNode root = compute_kd_tree(points);
  draw_kd_tree_impl(root, canvas, true);
}

void draw_kd_tree_impl(KdNode node, Rect rect, boolean xcut) {
  if (node == null)
    return;
    
  Point p = null;
  Point q = null;
    
  if (xcut) {
    p = new Point(node.point.x, rect.a.y);
    q = new Point(node.point.x, rect.b.y);
  } else {
    p = new Point(rect.a.x, node.point.y);
    q = new Point(rect.b.x, node.point.y);
  }
  line(p.x, p.y, q.x, q.y);
  
  draw_kd_tree_impl(node.left, new Rect(rect.a, q), !xcut);
  draw_kd_tree_impl(node.right, new Rect(p, rect.b), !xcut);
}

class KdNode {
  public final Point point;
  public final KdNode left;
  public final KdNode right;

  public KdNode(Point point, KdNode left, KdNode right) {
    this.point = point;
    this.left = left;
    this.right = right;
  }
}

KdNode build_kd_tree(List<Point> points, boolean xcut) {
  if (points.isEmpty())
    return null;
  //if (points.size() == 1)
    //return new KdNode(points.get(0), null, null);
    
  if (xcut) {
    Collections.sort(points, new XComparator());
  } else {
    Collections.sort(points, new YComparator());
  }
  
  int size = points.size();
  int half = size / 2;
  
  List<Point> lpoints = new ArrayList(points.subList(0, half));
  List<Point> rpoints = new ArrayList(points.subList(half + 1, size));
  
  KdNode ltree = build_kd_tree(lpoints, !xcut);
  KdNode rtree = build_kd_tree(rpoints, !xcut);
  
  return new KdNode(points.get(half), ltree, rtree);
}