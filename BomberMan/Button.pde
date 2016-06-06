class Button {
 int x, y;
 String text;
 int size;
 color normalColor;
 color overColor;
 boolean over;
 
 Button(int x, int y, String text, int size, color nc, color oc) {
   this.x = x;
   this.y = y;
   this.text = text;
   normalColor = nc;
   overColor = oc;
   this.size = size;
 }
 
 void draw() {
   //colorMode(HSB);
   textSize(size);
   if (over()) {
     fill(overColor);
   }
   else {
     fill(normalColor);
   }
   text(text, x, y);
 }
 
 boolean over() {
   return mouseX >= x && mouseX <= x + textWidth(text) && mouseY >= y && mouseY <= y + size;
 }
}