outputformat := "svg";
outputformatoptions := "format=rgb antialias=best";
hppp := 0.1;
vppp := 0.1;
tracingonline:=1;

beginfig(1);
u := 10cm;
pair vertex[];
vertex0 := (0,u);
for i=1 upto 5:
    vertex[i] := vertex0 rotated (60 * i);
endfor;
draw vertex0
  for i=1 upto 5: --vertex[i] endfor
  --cycle;

pickup pencircle scaled 3pt;
margin := 0.2;
middleleft := 1; middleright := 4; topleft := 0; topright := 5; bottomleft := 2; bottomright := 3;
pair access[][];
pair out[];
nbwires := 6;
nbsides := 6;
for iside=0 upto nbsides - 1:
    out[iside] := up rotated (30 + iside * 60);
    for iwire=0 upto nbwires:
        access[iside][iwire] :=
            vertex[iside] + 
            (margin + (1 - 2margin) * iwire / nbwires) * (vertex[(iside + 1) mod nbsides] - vertex[iside]);
    endfor;
endfor;

extra := 2cm;

color orange; orange := red + 0.5 green;
color yellow; yellow := (green + red);
color purple; purple := blue + .5 red;
color lightblue; lightblue := .5blue + .5white;
color brown; brown := 165/256*red + 42/256*green + 42/256*blue;

def from(expr iside, iaccess) =
    access[iside][iaccess] + (extra * out[iside])--access[iside][iaccess]{-out[iside]}
enddef;

def to(expr iside, iaccess) =
    access[iside][iaccess]{out[iside]}--access[iside][iaccess] + (extra * out[iside])
enddef;

def defaccess(expr iside, inewaccess, isourceaccess, coef) =
    access[iside][inewaccess] := access[iside][isourceaccess] + coef * (access[iside]1 - access[iside]0);
enddef;

def drawtwice(expr wire, firstscale, firstcolor, secondscale, secondcolor) =
    draw wire withpen pencircle scaled firstscale withcolor firstcolor;
    draw wire withpen pencircle scaled secondscale withcolor secondcolor;
enddef;

def trace(expr wire, thecolor) =
    drawtwice(wire, 4pt, black, 3pt, thecolor);
enddef;

def drawearth(expr wire) =
    drawtwice(wire, 4pt, .5green, 1.5pt, yellow);
enddef;

draw from(topleft, 0)..to(topright, nbwires) withcolor orange ;
 
few := 0.1;
defaccess(topleft, 90, 1, -few);
defaccess(topleft, 110, 1, few);
defaccess(middleright, 610, 6, few);
defaccess(middleright, 590, 6, -few);
trace(from(topleft, 90)..to(middleright, 610), white);
trace(from(topleft, 110)..to(middleright, 590), white);
 
pair bluejoin[]; bluejoin1 := 0.5u * out[topleft];
draw from(topleft, 5)..bluejoin1 withcolor blue;
draw from(topright, 5)..bluejoin1 withcolor blue;
draw from(bottomleft, 1)..bluejoin1 withcolor blue;
 
pair earthjoin; earthjoin := 0.5vertex1;
drawearth(from(topleft, 6)..earthjoin);
drawearth(from(middleleft, 0)..earthjoin);
drawearth(from(bottomleft, 0)..earthjoin);
 
pair bulb; bulb := origin;
draw from(topleft, 2)..bulb withcolor purple;
draw bluejoin1--bulb withcolor blue;
drawdot bulb withpen  pencircle scaled 25pt withcolor yellow;

pair blackjoin; blackjoin := .5u * out[bottomleft];
draw from(middleleft, nbwires)..blackjoin;
draw from(bottomleft, nbwires-2)..blackjoin;
draw from(topright, 2)..blackjoin;

bluejoin2 := .5 vertex3;
trace(from(middleleft, nbwires - 1)..bluejoin2, lightblue);
trace(from(bottomleft, nbwires-1)..bluejoin2, lightblue);
trace(from(topright, 1)..bluejoin2, lightblue);

pair brownjoin; brownjoin := .5u * out[middleright];
draw from(middleright, 3)..brownjoin withcolor brown;
draw from(topright, 0)..brownjoin withcolor brown;
draw from(bottomleft, nbwires)..brownjoin withcolor brown;

defaultfont:="cmr17";
label.rt("vers I2", sqrt(3)/2 * u * out[middleright]);

endfig;
end
