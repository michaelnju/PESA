format long;
charger_num=40;
D=2;
alpha=100;
beta=100;
%epsilon=0.6;
epsilon=0.3;

ep1=min(epsilon/2,1/(charger_num+2));
ep2=epsilon-ep1;
%%d=min(sqrt(2)/4*beta*(1/(sqrt(1-ep2))-1),sqrt(2)*ep2*D);
K=ceil(1/(1-sqrt(1-epsilon)));
side_length=100;
Region=[0 100 0 100];
Rt=0.02;
C2=1;
C1=0.01;
%下面是近似替代
Rt=(1-ep2)*Rt;
charger_num=ceil(charger_num/(1-ep1));
d=1.62;

p=load('.\parameter_data\points.mat');
devices_points_set=p.device_points;
[U_output,Yk_output,Xk_output,Charger_allocation,Charger_placement,X_subregion_num,Y_subregion_num]=FinalOutput(Region,D,d,K,charger_num,devices_points_set,ep1,alpha,beta,Rt,C1,C2);