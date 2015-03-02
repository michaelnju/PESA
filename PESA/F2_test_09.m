%%主要的参数;
clear;
ep=0.5;
step=0.05;
% Epsilon_set=[ep,ep+1*step,ep+2*step,ep+3*step,ep+4*step,ep+5*step,ep+6*step,ep+7*step,ep+8*step,ep+9*step,]; %%%charger num
%n_set=10;
Epsilon_set=0.9;
D=10;
C2=1;
C1=1;
n=20;
alpha=100;
beta=200;
Rt=0.0486;
utility_charger_differ=ones(1,size(Epsilon_set,2));
xi_charger_differ=cell(size(Epsilon_set,2),1);
for loop=1:size(Epsilon_set,2)
    epsilon=Epsilon_set(loop);
    epsilon=epsilon/2;
    K=ceil(1/(1-sqrt(1-epsilon)));
    side_length=160;
    Region=[0 side_length 0 side_length];
    ep1=min(epsilon/2,1/(n+2));
    ep2=epsilon-ep1;
    %d=sqrt(2)/4*beta*(1/sqrt(1-ep2)-1);
    d=14;
    num=floor(side_length/d);
    num=num^2;
    p=load('.\parameter_data\points.mat');
    devices_points_set=p.device_points_100_160;
    [utility,Yk_output,Xk_output,Charger_allocation,Charger_placement,X_subregion_num,Y_subregion_num]=FinalOutput(Region,D,d,K,n,devices_points_set,ep1,alpha,beta,Rt,C1,C2);
    utility_charger_differ(loop)=utility;
%     xi_charger_differ{loop,1}=xi;
%     disp('效率是：')
    disp(utility);
%     disp('开的charger个数：');
%     disp(size(find(xi>0),1));
end
% save('.\result_data\PESA_Epsion_differ_new.mat','n_set','utility_charger_differ','xi_charger_differ');



% Region=[0 side_length 0 side_length];
% d=sqrt(2)*ep2*D/4;%d=min(sqrt(2)/4*beta*(1/(sqrt(1-ep2))-1),sqrt(2)*ep2*D/4);
%d=sqrt(2)*ep2*D/4;
% num=floor(K*8*sqrt(2)/ep2);




