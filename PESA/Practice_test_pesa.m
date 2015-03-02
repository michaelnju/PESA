format short;
clear;
clc;
first=1;
Region=[0 3.6 0 3.6];
D=4.2;
C2=1;
C1=1;
% d=0.1;
d=0.1;
alpha=4.3246;
beta=0.34;
%%%%d=0.3; %d=30cm
min_dis=0.3;
% Rt=alpha/(min_dis+beta)^2;
rt=alpha/(beta)^2;
rt1=alpha/(min_dis+beta)^2;
Rt=rt+rt1;
%Rt=1.0;
%Rt=0.8;
% Rt=0.0486;
n=5;   %charger_num  device_num=10;  尽量也是高斯分布
critical_length=0.6;  %%%距离要在60cm左右；
epsilon=0.8;
epsilon=epsilon/2;
ep1=min(epsilon/2,1/(n+2));
% p=load('.\parameter_data\points.mat');
% device_point=p.device_points_10_4_2;
x=[0.3 0.7 1.7 0.3 0.2 0.1 0.4 0.7 0.75 0.9];
y=[0.3 0.4 1.3 1.7 1.9 2.3 2.2 2.0 2.35 1.95];
x1=round(x*2/3*100)/100;
y1=round(y*1/2*100)/100;
x1=x1+1.2;
y1=y1+1.2;
plot(x1,y1,'*b');
device_point=[x1',y1'];
[utility,xi,charger_points,emr]=FinalOutPut_Practice(Region,D,d,n,device_point,ep1,alpha,beta,Rt,C1,C2);
index_x=find(xi==1);
num=size(index_x,1);
charger_point=zeros(num,2);
for index=1:num
    charger_point(index,:)=charger_points(index_x(index),:);
end
plot(x1,y1,'*b',charger_point(:,1),charger_point(:,2),'+r');
disp(utility);
save('.\result_data\Practice_Exp\practice_pesa_1.mat','utility','charger_point','emr');

% 
% save('.\result_data\insight_PESA_n70_rt012.mat','y');
% save('.\result_data\insight_PESA_n70_rt012.mat','x','-append');
plot(x,y,'-b');
%%把xi对应的坐标求出来

