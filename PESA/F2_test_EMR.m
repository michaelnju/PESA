clc;
clear;

first=1;
% Rt_set=[0.14,0.17,0.2,0.23,0.26,0.29,0.32,0.35,0.38,0.41,0.44];
Rt_set = [0.15 0.16 0.17 0.19 0.21 0.23 0.25 0.27 0.29 0.31];
Rt_set = 0.25
D=4;
d=1;
side_length=20;%side_length=4*D*K;
Region=[0 side_length 0 side_length];
C2=1;
C1=1;
alpha=10;
beta=10;
n=20;
% n_set=20;
epsilon=0.8;
epsilon=epsilon/2;
ep1=min(epsilon/2,1/(n+2));

F2_Utility_2=ones(1,size(Rt_set,2));
for loop=1:size(Rt_set,2)
    Rt=Rt_set(loop);
    p=load('.\parameter_data\points.mat');
    devices_points_set=p.device_point_20_50;
    [utility,xi]=FinalOutput2(Region,D,d,n,devices_points_set,ep1,alpha,beta,Rt,C1,C2,first);
    F2_Utility_2(loop)=utility;
    disp('Ð§ÂÊÊÇ£º')
    disp(utility);
end
% save('.\result_data\1127\EMR_2.mat','F2_Utility_test','-append');

