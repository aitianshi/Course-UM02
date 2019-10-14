int xSize = 1500;
int ySize = 1500;

float distance = 200;

int nbBalls = (int)random(15, 25);
ArrayList<Ball> balls = new ArrayList<Ball>();

public class Color {
  private int r;
  private int g;
  private int b;
  
  Color(){
    this.r = (int)random(0, 256);
    this.g = (int)random(0, 256);
    this.b = (int)random(0, 256);
  }
  
  public int getRed(){ return this.r; }
  public int getGreen(){ return this.g; }
  public int getBlue(){ return this.b; }
}

public class Ball {
  private int x;
  private int y;
  private int speed;
  private boolean right;
  private boolean up;
  private int radius;
  private Color rgb;

  Ball() {
    this.x = (int)random(0, xSize);
    this.y = (int)random(0, xSize);
    this.speed = (int)random(2, 8);
    this.right = false;
    this.up = true;    
    this.radius = 80;
    this.rgb = new Color();
  }

  public void draw() {
    strokeWeight(0);
    fill(this.rgb.getRed(), this.rgb.getGreen(), this.rgb.getBlue());
    circle(this.x, this.y, this.radius);
  }

  public void move() {
    if (this.x >= xSize - this.radius/2) {
      this.right = false;
    } 
    if (this.x <= 0 + this.radius/2) {
      this.right = true;
    }

    if (this.right == false) {
      this.x -= this.speed;
    } else {
      this.x += this.speed;
    }

    if (this.y >= ySize - this.radius/2) {
      this.up = true;
    }
    if (this.y <= 0 + this.radius/2) {
      this.up = false;
    }

    if (this.up == true) {
      this.y -= this.speed;
    } else {
      this.y += this.speed;
    }
  }
  
  boolean close(Ball b){
    float x = pow((b.x - this.x), 2);
    float y = pow((b.y - this.y), 2);
    return sqrt(x+y) < distance;
  }
}

void setup() {
  background(0, 0, 0);
}

void settings(){
   size(1500, 1500);
}

void draw() {
  background(0, 0, 0);
  
  for (int i=0; i<nbBalls; i++) {
    balls.add(new Ball());
    balls.get(i).draw();
    balls.get(i).move();
  }
  
  for (int j=0; j<nbBalls; j++){
    for (int k=0; k<nbBalls; k++){
      if(j!=k && balls.get(j).close(balls.get(k))){
        strokeWeight(4);
        strokeCap(ROUND);
        stroke(255,255,255);
        line(balls.get(j).x, balls.get(j).y, balls.get(k).x, balls.get(k).y);
      }
    }
  }
  
}
