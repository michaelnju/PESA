
clc;
clear;
n=20;
side_length=160;
Region=[0 side_length 0 side_length];
D=10;
C2=1;
C1=1;
alpha=100;
beta=200;
error=0.05;
d=1;
p=load('.\parameter_data\points.mat');
device_points=p.device_points_100_160;
Rt=0.0486;
loop_=100;
utility=0;
for l=1:loop_
    [u,num_n] = TriangleAlgorithm(Region,d,Rt,alpha,beta,D,device_points,C1,C2,error,n);
    utility=utility+u;
end
utility=utility/loop_;
disp('Ð§ÂÊÊÇ£º')
disp(utility);

    
















