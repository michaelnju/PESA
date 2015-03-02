clear;
clc;
first=2;
n = 20;
% devicenum_set = [25 30 35 40 45 50 55 60 65 70];
devicenum_set = [5 10 15 20 25 30 35 40 45];
D=4;
side_length=20;%side_length=4*D*K;
Region=[0 side_length 0 side_length];
C2=1;
C1=1;
alpha=10;
beta=10;
num=4;
Rt=(alpha/beta^2)*num;
Random_utility=ones(1,size(devicenum_set,2));
xi_charger_differ=cell(size(devicenum_set,2),1);
up_times=5; %%阈值设为15次
d=1;
loop_=1000;

filename = load('./parameter_data/points.mat');
data = filename.data_70;
for loop=1:size(devicenum_set,2)
    num=devicenum_set(loop);
    devices_points_set = data(1:num,:);
    utility=0;
    for l=1:loop_
        [u]=RandomAlgorithmUtility(Region,d,n,Rt,alpha,beta,D,up_times,devices_points_set,C1,C2);
        utility=utility+u;
    end
    Random_utility(loop)=utility/loop_;
    disp('效率是：')
    disp(utility/loop_);
end
save('.\result_data\1127\device_chnum20_2.mat','Random_utility');