import java.util.Comparator;

int xSize = 3000;
int ySize = 2000;

int longMax = 800;
int largMax = 80;

int title = 100;
int header = 160;

int marginLeft = 200;
int marginTop = 275;
int marginBot = 200;
int marginRight = 650;

int paddingRight = 20;
int paddingNameLeft = 20;
int paddingTop = 50;

int nameSize = 500;
int titleSize = 60;
int headerSize = 40;
int textSize = 35;

float distance = 200;

Table table;

ArrayList<Person> characters = new ArrayList<Person>();

public class Person {
  
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
  }
  
  void draw(int i){
    float score = this.score * 100;
    float fromTop = marginTop + i*paddingTop*1.8;
    float fromLeft = marginLeft + nameSize + paddingNameLeft;
    float fromTopText = fromTop + textSize + 17;
    float columnLong = longMax * 1.2 * this.score;
    
    fill(255, 255, 255);    
    
    textSize(textSize);
    text(this.full_name, marginLeft, fromTopText);
    
    fill(255-score-70, 255-score-10, 255-score+30); 
    noStroke();
    rect(fromLeft, fromTop, columnLong, largMax);
    
    fill(255, 255, 255);
    text(this.score, fromLeft + columnLong + 20 , fromTopText);
  }
  
  float getScore(){
    return this.score; 
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

void setup() {
  size(3000, 2000);
  background(0, 0, 0);
  
  textSize(titleSize);
  text("Who is Game of Thrones character winner ?", marginLeft, title);
  textSize(headerSize);
  text("chart showing the top characters from Game of Thrones books according to their scores", marginLeft, header);
  
  table = loadTable("GOT.csv", "header");

  for (TableRow row : table.rows()) {
    String name = row.getString("common_name");
    float score = row.getFloat("score");
    if(score > 0.965){
      characters.add(new Person(name, score));
    }
  }

  for (int i=0; i<characters.size(); i++) {
    characters.get(i).draw(i);
  }  
  
  stroke(255, 255, 255);
  strokeWeight(2);
  line(marginLeft + nameSize + paddingNameLeft, marginTop, marginLeft + nameSize + paddingNameLeft, marginTop + characters.size()*paddingTop*1.787);

  for (int i = xSize - marginRight; i <= xSize - marginRight+550; i++) {
      float inter = map(i, xSize - marginRight, xSize - marginRight+550, 0, 1);
      color c = lerpColor(color(190), color(30, 60, 100), inter);
      stroke(c);
      line(i, ySize - marginBot, i, ySize - marginBot+largMax);
  }
  
  text("Score", xSize-marginRight-150, ySize-marginBot+130);
  text("0", xSize-marginRight, ySize-marginBot+130);
  text("2", xSize-marginRight+530, ySize-marginBot+130);
  
  
}
