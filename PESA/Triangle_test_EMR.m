clear;
clc;
% rt=10;
% step=10;
% Rt_set=[rt,rt+1*step,rt+2*step,rt+3*step,rt+4*step,rt+5*step,rt+6*step,rt+5*step];%%%charger nu
Rt_set=[0.14,0.17,0.2,0.23,0.26,0.29,0.32,0.35,0.38,0.41,0.44];
Rt_set = [0.15 0.16 0.17 0.18 0.19 0.20 0.21 0.22 0.23 0.24];
Rt_set = [0.13 0.15 0.16 0.17 0.19 0.21 0.23 0.25 0.27 0.29 0.31 0.33];
Rt_set=[0.1,0.11,0.12,0.13,0.14,0.15,0.16,0.17,0.18,0.19,0.20];
n=20;
D=4;
d=1;
side_length=20;
Region=[0 side_length 0 side_length];
C2=1;
C1=1;
alpha=10;
beta=10;
Triangle_Utility=ones(1,size(Rt_set,2));
error=0.05;
for loop=1:size(Rt_set,2)
    Rt=Rt_set(loop);
    p=load('.\parameter_data\points.mat');
    device_points=p.device_point_20_50;

    loop_=2000;
    utility=0;
    for l=1:loop_
        [u,num_n] = TriangleAlgorithm(Region,d,Rt,alpha,beta,D,device_points,C1,C2,error,n);
        utility=utility+u;
    end
    Triangle_Utility(loop)=utility/loop_;
    disp('Ð§ÂÊÊÇ£º')
    disp(utility/loop_);
end
save('.\result_data\1127\EMR.mat','Triangle_Utility','-append');