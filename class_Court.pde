class Court
{
  float x;
  float y;
  float largura;
  float altura;
  color c;

  Court(float x, float y, float largura, float altura, color c)
  {
    this.x = x;
    this.y = y;
    this.largura = largura;
    this.altura = altura;
    this.c = c;
  }
    

  //--------------------------------------
  void draw() // função draw propria da classe
  {
    pushMatrix();
    stroke(c);
    strokeWeight(8);
    noFill();
    rect(x,y,largura,altura);
    popMatrix();
  }
}

