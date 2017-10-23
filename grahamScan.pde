import java.util.List;
import java.util.Iterator;

List<Vec> grahamScan(List<Vec> points) {
  if (points.size() < 3)
    return new ArrayList();
  
  Vec pivot = findPivot(points);
  Vec xline = new Vec(pivot.x - 1, pivot.y);
  
  List<Angle> angles = computeAngles(xline, pivot, points);
  Collections.sort(angles);
  removeSimilarAngles(pivot, angles);
  
  List<Vec> hull = new ArrayList();
  hull.add(pivot);
  hull.add(angles.get(0).c);
  
  for (Angle angle: angles.subList(1, angles.size())) {
    Vec a = hull.get(hull.size() - 2);
    Vec b = hull.get(hull.size() - 1);
    Vec c = angle.c;
       
    while (ccw(a, b, c)) {
      hull.remove(hull.size() - 1);
        a = hull.get(hull.size() - 2);
        b = hull.get(hull.size() - 1);
    }
    
    hull.add(c);
  }
  
  return hull;
}

void removeSimilarAngles(Vec pivot, List<Angle> angles) {
  for (int i = 1; i != angles.size();) {
    Angle a = angles.get(i-1);
    Angle b = angles.get(i);
    
    if (!a.equals(b)) {
      ++i;
      continue;
    }
    
    float da = distance(pivot, a.c);
    float db = distance(pivot, b.c);
    angles.remove((Float.compare(da, db) < 0) ? a : b);
  }
}