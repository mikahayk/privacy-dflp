import spout.*;


final int TEXT_SIZE=14;
final int TEXT_SIZE_BOLD = 20;
  
//Declare our canvas.
PGraphics canvas;
PImage img; 

//Declare our Syphon Server
Spout server;

PFont fontNormal, fontBold, fontItalic, h1, h2, highlight;

boolean erase = false;
int img_x = 0, img_y = 0, text_x = 0, text_y = 0;
int img_width = 100, img_height = 100;
int gap100 = 100, gap50 = 50, gap20 = 20, gap30 = 30, gap60 = 60;



void settings () {
  size (1200, 600, P3D);

}

void setup () {

    
  fontNormal = createFont("Arial", TEXT_SIZE);
  fontBold   = createFont("Arial Bold", TEXT_SIZE_BOLD);
  h1 = createFont("Arial Bold", 50);
  h2 = createFont("Arial Bold", 30);
  highlight = createFont("Arial Bold", 50);
  
  //Set up our canvas to draw on
  canvas = createGraphics(width, height, P3D);

  //Set up our Syphon Server
  server = new Spout(this);
  server.createSender("magic");

  //I like to setup a black background

  canvas.beginDraw();
  canvas.background(0);
  canvas.endDraw();
}

void draw () {

    background(255,255,255,0);
    //background(0,0,0,0);
    noStroke();
   
   JSONArray data = loadJSONArray("http://localhost/privacy/index.php");
   //JSONArray data = loadJSONArray("http://magic.hosting.nyu.edu/privacy/index.php");

    if (data == null) {
      println("JSONObject could not be parsed");
    } else {
      
      img_x = 20; img_y = 200; /* Init first image position */ 
      text_x = 20; text_y = img_y + img_height + gap20;

      for (int i = 0; i < data.size(); i++) {
         
        if(i == 9) {
          img_x = 20;
          img_y += 210;
          text_x = 20;
          text_y += 210;
        }
        textFont(h1);
        text("MATCH or NOT ?", 400, 40);
 
        textFont(h2);
        fill(255,0,0,255);
        text("Send", 50, 100);
        delay(1000);
        fill(255,0,0,255);
        text("Send", 50, 100);
 
        fill(255,255,255,255);
        textFont(h2);
        text("an SMS to ", 130, 100);
        
        textFont(highlight);
        text("(551) 231 1717", 300, 105);

        textFont(h2);
        text("with the text ", 650, 100);
         /* YES or NO*/

        textFont(highlight);
        text("YES", 850, 105);
        
        textFont(h2);
        text("or", 970, 100);

        
        textFont(highlight);
        text("NO", 1015, 105);
        
        JSONObject poll = data.getJSONObject(i); 
        PImage img;
        img = loadImage(poll.getString("img"));
        image(img, img_x, img_y, img_width, img_height);
        textFont(fontNormal);
        text(poll.getString("name"), text_x, text_y); /* Full name */
        
        textFont(fontBold);
        text("seat : " + poll.getString("seat"), text_x, text_y + gap30); /* Seat */
        
        textFont(fontBold);
        text("voted : " + poll.getString("message"), text_x, text_y + gap60); /* Seat */
        
        img_x += img_width + gap30;
        text_x += img_width + gap30;
      }
      
    }
    
    
    /*
    JSONArray chart_data = loadJSONArray("http://localhost/privacy/chart.php");


     textSize(32);
     fill(0, 0, 0);
     text(chart_data.getJSONObject(0).getInt("yes") + "%", 300, 100);
     text(chart_data.getJSONObject(0).getInt("no") + "%", 600, 100);
     */
     
     
     server.sendTexture();

     delay(3000);
}

void keyPressed () {
  if (key=='e') {
    erase=!erase;
  }
}
