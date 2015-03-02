first=2;
rt=0.1;
step=0.1;
Rt_set=[0.1,0.11,0.12,0.13,0.14,0.15,0.16,0.17,0.18,0.19,0.20];


n=20;
D=4;
d = 1;
Region=[0 20 0 20];
C2=1;
C1=1;
alpha=10;
beta=10;
RTTT=alpha/beta^2;
Random_Utility=ones(1,size(Rt_set,2));
up_times=5; %%阈值设为15次
for loop=1:size(Rt_set,2)
    Rt=Rt_set(loop);
    p=load('.\parameter_data\points.mat');
    device_points=p.device_point_20_50;
    loop_= 2000;
    utility=0;
    for l=1:loop_
        [u]=RandomAlgorithmUtility(Region,d,n,Rt,alpha,beta,D,up_times,device_points,C1,C2);
        utility=utility+u;
    end
    Random_Utility(loop)=utility/loop_;
    disp('效率是：')
    disp(utility/loop_);
end
save('.\result_data\1127\EMR.mat','Rt_set','Random_Utility');