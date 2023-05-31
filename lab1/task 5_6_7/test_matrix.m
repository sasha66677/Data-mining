clc;
M=[1 2 3; 
   2 3 4;
   3 4 5];

row=[11 12 13];
coloumn=[14; 
         14;
         16];

disp(M(2,2));
disp(row(2));

min(M,[],1)
min(min(M,[],1))

max(M,[],2)
max(max(M,[],2))

M=[M,coloumn]
M(:,4)=[]

M=[M;row]
M(4,:)=[]



%task 6
disp("task 6");
C=[1 2 3 4 5;
   2 3 4 5 6;
   3 4 5 6 7;
   4 5 6 7 8;
   5 6 7 8 9];

col_min = min(C, [], 2);
disp("Минимальные по строкам");
disp(col_min);
   
row_min = min(C, [], 1);
disp("Минимальные по столбцам");
disp(row_min);


col_max = max(C, [], 2);
disp("Максимальные по строкам");
disp(col_max);
   
row_max = max(C, [], 1);
disp("Максимальные по столбцам");
disp(row_max);

max(max(C))
min(min(C))

%task 7
disp("task 7");
A=[2 1;
   3 4];
B=[4;
   11];
x=inv(A)*B
A*x