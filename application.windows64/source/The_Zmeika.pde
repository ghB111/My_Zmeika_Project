final int scale = 40;
final int wait = 720/4;
final int fruitAmount =3;

long time;
ArrayList<Fruit> fruits;
Snake snake;
boolean dead = false;
void setup(){
  size(800,800);
  fruits = new ArrayList<Fruit>();
  snake = new Snake();
  time = millis();
  for (int i = 0; i<fruitAmount; i++) {
    fruits.add(new Fruit());
  }
};


void draw(){
  if (dead) {delay(1500);exit();}
  background(254,255,10);
  strokeWeight(6);
  grid();
  showfruits();
  snake.show();
  snake.checkkey();
  if (snake.dead()) { death(); dead=true;} else {
  if (millis()>=time+wait) {
    for (int i = 0; i < fruits.size(); i++){
      if (fruits.get(i).x==snake.x && fruits.get(i).y==snake.y) {snake.eat(); destroyfruit(i);}
    }
    snake.update(); time=millis();}
}};

class Fruit {
    int x,y;
    void show() {
     fill(255,113,220);
     rect(x,y,scale,scale);  
    }
    Fruit() {
       boolean notok = true;
       while(notok) {
         notok = false;
         x = int(random(0,width/scale))*scale;
         y = int(random(0,height/scale))*scale;
         for (int i = 0; i < fruits.size(); i++) {
          if (x==fruits.get(i).x&&y==fruits.get(i).y) {notok=true; break;} //еще проверка на тело
       }
       if (!notok) {
         for (int i = 0; i<snake.tail.size(); i++ ) {
           if (x==snake.tail.get(i).x && y==snake.tail.get(i).y ) {notok = true; break;}
         }
     }
     }
    }
};

class Snake {
  int x,y;
  int dir;
  ArrayList<block> tail;
  
  Snake() {
   x = width/2;
   y = height/2;
   dir = 0;  
   tail = new ArrayList<block>();
  };
  
  void eat(){
  if (tail.size()==0){
  if (dir==0) {tail.add(new block(x,y+scale,dir));}
     if (dir==1) {tail.add(new block(x-scale,y,dir));}
     if (dir==2) {tail.add(new block(x,y-scale,dir));}
     if (dir==3) {tail.add(new block(x+scale,y,dir));}
}
  else {
    int lastDir = tail.get(tail.size()-1).dir;
    int lastX = tail.get(tail.size()-1).x;
    int lastY = tail.get(tail.size()-1).y;
     if (lastDir==0) {tail.add(new block(lastX,lastY+scale,lastDir));}
     if (lastDir==1) {tail.add(new block(lastX-scale,lastY,lastDir));}
     if (lastDir==2) {tail.add(new block(lastX,lastY-scale,lastDir));}
     if (lastDir==3) {tail.add(new block(lastX+scale,lastY,lastDir));}
  }
  }
  
  void show() {
    fill(19,188,59); push();
   rect(x,y,scale,scale);
    fill(255);
    if(dir==0){
    circle(x+scale/4,y+scale/4,18);
    circle(x+scale/4+scale/2,y+scale/4,18);}
    if (dir==1) {
    circle(x+3*scale/4,y+scale/4,18);
    circle(x+scale/4+scale/2,y+3*scale/4,18);}
    if (dir==2) {
    circle(x+scale/4,y+3*scale/4,18);
    circle(x+3*scale/4,y+3*scale/4,18);
    }
    if (dir==3) {
    circle(x+scale/4,y+scale/4,18);
    circle(x+scale/4,y+3*scale/4,18);
    }
    pop();
   for (int i = 0; i<tail.size(); i++) {
     tail.get(i).show();  
   }
  }
  void update() {
   if(tail.size()>0){ updatetail();};
   switch(dir) {
    case 0:
      y-=scale;break;
    case 1:
      x+=scale;break;
    case 2:
      y+=scale;break;
    case 3:
      x-=scale;break;
   }
   if (x>=width) {x=0;}
   if (y>=height) {y=0;}
   if (x<0) {x=width;}
   if (y<0) {y=height;}
  };
  
  void updatetail() {
    for (int i = tail.size()-1; i > 0; i--) {
        tail.get(i).x = tail.get(i-1).x;
        tail.get(i).y = tail.get(i-1).y;
    }
    tail.get(0).x = x;
    tail.get(0).y = y;
  
}
  
  void checkkey() {
   if (keyPressed) {
    if ((key=='W' || key == 'w' || key=='ц'|| key=='Ц' || keyCode==UP)&&(tail.size()<2 || dir!=2)) {dir = 0;}
    if ((key=='D' || key == 'd' || key=='в'|| key=='В' || keyCode==RIGHT)&&(tail.size()<2 || dir!=3)) {dir=1;}
    if ((key=='S' || key == 's' || key=='ы'|| key=='Ы' || keyCode==DOWN)&&(tail.size()<2 || dir!=0)) {dir=2;}
    if ((key=='A' || key == 'a' || key=='ф'|| key=='Ф' || keyCode==LEFT)&&(tail.size()<2 || dir!=1)) {dir=3;}
   }
  }
  
  boolean dead() {
     
    for(int i = 0; i < tail.size(); i++) {
     if (x==tail.get(i).x && y==tail.get(i).y) {return true;} 
    }
    return false;
  }
  
};

class block {
  int x,y;
  int dir; 
  block (int x0,int y0, int direction) {
   x=x0;
   y=y0;
  }
  void show(){
   rect(x,y,scale,scale); 
  }
  void update() {
    switch(dir) {
    case 0:
      y-=scale;break;
    case 1:
      x+=scale;break;
    case 2:
      y+=scale;break;
    case 3:
      x-=scale;break;
   } 
    
  }
};
void grid() {
  for (int i = scale; i < width; i+=scale) {
   line(i,0,i,height);
   line(0,i,width,i);
  }
    
};
void showfruits() {
   for(int i = 0;i < fruits.size(); i++) {
    fruits.get(i).show(); 
   }
  
}

void destroyfruit(int i) {
  fruits.remove(i);
  fruits.add(new Fruit());
}
void death() {
   background(0);
   textSize(55);
   fill(252,3,7);
   text("YOU ARE DEAD", width/4,height/2);
}
