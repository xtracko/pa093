enum Mode {
  DEFAULT,
  GW_HULL,
  GS_HULL,
  DE_TRIAG;
  
  @Override
  public String toString() {
    switch(this) {
    case DEFAULT: return "default";
    case GW_HULL: return "Gift-Wrapping hull";
    case GS_HULL: return "Graham-Scan hull";
    case DE_TRIAG: return "Delaunay triangulation";
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