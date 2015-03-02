
n=20;
epsilon=0.9;
epsilon=epsilon/2;
D=10;
K=ceil(1/(1-sqrt(1-epsilon)));
Region=[0 160 0 160];
C2=1;
C1=1;
alpha=100;
beta=200;
Rt=0.0486;

up_times=5; %%阈值设为15次

%     ep1=min(epsilon/2,1/(n+2));
%     ep2=epsilon-ep1;
%     beta=d*2*sqrt(2)/(1/(sqrt(1-ep2))-1);
%     rt=C2*alpha/(beta^2);
%     Rt=4*rt;
    p=load('.\parameter_data\points.mat');
    device_points=p.device_points_100_160;
    d=1;
    loop_=200;
    utility=0;
    for l=1:loop_
        [u]=RandomAlgorithmUtility(Region,d,n,Rt,alpha,beta,D,up_times,device_points,C1,C2);
        utility=utility+u;
    end
    utility=utility/loop_;
    disp('效率是：')
    disp(utility);

%save('.\result_data\Random_EMR_differ_n50.mat','Rt_set','utility_charger_differ');