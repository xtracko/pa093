import java.util.List;

List<Vec> giftWrapping(List<Vec> points) {
  if (points.size() < 3)
    return new ArrayList();
    
  Vec pivot = findPivot(points);
  
  List<Vec> hull = new ArrayList();
  List<Vec> work = new ArrayList(points);
  hull.add(pivot);
  work.remove(pivot);
  
  Vec a = new Vec(pivot.x - 10, pivot.y);
  Vec b = pivot;
  
  do {
    Vec c = findMinimalAngle(a, b, points).c;
    hull.add(c);
    work.remove(c);
    
    
    a = b;
    b = c;
  } while (b != pivot);    
  return hull;
}