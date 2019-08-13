
class Ball
{
  float x; // x coordinate of center
  float y; // y coordinate of center
  float d; // diameter
  color c; // color
  float vx;// velocidade x
  float vy;// velocidade y
  float alpha;
  float distancia;


  Ball(float x, float y, float d, color c) // construtor
  {
    this.x = x;
    this.y = y;
    this.d = d;
    this.c = c;
    this.vx =0;
    this.vy = 0;
  }

  float area() //calcular área
  {
    return PI * sq(d/2);
  }

  boolean contains(float x, float y) //verificar se um ponto(x,y) pertence ao circulo
  {
    return sq(this.x-x)+sq(this.y-y) <= sq(this.d / 2);
  }

  void move(float dx, float dy) // mover o circulo na direção x ou y
  {
    x += dx;
    y += dy;
  }

  void moveTo(float x, float y) // mover o circulo para as coordenadas x,y
  {
    this.x = x;
    this.y = y;
  }

  void travel(float t)
  {
    move(vx*t, vy*t);
  }

  void setVelocity(float vx, float vy)
  {
    this.vx = vx;
    this.vy = vy;
  }

  void bounceInsideCourt(float x0, float y0, float w, float h)
  {
    if (y - d/2 <= y0 )
    {
      y = y0 + d/2;
      vy = -vy;
      musica[2].play();
      musica[2].rewind();
    }
    if (y + d/2 >= y0 + h)
    {
      y = y0 + h - d/2;
      vy = -vy;
      musica[2].play();
      musica[2].rewind();
    }
    /*    if (x - d/2 <= x0 )
     {
     x = x0 + d/2;
     vx = -vx;
     }
     if ()
     {
     x = x0 + w - d/2;
     vx = -vx;
     }*/
  }


  boolean bounceInsideRacket1(Racket other)
  {

    if ( x >= other.x - other.largura && x <= other.x + other.largura && y >= other.y - other.altura/2 && y <= other.y+other.altura/2 && !game_over)
    {
      distancia=y-(other.y-other.altura/2);
      alpha=distancia*HALF_PI/other.altura+(PI+HALF_PI)/2;
      vx=-cos(alpha);      
      vy=-sin(alpha);
      musica[1].play();
      musica[1].rewind();
      p1_lastplay=true;
      p2_lastplay=false;
    }
    return (x <= (width-x)/9);
  }

  boolean bounceInsideRacket2(Racket other)
  {

    if ( x >= other.x - other.largura && x <= other.x + other.largura && y >= other.y - other.altura/2 && y <= other.y+other.altura/2 && !game_over)
    {
      distancia=y-(other.y-other.altura/2);
      alpha=distancia*HALF_PI/other.altura+(PI+HALF_PI)/2;
      vx=cos(-alpha);      
      vy=sin(-alpha);
      musica[1].play();
      musica[1].rewind();
      p2_lastplay=true;
      p1_lastplay=false;
    }
    return (x >= (width-x)*5/6 + width*5/6);
  }
  //--------------------------------------
  void draw() // função draw propria da classe
  {
    pushMatrix();
    noStroke();
    fill(c);
    ellipse(x, y, d, d);
    popMatrix();
  }
}

