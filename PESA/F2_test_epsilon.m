%%主要的参数;
clc;
first=1;
ep=0.5;
step=0.05;
Epsilon_set=[ep,ep+1*step,ep+2*step,ep+3*step,ep+4*step,ep+5*step,ep+6*step]; %%%charger num
%n_set=10;
Epsilon_set=0.85;
D=1.25;
C2=1;
C1=1;
n=20;
alpha=10;
beta=15;
Rt=0.4;
d=1;
side_length=20;
Region=[0 side_length 0 side_length];
utility_charger_differ=ones(1,size(Epsilon_set,2));
xi_charger_differ=cell(size(Epsilon_set,2),1);
for loop=1:size(Epsilon_set,2)
   epsilon=Epsilon_set(loop);
    epsilon=epsilon/2;
    K=ceil(1/(1-sqrt(1-epsilon)));
    ep1=min(epsilon/2,1/(n+2));
    ep2=epsilon-ep1;
    d=sqrt(2)/4*beta*(1/sqrt(1-ep2)-1);
    num=floor(side_length/d);
    num=num^2;
    p=load('.\parameter_data\points.mat');
    devices_points_set=p.device_point_20_50;
    total_utility=0;
        [utility,xi]=FinalOutput2(Region,D,d,n,devices_points_set,ep1,alpha,beta,Rt,C1,C2,first);
        total_utility=utility+total_utility;      
        utility_charger_differ(loop)=utility;
    
%     xi_charger_differ{loop,1}=xi;
    disp('效率是：')
    disp(utility);
end
% save('.\result_data\PESA_Epsion_differ_new.mat','n_set','utility_charger_differ','xi_charger_differ');



% Region=[0 side_length 0 side_length];
% d=sqrt(2)*ep2*D/4;%d=min(sqrt(2)/4*beta*(1/(sqrt(1-ep2))-1),sqrt(2)*ep2*D/4);
%d=sqrt(2)*ep2*D/4;
% num=floor(K*8*sqrt(2)/ep2);



