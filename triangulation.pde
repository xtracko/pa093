import java.util.List;
import java.util.Iterator;

List<Vec> delaunayTriangulation(List<Vec> points) {
  if (points.size() <  3)
    return new ArrayList();
  
  Collections.sort(points);
  
  Stack<Vec> stack = new Stack();
  stack.push(points.get(0));
  stack.push(points.get(1));
  
  for (Vec p : points.subList(2, points.size())) {
    Vec top = stack.pop();
    
    if (onTheSamePath(p, top)) {
      while (isCorrectLine) {
        stack.pop();
      }
      stack.push(p);
    } else {
      // TODO
      stack.push(top);
      stack.push(p);
    }
  }
  
  return new ArrayList();
}