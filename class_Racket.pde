class Racket
{
  float x;
  float y;
  float largura;
  float altura;
  color c;

  Racket(float x, float y, float largura, float altura, color c)
  {
    this.x = x;
    this.y = y;
    this.largura = largura;
    this.altura = altura;
    this.c = c;
  }
  void r1_move()
  {
    if (!game_over && b.vx!=0 && b.vy!=0 && !paused) 
    {
      if (key=='q')
        y-=60;
      if (key=='a')
        y+=60;
    }
  }

  void r2_move()
  {
    if (!game_over && b.vx!=0 && b.vy!=0 && !paused)
    {
      if (key=='p')
        y-=40;
      if (key=='l')
        y+=40;
    }
  }


  //--------------------------------------
  void draw() // função draw propria da classe
  {
    pushMatrix();
    noStroke();
    fill(c);
    rect(x, y, largura, altura);
    popMatrix();
  }
}

