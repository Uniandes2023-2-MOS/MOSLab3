Set i   atributos / a1 , a2, a3, a4, a5, a6, a7 /;
* a1 = Ataque, a2 = Centro, a3 = Defensa, a4 = Control balon, a5 = Disparo, a6 = rebotes, a7 = defensa
Set j   jugadores  / p1, p2, p3, p4, p5, p6, p7 /;


set iter iterations /it1*it11/;
scalar w1 weight 1 / 0 /;
scalar w2 weight 2 / 0 /;

parameter w1_vec(iter) w1 values
                 /it1 1, it2 0.9, it3 0.8, it4 0.7, it5 0.6, it6 0.5,
                  it7 0.4, it8 0.3, it9 , it10 0.1, it11 0/;
parameter w2_vec(iter) w2 values;

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
  x(i,j,k)    Amount of i type packets sent from the source node j
              to the destination node k.
  z           minimization
  f1          function 1
  f2          function 2;

Positive Variable x;

Equations
funObj                        Objective Function

invConstraint(i,j)            inventory constraint

demConstraint(i,k)            demand constraint

f1_value                      f1 value
f2_value                      f2 value;

f1_value               ..     f1=e= sum((i,j,k), c(j,k) * x(i,j,k));

f2_value               ..     f2=e= sum((i,j,k), t(j,k) * x(i,j,k));

funObj                 ..     z =e= sum ((j), x(j)*c(j,7));

invConstraint(i,j)     ..     sum((k), x(i,j,k)) =l= inv(i,j);

demConstraint(i,k)     ..     sum((j), x(i,j,k)) =e= dem(i,k);


Model Model1 /all/ ;

parameter z_res(iter) "z results to store";
parameter f1_res(iter) "f1 results to store";
parameter f2_res(iter) "f2 results to store";
parameter x_res(i,j,k,iter) "x results to store";

loop (iter,
    w1=w1_vec(iter);
    w2=1 - w1_vec(iter);
    w2_vec(iter)=w2;

    option lp=CPLEX;
    Solve Model1 using lp minimizing z;
    z_res(iter)=z.l;
    f1_res(iter)=f1.l;
    f2_res(iter)=f2.l;
    x_res(i,j,k,iter)=x.l(i,j,k);
    );

display z_res;
display f1_res;
display f2_res;
display w1_vec;
display w2_vec;
display x_res;

file GAMSresults /C:\Users\jerma\Desktop\postdoc\MOS\contenidoClase\Secci�n1_202020\codes\results.dat/;
put GAMSresults;
loop(iter,
         put iter.tl, @5, f1_res(iter), @18, f2_res(iter) /

         );
