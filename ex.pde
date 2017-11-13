
PImage img;
int tour;
int i,j, w, h;
int sk, sl;
float r,g,b;
int [][]obst={
        {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
        {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
        {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
        {1,0,0,0,0,0,0,0,0,0,1,1,0,0,0,1},
        {1,1,0,0,1,0,0,1,0,0,0,0,0,0,0,1},
        {1,0,0,0,1,0,0,1,1,0,0,0,0,0,0,1},
        {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
        {1,0,0,0,0,0,0,0,0,0,0,0,1,0,0,1},
        {1,0,0,0,1,0,0,0,0,0,0,0,1,0,0,1},
        {1,0,0,0,0,0,1,1,0,0,0,0,0,0,0,1},
        {1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,1},
        {1,0,0,0,0,1,0,0,0,0,0,0,0,1,1,1},
        {1,0,0,0,0,0,0,0,1,0,0,0,0,0,0,1},
        {1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,1},
        {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
        {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1}
      }; 

int [][] temp;
int [][] queue;
int [][] Marque;
int [][] path;
int tete;
int tetePath;
int roboti=-1,robotj=-1;
int obji=-1,objj=-1;
boolean weCan=false;
void setup() {
  size(512, 612);
  img = loadImage("im.jpg");
 w=img.width;
 h=img.height;
 tour=0;
 loadPixels();
  img.loadPixels();
  temp=new int[16][16];
  Marque=new int[16][16];
  queue= new int [1000][4];
  path= new int [1000][2];
  tetePath=0;
  for(i=0; i<16; i++) for(j=0; j<16; j++) {temp[i][j]=obst[i][j]; Marque[i][j]=0;}
  tete=1; queue[0][0]=1; queue[0][1]=6;queue[0][2]=-1;queue[0][3]=-1; 
}
int ii=0;
void draw() {
    obstacle_creat();
for (int x = 0; x < w; x++ ) {
    for (int y = 0; y < h; y++ ) {

      int loc = x + y*w;
      int stepx=w/16;
      int stepy=h/16;
      i= y/stepy; j=x/stepx;
      int val=obst[i][j];
      switch (val)
      {
        case 0: r= 0; g=0; b=0; break;
        case 1: r= 0; g=0; b=255; break;
        case 2: r= 255; g=0; b=0; break;
        case 3: r= 0; g=255; b=0; break;
        case 4: r= 150; g=150; b=150; break;
        case 5: r= 255; g=255; b=255; break;
      }      
      color c = color(r, g, b);
      pixels[loc]=c;      
    }
  }
  if(obstacle && mousePressed && mouseY<512){ print(mouseX/(w/16),mouseY/(h/16),"\n");obst[mouseY/(h/16)][mouseX/(w/16)]=1;temp[mouseY/(h/16)][mouseX/(w/16)]=1;}
  if(robot && mousePressed && mouseY<512 && obst[mouseY/(h/16)][mouseX/(w/16)]!=1 && !start) {
      if(roboti!=-1 && robotj!=-1)  {obst[roboti][robotj]=0;temp[roboti][robotj]=0;}
       roboti=mouseY/(h/16);
       robotj=mouseX/(w/16);
       obst[mouseY/(h/16)][mouseX/(w/16)]=2;
       temp[mouseY/(h/16)][mouseX/(w/16)]=2;
       queue[0][0]=roboti; queue[0][1]=robotj;
       Marque[roboti][robotj]=1;
       sk=roboti;sl=robotj;
       weCan=true;
     }
     if(objectif && mousePressed && mouseY<512 && obst[mouseY/(h/16)][mouseX/(w/16)]!=1 && !start) {
           if(obji !=-1 && objj!=-1) {obst[obji][objj]=0;temp[obji][objj]=0;}
        obji=mouseY/(h/16);
        objj=mouseX/(w/16);
        obst[mouseY/(h/16)][mouseX/(w/16)]=3;
        temp[mouseY/(h/16)][mouseX/(w/16)]=3;
     }
    
  updatePixels(); 
  
  if(tour!=2 && start && weCan)  avance();
 
  delay(100);
 
if(tour==-1){tour=2;}
  
  if(tour==2){if(ii<tetePath-1) {obst[path[ii][0]][path[ii][1]]=5;ii++;}}
 
   drawMenu();
   
  
}

int n=0;
boolean bol=false;

void avance()
{
  
  int k,l, kk, ll,z,zz;
  // Trouver les noeuds fils du prelmier element de la file queue
  if(tete==0) tour=-1;
  else
  {
    k=queue[tete-1][0]; l=queue[tete-1][1];
    z=queue[tete-1][2]; zz=queue[tete-1][3];
      bol=false;
      n=0;
      while(n<tetePath && !bol)
      {
        if(path[n][0]==z && path[n][1]==zz)
        {
          bol=true;
         tetePath=n+1;
         //print("n"+n);
      }
        n++;
        
      }
    
    path[tetePath][0]=k;path[tetePath][1]=l;tetePath++;
    
    obst[k][l]=2; obst[sk][sl]=4; sk=k; sl=l; tete--;
    //for(kk=-1; kk<2; kk++) 
     // for(ll=-1; ll<2; ll++)
   // {
    //if(!((kk==0)&&(ll==0))&&(Marque[k+kk][l+ll]==0))
    kk=0;ll=-1;
    if(Marque[k+kk][l+ll]==0)
    switch (temp[k+kk][l+ll])
    {
      case 1: break;
      case 0: // enfiler
              queue[tete][0]=k+kk; queue[tete][1]=l+ll;queue[tete][2]=k;queue[tete][3]=l; Marque[k+kk][l+ll]=1; tete++; //print(tete, "  ");
              break;
      case 3: tour=-1;// print(k+kk,l+ll); break;
    }
    kk=0;ll=1;if(Marque[k+kk][l+ll]==0)
    switch (temp[k+kk][l+ll])
    {
      case 1: break;
      case 0: // enfiler
              queue[tete][0]=k+kk; queue[tete][1]=l+ll;queue[tete][2]=k;queue[tete][3]=l; Marque[k+kk][l+ll]=1; tete++;  //print(tete, "  ");
              break;
      case 3: tour=-1;// print(k+kk,l+ll); break;
    }
    kk=-1;ll=0;if(Marque[k+kk][l+ll]==0)
    switch (temp[k+kk][l+ll])
    {
      case 1: break;
      case 0: // enfiler
              queue[tete][0]=k+kk; queue[tete][1]=l+ll;queue[tete][2]=k;queue[tete][3]=l; Marque[k+kk][l+ll]=1;tete++;  // print(tete, "  ");
              break;
      case 3: tour=-1;// print(k+kk,l+ll); break;
    }
    kk=1;ll=0;if(Marque[k+kk][l+ll]==0)
    switch (temp[k+kk][l+ll])
    {
      case 1: break;
      case 0: // enfiler
              queue[tete][0]=k+kk; queue[tete][1]=l+ll;queue[tete][2]=k;queue[tete][3]=l; Marque[k+kk][l+ll]=1;tete++; //print(tete, "  ");
              break;
      case 3: tour=-1;// print(k+kk,l+ll); break;
    }
    //}
    //décaler les éléments de la queue
    //for(i=0; i<tete-1; i++) {queue[i][0]=queue[i+1][0]; queue[i][1]=queue[i+1][1];} tete=tete-1;
  
  }
}
void drawMenu(){
        stroke(255);
        fill(128,0,128);
        rect(0,512,128,100);
        textSize(22);
        fill(255);
        text(" Start ",15,568);
        
        stroke(255);
        fill(0,102,153);
        rect(128,512,128,100);
        textSize(22);
        fill(255);
        text(" Obstacle ",143,568);
        
        stroke(255);
        fill(255,0,0);
        rect(256,512,128,100);
        textSize(22);
        fill(255);
        text(" Robot ",271,568);
        
        stroke(255);
        fill(0,255,64);
        rect(384,512,128,100);
        textSize(22);
        fill(255);
        text(" Objectif ",399,568);

}
boolean start,obstacle,robot,objectif;
void obstacle_creat(){
       
       if(mousePressed){
          
          if(mouseX>0 && mouseX<128 && mouseY>512 && mouseY<612){
             start=true; print("s");
             }
          if(mouseX>128 && mouseX<256 && mouseY>512 && mouseY<612){
            robot=false;objectif=false;obstacle = true; print("obs");
             }
          if(mouseX>256 && mouseX<384 && mouseY>512 && mouseY<612){
             obstacle=false;objectif=false; robot = true; print("r");
             }
           if(mouseX>384 && mouseX<512 &&mouseY>512 && mouseY<612){
             objectif = true;obstacle=false; robot=false; print("obj");
             }
           
      
        }
    }