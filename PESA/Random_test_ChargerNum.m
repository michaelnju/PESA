clear;
clc;
first=2;
n_set=[10 12 14 16 18 20 22 24 26 28 30];  %%%charger num
n_set = [20 22 24 26 28 30 32 34 36 38 40];
n_set = [16 18 20 22 24 26 28 30 32 34 36 38 40 42];
n_set =20;
D=4;
side_length=20;%side_length=4*D*K;
Region=[0 side_length 0 side_length];
C2=1;
C1=1;
alpha=10;
beta=10;
num=4;
Rt=(alpha/beta^2)*num;
chargernum_random_utility=ones(1,size(n_set,2));
xi_charger_differ=cell(size(n_set,2),1);
up_times=5; %%阈值设为15次

d=1;
loop_=4000;
for loop=1:size(n_set,2)
    n=n_set(loop);
    p=load('.\parameter_data\points.mat');
    devices_points_set=p.device_point_20_50;
 
    utility=0;
    for l=1:loop_
        [u]=RandomAlgorithmUtility(Region,d,n,Rt,alpha,beta,D,up_times,devices_points_set,C1,C2);
        utility=utility+u;
    end
    chargernum_random_utility(loop)=utility/loop_;
    disp('效率是：')
    disp(utility/loop_);
end
% save('.\result_data\1127\chargernum_step2_3t','chargernum_random_utility');