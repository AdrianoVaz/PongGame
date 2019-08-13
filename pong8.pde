import ddf.minim.*;
import gifAnimation.*;

int myWidth = 1200;
int myHeight = 600;

Gif win;
Gif lose;
Gif banana;
Gif sleep;

Minim minim;
AudioPlayer [] musica;

String [] nomes = {  
  "player2.wav", "racket.WAV", "wall.wav", "player1.mp3", "draw.mp3", "theme.mp3", "bonus.wav"
};


color black = color(0, 0, 0);
color white = color(255, 255, 255);
color red = color(255, 0, 0);

float x;  // tamanho da quadra
float y;  // tamanho da quadra
float d; //diametro
float dx; //direção X
float dy; //direção Y

float px; //posição X
float py; //posição Y

boolean pressed=false; // qd carrego no espaço
boolean pause=false;   // qd está pause
boolean exit_p1=false; // quando a bola saiu da quadra
boolean exit_p2=false;  // quando a bola saiu da quadra
boolean game_over=false;  // quando o jogo acabou
boolean game_start=false; // quando o jogo começou
boolean player1_wins=true;  // quando player 1 ganha
boolean player2_wins=false;  // quando player 2 ganha
boolean bonus=false;   // qd bonus está activado
boolean p1_lastplay=false;  // quando a ultima raquete a tocar na bola foi o player 1
boolean p2_lastplay=false;  //  quando a ultima raquete a tocar na bola foi o player 2


int velocidade_bola=4;
int tamanho_p1;
int tamanho_p2;
int speed;
int nFrames;
int pontos_p1;
int pontos_p2;

Ball b;
Court c;
Racket r1;
Racket r2;

void setup()
{
  size(myWidth, myHeight);
  minim = new Minim(this);
  initPlayers(); 
  win = new Gif(this, "win.gif");
  lose = new Gif(this, "lose.gif");
  banana = new Gif(this, "bonus.gif");
  sleep= new Gif(this, "pause.gif");
  win.play();
  lose.play();
  banana.play();
  sleep.play();
  rectMode(CENTER);
  textAlign(CENTER);
  imageMode(CENTER);
  x=width*5/6;
  y=height*3/4;
  c=new Court(width/2, height/2, x, y, white);
  b=new Ball(width/2, height/2, 30, red);
  r1=new Racket((width-x)/2+30, height/2, width/50, height/5, white);
  r2=new Racket((width+x)/2-30, height/2, width/50, height/5, white);
  pontos_p1=0;
  pontos_p2=0;
  nFrames=0;
  tamanho_p1=0;
  tamanho_p2=0;
  musica[5].play();
}

void draw()
{
  background(black);
  c.draw();
  b.draw();
  r1.draw();
  r2.draw();
  update();
}

void initPlayers() {
  musica = new AudioPlayer[10];
  for ( int i=0; i<nomes.length; i++)
    musica[i]=minim.loadFile(nomes[i]);
}

void update()
{ 
  if (game_start && !pause)
    nFrames++;
  if (nFrames/60>=10)
  {
    b.c=color(random(0, 255), random(0, 255), random(0, 255));
    bonus=true;
    b.travel(nFrames/360);
  }
  if (!p1_lastplay && !p2_lastplay)
    b.travel(velocidade_bola);
  else if (p1_lastplay)
  {
    speed=pontos_p2-pontos_p1;
    if (speed>0)
      b.travel(velocidade_bola+speed);  
    else
      b.travel(velocidade_bola);
  } else if (p2_lastplay)
  {
    speed=pontos_p1-pontos_p2;
    if (speed>0)
      b.travel(velocidade_bola+speed);
    else
      b.travel(velocidade_bola);
  }
  b.bounceInsideCourt((width-x)/2, (height-y)/2, x, y);
  exit_p1=b.bounceInsideRacket1(r1);
  exit_p2=b.bounceInsideRacket2(r2);
  if (exit_p1)
  {
    if (!game_over)
    {
      game_over=true;
      if (!bonus)
        pontos_p2++;
      else
        pontos_p2+=5;
      player2_wins=true;
      b.setVelocity(0, 0);
      nFrames=0;
      b.c=red;
      bonus=false;
      p1_lastplay=false;
      p2_lastplay=false;
      game_start=false;
    }
    if (game_over && !game_start)
    {
      image(this.win, width*4/5, height/2);
      image(this.lose, width/5, height/2);
      textSize(42);
      text("Press Enter to Play", width/2, height/3);
    }
  }
  if (exit_p2)
  {
    if (!game_over)
    {
      if (!bonus)
        pontos_p1++;
      else
        pontos_p1+=5;
      game_over=true;
      player1_wins=true;
      b.setVelocity(0, 0);
      nFrames=0;
      b.c=red;
      bonus=false;
      p1_lastplay=false;
      p2_lastplay=false;
      game_start=false;
    }
    if (game_over && !game_start)
    {
      image(this.win, width/5, height/2);
      image(this.lose, width*4/5, height/2);
      textSize(42);
      text("Press Enter to Play", width/2, height/3);
    }
  }
  textSize(42);
  text(pontos_p1, width/10, 50);
  text(pontos_p2, width*9/10, 50);
  if (game_over && player1_wins)
  {
    textSize(20);
    text("Player 1 Wins!", width/5, height/2.5);
    text("Player 2 Loses!", width*4/5, height/2.5);
  }
  if (game_over && player2_wins)
  {
    textSize(20);

    text("Player 2 Wins!", width*4/5, height/2.5);
    text("Player 1 Loses!", width/5, height/2.5);
  }
  if (b.x==width/2 && b.y==height/2 && b.vx==0 && b.vy==0)
    text("Press Enter to Play", width/2, height/3);
  if (pause)
  {
    text("GAME PAUSED", width/2, height/2);
    image(this.sleep, width/3, height/2);
  }

  if (bonus)
  {  
    image(this.banana, width/3.5, 40);
    image(this.banana, width*2.5/3.5, 40);
    fill(random(0, 255), random(0, 255), random(0, 255));
    text("BONUS ACTIVATED", width/2, 50);

    if (!musica[6].isPlaying())
    { 
      musica[3].pause();
      musica[4].pause();
      musica[0].pause();
      musica[6].rewind();
      musica[6].play();
    }
  }
}

void keyPressed()
{    
  r2.r2_move();
  r1.r1_move();

  if (key==' ' && !pressed && game_start)
  {
    px = b.vx;
    py = b.vy;
    b.setVelocity(0, 0);
    pressed=true;
    pause=true;
  } else if (key==' ' && pressed && game_start)
  {
    b.setVelocity(px, py);
    pressed=false;
    pause=false;
  }
  if (keyCode==ENTER )
  {
    musica[5].pause();
    if (!(b.x==width/2 && b.y==height/2) & (player1_wins || player2_wins) )
    {
      b.setVelocity(0, 0);
      b.x=width/2;
      b.y=height/2;
      game_over=false;
    } else if (player2_wins)
    {    
      game_start=true;

      tamanho_p1=pontos_p2-pontos_p1;
      if (tamanho_p1>0)
        r1.altura=height/5+tamanho_p1*10;
      else r1.altura=height/5;
      tamanho_p2=pontos_p1-pontos_p2;
      if (tamanho_p2>0)
        r2.altura=height/5+tamanho_p2*10;
      else
        r2.altura=height/5;
      b.vx=cos(-random((PI+HALF_PI)/2, (PI+PI/4)));      
      b.vy=sin(-random((PI+HALF_PI)/2, (PI+PI/4)));
      player2_wins=false;
      if (!musica[0].isPlaying() && pontos_p2>pontos_p1)
      { 
        musica[3].pause();
        musica[4].pause();
        musica[6].pause();
        musica[0].rewind();
        musica[0].play();
      } else if (!musica[4].isPlaying() && pontos_p1==pontos_p2)
      {
        musica[0].pause();
        musica[3].pause();
        musica[6].pause();
        musica[4].rewind();
        musica[4].play();
      }
    } else if (player1_wins)
    {
      game_start=true;

      tamanho_p1=pontos_p2-pontos_p1;
      if (tamanho_p1>0)
        r1.altura=height/5+tamanho_p1*10;
      else r1.altura=height/5;
      tamanho_p2=pontos_p1-pontos_p2;
      if (tamanho_p2>0)
        r2.altura=height/5+tamanho_p2*10;
      else
        r2.altura=height/5;
      b.vx=cos(random(-PI/4, PI/4));      
      b.vy=sin(random(-PI/4, PI/4));
      player1_wins=false;
      if (!musica[3].isPlaying() && pontos_p1>pontos_p2) 
      { 
        musica[0].pause();
        musica[4].pause();
        musica[6].pause();
        musica[3].rewind();
        musica[3].play();
      } else if (!musica[4].isPlaying() && pontos_p1==pontos_p2)
      {
        musica[0].pause();
        musica[3].pause();
        musica[6].pause();
        musica[4].rewind();
        musica[4].play();
      }
    }
  }
}
