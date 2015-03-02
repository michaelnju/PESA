%%主要的参数;
clear;
clc;
%n_set=[10 12 14 16 18 20 22 24 26 28 30]; %%%charger num
% n_set = 14;
n_set = [20 22 24 26 28 30 32 34 36 38 40];
n_set = 20;
% p_pe = load('./result_data/1127/chargernum_step2_2.mat');
% data = p_pe.data;
% % %% update the data;
%  data(2) = 11.386519819156934;
%  save('./result_data/1127/chargernum_step2_2.mat','data','-append');      

epsilon=0.8;
epsilon=epsilon/2;
D=4;
%d=10;
d=1;
side_length=20;%side_length=4*D*K;
Region=[0 side_length 0 side_length];
C2=1;
C1=1;
alpha=10;
beta=10;
num=4;
Rt=(alpha/beta^2)*num;
chargernum_F2_utility=ones(1,size(n_set,2));
xi_charger_differ=cell(size(n_set,2),1);
first=2;
for loop=1:size(n_set,2)
    n=n_set(loop);
    ep1=min(epsilon/2,1/(n+2));
    p=load('.\parameter_data\points.mat');
    devices_points_set=p.device_point_20_50;
    [utility,xi]=FinalOutput2(Region,D,d,n,devices_points_set,ep1,alpha,beta,Rt,C1,C2,first);
    chargernum_F2_utility(loop)=utility;
    xi_charger_differ{loop,1}=xi;
    disp('效率是：')
    disp(utility);
    disp('开的charger个数：');
    disp(size(find(xi>0),1));
end
charger_utility_test1 = chargernum_F2_utility;
% save('.\result_data\1127\chargernum.mat','charger_utility_test1','-append');