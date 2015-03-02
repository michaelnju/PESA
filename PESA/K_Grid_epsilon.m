%%主要的参数：
n=20; %%%charger num
epsilon=0.9;
epsilon=epsilon/2;
ep1=min(epsilon/2,1/(n+2));
ep2=epsilon-ep1;
K=ceil(1/(1-sqrt(1-epsilon)));
D=10;
Region=[0 320 0 320];
alpha=100;
beta=90.756;
% d=sqrt(2)*ep2*D/4;%d=min(sqrt(2)/4*beta*(1/(sqrt(1-ep2))-1),sqrt(2)*ep2*D/4);
d=sqrt(2)/4*beta*(1/(sqrt(1-ep2))-1);

    d=sqrt(2)/4*beta*(1/sqrt(1-ep2)-1);
    p=load('.\parameter_data\points.mat');
    devices_points_set=p.device_points_100_320;


Rt=0.01;
C2=1;
C1=0.01;


[U_output,Yk_output,Xk_output,Charger_allocation,Charger_placement,X_subregion_num,Y_subregion_num]=FinalOutput(Region,D,d,K,n,devices_points_set,ep1,alpha,beta,Rt,C1,C2);