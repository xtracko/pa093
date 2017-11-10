import java.util.List;

List<Point> sweepLane(List<Point> points) {
  if (points.size() <  3)
    return new ArrayList();
  
  List<Point> ordering = new ArrayList(points);
  Collections.sort(ordering);
  
  divideToLeftAndRightPath(points, ordering);
    
  Stack<Point> stack = new Stack();
  stack.push(ordering.get(0));
  stack.push(ordering.get(1));
  
  List<Point> triangulation = new ArrayList();
  for (Point p : ordering.subList(2, ordering.size())) {
    Point top = stack.pop();
    
    if (p.flag == top.flag) {      
      Point q = stack.pop();
      while(!stack.isEmpty() && !isCcw(p, top, q)) {
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

void divideToLeftAndRightPath(List<Point> points, List<Point> ordering) {
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

class Stack<E> {
  private List<E> data = new ArrayList();
  
  public boolean isEmpty() {
    return data.isEmpty();
  }
  
  public int size() {
    return data.size();
  }
    
  public E pop() {
    E item = data.get(data.size() - 1);
    data.remove(item);
    return item;
  }
  
  public void push(E e) {
    assert(data.add(e));
  }
}