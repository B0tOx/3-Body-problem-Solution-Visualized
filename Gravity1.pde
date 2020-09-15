ArrayList<Planet> planets;
float fmax = 0;
ArrayList<PVector> stars;
int steps = 100;

void setup() {
  //size(800, 600);
  fullScreen();
  frameRate(1000);

  planets = new ArrayList<Planet>();

  planets.add(new Planet(0.97000436, 0.24308731, 0.466203685, -0.43236573, 60, 1, 0, 0, 255));
  planets.add(new Planet(-0.97000436, -0.24308731, 0.466203685, -0.43236573, 60, 1, 255, 0, 0));
  planets.add(new Planet(0, 0, -0.93240737, 0.86473146, 60, 1, 255, 255, 255));

  stars = new ArrayList<PVector>();
  for (int i = 0; i < 500; i++) {
    stars.add(new PVector(random(0, width), random(0, height)));
  }
   for (int i = 0; i < steps; i++) {
    pre();
  }
}

void draw() {  
  background(0);
  for (int i = 0; i < stars.size()-1; i++) {
    PVector star = stars.get(i);
    stroke(255);
    point(star.x, star.y);
  }

  pushMatrix();
  translate(width/2, height/2);
  for (Planet planet1 : planets) {
    planet1.show();
  }
  popMatrix();

  for (Planet planet1 : planets) {
    planet1.grav(planet1, planets);
  }
  for (Planet planet1 : planets) {
    planet1.updateVel();
  }
}

void pre() {
  for (Planet planet1 : planets) {
    planet1.grav(planet1, planets);
  }

  for (Planet planet1 : planets) {
    planet1.updateVel();
  }
}
