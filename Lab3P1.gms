Set i   atributos / a1 , a2, a3, a4, a5, a6, a7 /;
* a1 = Ataque, a2 = Centro, a3 = Defensa, a4 = Control balon, a5 = Disparo, a6 = rebotes, a7 = defensa
Set j   jugadores  / p1, p2, p3, p4, p5, p6, p7 /;

parameter rm(i) minimo de valores
/a1 2, a2 1, a3 4, a4 10, a5 10, a6 10/;



Table c(j,i) atributos de jugadores
        a1  a2  a3  a4  a5  a6  a7
p1      1   0   0   3   3   1   3
p2      0   1   0   2   1   3   2
p3      1   0   1   2   3   2   2
p4      0   1   1   1   3   3   1
p5      1   0   1   3   3   3   3
p6      0   1   1   3   1   2   3    
p7      1   0   1   3   2   2   1;



Variables
z objective

Binary Variable
x(j) jugadores que juega

Equations
funObj                        Objective Function

minRol                        Minimo de roles

cantidadJugadores

terceroOSegundo
;


funObj                ..     z =e= sum ((j), x(j)*c(j,"a7"));


minRol (i)$[ord(i) >= 1 and ord(i) <= 6]..  sum((j), c(j,i)) =g= rm(i);

cantidadJugadores       ..  sum((j), x(j)) =e= 5;


terceroOSegundo    ..     x("p3") + x("p2") =e= 1;

Model Model1 /all/;
option lp=CPLEX;
Solve model1 using mip maximizing z;


Display x.l;
Display z.l;


