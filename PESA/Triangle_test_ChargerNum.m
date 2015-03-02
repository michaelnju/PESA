clear;
clc;
% p_pe = load('E:\仿真_final\result_data\1127\chargernum_step2_2.mat');
% chargernum_triangle_utility = p_pe.chargernum_triangle_utility;
% %%%% update the data;
% chargernum_triangle_utility(8:11) = [11.92 11.97 12.00 12.01];
% save('.\result_data\1127\chargernum_step2_2.mat','chargernum_triangle_utility','-append');
n_set=[10 12 14 16 18 20 22 24 26 28 30];  %%%charger num
n_set = [20 22 24 26 28 30 32 34 36 38 40];
% n_set = [16 18 20 22 24 26 28 30 32 34 36 38 40 42];
% n_set = 34;
n_set = 20;
Rt_set=[0.1,0.11,0.12,0.13,0.14,0.15,0.16,0.17,0.18,0.19,0.20];
D=4;
side_length=20;%side_length=4*D*K;
Region=[0 side_length 0 side_length];
C2=1;
C1=1;
alpha=10;
beta=10;
num=4;
Rt=(alpha/beta^2)*num;
chargernum_triangle_utility=ones(1,size(n_set,2));
error=0.05;
for loop=1:size(n_set,2)
    n = n_set(loop);
    p=load('.\parameter_data\points.mat');
    device_points=p.device_point_20_50;
    d=1;
    loop_=1000;
    utility=0;
    for l=1:loop_
        [u,num_n] = TriangleAlgorithm(Region,d,Rt,alpha,beta,D,device_points,C1,C2,error,n);
        utility=utility+u;
    end
    chargernum_triangle_utility(loop)=utility/loop_;
    disp('效率是：')
    disp(utility/loop_);
end
% save('.\result_data\1127\chargernum_step2_2.mat','chargernum_triangle_utility','-append');















