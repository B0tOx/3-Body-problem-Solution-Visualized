import java.util.Arrays;

class Planet {
  PVector pos;
  PVector vel;
  float radius;
  float mass;
  float r, g, b;
  PVector currVel;
  ArrayList<PVector> posStore;

  int traillength = 200;
  float Grav = 1;

  Planet(float x, float y, float vx, float vy, float r, float m, float re, float g, float b) {
    this.pos = new PVector(x, y);
    this.vel = new PVector(vx, vy);
    this.radius = r;
    this.mass = m;
    this.r = re;
    this.g = g;
    this.b = b;
    this.posStore = new ArrayList<PVector>(traillength);
    for (int i = 0; i < traillength; i++) {
      posStore.add(new PVector(this.pos.x, this.pos.y));
    }
  }

  void grav(Planet planet1, ArrayList<Planet> planets) {
    for (Planet planet2 : planets) {
      if (planet1 == planet2) continue;
      PVector forceDir = PVector.sub(planet2.pos, planet1.pos); 
      float d = forceDir.magSq();
      forceDir.normalize();
      PVector f = forceDir.mult(Grav * planet2.mass / d);
      PVector temp = new PVector(f.x, f.y);   
      vel = planet1.vel.add(temp.mult(0.01));
    }
  }

  void updateVel() {
    PVector temp = new PVector(vel.x, vel.y); 
    pos.add(temp.mult(0.01));
    posStore.add(0, new PVector(this.pos.x, this.pos.y));
    if ( posStore.size() >= traillength) posStore.remove(traillength);
  }
  
  float exp(float a) {
    float a2 = 255 * (pow(0.97, a));
    return a2;
  }

  void show() {
    for (int i = posStore.size()-1; i > -1; i--) {
      PVector pos2 = posStore.get(i);
      float a = map(i, 0, posStore.size(), 0, 255);
      float r1 = r;
      float g1 = g;
      float b1 = b;
      if (i != 0) {
        r1 = r/2;
        g1 = g/2;
        b1 = b/2;
      }
      else{
        r1 = r;
        g1 = g;
        b1 = b;
      }
      float a1 = exp(a);

      noStroke();
      fill(r1, g1, b1, a1);
      if (pos2 != null) circle(pos2.x * 400, pos2.y * 400, this.radius);
    }
  }
}
