import java.util.List;

List<Point> compute_delaunay_triangulation(List<Point> points) {
  if (points.size() <  3)
    return new ArrayList();
  
  List<Point> ordering = new ArrayList(points);
  Collections.sort(ordering);
  
  Stack<Point> stack = new Stack();
  stack.push(ordering.get(0));
  stack.push(ordering.get(1));
  
  List<Point> triangulation = new ArrayList();
  for (Point p : ordering.subList(2, ordering.size())) {
    Point top = stack.pop();
    
    if (onTheSamePath(p, top)) {
      //while (isCorrectLine) {
      //  stack.pop();
      //}
      
      stack.push(p);
    } else {
      triangulation.add(p);
      while (!stack.isEmpty())
        triangulation.add(stack.pop());
        
      stack.push(top);
      stack.push(p);
    }
  }
  return triangulation;
}

void draw_delaunay_triangulation(List<Point> points) {
  noFill();
  stroke(255, 85, 85);
  
  beginShape(TRIANGLE_STRIP);
  for (Point p : compute_delaunay_triangulation(points))
    vertex(p.x, p.y);
  endShape();
}