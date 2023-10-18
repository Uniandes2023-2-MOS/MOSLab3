Set i   atributos / a1 , a2, a3, a4, a5 /;
* a1 = rol, a2 = Control balon, a3 = Disparo, a4 = rebotes, a5 = defensa
Set j   jugadores  / p1, p2, p3, p4, p5, p6, p7 /;


set iter iterations /it1*it11/;
scalar w1 weight 1 / 0 /;
scalar w2 weight 2 / 0 /;

parameter w1_vec(iter) w1 values
                 /it1 1, it2 0.9, it3 0.8, it4 0.7, it5 0.6, it6 0.5,
                  it7 0.4, it8 0.3, it9 , it10 0.1, it11 0/;
parameter w2_vec(iter) w2 values;

* Para rol, Ataque, centro, defensa = 1 1 1 a decimal
Table c(j,i) atributos de d
        a1  a2  a3  a4  a5
p1      1   3   3   1   3
p2      2   2   1   3   2
p3      5   2   3   2   2
p4      6   1   3   3   1
p5      5   3   3   3   3
p6      6   3   1   2   3    
p7      5   3   2   2   1;

Table t(j,k) sending delay
                 d1       d2      d3       d4
s1               12       14      10       11
s2               11        8       7       13
s3                6       11       4       15;

Table inv(i,j) inventory
                  s1       s2       s3
p1                60       80       50
p2                20       20       30;

Table dem(i,k) demand
                 d1      d2      d3       d4
p1               50      90      40       10
p2               10      20      10       30;


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

funObj                 ..     z =e= w1*f1 + w2*f2;

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
