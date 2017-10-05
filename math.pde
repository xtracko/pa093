class Vec {
  public float x;
  public float y;
  
  public Vec(float x, float y) {
    this.x = x;
    this.y = y;
  }
  
  public Vec mul(float scalar) {
    return new Vec(x * scalar, y * scalar);
  }
  
  public Vec div(float scalar) {
    return new Vec(x / scalar, y / scalar);
  }
  
  public Vec add(Vec other) {
    return new Vec(this.x + other.x, this.y + other.y);
  }
   
  public Vec sub(Vec other) {
    return new Vec(this.x - other.x, this.y - other.y);
  }
   
  public float dot(Vec other) {
    return this.x * other.x + this.y * other.y;
  }
   
  public float norm() {
    return sqrt(x * x + y * y);
  }
  
  @Override
  public boolean equals(Object other) {
    if (this == other)
        return true;
        
    if (other == null)
      return false;
      
    if (!(other instanceof Vec))
      return false;
      
    Vec vec = (Vec)other;
    return Float.compare(x, vec.x) == 0 && Float.compare(y, vec.y) == 0;
  }
}

class Angle implements Comparable<Angle> {
  public final float value;
  public final Vec a;
  public final Vec b;
  public final Vec c;
  
  public Angle(Vec a, Vec b, Vec c) {
    this.value = angle(a, b, c);
    this.a = a;
    this.b = b;
    this.c = c;
  }
  
  @Override
  public int compareTo(Angle other) {
    return Float.compare(this.value, other.value);
  }
  
  @Override
  public boolean equals(Object other) {
    if (this == other)
        return true;
    if (other == null)
      return false;
      
    if (!(other instanceof Angle))
      return false;
    return compareTo((Angle)other) == 0;
  }
}

float distance(Vec a, Vec b) {
  return a.sub(b).norm();
}

float angle(Vec a, Vec b, Vec c) {
  Vec l1 = b.sub(a);
  Vec l2 = c.sub(b);
  float mag = l1.norm() * l2.norm();
  
  return acos(l1.dot(l2) / mag);
}