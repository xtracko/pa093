import java.util.List;

List<Point> compute_delaunay_triangulation(List<Point> points) {
  if (points.size() <  3)
    return new ArrayList();
  
  List<Point> ordering = new ArrayList(points);
  Collections.sort(ordering);
  
  divide_to_left_and_right_path(points, ordering);
    
  Stack<Point> stack = new Stack();
  stack.push(ordering.get(0));
  stack.push(ordering.get(1));
  
  List<Point> triangulation = new ArrayList();
  for (Point p : ordering.subList(2, ordering.size())) {
    Point top = stack.pop();
    
    if (p.flag == top.flag) {      
      Point q = stack.pop();
      while(!stack.isEmpty() && !is_ccw(p, top, q)) {
        triangulation.add(p);
        triangulation.add(q);
        top = q;
        q = stack.pop();
      }
      stack.push(q);
    } else {
      triangulation.add(p);
      triangulation.add(top);
      
      while (!stack.isEmpty()) {
        triangulation.add(p);
        triangulation.add(stack.pop());
      }
    }
    
    stack.push(top);
    stack.push(p);
  }
  return triangulation;
}

void divide_to_left_and_right_path(List<Point> points, List<Point> ordering) {
  final int size = points.size();
  final int bot_index = points.indexOf(ordering.get(0));
  final int top_index = points.indexOf(ordering.get(ordering.size() - 1));
  
  for (int i = bot_index; i != top_index; i = (i + 1) % size) {
    points.get(i).flag = true;
  }
  for (int i = top_index; i != bot_index; i = (i + 1) % size) {
    points.get(i).flag = false;
  }
}

void draw_delaunay_triangulation(List<Point> points) {
  noFill();
  stroke(255, 85, 85);
  
  beginShape(LINES);
  for (Point p : compute_delaunay_triangulation(points))
    vertex(p.x, p.y);
  endShape();
}