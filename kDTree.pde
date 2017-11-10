import java.util.List;

KdNode kdTree(List<Point> points) {    
  return kdTree(new ArrayList(points), true);
}

KdNode kdTree(List<Point> points, boolean xcut) {
  if (points.isEmpty())
    return null;
    
  if (xcut) {
    Collections.sort(points, new XComparator());
  } else {
    Collections.sort(points, new YComparator());
  }
  
  int size = points.size();
  int half = size / 2;
  
  List<Point> lpoints = new ArrayList(points.subList(0, half));
  List<Point> rpoints = new ArrayList(points.subList(half + 1, size));
  
  KdNode ltree = kdTree(lpoints, !xcut);
  KdNode rtree = kdTree(rpoints, !xcut);
  
  return new KdNode(points.get(half), ltree, rtree);
}

class KdNode {
  Point point;
  KdNode left;
  KdNode right;

  KdNode(Point point, KdNode left, KdNode right) {
    this.point = point;
    this.left = left;
    this.right = right;
  }
}

void drawKdTree(KdNode root) {
  noFill();
  stroke(DARK_COLOR);

  drawKdTree(root, new Point(0, 0), new Point(width, height), true);
}

void drawKdTree(KdNode node, Point a, Point b, boolean xcut) {
  if (node == null)
    return;
    
  Point p = null;
  Point q = null;
    
  if (xcut) {
    p = new Point(node.point.x, a.y);
    q = new Point(node.point.x, b.y);
  } else {
    p = new Point(a.x, node.point.y);
    q = new Point(b.x, node.point.y);
  }
  line(p.x, p.y, q.x, q.y);
  
  drawKdTree(node.left, a, q, !xcut);
  drawKdTree(node.right, p, b, !xcut);
}