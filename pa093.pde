enum Tool {
  POINTS,
  POLYGONS;
}

enum Algorithm {
  NONE,
  GW_HULL,
  GS_HULL,
  SL_TRIANGULATION,
  DE_TRIANGULATION,
  KD_TREE;
}


final color NORMAL_COLOR = color(233, 30, 99);
final color LIGHT_COLOR = color(255, 96, 144);
final color DARK_COLOR = color(176, 0, 58);

Points points = new Points();
Tool tool = Tool.POINTS;
Algorithm algorithm = Algorithm.NONE;

void setup() {
  size(1000, 800);
}

void draw() {
  background(255);
  
  if (tool == Tool.POINTS) {
    drawSubcaption("Points");
    drawPoints(points);
  } else {
    drawSubcaption("Polygons");
    drawPoints(points);
    drawClosedPolygon(points);
  }

  switch (algorithm) {
    case NONE: {
      drawCaption("none");
      break;
    }
    case GW_HULL: {
      drawCaption("Gift-Wrapping");
      drawPolygon(giftWrapping(points));
      break;
    }
    case GS_HULL: {
      drawCaption("Graham-Scan");
      drawPolygon(grahamScan(points));
      break;
    }
    case SL_TRIANGULATION: {
      drawCaption("Sweep-Lane");
      List<Point> polygon = grahamScan(points);
      drawPolygon(polygon);
      drawLines(sweepLane(polygon));
      break;
    }
    case DE_TRIANGULATION: {
      drawCaption("Delaunay");
      break;
    }
    case KD_TREE: {
      drawCaption("KD-Tree");
      drawKdTree(kdTree(points));
      break;
    }
  }
  
  drawHelp();
}

void mouseClicked() {
  switch (mouseButton) {
  case LEFT: points.add(mouseX, mouseY); break;
  case RIGHT: points.remove(mouseX, mouseY); break;
  }
  
  redraw();
}

void mouseDragged() {
  Point selected = points.find(pmouseX, pmouseY);
  if (selected != null) {
    selected.x = mouseX;
    selected.y = mouseY;
  }

  redraw();
}

void keyPressed() {
  switch (key) {
  case 'p': tool = (tool == Tool.POINTS) ? Tool.POLYGONS : Tool.POINTS; break;
  case 'r': points.addRandom(5); break;
  case 'c': points.clear(); break;
  case 'n': algorithm = Algorithm.NONE; break;
  case 'h': algorithm = Algorithm.GW_HULL; break;
  case 'g': algorithm = Algorithm.GS_HULL; break;
  case 't': algorithm = Algorithm.SL_TRIANGULATION; break;
  case 'd': algorithm = Algorithm.DE_TRIANGULATION; break;
  case 'k': algorithm = Algorithm.KD_TREE; break;
  }
  
  redraw();
}

void drawHelp() {
  String help = "[left click] add point\n"
              + "[right click] remove point\n"
              + "[mouse drag] move point\n"
              + "[r] add 5 random points\n"
              + "[c] clear canvas\n"
              + "[p] switch points or polygons\n"
              + "[n] none\n"
              + "[h] Gift-Wrapping\n" 
              + "[g] Graham-Scan\n"
              + "[t] Sweeping-Lane\n"
              + "[d] Delaunay\n"
              + "[k] KD-Tree\n";
  fill(0);
  text(help, width - textWidth(help) - 20, 20);
}

void drawCaption(String caption) {
  fill(NORMAL_COLOR);
  text(caption, 20, 20);
}

void drawSubcaption(String subcaption) {
  fill(LIGHT_COLOR);
  text(subcaption, 20, 45);
}

void drawPoints(List<Point> points) {
  fill(0);
  stroke(0);

  for (Point p : points)
    ellipse(p.x, p.y, 8, 8);
}

void drawPolygon(List<Point> points) {
  noFill();
  stroke(DARK_COLOR);
  
  beginShape();
  for (Point p: points)
    vertex(p.x, p.y);
  endShape();
}

void drawClosedPolygon(List<Point> points) {
  noFill();
  stroke(DARK_COLOR);
  
  beginShape();
    for (Point p: points) {
      vertex(p.x, p.y);
    }
    if (points.size() > 2) {
      Point front = points.get(0);
      vertex(front.x, front.y);
    }
  endShape();
}

void drawLines(List<Point> points) {
  noFill();
  stroke(DARK_COLOR);
  
  beginShape(LINES);
  for (Point p : points)
    vertex(p.x, p.y);
  endShape();
}

class Points extends ArrayList<Point> {  
  Point find(float x, float y) {
    for (Point p : points)
      if (p.distance(new Point(x, y)) <= 4)
        return p;
    return null;
  }
  
  void add(float x, float y) {
    super.add(new Point(x, y));
  }
  
  void remove(float x, float y) {
    super.remove(find(x, y));
  }
  
  void addRandom(int n) {
    float span = 6;
    for (int i = 0; i != n; ++i) {
      int x = (int)(randomGaussian() * (width / span)) + (width / 2);
      int y = (int)(randomGaussian() * (height / span)) + (height / 2);
      add(new Point(x, y));
    }
  }
}