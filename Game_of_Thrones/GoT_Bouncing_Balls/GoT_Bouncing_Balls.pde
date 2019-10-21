int xSize = 3000;
int ySize = 2000;

float distance = 200;

Table table;

ArrayList<Person> characters = new ArrayList<Person>();

public class Person {
  
  private Ball ball;
  private String aliases;
  private int awoif_in_degree;
  private int awoif_infobox_length;
  private String[] awoif_links;
  private int awoif_out_degree;
  private int awoif_page_size;
  private int[] books;
  private String category;
  private String common_name;
  private String full_name;
  private String short_name;
  private String[] titles;
  private String url;
  private float score;
  
  Person(String full_name, float score){
     this.full_name = full_name;
     this.score = score;
     this.ball = new Ball(full_name, score);
  }
  
  void draw(){
    this.ball.draw();
  }
  
  void move(){
    this.ball.move();
  }
}


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
  private float radius;
  private Color rgb;
  private String label;

  Ball(String label, float radius) {
    this.x = (int)random(0, xSize);
    this.y = (int)random(0, ySize);
    this.speed = (int)random(2, 10);
    this.right = false;
    this.up = true;    
    this.radius = radius*100;
    this.rgb = new Color();
    this.label = label;
  }

  public void draw() {
    strokeWeight(0);
    fill(this.rgb.getRed(), this.rgb.getGreen(), this.rgb.getBlue());
    circle(this.x, this.y, this.radius);
    fill(255,255,255);
    textSize(30);
    text(this.label, this.x-100, this.y);
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
  size(3000, 2000);
  background(0, 0, 0);
  
  table = loadTable("GOT.csv", "header");

  println(table.getRowCount() + " total rows in table");

  for (TableRow row : table.rows()) {
    String name = row.getString("common_name");
    float score = row.getFloat("score");
    if(score > 0.95){
      characters.add(new Person(name, score));
    }
  }
}

void draw() {
  background(0, 0, 0);
  
  for (int i=0; i<characters.size(); i++) {
    characters.get(i).draw();
    characters.get(i).move();
  }  
}
