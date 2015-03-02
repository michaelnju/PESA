clear;
clc;
first=1;
Region=[-1.2 2.4 -1.2 2.4];
D=4.2;
C2=1;
C1=1;
% d=0.1;
d=0.2;
alpha=4.3246;
beta=0.34;
%%%%d=0.3; %d=30cm
min_dis=0.3;
% Rt=alpha/(min_dis+beta)^2;
rt=alpha/(beta)^2;
Rt=1.5*rt;
%Rt=1.0;
%Rt=0.8;
% Rt=0.0486;
n=5;   %charger_num  device_num=10;  尽量也是高斯分布
critical_length=0.6;  %%%距离要在60cm左右；
% p=load('.\parameter_data\points.mat');
% device_point=p.device_points_10_4_2;
x=[0.3 0.7 1.7 0.3 0.2 0.1 0.4 0.7 0.75 0.9];
y=[0.3 0.4 1.3 1.7 1.9 2.3 2.2 2.0 2.35 1.95];
x1=round(x*2/3*100)/100;
y1=round(y*1/2*100)/100;
plot(x1,y1,'*b');
device_point=[x1',y1'];
charger_deploy_set=cell(1,100);
utility_set=zeros(1,100);
device_emr_set=cell(1,100);
for loop=1:100
    [utility,charger_deploy,device_emr] = RandomAlgorithm_practice(Region,d,n,Rt,alpha,beta,D,device_point,C1,C2);
    charger_deploy_set{loop}=charger_deploy;
    device_emr_set{loop}=device_emr;
    utility_set(loop)=utility;
end
%%找到Utility中间的值，排序；

utility_set_temp=sort(utility_set);
utility_middle=utility_set_temp(ceil(size(utility_set_temp,2)/2));
index=find(utility_set==utility_middle,1);  %%找到中间值对应的第一个元素的下标
charger_point=charger_deploy_set{index};
device_emr=device_emr_set{index};
save('.\result_data\Practice_Exp\practice_random_4.mat','utility_middle','charger_point','device_emr');
plot(x1,y1,'*b',charger_point(:,1),charger_point(:,2),'+r');




