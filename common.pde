import java.util.Collections;
import java.util.Comparator;

Vec findPivot(List<Vec> points) {
  return Collections.max(points);
}

List<Angle> computeAngles(Vec a, Vec b, List<Vec> cs) {
  List<Angle> angles = new ArrayList();
  for (Vec c : cs)
    angles.add(new Angle(a, b, c));
  return angles;
}

Angle findMinimalAngle(Vec a, Vec b, List<Vec> cs) {
  return Collections.min(computeAngles(a, b, cs));
}

boolean ccw(Vec a, Vec b, Vec c) {
  float cp = (b.x - a.x) * (c.y - a.y) - (b.y - a.y) * (c.x - a.x);
  return Float.compare(cp, 0) > 0;
}

class Stack<E> {
  private List<E> data = new ArrayList();
  
  public boolean isEmpty() {
    return data.isEmpty();
  }
    
  public E pop() {
    E e = data.get(data.size() - 1);
    data.remove(e);
    return e;
  }
  
  public void push(E e) {
    data.add(e);
  }
}