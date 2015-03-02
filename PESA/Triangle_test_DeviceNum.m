clear;
clc;
% devicenum_set = [25 30 35 40 45 50 55 60 65 70];
% devicenum_set = 70;
devicenum_set = [5 10 15 20 25 30 35 40 45];
n=20;
D=4;
d=1;
side_length=20;
Region=[0 side_length 0 side_length];
C2=1;
C1=1;
alpha=10;
beta=10;
Rt = 0.4;
Triangle_utility=ones(1,size(devicenum_set,2));
error=0.05;

filename = load('./parameter_data/points.mat');
data = filename.data_70;

for loop=1:size(devicenum_set,2)

    num=devicenum_set(loop);
    devices_points_set = data(1:num,:);
    loop_=2000;
    utility=0;
    for l=1:loop_
        [u,num_n] = TriangleAlgorithm(Region,d,Rt,alpha,beta,D,devices_points_set,C1,C2,error,n);
        utility=utility+u;
    end
    Triangle_utility(loop)=utility/loop_;
    disp('Ð§ÂÊÊÇ£º')
    disp(utility/loop_);
end
 save('.\result_data\1127\device_chnum20_2.mat','devicenum_set','Triangle_utility','-append');