Sets
    i /p1*p6/
alias(j,i);


table t(i,j)
    p1 p2 p3 p4 p5 p6
p1  0  10 20 30 30 20
p2  10 0  25 35 20 10
p3  20 25 0  15 30 20
p4  30 35 15 0  15 25
p5  30 20 30 15 0  14
p6  20 10 20 25 14 0

Variables
z objective,
x ;

Binary Variable x;

Equations
objectiveFunction      objective function

station
;

objectiveFunction   .. z =e= sum(i,x(i));

station(j)   ..  sum(i$(t(i,j)<=15),x(i))=g=1;


Model model1 /all/ ;
option mip=CPLEX
Solve model1 using mip minimizing z;

Display x.l;
Display z.l;