Sets
t       tubes                       /t1*t7/
i       x positions (horizontal)    /1*4/
j       y positions (vertical)      /1*5/
;

Table TT(t, x, y) Indicates if tube t is under tile in position x y
        1.1 1.2 1.3 1.4 1.5
    t1  1   1   0   0   0
    t2  0   1   1   0   0   
    t3  0   0   0   1   1
    t4  0   0   1   1   0
    t5  0   0   0   0   0
    t6  0   0   0   0   0
    t7
    
    +   2.1 2.2 2.3 2.4 2.5
    t1  0   0   0   0   0
    t2  0   0   0   0   0
    t3  0   0   0   0   0
    t4  0   0   1   1   0
    t5  0   0   1   1   0
    t6  1   1   0   0   0
    t7
    
    +   3.1 3.2 3.3 3.4 3.5
    t1  0   0   0   0   0   
    t2  0   0   0   0   0
    t3  0   0   0   0   0
    t4  0   0   0   0   0
    t5  0   0   1   1   0
    t6  1   1   0   0   0
    t7  0   0   0   0   1
    
    +   4.1 4.2 4.3 4.4 4.5
    t1  0   0   0   0   0
    t2  0   0   0   0   0
    t3  0   0   0   0   0
    t4  0   0   0   0   0
    t5  0   0   0   0   0
    t6  0   0   0   0   0
    t7  0   0   1   1   1
;

Variables
d(y,x)      Indicates if tile in position x y should be broken
z           Objective function
;

Binary variables d(y,x);

Equations
r1      Restriction 1: each tube should be seen at least once.
ntiles  Objective function
;

r1(t)   ..      sum((x), sum((y), d(y,x) * TT(t, x, y) )) =g= 1;
ntiles  ..      z =e=    sum((x), sum((y), d(y,x)))

Model model1 /all/;
Option mip=CPLEX;
Solve model1 using mip minimizing z;
display d.l;