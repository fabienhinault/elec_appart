outputformat := "svg";
outputformatoptions := "format=rgb antialias=best";
hppp := 0.1;
vppp := 0.1;
tracingonline:=1;

%tracingall;

u := 10cm;
pair vertex[];
vertex0 := (0,u);
for i=1 upto 5:
    vertex[i] := vertex0 rotated (60 * i);
endfor;

margin := 0.2;
% sides
middleleft := 1; middleright := 4; topleft := 0; topright := 5; bottomleft := 2; bottomright := 3;
% vertices
middletop := 0; lefttop := 1; leftbottom := 2; middlebottom := 3; rightbottom := 4; righttop := 5;
pair access[][];
pair out[];
pair midside[];
nbwires := 6;
nbsides := 6;
for iside=0 upto nbsides - 1:
    out[iside] := up rotated (30 + iside * 60);
    for iwire=0 upto nbwires:
        access[iside][iwire] :=
            vertex[iside] + 
            (margin + (1 - 2margin) * iwire / nbwires) * (vertex[(iside + 1) mod nbsides] - vertex[iside]);
    endfor;
    midside[iside] := access[iside][nbwires/2];
endfor;

extra := 2cm;

color orange; orange := red + 0.5 green;
color yellow; yellow := (green + red);
color purple; purple := blue + .5 red;
color lightblue; lightblue := .5blue + .5white;
color brown; brown := 165/256*red + 42/256*green + 42/256*blue;

def accessmac(expr iside, iwire) =
    vertex[iside] + 
    (margin + (1 - 2margin) * iwire / nbwires) * (vertex[(iside + 1) mod nbsides] - vertex[iside])
enddef;

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

def sidejoin(expr iside) =
    .5 u * out[iside]
enddef;

def vertexjoin(expr ivertex) =
    .5 vertex[ivertex]
enddef;

def inter(expr side_a, iaccess_a, side_b, iaccess_b) =
    begingroup
        save x;
        pair x;
        x = access[side_a][iaccess_a] + whatever out[side_a];
        x = access[side_b][iaccess_b] + whatever out[side_b];
        x
    endgroup
enddef;

def abstractjoinwires(expr joinpoint)(text _draw, T) =
    _ix_ := 0;
    for _x_ = T:
        _ixmod_ :=  _ix_ mod 2;
        if _ixmod_ = 0:
            side := _x_;
        else:
            _draw(side, _x_, joinpoint);
        fi
        _ix_ := _ix_ + 1;
    endfor
enddef;

def tracewithcolor(expr thecolor, side, iaccess, joinpoint)=
    trace(from(side, iaccess)..joinpoint, thecolor);
enddef;

def drawwithcolor(expr thecolor, side, iaccess, joinpoint)=
    draw from(side, iaccess)..joinpoint withcolor thecolor;
enddef;

def drawearthjoin(expr side, iaccess, joinpoint)=
    drawearth(from(side, iaccess)..joinpoint);
enddef;

def joinwires(expr joinpoint, thecolor)(text T) =
    abstractjoinwires(joinpoint)(drawwithcolor(thecolor))(T);
enddef;

def jointrace(expr joinpoint, thecolor)(text T) =
    abstractjoinwires(joinpoint)(tracewithcolor(thecolor))(T);
enddef;

def joinearth(expr joinpoint)(text T) =
    abstractjoinwires(joinpoint)(drawearthjoin)(T);
enddef;


defaultfont:="cmr17";

beginfig(1);
label.lft("PLAFOND ENTREE", 1.3u * up);
draw vertex0
  for i=1 upto 5: --vertex[i] endfor
  --cycle;

pickup pencircle scaled 3pt;
draw from(topleft, 0)..to(topright, nbwires) withcolor orange ;
 
few := 0.1;
defaccess(topleft, 90, 1, -few);
defaccess(topleft, 110, 1, few);
defaccess(middleright, 610, 6, few);
defaccess(middleright, 590, 6, -few);
trace(from(topleft, 90)..to(middleright, 610), white);
trace(from(topleft, 110)..to(middleright, 590), white);


pair bluejoin;  bluejoin := 0.5u * out[topleft];
joinwires(bluejoin, blue, topleft, 5, topright, 5, bottomleft, 1);
 
joinearth(vertexjoin(1), topleft, 6, middleleft, 0, bottomleft, 0);
 
pair bulb; bulb := origin;
draw from(topleft, 2)..bulb withcolor purple;
draw bluejoin--bulb withcolor blue;
drawdot bulb withpen  pencircle scaled 25pt withcolor yellow;

joinwires(sidejoin(bottomleft), black, middleleft, nbwires, bottomleft, nbwires-2, topright, 2);
jointrace(vertexjoin(middlebottom), lightblue, middleleft, nbwires - 1, bottomleft, nbwires-1, topright, 1)
joinwires(sidejoin(middleright), brown, middleright, 3, topright, 0, bottomleft, nbwires);

label.rt("vers I2", sqrt(3)/2 * u * out[middleright]);
label.lft("vers I1", access[topleft][1]);
endfig;

beginfig(2);
label.lft("PLAFOND SEJOUR", 1.3u * up);
draw vertex0
  for i=1 upto 5: --vertex[i] endfor
  --cycle;

pickup pencircle scaled 3pt;
joinearth(vertexjoin(leftbottom), middleleft, 6, bottomleft, 0);

bulb := 1.3 * vertexjoin(lefttop);
draw from(topleft, 6)..bulb withcolor purple;
draw from(middleleft, 0)..bulb withcolor blue;
drawdot bulb withpen  pencircle scaled 25pt withcolor yellow;

joinwires(vertexjoin(lefttop), brown, topleft, 5, middleleft, 1);

pair redjoin; redjoin := vertexjoin(righttop);
joinwires(redjoin, red, topleft, 0, middleleft, 2);
draw from(bottomleft, 6)..redjoin; % black wire

joinwires(origin, blue, topleft, 3, middleleft, 3, bottomleft, 3);

label.lft("vers P2", midside[bottomleft]);
label.lft("vers I1", access[topleft][nbwires]);
label.lft("vers P1", access[topleft][1]);
label.lft("vers SALON ", midside[middleleft]);
endfig;
end


