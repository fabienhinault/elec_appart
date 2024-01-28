outputformat := "svg";
outputformatoptions := "format=rgb antialias=best";
hppp := 0.1;
vppp := 0.1;
tracingonline:=1;

beginfig(1);
u := 10cm;
pair h[];
h0 := (0,u);
for i=1 upto 5:
    h[i] := h0 rotated (60 * i);
endfor;
draw h0
  for i=1 upto 5: --h[i] endfor
  --cycle;
for i=0 upto 5:
    label.lft(decimal i, h[i]);
endfor;

margin := 0.2;
pair middleleft[], middleright[], topleft[], topright[], bottomleft[], bottomright[];
nbwires := 6;
for iwire=0 upto (nbwires):
    topleft[iwire] := h0 + (margin + (1 - 2margin) * iwire / nbwires) * (h1 - h0);
    middleleft[iwire] := h1 +(margin + (1 - 2margin) * iwire / nbwires) * (h2 - h1);
    bottomleft[iwire] := h2 + (margin + (1 - 2margin) * iwire / nbwires) * (h3 - h2);
    bottomright[iwire] := h3 + (margin + (1 - 2margin) * iwire / nbwires) * (h4 - h3);
    middleright[iwire] := h4 + (margin + (1 - 2margin) * iwire / nbwires) * (h5 - h4);
    topright[iwire] := h5 + (margin + (1 - 2margin) * iwire / nbwires) * (h0 - h5);
endfor;

pair outtopleft; outtopleft = up rotated  30 ;
pair outmiddleleft;  outmiddleleft:= up rotated 90 ;
pair outbottomleft; outbottomleft := up rotated (30 + 2*60);
pair outbottomright; outbottomright := up rotated (30 + 3*60);
pair outmiddleright;  outmiddleright :=  up rotated (30 + 4*60);
pair outtopright; outtopright := up  rotated (30 + 5*60);

pickup pencircle scaled 3pt;
extra := 2cm;

color orange; orange := red + 0.5 green;
draw topleft[0] + (2cm * outtopleft)--topleft[0]{-outtopleft}..topright[nbwires]{outtopright}--topright[nbwires] + 2cm*outtopright withcolor orange ;

few := 0.1;
topleft90 = topleft1 + few * (topleft0 - topleft1);
middleright610 = middleright6 - few * (middleright5 - middleright6);
topleft110 = topleft1 + few * (topleft2 - topleft1);
middleright590 = middleright6 + few * (middleright5 - middleright6);
path wire;
wire := topleft90 +  (2cm * outtopleft)--topleft90{-outtopleft}..middleright610{outmiddleright}--middleright610 + (2cm*outmiddleright);
draw wire withpen pencircle scaled 4pt;
draw wire withcolor white;
wire := topleft110 +  (2cm * outtopleft)--topleft110{-outtopleft}..middleright590{outmiddleright}--middleright590 + (2cm*outmiddleright);
draw wire withpen pencircle scaled 4pt;
draw wire withcolor white;

pair bluejoin[]; bluejoin1 := 0.5u * outtopleft;
draw topleft5 + (2cm * outtopleft)--topleft5{-outtopleft}..bluejoin1 withcolor blue;
draw topright5 + (2cm * outtopright)--topright5{-outtopright}..bluejoin1 withcolor blue;
draw bottomleft1 +  (2cm * outbottomleft)--bottomleft1{-outbottomleft}..bluejoin1 withcolor blue;

pair earthjoin; earthjoin := 0.5h1;
wire := topleft6 + (2cm * outtopleft)--topleft6{-outtopleft}..earthjoin;
draw wire withpen pencircle scaled 4pt withcolor .5green;
color yellow; yellow := (green + red);
draw wire withpen pencircle scaled 1.5pt withcolor yellow;
wire := middleleft0 + extra*outmiddleleft-- middleleft0{-outmiddleleft}..earthjoin;
draw wire withpen pencircle scaled 4pt withcolor .5green;
draw wire withpen pencircle scaled 1.5pt withcolor yellow;
wire := bottomleft0 + extra*outbottomleft--bottomleft0{-outbottomleft}..earthjoin;
draw wire withpen pencircle scaled 4pt withcolor .5green;
draw wire withpen pencircle scaled 1.5pt withcolor yellow;

pair bulb; bulb := origin;
color purple; purple := blue + .5 red;
draw topleft2 + extra*outtopleft--topleft2{-outtopleft}..bulb withcolor purple;
draw bluejoin1--bulb withcolor blue;
drawdot bulb withpen  pencircle scaled 25pt withcolor yellow;

endfig;
end
