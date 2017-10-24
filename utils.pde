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

boolean is_ccw(Point a, Point b, Point c) {
  float cp = (b.x - a.x) * (c.y - a.y) - (b.y - a.y) * (c.x - a.x);
  return Float.compare(cp, 0) > 0;
}