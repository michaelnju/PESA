clear;
clc;
region=[0 20 0 20];
D=3;
C2=1;
C1=1;
d=1;
alpha=10;
beta=10;
rt=alpha/beta^2;
Rt=0.8;
% Rt=0.0486;
n=30;   %charger_num
p=load('.\parameter_data\gaussion_point.mat');
device_points=p.point_in;%%%gaussion_point
error=0.05;
%%%计算100次，然后求平均
y=0;
for loop=1:100
    [x,y_axis]= TriangleAlgorithm_insight(region,d,Rt,alpha,beta,D,device_points,C2,error,n);
    y=y+y_axis;
end
    del_set=find(y<0);
    if ~isempty(del_set)
        for del=1:size(del_set,2)
            x(del_set(del)-(del-1))=[];
            y(del_set(del)-(del-1))=[];
        end
    end
y=y/100;
save('.\result_data\insight_angle','x','y');
plot(x,y,'-b');
xlabel('\fontsize {16}\fontname {Helvetica}Triangle');


%%把xi对应的坐标求出来

