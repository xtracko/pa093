class Stack<E> {
  private List<E> data = new ArrayList();
  
  public boolean isEmpty() {
    return data.isEmpty();
  }
  
  public int size() {
    return data.size();
  }
    
  public E pop() {
    final int i = data.size() - 1;
    final E e = data.get(i);
    data.remove(i);
    return e;
  }
  
  public void push(E e) {
    assert(data.add(e));
  }
}

boolean is_ccw(Point a, Point b, Point c) {
  float cp = (b.x - a.x) * (c.y - a.y) - (b.y - a.y) * (c.x - a.x);
  return Float.compare(cp, 0) > 0;
}

class Rect {
  final public Point a;
  final public Point b;
  
  Rect(Point a, Point b) {
    this.a = a;
    this.b = b;
  }
}