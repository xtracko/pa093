import java.util.Collections;
import java.util.Comparator;

Vec findPivot(List<Vec> points) {
  return Collections.max(points, new Comparator<Vec>() {
      @Override
      public int compare(Vec a, Vec b) {
        int result = Float.compare(a.y, b.y);
        if (result == 0)
          return Float.compare(a.x, b.x) * (-1);
        return result;
      }
    });
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