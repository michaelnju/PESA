clc;
clear;
first=2;
D=4;
d=1;
side_length=20;%side_length=4*D*K;
Region=[0 side_length 0 side_length];
devicenum_set = [5 10 15 20 25 30 35 40 45];
devicenum_set = 30;
C2=1;
C1=1;
alpha=10;
beta=10;
n=20;
% n_set=20;
epsilon=0.8;
epsilon=epsilon/2;
ep1=min(epsilon/2,1/(n+2));
Rt=0.4;

filename = load('./parameter_data/points.mat');
data = filename.data_70;

F2_utility=ones(1,size(devicenum_set,2));
for loop=1:size(devicenum_set,2)
    num=devicenum_set(loop);
    devices_points_set = data(1:num,:);
    [utility,xi]=FinalOutput2(Region,D,d,n,devices_points_set,ep1,alpha,beta,Rt,C1,C2,first);
    F2_utility(loop)=utility;
    disp('Ð§ÂÊÊÇ£º')
    disp(utility);
end
% save('.\result_data\1127\device_chnum20_2.mat','F2_utility','-append');
 



