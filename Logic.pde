enum Mode {
  DEFAULT,
  GW_HULL,
  GS_HULL,
  DE_TRIAG,
  KD_TREE;
  
  @Override
  public String toString() {
    switch(this) {
    case DEFAULT: return "default";
    case GW_HULL: return "Gift-Wrapping hull";
    case GS_HULL: return "Graham-Scan hull";
    case DE_TRIAG: return "Delaunay triangulation";
    case KD_TREE: return "Kd-Tree";
    }
    throw new IllegalArgumentException("undefined");
  }
}

enum Tool {
  POINT,
  POLYGON;
  
  @Override
  public String toString() {
    switch(this) {
    case POINT: return "Point";
    case POLYGON: return "Polygon";
    }
    throw new IllegalArgumentException("undefined");
  }
}